<?php

namespace Tests\Feature;

use App\Exceptions\InsufficientStockException;
use App\Models\Order;
use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\Seller;
use App\Models\User;
use App\Services\CheckoutService;
use App\Services\Shipping\DTO\ShippingItem;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class CheckoutStockTest extends TestCase
{
    use RefreshDatabase;

    private function customer(): array
    {
        return [
            'customer_name' => 'Maria Silva',
            'customer_email' => 'maria@example.test',
            'customer_document' => '12345678909',
            'customer_phone' => '(11) 99999-0000',
            'shipping_zip_code' => '20040020',
            'shipping_street' => 'Rua da Entrega',
            'shipping_number' => '42',
            'shipping_complement' => null,
            'shipping_neighborhood' => 'Centro',
            'shipping_city' => 'Rio de Janeiro',
            'shipping_state' => 'RJ',
            'notes' => null,
        ];
    }

    public function test_checkout_decrements_stock_and_creates_split_per_seller(): void
    {
        $sellerA = Seller::factory()->create(['gateway_receiver_id' => 'recv_a']);
        $sellerB = Seller::factory()->create(['gateway_receiver_id' => 'recv_b']);

        $variantA = ProductVariant::factory()->for(Product::factory()->for($sellerA))->create([
            'price' => 100.00,
            'stock' => 10,
        ]);
        $variantB = ProductVariant::factory()->for(Product::factory()->for($sellerB))->create([
            'price' => 250.00,
            'stock' => 4,
        ]);

        $items = collect([
            new ShippingItem($variantA->load('product.seller'), 2),
            new ShippingItem($variantB->load('product.seller'), 1),
        ]);

        $order = app(CheckoutService::class)->placeOrder($this->customer(), $items, 'pix');

        $this->assertInstanceOf(Order::class, $order);
        $this->assertSame('pending', $order->status);
        $this->assertSame('pending', $order->payment_status);
        $this->assertCount(2, $order->items);
        $this->assertCount(2, $order->shipments);
        $this->assertCount(2, $order->payments);

        $this->assertSame(8, $variantA->fresh()->stock);
        $this->assertSame(3, $variantB->fresh()->stock);

        $this->assertSame(450.0, (float) $order->subtotal);
        $this->assertSame(
            (float) $order->total,
            round((float) $order->subtotal + (float) $order->shipping_total, 2)
        );
        $this->assertSame(
            (float) $order->total,
            round((float) $order->payments->sum('amount'), 2)
        );

        $paymentA = $order->payments->firstWhere('seller_id', $sellerA->id);
        $this->assertSame('recv_a', $paymentA->gateway_receiver_id);
        $this->assertSame(20.0, (float) $paymentA->platform_fee);
        $this->assertSame(
            round((float) $paymentA->amount - (float) $paymentA->platform_fee, 2),
            (float) $paymentA->seller_amount
        );
    }

    public function test_checkout_aborts_and_rolls_back_when_stock_is_insufficient(): void
    {
        $seller = Seller::factory()->create();
        $variant = ProductVariant::factory()->for(Product::factory()->for($seller))->create([
            'sku' => 'SKU-LIMITADO',
            'stock' => 1,
        ]);

        $items = collect([new ShippingItem($variant->load('product.seller'), 2)]);

        try {
            app(CheckoutService::class)->placeOrder($this->customer(), $items, 'pix');
            $this->fail('Esperava InsufficientStockException.');
        } catch (InsufficientStockException $exception) {
            $this->assertSame('SKU-LIMITADO', $exception->sku);
            $this->assertSame(1, $exception->available);
        }

        $this->assertSame(1, $variant->fresh()->stock);
        $this->assertSame(0, Order::count());
    }

    public function test_cancelling_an_order_restores_stock(): void
    {
        $user = User::factory()->create(['role' => User::ROLE_ADMIN]);
        $seller = Seller::factory()->create();
        $variant = ProductVariant::factory()->for(Product::factory()->for($seller))->create([
            'stock' => 5,
            'price' => 90,
        ]);

        $items = collect([new ShippingItem($variant->load('product.seller'), 2)]);
        $order = app(CheckoutService::class)->placeOrder($this->customer(), $items, 'pix');

        $this->assertSame(3, $variant->fresh()->stock);

        $this->actingAs($user)
            ->patch(route('admin.orders.status', $order), ['status' => Order::STATUS_CANCELLED])
            ->assertRedirect();

        $this->assertSame(5, $variant->fresh()->stock);
        $this->assertSame(Order::STATUS_CANCELLED, $order->fresh()->status);
    }
}
