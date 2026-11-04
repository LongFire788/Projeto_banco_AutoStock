<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Seller extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'legal_name',
        'trade_name',
        'document',
        'email',
        'phone',
        'zip_code',
        'address_street',
        'address_number',
        'address_complement',
        'address_neighborhood',
        'address_city',
        'address_state',
        'gateway_receiver_id',
        'active',
    ];

    protected function casts(): array
    {
        return [
            'active' => 'boolean',
        ];
    }

    public function products(): HasMany
    {
        return $this->hasMany(Product::class);
    }

    public function orderShipments(): HasMany
    {
        return $this->hasMany(OrderShipment::class);
    }

    public function payments(): HasMany
    {
        return $this->hasMany(Payment::class);
    }

    public function scopeActive($query)
    {
        return $query->where('active', true);
    }

    public function scopeSearch($query, ?string $term)
    {
        if (blank($term)) {
            return $query;
        }

        return $query->where(function ($query) use ($term) {
            $query->where('legal_name', 'like', "%{$term}%")
                ->orWhere('trade_name', 'like', "%{$term}%")
                ->orWhere('document', 'like', "%{$term}%")
                ->orWhere('email', 'like', "%{$term}%")
                ->orWhere('address_city', 'like', "%{$term}%");
        });
    }

    public function getFullAddressAttribute(): string
    {
        return sprintf(
            '%s, %s%s - %s, %s/%s - CEP %s',
            $this->address_street,
            $this->address_number,
            $this->address_complement ? ' ' . $this->address_complement : '',
            $this->address_neighborhood,
            $this->address_city,
            $this->address_state,
            $this->zip_code
        );
    }
}
