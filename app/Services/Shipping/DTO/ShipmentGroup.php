<?php

namespace App\Services\Shipping\DTO;

use App\Models\Seller;
use Illuminate\Support\Collection;

final readonly class ShipmentGroup
{
    /**
     * @param  Collection<int, ShippingItem>  $items
     */
    public function __construct(
        public Seller $seller,
        public Collection $items,
        public float $subtotal,
        public int $weightGrams,
        public int $cubicWeightGrams,
        public int $lengthCm,
        public int $widthCm,
        public int $heightCm,
    ) {
    }

    public function billableWeightGrams(): int
    {
        return max($this->weightGrams, $this->cubicWeightGrams);
    }

    public function billableWeightKg(): float
    {
        return round($this->billableWeightGrams() / 1000, 3);
    }

    public function itemCount(): int
    {
        return (int) $this->items->sum('quantity');
    }

    public function toArray(): array
    {
        return [
            'seller_id' => $this->seller->id,
            'seller_name' => $this->seller->trade_name,
            'origin_zip_code' => $this->seller->zip_code,
            'subtotal' => $this->subtotal,
            'weight_grams' => $this->weightGrams,
            'cubic_weight_grams' => $this->cubicWeightGrams,
            'billable_weight_grams' => $this->billableWeightGrams(),
            'dimensions' => [
                'length_cm' => $this->lengthCm,
                'width_cm' => $this->widthCm,
                'height_cm' => $this->heightCm,
            ],
            'items' => $this->items->map(fn (ShippingItem $item) => [
                'sku' => $item->variant->sku,
                'quantity' => $item->quantity,
                'unit_price' => (float) $item->variant->price,
                'weight_grams' => $item->variant->effective_weight_grams,
                'dimensions' => [
                    'length_cm' => $item->variant->length_cm,
                    'width_cm' => $item->variant->width_cm,
                    'height_cm' => $item->variant->height_cm,
                ],
            ])->values()->all(),
        ];
    }
}
