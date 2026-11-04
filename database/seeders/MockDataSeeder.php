<?php

namespace Database\Seeders;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\OrderShipment;
use App\Models\Payment;
use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\Seller;
use App\Models\VehicleModel;
use App\Services\Payments\PixPayloadBuilder;
use Illuminate\Database\Seeder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

/**
 * Popula a base com dados de demonstração:
 *  - 200 produtos (com variações/SKUs, atributos e compatibilidade veicular)
 *  - 200 pedidos (com itens, envios por vendedor, split de pagamento e Pix)
 *
 * O seeder é idempotente: se a base já tiver 200 produtos/pedidos, não duplica.
 */
class MockDataSeeder extends Seeder
{
    private const PRODUCT_TARGET = 200;

    private const ORDER_TARGET = 200;

    private const SELLER_TARGET = 8;

    private int $skuSequence = 1;

    public function run(): void
    {
        // Deixa a geração reproduzível entre execuções.
        mt_srand(20261104);

        $sellers = $this->ensureSellers();
        $vehicles = $this->ensureVehicles();

        $this->createProducts($sellers, $vehicles);
        $this->createOrders();

        $this->command?->info(sprintf(
            'MockDataSeeder: %d produtos, %d variações e %d pedidos na base.',
            Product::count(),
            ProductVariant::count(),
            Order::count(),
        ));
    }

    private function ensureSellers(): Collection
    {
        while (Seller::count() < self::SELLER_TARGET) {
            Seller::factory()->create();
        }

        return Seller::query()->where('active', true)->get();
    }

    private function ensureVehicles(): Collection
    {
        $extra = [
            ['brand' => 'Chevrolet', 'model' => 'Cruze', 'year_start' => 2017, 'year_end' => 2023, 'engine' => '1.4 Turbo'],
            ['brand' => 'Hyundai', 'model' => 'HB20', 'year_start' => 2019, 'year_end' => 2024, 'engine' => '1.0 12V Flex'],
            ['brand' => 'Renault', 'model' => 'Kwid', 'year_start' => 2018, 'year_end' => 2024, 'engine' => '1.0 12V Flex'],
            ['brand' => 'Jeep', 'model' => 'Renegade', 'year_start' => 2016, 'year_end' => 2023, 'engine' => '1.8 16V Flex'],
            ['brand' => 'Nissan', 'model' => 'Kicks', 'year_start' => 2017, 'year_end' => 2023, 'engine' => '1.6 16V Flex'],
            ['brand' => 'Ford', 'model' => 'Ka', 'year_start' => 2015, 'year_end' => 2021, 'engine' => '1.0 12V Flex'],
            ['brand' => 'Fiat', 'model' => 'Toro', 'year_start' => 2017, 'year_end' => 2023, 'engine' => '1.8 16V Flex'],
            ['brand' => 'Volkswagen', 'model' => 'T-Cross', 'year_start' => 2020, 'year_end' => 2024, 'engine' => '1.0 TSI'],
            ['brand' => 'Toyota', 'model' => 'Yaris', 'year_start' => 2019, 'year_end' => 2023, 'engine' => '1.5 16V Flex'],
            ['brand' => 'Honda', 'model' => 'HR-V', 'year_start' => 2016, 'year_end' => 2022, 'engine' => '1.8 16V Flex'],
            ['brand' => 'Chevrolet', 'model' => 'S10', 'year_start' => 2016, 'year_end' => 2022, 'engine' => '2.5 Flex'],
            ['brand' => 'Fiat', 'model' => 'Strada', 'year_start' => 2015, 'year_end' => 2023, 'engine' => '1.4 8V Flex'],
        ];

        foreach ($extra as $vehicle) {
            VehicleModel::firstOrCreate($vehicle);
        }

        return VehicleModel::query()->orderBy('id')->get();
    }

