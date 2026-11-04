<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class ProductVariant extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'product_id',
        'sku',
        'name',
        'price',
        'compare_at_price',
        'stock',
        'weight_grams',
        'length_cm',
        'width_cm',
        'height_cm',
        'active',
    ];

    protected function casts(): array
    {
        return [
            'price' => 'decimal:2',
            'compare_at_price' => 'decimal:2',
            'stock' => 'integer',
            'weight_grams' => 'integer',
            'length_cm' => 'integer',
            'width_cm' => 'integer',
            'height_cm' => 'integer',
            'active' => 'boolean',
        ];
    }

    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }

    public function attributes(): HasMany
    {
        return $this->hasMany(VariantAttribute::class);
    }

    public function orderItems(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('active', true);
    }

    public function isInStock(int $quantity = 1): bool
    {
        return $this->stock >= $quantity;
    }

    /**
     * Peso cúbico em gramas (divisor 6000 usado por Correios/Melhor Envio).
     */
    public function getCubicWeightGramsAttribute(): int
    {
        return (int) ceil(($this->length_cm * $this->width_cm * $this->height_cm) / 6);
    }

    public function getEffectiveWeightGramsAttribute(): int
    {
        return max($this->weight_grams, $this->cubicWeightGrams);
    }

    public function getDimensionsLabelAttribute(): string
    {
        return sprintf('%d x %d x %d cm', $this->length_cm, $this->width_cm, $this->height_cm);
    }
}
