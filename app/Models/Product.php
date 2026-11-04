<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class Product extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'seller_id',
        'name',
        'slug',
        'brand',
        'category',
        'description',
        'image_url',
        'active',
    ];

    protected function casts(): array
    {
        return [
            'active' => 'boolean',
        ];
    }

    public function seller(): BelongsTo
    {
        return $this->belongsTo(Seller::class);
    }

    public function variants(): HasMany
    {
        return $this->hasMany(ProductVariant::class);
    }

    public function compatibilities(): BelongsToMany
    {
        return $this->belongsToMany(
            VehicleModel::class,
            'product_compatibilities',
            'product_id',
            'vehicle_model_id'
        )->withTimestamps();
    }

    public function orderItems(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('active', true);
    }

    public function scopeSearch(Builder $query, ?string $term): Builder
    {
        if (blank($term)) {
            return $query;
        }

        return $query->where(function (Builder $query) use ($term) {
            $query->where('name', 'like', "%{$term}%")
                ->orWhere('brand', 'like', "%{$term}%")
                ->orWhere('category', 'like', "%{$term}%");
        });
    }

    public function scopeCompatibleWith(Builder $query, ?int $vehicleModelId): Builder
    {
        if (blank($vehicleModelId)) {
            return $query;
        }

        return $query->whereHas('compatibilities', fn (Builder $query) => $query->whereKey($vehicleModelId));
    }

    public function getPriceFromAttribute(): ?float
    {
        $price = $this->variants->min('price');

        return $price !== null ? (float) $price : null;
    }

    public function getRouteKeyName(): string
    {
        return 'slug';
    }

    public static function uniqueSlug(string $value, ?int $ignoreId = null): string
    {
        $base = Str::slug($value) ?: 'produto';
        $slug = $base;
        $suffix = 2;

        while (static::withTrashed()
            ->where('slug', $slug)
            ->when($ignoreId, fn (Builder $query) => $query->whereKeyNot($ignoreId))
            ->exists()
        ) {
            $slug = $base . '-' . $suffix++;
        }

        return $slug;
    }
}
