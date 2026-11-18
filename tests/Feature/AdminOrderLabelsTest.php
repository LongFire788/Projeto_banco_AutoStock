<?php

namespace Tests\Feature;

use App\Models\Order;
use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\Seller;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AdminOrderLabelsTest extends TestCase
{
    use RefreshDatabase;

    public function test_status_do_painel_sao_exibidos_em_portugues(): void
    {
        $admin = User::factory()->create(['role' => User::ROLE_ADMIN]);
        $seller = Seller::factory()->create(['zip_code' => '01310100']);

        $variant = ProductVariant::factory()->for(Product::factory()->for($seller))->create([
            'price' => 100,
            'stock' => 5,
            'weight_grams' => 1000,
            'length_cm' => 20,
            'width_cm' => 15,
            'height_cm' => 10,
        ]);

        $this->post(route('cart.add'), ['variant_id' => $variant->id, 'quantity' => 1]);

        $this->post(route('checkout.store'), [
            'customer_name' => 'João Souza',
            'customer_email' => 'joao@example.test',
            'customer_document' => '12345678909',
            'shipping_zip_code' => '20040020',
            'shipping_street' => 'Rua A',
            'shipping_number' => '10',
            'shipping_neighborhood' => 'Centro',
            'shipping_city' => 'Rio de Janeiro',
            'shipping_state' => 'RJ',
            'payment_method' => 'credit_card',
            'selected_services' => [$seller->id => 'PAC'],
        ])->assertRedirect();

        $order = Order::firstOrFail();

        $this->actingAs($admin)->get(route('admin.orders.index'))
            ->assertOk()
            ->assertSee('Aguardando pagamento')
            ->assertDontSee('Pending');

        $this->actingAs($admin)->get(route('admin.orders.show', $order))
            ->assertOk()
            ->assertSee('Aguardando pagamento')
            ->assertSee('Em separação')
            ->assertSee('Enviado')
            ->assertSee('Etiqueta gerada')
            ->assertSee('Cartão de crédito')
            ->assertDontSee('Shipped')
            ->assertDontSee('Label generated')
            ->assertDontSee('Credit card');
    }
}