    private function createProducts(Collection $sellers, Collection $vehicles): void
    {
        $missing = self::PRODUCT_TARGET - Product::count();

        if ($missing <= 0) {
            return;
        }

        $catalog = $this->catalog();
        $categories = array_keys($catalog);
        $brands = [
            'Cofap', 'Monroe', 'Nakata', 'Bosch', 'Mann Filter', 'Mahle', 'Gates', 'NGK',
            'Valeo', 'Delphi', 'Magneti Marelli', 'SKF', 'TRW', 'Varga', 'Moura', 'Heliar',
            'Denso', 'Sachs', 'Continental', 'Fram',
        ];
        $specs = ['Original', 'Linha Leve', 'Reforçado', 'Premium', 'HD', 'Série Ouro'];

        $usedNames = [];
        $created = 0;

        while ($created < $missing) {
            $category = $categories[$created % count($categories)];
            $config = $catalog[$category];
            $part = fake()->randomElement($config['parts']);
            $brand = fake()->randomElement($brands);
            $spec = fake()->boolean(30) ? fake()->randomElement($specs) : null;

            $name = trim("{$part} {$brand} " . ($spec ?? ''));

            if (isset($usedNames[$name])) {
                $attempts = 0;

                do {
                    $part = fake()->randomElement($config['parts']);
                    $brand = fake()->randomElement($brands);
                    $spec = fake()->boolean(50) ? fake()->randomElement($specs) : null;
                    $name = trim("{$part} {$brand} " . ($spec ?? ''));
                    $attempts++;
                } while (isset($usedNames[$name]) && $attempts < 20);

                if (isset($usedNames[$name])) {
                    $name .= ' Geração ' . ($created + 1);
                }
            }

            $usedNames[$name] = true;

            $product = Product::create([
                'seller_id' => $sellers->random()->id,
                'name' => $name,
                'slug' => Product::uniqueSlug($name),
                'brand' => $brand,
                'category' => $category,
                'description' => $this->description($part, $brand, $category),
                'image_url' => null,
                'active' => true,
            ]);

            $compatibilities = $vehicles
                ->random(fake()->numberBetween(1, min(4, $vehicles->count())))
                ->pluck('id')
                ->all();

            $product->compatibilities()->sync($compatibilities);

            $variantNames = fake()->numberBetween(1, 3) === 1
                ? ['Único']
                : fake()->randomElements(
                    ['Lado Direito', 'Lado Esquerdo', 'Dianteiro', 'Traseiro', 'Original', 'Reforçado', 'Esportivo', 'HD'],
                    fake()->numberBetween(2, 3),
                );

            $basePrice = fake()->randomFloat(2, $config['price'][0], $config['price'][1]);

            foreach ($variantNames as $index => $variantName) {
                $price = round($basePrice * fake()->randomFloat(2, 0.94, 1.08), 2);
                $compareAt = fake()->boolean(45)
                    ? round($price * fake()->randomFloat(2, 1.08, 1.28), 2)
                    : null;

                $variant = ProductVariant::create([
                    'product_id' => $product->id,
                    'sku' => $this->sku($brand),
                    'name' => $variantName,
                    'price' => $price,
                    'compare_at_price' => $compareAt,
                    'stock' => fake()->boolean(12) ? 0 : fake()->numberBetween(1, 80),
                    'weight_grams' => fake()->numberBetween(...$config['weight']),
                    'length_cm' => fake()->numberBetween(...$config['length']),
                    'width_cm' => fake()->numberBetween(...$config['width']),
                    'height_cm' => fake()->numberBetween(...$config['height']),
                    'active' => true,
                ]);

                $attributes = [
                    'Material' => fake()->randomElement($config['attrs']),
                    'Garantia' => fake()->randomElement(['6 meses', '12 meses', '24 meses']),
                ];

                if (count($variantNames) > 1) {
                    $attributes = ['Posição' => $variantName] + $attributes;
                }

                if ($index === 0 && fake()->boolean(35)) {
                    $attributes['Origem'] = fake()->randomElement(['Nacional', 'Importado']);
                }

                foreach ($attributes as $attributeName => $attributeValue) {
                    $variant->attributes()->create([
                        'name' => $attributeName,
                        'value' => $attributeValue,
                    ]);
                }
            }

            $created++;
        }
    }

