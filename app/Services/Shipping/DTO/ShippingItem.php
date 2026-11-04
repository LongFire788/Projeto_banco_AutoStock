<?php

namespace App\Services\Shipping\DTO;

use App\Models\ProductVariant;

final readonly class ShippingItem
{
    public function __construct(
        public ProductVariant $variant,
        public int $quantity,
    ) {
    }

    public function subtotal(): float
    {
        return round((float) $this->variant->price * $this->quantity, 2);
    }

    public function weightGrams(): int
    {
        return $this->variant->effective_weight_grams * $this->quantity;
    }

    public function cubicWeightGrams(): int
    {
        return (int) ceil(
            ($this->variant->length_cm * $this->variant->width_cm * $this->variant->height_cm * $this->quantity) / 6
        );
    }
}
