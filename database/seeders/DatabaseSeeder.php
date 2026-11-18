<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\Seller;
use App\Models\User;
use App\Models\VehicleModel;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        User::updateOrCreate(
            ['email' => 'admin@autostock.test'],
            [
                'name' => 'Administrador AutoStock',
                'password' => Hash::make('password'),
                'role' => User::ROLE_ADMIN,
            ]
        );

        $sellers = collect([
            [
                'legal_name' => 'Cofap Autopeças Ltda',
                'trade_name' => 'Cofap Center',
                'document' => '12345678000190',
                'email' => 'vendas@cofapcenter.test',
                'phone' => '(11) 98888-1000',
                'zip_code' => '01310100',
                'address_street' => 'Avenida Paulista',
                'address_number' => '1000',
                'address_neighborhood' => 'Bela Vista',
                'address_city' => 'São Paulo',
                'address_state' => 'SP',
                'gateway_receiver_id' => 'recv_cofap_001',
                'active' => true,
            ],
            [
                'legal_name' => 'Bosch Parts Distribuidora Ltda',
                'trade_name' => 'Bosch Parts',
                'document' => '98765432000110',
                'email' => 'vendas@boschparts.test',
                'phone' => '(41) 97777-2000',
                'zip_code' => '80420000',
                'address_street' => 'Rua Comendador Araújo',
                'address_number' => '500',
                'address_neighborhood' => 'Centro',
                'address_city' => 'Curitiba',
                'address_state' => 'PR',
                'gateway_receiver_id' => 'recv_bosch_002',
                'active' => true,
            ],
            [
                'legal_name' => 'Mann Filter Brasil Ltda',
                'trade_name' => 'Mann Filter Store',
                'document' => '11222333000144',
                'email' => 'vendas@mannstore.test',
                'phone' => '(31) 96666-3000',
                'zip_code' => '30130010',
                'address_street' => 'Avenida Afonso Pena',
                'address_number' => '800',
                'address_neighborhood' => 'Centro',
                'address_city' => 'Belo Horizonte',
                'address_state' => 'MG',
                'gateway_receiver_id' => 'recv_mann_003',
                'active' => true,
            ],
        ])->map(fn (array $data) => Seller::updateOrCreate(['document' => $data['document']], $data));

        $vehicles = collect([
            ['brand' => 'Volkswagen', 'model' => 'Gol', 'year_start' => 2014, 'year_end' => 2020, 'engine' => '1.0 12V Flex'],
            ['brand' => 'Chevrolet', 'model' => 'Onix', 'year_start' => 2016, 'year_end' => 2022, 'engine' => '1.0 12V Flex'],
            ['brand' => 'Fiat', 'model' => 'Argo', 'year_start' => 2018, 'year_end' => 2023, 'engine' => '1.3 8V Flex'],
            ['brand' => 'Toyota', 'model' => 'Corolla', 'year_start' => 2015, 'year_end' => 2021, 'engine' => '2.0 16V Flex'],
            ['brand' => 'Honda', 'model' => 'Civic', 'year_start' => 2016, 'year_end' => 2021, 'engine' => '2.0 16V Flex'],
        ])->map(fn (array $data) => VehicleModel::firstOrCreate($data));

        $products = [
            [
                'seller' => $sellers[0],
                'name' => 'Amortecedor Dianteiro Cofap',
                'brand' => 'Cofap',
                'category' => 'Suspensão',
                'description' => 'Amortecedor dianteiro a gás, alta durabilidade e conforto para uso urbano. Vendido por unidade.',
                'vehicles' => [0, 1, 2],
                'variants' => [
                    ['sku' => 'AMORT-COF-DIR', 'name' => 'Lado Direito', 'price' => 389.90, 'compare_at_price' => 449.90, 'stock' => 12, 'weight_grams' => 3200, 'length_cm' => 60, 'width_cm' => 18, 'height_cm' => 18, 'attributes' => ['Posição' => 'Direito', 'Material' => 'Aço']],
                    ['sku' => 'AMORT-COF-ESQ', 'name' => 'Lado Esquerdo', 'price' => 389.90, 'compare_at_price' => 449.90, 'stock' => 8, 'weight_grams' => 3200, 'length_cm' => 60, 'width_cm' => 18, 'height_cm' => 18, 'attributes' => ['Posição' => 'Esquerdo', 'Material' => 'Aço']],
                ],
            ],
            [
                'seller' => $sellers[1],
                'name' => 'Kit Pastilhas de Freio Bosch',
                'brand' => 'Bosch',
                'category' => 'Freios',
                'description' => 'Jogo de pastilhas cerâmicas com alta performance e baixo ruído. Acompanha sensores quando aplicável.',
                'vehicles' => [0, 1, 2, 3],
                'variants' => [
                    ['sku' => 'PAST-BOSCH-DIANT', 'name' => 'Eixo Dianteiro', 'price' => 219.90, 'compare_at_price' => null, 'stock' => 20, 'weight_grams' => 1400, 'length_cm' => 25, 'width_cm' => 18, 'height_cm' => 8, 'attributes' => ['Posição' => 'Dianteiro', 'Material' => 'Cerâmica']],
                    ['sku' => 'PAST-BOSCH-TRAS', 'name' => 'Eixo Traseiro', 'price' => 189.90, 'compare_at_price' => null, 'stock' => 15, 'weight_grams' => 1100, 'length_cm' => 22, 'width_cm' => 16, 'height_cm' => 7, 'attributes' => ['Posição' => 'Traseiro', 'Material' => 'Cerâmica']],
                ],
            ],
            [
                'seller' => $sellers[2],
                'name' => 'Filtro de Óleo Mann W 712/95',
                'brand' => 'Mann Filter',
                'category' => 'Motor',
                'description' => 'Filtro de óleo com válvula anti-retorno e mídia filtrante de alta eficiência.',
                'vehicles' => [0, 1, 2, 3, 4],
                'variants' => [
                    ['sku' => 'FILT-MANN-71295', 'name' => 'Único', 'price' => 49.90, 'compare_at_price' => 59.90, 'stock' => 50, 'weight_grams' => 320, 'length_cm' => 12, 'width_cm' => 9, 'height_cm' => 9, 'attributes' => ['Rosca' => '3/4-16 UNF']],
                ],
            ],
            [
                'seller' => $sellers[1],
                'name' => 'Bateria Moura M60AD 60Ah',
                'brand' => 'Moura',
                'category' => 'Elétrica',
                'description' => 'Bateria automotiva 60Ah, livre de manutenção, com 18 meses de garantia.',
                'vehicles' => [0, 1, 2, 3, 4],
                'variants' => [
                    ['sku' => 'BAT-MOURA-60', 'name' => '60Ah', 'price' => 549.90, 'compare_at_price' => 629.90, 'stock' => 6, 'weight_grams' => 14500, 'length_cm' => 30, 'width_cm' => 20, 'height_cm' => 22, 'attributes' => ['Capacidade' => '60Ah', 'Tensão' => '12V']],
                ],
            ],
            [
                'seller' => $sellers[0],
                'name' => 'Palheta Limpador Bosch Aerotwin',
                'brand' => 'Bosch',
                'category' => 'Acessórios',
                'description' => 'Par de palhetas aerodinâmicas com encaixe universal e excelente visibilidade.',
                'vehicles' => [0, 1, 2, 3, 4],
                'variants' => [
                    ['sku' => 'PALH-BOSCH-AERO', 'name' => 'Par 24" + 18"', 'price' => 129.90, 'compare_at_price' => null, 'stock' => 30, 'weight_grams' => 650, 'length_cm' => 70, 'width_cm' => 8, 'height_cm' => 6, 'attributes' => ['Tamanho' => '24/18 polegadas']],
                ],
            ],
        ];

        foreach ($products as $data) {
            $product = Product::updateOrCreate(
                ['slug' => Str::slug($data['name'])],
                [
                    'seller_id' => $data['seller']->id,
                    'name' => $data['name'],
                    'brand' => $data['brand'],
                    'category' => $data['category'],
                    'description' => $data['description'],
                    'active' => true,
                ]
            );

            $product->compatibilities()->sync(
                collect($data['vehicles'])->map(fn (int $index) => $vehicles[$index]->id)->all()
            );

            foreach ($data['variants'] as $variantData) {
                $attributes = $variantData['attributes'];
                unset($variantData['attributes']);

                $variant = ProductVariant::updateOrCreate(
                    ['sku' => $variantData['sku']],
                    ['product_id' => $product->id, 'active' => true, ...$variantData]
                );

                $variant->attributes()->delete();

                foreach ($attributes as $name => $value) {
                    $variant->attributes()->create(['name' => $name, 'value' => $value]);
                }
            }
        }

        $this->call([
            MockDataSeeder::class,
            ProductImageSeeder::class,
        ]);
    }
}