    private function createOrders(): void
    {
        $missing = self::ORDER_TARGET - Order::count();

        if ($missing <= 0) {
            return;
        }

        $variants = ProductVariant::query()
            ->with('product')
            ->where('active', true)
            ->whereHas('product', fn ($query) => $query->where('active', true))
            ->get();

        if ($variants->isEmpty()) {
            $this->command?->warn('MockDataSeeder: nenhuma variação ativa encontrada para gerar pedidos.');

            return;
        }

        $pix = app(PixPayloadBuilder::class);
        $locations = $this->locations();

        for ($i = 0; $i < $missing; $i++) {
            $placedAt = Carbon::now()
                ->subDays(fake()->numberBetween(0, 120))
                ->subMinutes(fake()->numberBetween(0, 1439));

            $selected = $variants->random(fake()->numberBetween(1, min(3, $variants->count())));
            $selected = $selected instanceof ProductVariant ? collect([$selected]) : $selected;

            $quantities = $selected->mapWithKeys(
                fn (ProductVariant $variant) => [$variant->id => fake()->numberBetween(1, 2)]
            );

            $status = $this->randomStatus();
            $paymentMethod = fake()->randomElement(['pix', 'pix', 'credit_card', 'credit_card', 'boleto']);
            $location = fake()->randomElement($locations);

            DB::transaction(function () use (
                $selected,
                $quantities,
                $status,
                $paymentMethod,
                $location,
                $placedAt,
                $pix,
            ) {
                $number = $this->generateOrderNumber($placedAt);

                $subtotal = round($selected->sum(
                    fn (ProductVariant $variant) => (float) $variant->price * $quantities[$variant->id]
                ), 2);

                $groups = $selected->groupBy(fn (ProductVariant $variant) => $variant->product->seller_id);

                $shippingPlans = [];
                $shippingTotal = 0.0;

                foreach ($groups as $sellerId => $sellerVariants) {
                    $plan = $this->shippingPlan($sellerVariants, $quantities);
                    $shippingPlans[$sellerId] = $plan;
                    $shippingTotal += $plan['price'];
                }

                $shippingTotal = round($shippingTotal, 2);
                $total = round($subtotal + $shippingTotal, 2);
                $paymentStatus = match ($status) {
                    Order::STATUS_PENDING => Order::PAYMENT_PENDING,
                    Order::STATUS_CANCELLED => Order::PAYMENT_REFUNDED,
                    default => Order::PAYMENT_PAID,
                };

                $order = Order::create([
                    'number' => $number,
                    'customer_name' => fake()->name(),
                    'customer_email' => fake()->safeEmail(),
                    'customer_document' => preg_replace('/\D/', '', fake()->cpf()),
                    'customer_phone' => sprintf('(%s) 9%s-%s', fake()->numerify('##'), fake()->numerify('####'), fake()->numerify('####')),
                    'shipping_zip_code' => $location['zip'],
                    'shipping_street' => $location['street'],
                    'shipping_number' => (string) fake()->numberBetween(10, 3200),
                    'shipping_complement' => fake()->boolean(30) ? 'Apto ' . fake()->numberBetween(11, 999) : null,
                    'shipping_neighborhood' => $location['neighborhood'],
                    'shipping_city' => $location['city'],
                    'shipping_state' => $location['state'],
                    'subtotal' => $subtotal,
                    'shipping_total' => $shippingTotal,
                    'discount_total' => 0,
                    'total' => $total,
                    'status' => $status,
                    'payment_status' => $paymentStatus,
                    'payment_method' => $paymentMethod,
                    'pix_payload' => $paymentMethod === 'pix' ? $pix->payload($total, $number) : null,
                    'pix_expires_at' => $paymentMethod === 'pix' ? $placedAt->copy()->addMinutes(30) : null,
                    'notes' => null,
                    'placed_at' => $placedAt,
                ]);

                $shipmentStatus = $this->shipmentStatus($status);
                $trackingCode = in_array($shipmentStatus, [OrderShipment::STATUS_POSTED, OrderShipment::STATUS_DELIVERED], true)
                    ? Str::upper(Str::random(2)) . fake()->numerify('#########') . 'BR'
                    : null;

                foreach ($groups as $sellerId => $sellerVariants) {
                    $plan = $shippingPlans[$sellerId];
                    $seller = $sellerVariants->first()->product->seller;

                    $shipment = OrderShipment::create([
                        'order_id' => $order->id,
                        'seller_id' => $sellerId,
                        'shipping_method' => $plan['name'],
                        'shipping_service_code' => $plan['code'],
                        'tracking_code' => $trackingCode,
                        'shipping_cost' => $plan['price'],
                        'status' => $shipmentStatus,
                        'estimated_delivery_date' => $plan['days'] > 0
                            ? $placedAt->copy()->addWeekdays($plan['days'])->toDateString()
                            : null,
                        'payload' => [
                            'quote' => [
                                'service_code' => $plan['code'],
                                'service_name' => $plan['name'],
                                'price' => $plan['price'],
                                'delivery_days' => $plan['days'],
                                'is_pickup' => $plan['code'] === 'PICKUP',
                            ],
                            'package' => [
                                'seller_id' => $sellerId,
                                'seller_name' => $seller->trade_name,
                                'origin_zip_code' => $seller->zip_code,
                                'destination_zip_code' => $location['zip'],
                                'items_count' => $sellerVariants->sum(fn (ProductVariant $variant) => $quantities[$variant->id]),
                                'weight_kg' => round($sellerVariants->sum(
                                    fn (ProductVariant $variant) => $variant->effective_weight_grams * $quantities[$variant->id]
                                ) / 1000, 3),
                            ],
                        ],
                    ]);

                    $sellerSubtotal = 0.0;

                    foreach ($sellerVariants as $variant) {
                        $quantity = $quantities[$variant->id];
                        $lineTotal = round((float) $variant->price * $quantity, 2);
                        $sellerSubtotal += $lineTotal;

                        OrderItem::create([
                            'order_id' => $order->id,
                            'order_shipment_id' => $shipment->id,
                            'seller_id' => $sellerId,
                            'product_id' => $variant->product_id,
                            'product_variant_id' => $variant->id,
                            'product_name' => $variant->product->name,
                            'variant_name' => $variant->name,
                            'sku' => $variant->sku,
                            'quantity' => $quantity,
                            'unit_price' => $variant->price,
                            'total' => $lineTotal,
                            'weight_grams' => $variant->weight_grams,
                            'length_cm' => $variant->length_cm,
                            'width_cm' => $variant->width_cm,
                            'height_cm' => $variant->height_cm,
                        ]);
                    }

                    $sellerSubtotal = round($sellerSubtotal, 2);
                    $platformFee = round($sellerSubtotal * 0.10, 2);
                    $amount = round($sellerSubtotal + $plan['price'], 2);

                    Payment::create([
                        'order_id' => $order->id,
                        'seller_id' => $sellerId,
                        'gateway' => 'sandbox',
                        'gateway_payment_id' => 'SIM-' . Str::ulid(),
                        'gateway_receiver_id' => $seller->gateway_receiver_id,
                        'amount' => $amount,
                        'platform_fee' => $platformFee,
                        'seller_amount' => round($amount - $platformFee, 2),
                        'status' => match ($paymentStatus) {
                            Order::PAYMENT_PAID => Payment::STATUS_PAID,
                            Order::PAYMENT_REFUNDED => Payment::STATUS_REFUNDED,
                            default => Payment::STATUS_PENDING,
                        },
                        'paid_at' => in_array($paymentStatus, [Order::PAYMENT_PAID, Order::PAYMENT_REFUNDED], true)
                            ? $placedAt->copy()->addMinutes(fake()->numberBetween(1, 120))
                            : null,
                        'payload' => [
                            'payment_method' => $paymentMethod,
                            'split' => [
                                'receiver_id' => $seller->gateway_receiver_id,
                                'seller_amount' => round($amount - $platformFee, 2),
                                'platform_fee' => $platformFee,
                                'platform_fee_percent' => 10,
                            ],
                        ],
                    ]);
                }

                // Mantém o histórico do pedido coerente com a data em que foi feito.
                $order->timestamps = false;
                $order->forceFill([
                    'created_at' => $placedAt,
                    'updated_at' => $placedAt,
                ])->save();
            });
        }
    }

