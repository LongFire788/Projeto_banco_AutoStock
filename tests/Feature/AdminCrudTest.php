<?php

namespace Tests\Feature;

use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\Seller;
use App\Models\User;
use App\Models\VehicleModel;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AdminCrudTest extends TestCase
{
    use RefreshDatabase;

    public function test_guest_is_redirected_from_admin(): void
    {
        $this->get(route('admin.dashboard'))->assertRedirect(route('login'));
    }

    public function test_admin_can_manage_sellers_products_variants_and_vehicles(): void
    {
        $admin = User::factory()->create();

        $this->actingAs($admin)->get(route('admin.dashboard'))->assertOk();

        $this->actingAs($admin)->post(route('admin.sellers.store'), [
            'legal_name' => 'Peças Silva Ltda',
            'trade_name' => 'Peças Silva',
            'document' => '12345678000199',
            'email' => 'contato@pecassilva.test',
            'phone' => '(11) 98888-7777',
            'zip_code' => '01001000',
            'address_street' => 'Praça da Sé',
            'address_number' => '10',
            'address_complement' => null,
            'address_neighborhood' => 'Sé',
            'address_city' => 'São Paulo',
            'address_state' => 'sp',
            'gateway_receiver_id' => 'recv_teste',
            'active' => '1',
        ])->assertRedirect();

        $seller = Seller::firstWhere('email', 'contato@pecassilva.test');
        $this->assertNotNull($seller);
        $this->assertSame('SP', $seller->address_state);

        $vehicle = VehicleModel::create([
            'brand' => 'Volkswagen',
            'model' => 'Gol',
            'year_start' => 2014,
            'year_end' => 2020,
            'engine' => '1.0',
        ]);

        $this->actingAs($admin)->post(route('admin.products.store'), [
            'seller_id' => $seller->id,
            'name' => 'Amortecedor Traseiro',
            'slug' => '',
            'brand' => 'Cofap',
            'category' => 'Suspensão',
            'description' => 'Teste',
            'image_url' => null,
            'active' => '1',
            'vehicle_model_ids' => [$vehicle->id],
        ])->assertRedirect();

        $product = Product::firstWhere('name', 'Amortecedor Traseiro');
        $this->assertNotNull($product);
        $this->assertSame('amortecedor-traseiro', $product->slug);
        $this->assertTrue($product->compatibilities()->whereKey($vehicle->id)->exists());

        $this->actingAs($admin)->post(route('admin.products.variants.store', $product), [
            'sku' => 'amort-tras-01',
            'name' => 'Lado Esquerdo',
            'price' => '199.90',
            'compare_at_price' => null,
            'stock' => '7',
            'weight_grams' => '1500',
            'length_cm' => '40',
            'width_cm' => '15',
            'height_cm' => '15',
            'active' => '1',
            'attributes' => [
                ['name' => 'Posição', 'value' => 'Esquerdo'],
            ],
        ])->assertRedirect(route('admin.products.show', $product));

        $variant = ProductVariant::firstWhere('sku', 'AMORT-TRAS-01');
        $this->assertNotNull($variant);
        $this->assertSame(7, $variant->stock);
        $this->assertSame('Posição', $variant->attributes->first()->name);

        $this->actingAs($admin)->get(route('admin.products.show', $product))->assertOk()->assertSee('AMORT-TRAS-01');
        $this->actingAs($admin)->get(route('admin.products.variants.edit', [$product, $variant]))->assertOk();
    }
}
