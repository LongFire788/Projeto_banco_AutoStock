<?php

namespace Tests\Feature;

use App\Models\Order;
use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\Seller;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class StorefrontCheckoutTest extends TestCase
{
    use RefreshDatabase;

    public function test_customer_can_add_to_cart_and_complete_checkout(): void
    {
        $seller = Seller::factory()->create([
            'zip_code' => '01310100',
            'trade_name' => 'Loja Teste',
        ]);

        $variant = ProductVariant::factory()->for(Product::factory()->for($seller))->create([
            'price' => 100.00,
            'stock' => 10,
            'weight_grams' => 1000,
            'length_cm' => 20,
            'width_cm' => 15,
            'height_cm' => 10,
        ]);

        $this->get(route('home'))->assertOk()->assertSee($variant->product->name);

        $this->post(route('cart.add'), [
            'variant_id' => $variant->id,
            'quantity' => 2,
        ])->assertRedirect(route('cart.index'));

        $this->get(route('cart.index'))->assertOk()->assertSee($variant->product->name);

        $this->get(route('checkout.index', ['zip' => '20040020']))
            ->assertOk()
            ->assertSee('Loja Teste')
            ->assertSee('Econômico (PAC)');

        $response = $this->post(route('checkout.store'), [
            'customer_name' => 'João Souza',
            'customer_email' => 'joao@example.test',
            'customer_document' => '12345678909',
            'customer_phone' => '(21) 99999-0000',
            'shipping_zip_code' => '20040020',
            'shipping_street' => 'Rua A',
            'shipping_number' => '10',
            'shipping_complement' => null,
            'shipping_neighborhood' => 'Centro',
            'shipping_city' => 'Rio de Janeiro',
            'shipping_state' => 'RJ',
            'payment_method' => 'pix',
            'notes' => null,
            'selected_services' => [$seller->id => 'PAC'],
        ]);

        $order = Order::first();
        $this->assertNotNull($order);
        $response->assertRedirect(route('checkout.success', $order));

        $this->assertSame(8, $variant->fresh()->stock);
        $this->assertSame(1, $order->items()->count());
        $this->assertSame(1, $order->shipments()->count());
        $this->assertSame(1, $order->payments()->count());
        $this->assertSame('pending', $order->payment_status);

        $this->get(route('checkout.success', $order))->assertOk()->assertSee($order->number);

        $this->get(route('cart.index'))->assertOk()->assertSee('Seu carrinho está vazio.');
    }
}