    /**
     * @param  Collection<int, ProductVariant>  $variants
     * @param  Collection<int, int>  $quantities
     * @return array{code: string, name: string, price: float, days: int}
     */
    private function shippingPlan(Collection $variants, Collection $quantities): array
    {
        $weightKg = max(0.3, $variants->sum(
            fn (ProductVariant $variant) => $variant->effective_weight_grams * $quantities[$variant->id]
        ) / 1000);

        $itemCount = max(1, $variants->sum(fn (ProductVariant $variant) => $quantities[$variant->id]));
        $economic = round(14.90 + ($weightKg * 2.35) + ($itemCount * 1.50), 2);

        $roll = fake()->numberBetween(1, 100);

        if ($roll <= 50) {
            return [
                'code' => 'PAC',
                'name' => 'Econômico (PAC)',
                'price' => $economic,
                'days' => 4 + (int) ceil($weightKg / 2),
            ];
        }

        if ($roll <= 85) {
            return [
                'code' => 'SEDEX',
                'name' => 'Expresso (SEDEX)',
                'price' => round($economic * 1.65, 2),
                'days' => 2 + (int) ceil($weightKg / 4),
            ];
        }

        return [
            'code' => 'PICKUP',
            'name' => 'Retirar no lojista',
            'price' => 0.0,
            'days' => 0,
        ];
    }

