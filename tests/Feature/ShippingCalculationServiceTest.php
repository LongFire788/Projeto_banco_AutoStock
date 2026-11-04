<?php

namespace Tests\Feature;

use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\Seller;
use App\Services\Shipping\DTO\ShippingItem;
use App\Services\Shipping\ShippingCalculationService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ShippingCalculationServiceTest extends TestCase
{
    use RefreshDatabase;

    public function test_it_groups_cart_items_by_seller_and_builds_one_payload_per_origin(): void
    {
        $sellerSp = Seller::factory()->create(['zip_code' => '01310100', 'trade_name' => 'Loja SP']);
        $sellerPr = Seller::factory()->create(['zip_code' => '80420000', 'trade_name' => 'Loja PR']);

        $variantSp = ProductVariant::factory()
            ->for(Product::factory()->for($sellerSp))
            ->create([
                'price' => 100.00,
                'weight_grams' => 2000,
                'length_cm' => 30,
                'width_cm' => 20,
                'height_cm' => 10,
            ]);

        $variantPr = ProductVariant::factory()
            ->for(Product::factory()->for($sellerPr))
            ->create([
                'price' => 50.00,
                'weight_grams' => 1000,
                'length_cm' => 20,
                'width_cm' => 10,
                'height_cm' => 10,
            ]);

        $items = collect([
            new ShippingItem($variantSp->load('product.seller'), 2),
            new ShippingItem($variantPr->load('product.seller'), 1),
        ]);

        $service = app(ShippingCalculationService::class);
        $groups = $service->groupBySeller($items);

        $this->assertCount(2, $groups);

        $groupSp = $groups->firstWhere('seller.id', $sellerSp->id);
        $this->assertNotNull($groupSp);
        $this->assertSame(200.0, $groupSp->subtotal);
        $this->assertSame(4000, $groupSp->weightGrams);

        $payloads = $service->buildPayloads($items, '20040-020');

        $this->assertCount(2, $payloads);
        $this->assertSame('01310100', $payloads[$sellerSp->id]['from']['postal_code']);
        $this->assertSame('80420000', $payloads[$sellerPr->id]['from']['postal_code']);
        $this->assertSame('20040020', $payloads[$sellerSp->id]['to']['postal_code']);
        $this->assertSame(2, $payloads[$sellerSp->id]['products'][0]['quantity']);
        $this->assertSame(2.0, $payloads[$sellerSp->id]['products'][0]['weight']);
        $this->assertSame(4.0, $payloads[$sellerSp->id]['volumes'][0]['weight']);
    }

    public function test_it_returns_quotes_per_seller_with_a_shipping_total(): void
    {
        $sellerA = Seller::factory()->create();
        $sellerB = Seller::factory()->create();

        $variantA = ProductVariant::factory()->for(Product::factory()->for($sellerA))->create(['price' => 80]);
        $variantB = ProductVariant::factory()->for(Product::factory()->for($sellerB))->create(['price' => 120]);

        $items = collect([
            new ShippingItem($variantA->load('product.seller'), 1),
            new ShippingItem($variantB->load('product.seller'), 1),
        ]);

        $quote = app(ShippingCalculationService::class)->quoteCart($items, '01310100');

        $this->assertCount(2, $quote['groups']);
        $this->assertGreaterThan(0, $quote['shipping_total']);
        $this->assertNotEmpty($quote['groups'][0]['options']);
        $this->assertSame('PAC', $quote['groups'][0]['default_service_code']);
    }
}
