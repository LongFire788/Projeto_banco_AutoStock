<?php

namespace App\Services\Shipping;

use App\Services\Shipping\Contracts\ShippingGateway;
use App\Services\Shipping\DTO\ShipmentGroup;
use App\Services\Shipping\DTO\ShippingItem;
use Illuminate\Support\Collection;

class ShippingCalculationService
{
    public function __construct(
        private readonly ShippingGateway $gateway,
        private readonly MelhorEnvioPayloadBuilder $payloadBuilder,
    ) {
    }

    /**
     * Agrupa os itens do carrinho por seller (origem do despacho).
     * Cada grupo gera um único pacote consolidado.
     *
     * @param  Collection<int, ShippingItem>  $items
     * @return Collection<int, ShipmentGroup>
     */
    public function groupBySeller(Collection $items): Collection
    {
        return $items
            ->filter(fn (ShippingItem $item) => $item->quantity > 0)
            ->groupBy(fn (ShippingItem $item) => $item->variant->product->seller_id)
            ->map(function (Collection $sellerItems) {
                /** @var ShippingItem $first */
                $first = $sellerItems->first();
                $seller = $first->variant->product->seller;

                $height = (int) $sellerItems->sum(
                    fn (ShippingItem $item) => $item->variant->height_cm * $item->quantity
                );

                $length = (int) $sellerItems->max(fn (ShippingItem $item) => $item->variant->length_cm);
                $width = (int) $sellerItems->max(fn (ShippingItem $item) => $item->variant->width_cm);
                $height = min(200, max(1, $height));

                $weight = (int) $sellerItems->sum(fn (ShippingItem $item) => $item->weightGrams());
                $cubicWeight = (int) ceil(($length * $width * $height) / 6);
                $subtotal = round((float) $sellerItems->sum(fn (ShippingItem $item) => $item->subtotal()), 2);

                return new ShipmentGroup(
                    seller: $seller,
                    items: $sellerItems->values(),
                    subtotal: $subtotal,
                    weightGrams: $weight,
                    cubicWeightGrams: $cubicWeight,
                    lengthCm: $length,
                    widthCm: $width,
                    heightCm: $height,
                );
            })
            ->sortBy(fn (ShipmentGroup $group) => $group->seller->id)
            ->values();
    }

    /**
     * Payloads de cotação do Melhor Envio, um por vendedor/origem.
     *
     * @param  Collection<int, ShippingItem>  $items
     * @return array<int, array<string, mixed>>
     */
    public function buildPayloads(Collection $items, string $destinationZipCode): array
    {
        return $this->groupBySeller($items)
            ->mapWithKeys(fn (ShipmentGroup $group) => [
                $group->seller->id => $this->payloadBuilder->forGroup($group, $destinationZipCode),
            ])
            ->all();
    }

    /**
     * Cotação completa: um conjunto de opções por vendedor + total logístico.
     *
     * @param  Collection<int, ShippingItem>  $items
     * @return array{
     *     groups: array<int, array<string, mixed>>,
     *     shipping_total: float,
     *     destination_zip_code: string
     * }
     */
    public function quoteCart(Collection $items, string $destinationZipCode): array
    {
        $groups = $this->groupBySeller($items)->map(function (ShipmentGroup $group) use ($destinationZipCode) {
            $options = $this->gateway->quote($group, $destinationZipCode);
            $default = collect($options)->firstWhere('service_code', 'PAC') ?? ($options[0] ?? null);

            return [
                ...$group->toArray(),
                'options' => $options,
                'default_service_code' => $default['service_code'] ?? null,
            ];
        })->values()->all();

        $shippingTotal = collect($groups)->sum(
            fn (array $group) => (float) (collect($group['options'])->firstWhere(
                'service_code',
                $group['default_service_code']
            )['price'] ?? 0)
        );

        return [
            'groups' => $groups,
            'shipping_total' => round((float) $shippingTotal, 2),
            'destination_zip_code' => preg_replace('/\D/', '', $destinationZipCode) ?? '',
        ];
    }
}