    private function randomStatus(): string
    {
        $roll = fake()->numberBetween(1, 100);

        return match (true) {
            $roll <= 15 => Order::STATUS_PENDING,
            $roll <= 35 => Order::STATUS_PAID,
            $roll <= 55 => Order::STATUS_PROCESSING,
            $roll <= 75 => Order::STATUS_SHIPPED,
            $roll <= 95 => Order::STATUS_DELIVERED,
            default => Order::STATUS_CANCELLED,
        };
    }

    private function shipmentStatus(string $orderStatus): string
    {
        return match ($orderStatus) {
            Order::STATUS_PROCESSING => OrderShipment::STATUS_LABEL_GENERATED,
            Order::STATUS_SHIPPED => OrderShipment::STATUS_POSTED,
            Order::STATUS_DELIVERED => OrderShipment::STATUS_DELIVERED,
            Order::STATUS_CANCELLED => OrderShipment::STATUS_CANCELLED,
            default => OrderShipment::STATUS_PENDING,
        };
    }

    private function generateOrderNumber(Carbon $placedAt): string
    {
        do {
            $number = 'ORD-' . $placedAt->format('Ymd') . '-' . Str::upper(Str::random(6));
        } while (Order::query()->where('number', $number)->exists());

        return $number;
    }

    private function sku(string $brand): string
    {
        $prefix = Str::upper(Str::substr(preg_replace('/[^A-Za-z]/', '', Str::ascii($brand)) ?? 'SKU', 0, 4));

        return $prefix . '-' . str_pad((string) $this->skuSequence++, 5, '0', STR_PAD_LEFT);
    }

    private function description(string $part, string $brand, string $category): string
    {
        return sprintf(
            '%s %s, categoria %s. Peça de reposição com procedência garantida, '
            . 'ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.',
            $part,
            $brand,
            $category,
        );
    }

    /**
     * @return array<string, array{parts: array<int, string>, price: array{0: float, 1: float}, weight: array{0: int, 1: int}, length: array{0: int, 1: int}, width: array{0: int, 1: int}, height: array{0: int, 1: int}, attrs: array<int, string>}>
     */
    private function catalog(): array
    {
        return [
            'Suspensão' => [
                'parts' => [
                    'Amortecedor Dianteiro', 'Amortecedor Traseiro', 'Kit Amortecedores', 'Mola Helicoidal',
                    'Bandeja de Suspensão', 'Pivô de Suspensão', 'Bucha da Bandeja', 'Terminal de Direção',
                    'Barra Estabilizadora', 'Coxim do Motor',
                ],
                'price' => [149.90, 899.90],
                'weight' => [1200, 9000],
                'length' => [40, 80],
                'width' => [15, 30],
                'height' => [12, 25],
                'attrs' => ['Aço', 'Alumínio', 'Borracha'],
            ],
            'Freios' => [
                'parts' => [
                    'Pastilha de Freio', 'Disco de Freio', 'Tambor de Freio', 'Lonas de Freio',
                    'Flexível de Freio', 'Cilindro de Roda', 'Kit Freio Traseiro', 'Fluido de Freio',
                ],
                'price' => [39.90, 649.90],
                'weight' => [300, 6500],
                'length' => [20, 35],
                'width' => [15, 30],
                'height' => [5, 15],
                'attrs' => ['Cerâmica', 'Aço', 'Ferro Fundido'],
            ],
            'Motor' => [
                'parts' => [
                    'Filtro de Óleo', 'Filtro de Ar', 'Filtro de Combustível', 'Correia Dentada',
                    'Kit Correia Dentada', 'Vela de Ignição', 'Bomba d\'Água', 'Bomba de Combustível',
                    'Junta do Cabeçote', 'Tensor da Correia',
                ],
                'price' => [24.90, 459.90],
                'weight' => [200, 4200],
                'length' => [15, 40],
                'width' => [10, 30],
                'height' => [8, 25],
                'attrs' => ['Aço', 'Alumínio', 'Borracha', 'Papel'],
            ],
            'Elétrica' => [
                'parts' => [
                    'Bateria 60Ah', 'Bateria 70Ah', 'Alternador', 'Motor de Partida',
                    'Sensor de Oxigênio', 'Sensor de Rotação', 'Bobina de Ignição', 'Lâmpada Farol',
                ],
                'price' => [29.90, 1290.00],
                'weight' => [100, 15000],
                'length' => [20, 40],
                'width' => [15, 30],
                'height' => [15, 30],
                'attrs' => ['Cobre', 'Chumbo', 'Alumínio'],
            ],
            'Arrefecimento' => [
                'parts' => [
                    'Radiador', 'Mangueira do Radiador', 'Válvula Termostática', 'Ventilador do Radiador',
                    'Reservatório de Água', 'Eletroventilador',
                ],
                'price' => [49.90, 899.90],
                'weight' => [400, 6000],
                'length' => [40, 90],
                'width' => [30, 60],
                'height' => [10, 30],
                'attrs' => ['Alumínio', 'Plástico', 'Borracha'],
            ],
            'Transmissão' => [
                'parts' => [
                    'Kit Embreagem', 'Rolamento de Embreagem', 'Atuador de Embreagem',
                    'Junta Homocinética', 'Coifa da Homocinética',
                ],
                'price' => [89.90, 1490.00],
                'weight' => [800, 12000],
                'length' => [30, 50],
                'width' => [25, 40],
                'height' => [15, 30],
                'attrs' => ['Aço', 'Ferro Fundido', 'Borracha'],
            ],
            'Acessórios' => [
                'parts' => [
                    'Palheta Limpador', 'Tapete Automotivo', 'Capa de Volante', 'Antena Automotiva',
                    'Calota', 'Protetor de Carter', 'Kit Ferramentas',
                ],
                'price' => [19.90, 299.90],
                'weight' => [150, 2500],
                'length' => [30, 80],
                'width' => [10, 30],
                'height' => [5, 20],
                'attrs' => ['Borracha', 'Plástico', 'Nylon'],
            ],
            'Direção' => [
                'parts' => [
                    'Caixa de Direção', 'Bomba de Direção Hidráulica', 'Terminal Axial', 'Coifa de Direção',
                ],
                'price' => [69.90, 1190.00],
                'weight' => [600, 8500],
                'length' => [30, 70],
                'width' => [20, 40],
                'height' => [15, 30],
                'attrs' => ['Aço', 'Alumínio', 'Borracha'],
            ],
        ];
    }

