<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Payment extends Model
{
    use HasFactory;

    public const STATUS_PENDING = 'pending';
    public const STATUS_PAID = 'paid';
    public const STATUS_FAILED = 'failed';
    public const STATUS_REFUNDED = 'refunded';

    protected $fillable = [
        'order_id',
        'seller_id',
        'gateway',
        'gateway_payment_id',
        'gateway_receiver_id',
        'amount',
        'platform_fee',
        'seller_amount',
        'status',
        'paid_at',
        'payload',
    ];

    protected function casts(): array
    {
        return [
            'amount' => 'decimal:2',
            'platform_fee' => 'decimal:2',
            'seller_amount' => 'decimal:2',
            'paid_at' => 'datetime',
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

    public function getStatusLabelAttribute(): string
    {
        return match ($this->status) {
            self::STATUS_PENDING => 'Pendente',
            self::STATUS_PAID => 'Aprovado',
            self::STATUS_FAILED => 'Recusado',
            self::STATUS_REFUNDED => 'Estornado',
            default => ucfirst($this->status),
        };
    }
}
