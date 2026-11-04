<?php

namespace Tests\Feature;

use App\Models\Order;
use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\Seller;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class PixCheckoutTest extends TestCase
{
    use RefreshDatabase;

    private function checkoutPayload(Seller $seller, string $paymentMethod = 'pix'): array
    {
        return [
            'customer_name' => 'Ana Pereira',
            'customer_email' => 'ana@example.test',
            'customer_document' => '12345678901',
            'customer_phone' => '(11) 99999-0000',
            'shipping_zip_code' => '20040020',
            'shipping_street' => 'Rua B',
            'shipping_number' => '20',
            'shipping_complement' => null,
            'shipping_neighborhood' => 'Centro',
            'shipping_city' => 'Rio de Janeiro',
            'shipping_state' => 'RJ',
            'payment_method' => $paymentMethod,
            'notes' => null,
            'selected_services' => [$seller->id => 'PAC'],
        ];
    }

    private function makeSellerWithVariant(): array
    {
        $seller = Seller::factory()->create([
            'zip_code' => '01310100',
            'trade_name' => 'Loja Pix',
        ]);

        $variant = ProductVariant::factory()->for(Product::factory()->for($seller))->create([
            'price' => 100.00,
            'stock' => 5,
            'weight_grams' => 1000,
            'length_cm' => 20,
            'width_cm' => 15,
            'height_cm' => 10,
        ]);

        return [$seller, $variant];
    }

    public function test_pix_checkout_persists_payload_and_shows_qr_code(): void
    {
        [$seller, $variant] = $this->makeSellerWithVariant();

        $this->post(route('cart.add'), [
            'variant_id' => $variant->id,
            'quantity' => 1,
        ])->assertRedirect(route('cart.index'));

        $response = $this->post(route('checkout.store'), $this->checkoutPayload($seller));

        $order = Order::firstOrFail();

        $response->assertRedirect(route('checkout.success', $order));

        $this->assertSame('pix', $order->payment_method);
        $this->assertNotNull($order->pix_payload);
        $this->assertNotNull($order->pix_expires_at);
        $this->assertStringStartsWith('000201', $order->pix_payload);
        $this->assertSame(4, strlen(substr($order->pix_payload, -4)));

        $this->get(route('checkout.success', $order))
            ->assertOk()
            ->assertSee('Pague com Pix')
            ->assertSee('Pix copia e cola')
            ->assertSee('<svg', false)
            ->assertSee($order->pix_payload);
    }

    public function test_non_pix_checkout_does_not_generate_a_pix_payload(): void
    {
        [$seller, $variant] = $this->makeSellerWithVariant();

        $this->post(route('cart.add'), [
            'variant_id' => $variant->id,
            'quantity' => 1,
        ])->assertRedirect(route('cart.index'));

        $this->post(route('checkout.store'), $this->checkoutPayload($seller, 'credit_card'))
            ->assertRedirect();

        $order = Order::firstOrFail();

        $this->assertSame('credit_card', $order->payment_method);
        $this->assertNull($order->pix_payload);
        $this->assertNull($order->pix_expires_at);

        $this->get(route('checkout.success', $order))
            ->assertOk()
            ->assertDontSee('Pague com Pix');
    }

    public function test_success_page_regenerates_payload_for_legacy_pix_orders(): void
    {
        [$seller, $variant] = $this->makeSellerWithVariant();

        $this->post(route('cart.add'), [
            'variant_id' => $variant->id,
            'quantity' => 1,
        ]);

        $this->post(route('checkout.store'), $this->checkoutPayload($seller));

        $order = Order::firstOrFail();
        $order->forceFill(['pix_payload' => null, 'pix_expires_at' => null])->save();

        $this->get(route('checkout.success', $order))
            ->assertOk()
            ->assertSee('Pague com Pix');

        $order->refresh();

        $this->assertNotNull($order->pix_payload);
        $this->assertNotNull($order->pix_expires_at);
    }

    public function test_admin_order_page_shows_the_pix_qr_code(): void
    {
        [$seller, $variant] = $this->makeSellerWithVariant();

        $this->post(route('cart.add'), [
            'variant_id' => $variant->id,
            'quantity' => 1,
        ]);

        $this->post(route('checkout.store'), $this->checkoutPayload($seller));

        $order = Order::firstOrFail();
        $user = User::factory()->create();

        $this->actingAs($user)
            ->get(route('admin.orders.show', $order))
            ->assertOk()
            ->assertSee('Pix')
            ->assertSee('<svg', false)
            ->assertSee($order->pix_payload);
    }

    public function test_demo_key_warning_is_shown_on_the_success_page(): void
    {
        config(['payments.pix.is_demo' => true]);

        [$seller, $variant] = $this->makeSellerWithVariant();

        $this->post(route('cart.add'), [
            'variant_id' => $variant->id,
            'quantity' => 1,
        ]);

        $this->post(route('checkout.store'), $this->checkoutPayload($seller));

        $order = Order::firstOrFail();

        $this->get(route('checkout.success', $order))
            ->assertOk()
            ->assertSee('Chave Pix de demonstração');
    }

    public function test_pix_regenerate_command_updates_the_stored_payload(): void
    {
        [$seller, $variant] = $this->makeSellerWithVariant();

        $this->post(route('cart.add'), [
            'variant_id' => $variant->id,
            'quantity' => 1,
        ]);

        $this->post(route('checkout.store'), $this->checkoutPayload($seller));

        $order = Order::firstOrFail();

        config(['payments.pix.key' => 'nova-chave@exemplo.test']);

        $this->artisan('pix:regenerate', ['order' => $order->number])
            ->assertSuccessful();

        $this->assertStringContainsString('nova-chave@exemplo.test', $order->fresh()->pix_payload);
    }
}