    /**
     * @return array<int, array{city: string, state: string, zip: string, neighborhood: string, street: string}>
     */
    private function locations(): array
    {
        return [
            ['city' => 'São Paulo', 'state' => 'SP', 'zip' => '01310100', 'neighborhood' => 'Bela Vista', 'street' => 'Avenida Paulista'],
            ['city' => 'Rio de Janeiro', 'state' => 'RJ', 'zip' => '20040020', 'neighborhood' => 'Centro', 'street' => 'Avenida Rio Branco'],
            ['city' => 'Belo Horizonte', 'state' => 'MG', 'zip' => '30130010', 'neighborhood' => 'Centro', 'street' => 'Avenida Afonso Pena'],
            ['city' => 'Curitiba', 'state' => 'PR', 'zip' => '80420000', 'neighborhood' => 'Centro', 'street' => 'Rua Comendador Araújo'],
            ['city' => 'Porto Alegre', 'state' => 'RS', 'zip' => '90010150', 'neighborhood' => 'Centro Histórico', 'street' => 'Rua dos Andradas'],
            ['city' => 'Salvador', 'state' => 'BA', 'zip' => '40015010', 'neighborhood' => 'Comércio', 'street' => 'Avenida da França'],
            ['city' => 'Recife', 'state' => 'PE', 'zip' => '50030230', 'neighborhood' => 'Boa Vista', 'street' => 'Rua da Aurora'],
            ['city' => 'Fortaleza', 'state' => 'CE', 'zip' => '60060180', 'neighborhood' => 'Centro', 'street' => 'Rua Floriano Peixoto'],
            ['city' => 'Brasília', 'state' => 'DF', 'zip' => '70040900', 'neighborhood' => 'Asa Sul', 'street' => 'SQS 308'],
            ['city' => 'Goiânia', 'state' => 'GO', 'zip' => '74003010', 'neighborhood' => 'Setor Central', 'street' => 'Avenida Anhanguera'],
            ['city' => 'Campinas', 'state' => 'SP', 'zip' => '13010111', 'neighborhood' => 'Centro', 'street' => 'Rua Barão de Jaguara'],
            ['city' => 'Florianópolis', 'state' => 'SC', 'zip' => '88010400', 'neighborhood' => 'Centro', 'street' => 'Rua Felipe Schmidt'],
        ];
    }
}
