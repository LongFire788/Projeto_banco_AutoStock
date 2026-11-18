<?php

namespace Tests\Feature;

use App\Models\Order;
use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\Seller;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Http;
use Tests\TestCase;

class CheckoutValidationAndCepTest extends TestCase
{
    use RefreshDatabase;

    public function test_cpf_com_digito_verificador_errado_diz_cpf_invalido(): void
    {
        $this->from(route('checkout.index'))
            ->post(route('checkout.store'), $this->payload('123.456.789-01'))
            ->assertRedirect(route('checkout.index'))
            ->assertSessionHasErrors(['customer_document' => 'CPF inválido.']);

        $this->assertDatabaseCount('orders', 0);
    }

    public function test_cpf_em_branco_e_obrigatorio(): void
    {
        $this->from(route('checkout.index'))
            ->post(route('checkout.store'), $this->payload(''))
            ->assertRedirect(route('checkout.index'))
            ->assertSessionHasErrors(['customer_document' => 'Informe o CPF ou CNPJ.']);

        $this->assertDatabaseCount('orders', 0);
    }

    public function test_cnpj_invalido_tem_mensagem_propria(): void
    {
        $this->post(route('checkout.store'), $this->payload('00000000000000'))
            ->assertSessionHasErrors(['customer_document' => 'CNPJ inválido.']);
    }

    public function test_cpf_valido_passa_pela_validacao(): void
    {
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

        $payload = $this->payload('529.982.247-25');
        $payload['selected_services'] = [$seller->id => 'PAC'];

        $this->post(route('checkout.store'), $payload)->assertRedirect();

        $this->assertSame('52998224725', Order::firstOrFail()->customer_document);
    }

    public function test_cep_lookup_devolve_rua_bairro_cidade_e_uf(): void
    {
        Http::fake([
            'https://viacep.com.br/ws/20040020/json/' => Http::response([
                'logradouro' => 'Avenida Rio Branco',
                'bairro' => 'Centro',
                'localidade' => 'Rio de Janeiro',
                'uf' => 'RJ',
                'complemento' => '',
            ]),
        ]);

        $this->get(route('cep.lookup', '20040-020'))
            ->assertOk()
            ->assertJson([
                'zip_code' => '20040020',
                'street' => 'Avenida Rio Branco',
                'neighborhood' => 'Centro',
                'city' => 'Rio de Janeiro',
                'state' => 'RJ',
            ]);
    }

    public function test_cep_lookup_trata_cep_invalido_e_inexistente(): void
    {
        $this->get(route('cep.lookup', '123'))->assertStatus(422);

        Http::fake([
            'https://viacep.com.br/ws/00000000/json/' => Http::response(['erro' => true]),
        ]);

        $this->get(route('cep.lookup', '00000000'))->assertStatus(404);
    }

    public function test_checkout_tem_autopreenchimento_de_endereco_por_cep(): void
    {
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

        $this->get(route('checkout.index', ['zip' => '20040020']))
            ->assertOk()
            ->assertSee('lookupCep()', false)
            ->assertSee('x-ref="shippingZip"', false)
            ->assertSee('x-ref="street"', false)
            ->assertSee('\/cep', false);
    }

    /**
     * @return array<string, mixed>
     */
    private function payload(string $document): array
    {
        return [
            'customer_name' => 'João Souza',
            'customer_email' => 'joao@example.test',
            'customer_document' => $document,
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
        ];
    }
}
