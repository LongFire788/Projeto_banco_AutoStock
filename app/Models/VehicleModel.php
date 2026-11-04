<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class VehicleModel extends Model
{
    use HasFactory;

    protected $fillable = [
        'brand',
        'model',
        'year_start',
        'year_end',
        'engine',
    ];

    protected function casts(): array
    {
        return [
            'year_start' => 'integer',
            'year_end' => 'integer',
        ];
    }

    public function products(): BelongsToMany
    {
        return $this->belongsToMany(
            Product::class,
            'product_compatibilities',
            'vehicle_model_id',
            'product_id'
        )->withTimestamps();
    }

    public function scopeSearch(Builder $query, ?string $term): Builder
    {
        if (blank($term)) {
            return $query;
        }

        return $query->where(function (Builder $query) use ($term) {
            $query->where('brand', 'like', "%{$term}%")
                ->orWhere('model', 'like', "%{$term}%")
                ->orWhere('engine', 'like', "%{$term}%");
        });
    }

    public function getDisplayNameAttribute(): string
    {
        return sprintf(
            '%s %s (%d-%d)%s',
            $this->brand,
            $this->model,
            $this->year_start,
            $this->year_end,
            $this->engine ? ' - ' . $this->engine : ''
        );
    }
}
