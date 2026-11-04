<?php

namespace App\Services;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\OrderShipment;
use App\Models\ProductVariant;
use App\Models\Seller;
use App\Services\Payments\PixPayloadBuilder;
use App\Services\Shipping\DTO\ShippingItem;
use App\Services\Shipping\ShippingCalculationService;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use InvalidArgumentException;
use RuntimeException;

class CheckoutService
{
    public function __construct(
        private readonly ShippingCalculationService $shipping,
        private readonly InventoryService $inventory,
        private readonly SplitPaymentService $splitPayments,
        private readonly PixPayloadBuilder $pix,
    ) {
    }

    /**
     * @param  array<string, string|null>  $customer
     * @param  Collection<int, ShippingItem>  $items
     * @param  array<int|string, string>  $selectedServices  seller_id => service_code
     */
    public function placeOrder(
        array $customer,
        Collection $items,
        string $paymentMethod,
        array $selectedServices = [],
    ): Order {
        if ($items->isEmpty()) {
            throw new InvalidArgumentException('O carrinho está vazio.');
        }

        $destinationZipCode = preg_replace('/\D/', '', (string) $customer['shipping_zip_code']) ?? '';

        // Cotação feita antes da transação para não segurar locks durante I/O externo.
        $quote = $this->shipping->quoteCart($items, $destinationZipCode);
        $resolvedGroups = $this->resolveShippingOptions($quote['groups'], $selectedServices);

        $subtotal = round((float) $items->sum(fn (ShippingItem $item) => $item->subtotal()), 2);
        $shippingTotal = round((float) collect($resolvedGroups)->sum(
            fn (array $resolved) => (float) $resolved['option']['price']
        ), 2);

        $sellers = $items
            ->map(fn (ShippingItem $item) => $item->variant->product->seller)
            ->keyBy('id');

        return DB::transaction(function () use (
            $customer,
            $items,
            $paymentMethod,
            $resolvedGroups,
            $subtotal,
            $shippingTotal,
            $sellers,
            $destinationZipCode
        ) {
            /** @var Collection<int, ProductVariant> $lockedVariants */
            $lockedVariants = $this->inventory->reserve($items);

            $number = $this->generateOrderNumber();
            $total = round($subtotal + $shippingTotal, 2);
            $isPix = $paymentMethod === 'pix';

            $order = Order::create([
                'number' => $number,
                'customer_name' => $customer['customer_name'],
                'customer_email' => $customer['customer_email'],
                'customer_document' => $customer['customer_document'] ?? null,
                'customer_phone' => $customer['customer_phone'] ?? null,
                'shipping_zip_code' => $destinationZipCode,
                'shipping_street' => $customer['shipping_street'],
                'shipping_number' => $customer['shipping_number'],
                'shipping_complement' => $customer['shipping_complement'] ?? null,
                'shipping_neighborhood' => $customer['shipping_neighborhood'],
                'shipping_city' => $customer['shipping_city'],
                'shipping_state' => strtoupper((string) $customer['shipping_state']),
                'subtotal' => $subtotal,
                'shipping_total' => $shippingTotal,
                'discount_total' => 0,
                'total' => $total,
                'status' => Order::STATUS_PENDING,
                'payment_status' => Order::PAYMENT_PENDING,
                'payment_method' => $paymentMethod,
                'pix_payload' => $isPix ? $this->pix->payload($total, $number) : null,
                'pix_expires_at' => $isPix ? $this->pix->expiresAt() : null,
                'notes' => $customer['notes'] ?? null,
                'placed_at' => now(),
            ]);

            foreach ($resolvedGroups as $resolved) {
                $group = $resolved['group'];
                $option = $resolved['option'];
                $seller = $sellers->get($group['seller_id']);

                $shipment = OrderShipment::create([
                    'order_id' => $order->id,
                    'seller_id' => $group['seller_id'],
                    'shipping_method' => $option['service_name'],
                    'shipping_service_code' => $option['service_code'],
                    'tracking_code' => null,
                    'shipping_cost' => $option['price'],
                    'status' => OrderShipment::STATUS_PENDING,
                    'estimated_delivery_date' => $option['delivery_days'] > 0
                        ? now()->addWeekdays($option['delivery_days'])->toDateString()
                        : null,
                    'payload' => [
                        'quote' => $option,
                        'package' => $group,
                    ],
                ]);

                $sellerItems = $items->filter(
                    fn (ShippingItem $item) => $item->variant->product->seller_id === $group['seller_id']
                );

                foreach ($sellerItems as $item) {
                    $variant = $lockedVariants->get($item->variant->id);
                    $product = $variant->product;

                    OrderItem::create([
                        'order_id' => $order->id,
                        'order_shipment_id' => $shipment->id,
                        'seller_id' => $product->seller_id,
                        'product_id' => $product->id,
                        'product_variant_id' => $variant->id,
                        'product_name' => $product->name,
                        'variant_name' => $variant->name,
                        'sku' => $variant->sku,
                        'quantity' => $item->quantity,
                        'unit_price' => $variant->price,
                        'total' => round((float) $variant->price * $item->quantity, 2),
                        'weight_grams' => $variant->weight_grams,
                        'length_cm' => $variant->length_cm,
                        'width_cm' => $variant->width_cm,
                        'height_cm' => $variant->height_cm,
                    ]);
                }

                /** @var Seller $seller */
                $this->splitPayments->createForSeller(
                    $order,
                    $seller,
                    (float) $group['subtotal'],
                    (float) $option['price'],
                    $paymentMethod,
                );
            }

            return $order->load(['items', 'shipments.seller', 'payments.seller']);
        }, attempts: 3);
    }

    /**
     * @param  array<int, array<string, mixed>>  $groups
     * @param  array<int|string, string>  $selectedServices
     * @return array<int, array{group: array<string, mixed>, option: array<string, mixed>}>
     */
    private function resolveShippingOptions(array $groups, array $selectedServices): array
    {
        return collect($groups)->map(function (array $group) use ($selectedServices) {
            $options = collect($group['options']);
            $selectedCode = $selectedServices[$group['seller_id']] ?? $group['default_service_code'];
            $option = $options->firstWhere('service_code', $selectedCode) ?? $options->first();

            if (! $option) {
                throw new RuntimeException(
                    "Nenhuma opção de frete disponível para o vendedor {$group['seller_name']}."
                );
            }

            return ['group' => $group, 'option' => $option];
        })->values()->all();
    }

    private function generateOrderNumber(): string
    {
        do {
            $number = 'ORD-' . now()->format('Ymd') . '-' . Str::upper(Str::random(6));
        } while (Order::where('number', $number)->exists());

        return $number;
    }
}
