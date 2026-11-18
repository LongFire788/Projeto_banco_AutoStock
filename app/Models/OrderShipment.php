<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class OrderShipment extends Model
{
    use HasFactory;

    public const STATUS_PENDING = 'pending';
    public const STATUS_LABEL_GENERATED = 'label_generated';
    public const STATUS_POSTED = 'posted';
    public const STATUS_DELIVERED = 'delivered';
    public const STATUS_CANCELLED = 'cancelled';

    protected $fillable = [
        'order_id',
        'seller_id',
        'shipping_method',
        'shipping_service_code',
        'tracking_code',
        'shipping_cost',
        'status',
        'estimated_delivery_date',
        'payload',
    ];

    protected function casts(): array
    {
        return [
            'shipping_cost' => 'decimal:2',
            'estimated_delivery_date' => 'date',
            'payload' => 'array',
        ];
    }

    public function order(): BelongsTo
    {
        return $this->belongsTo(Order::class);
    }

    public function seller(): BelongsTo
    {
        return $this->belongsTo(Seller::class);
    }

    public function items(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }

    public function getStatusLabelAttribute(): string
    {
        return self::statusLabels()[$this->status] ?? ucfirst((string) $this->status);
    }

    /**
     * @return array<string, string>
     */
    public static function statusLabels(): array
    {
        return [
            self::STATUS_PENDING => 'Pendente',
            self::STATUS_LABEL_GENERATED => 'Etiqueta gerada',
            self::STATUS_POSTED => 'Postado',
            self::STATUS_DELIVERED => 'Entregue',
            self::STATUS_CANCELLED => 'Cancelado',
        ];
    }

    public static function statuses(): array
    {
        return [
            self::STATUS_PENDING,
            self::STATUS_LABEL_GENERATED,
            self::STATUS_POSTED,
            self::STATUS_DELIVERED,
            self::STATUS_CANCELLED,
        ];
    }
}
