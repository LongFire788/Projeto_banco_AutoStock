<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Order extends Model
{
    use HasFactory;

    public const STATUS_PENDING = 'pending';
    public const STATUS_PAID = 'paid';
    public const STATUS_PROCESSING = 'processing';
    public const STATUS_SHIPPED = 'shipped';
    public const STATUS_DELIVERED = 'delivered';
    public const STATUS_CANCELLED = 'cancelled';

    public const PAYMENT_PENDING = 'pending';
    public const PAYMENT_PAID = 'paid';
    public const PAYMENT_FAILED = 'failed';
    public const PAYMENT_REFUNDED = 'refunded';

    protected $fillable = [
        'number',
        'customer_name',
        'customer_email',
        'customer_document',
        'customer_phone',
        'shipping_zip_code',
        'shipping_street',
        'shipping_number',
        'shipping_complement',
        'shipping_neighborhood',
        'shipping_city',
        'shipping_state',
        'subtotal',
        'shipping_total',
        'discount_total',
        'total',
        'status',
        'payment_status',
        'payment_method',
        'pix_payload',
        'pix_expires_at',
        'notes',
        'placed_at',
    ];

    protected function casts(): array
    {
        return [
            'subtotal' => 'decimal:2',
            'shipping_total' => 'decimal:2',
            'discount_total' => 'decimal:2',
            'total' => 'decimal:2',
            'pix_expires_at' => 'datetime',
            'placed_at' => 'datetime',
        ];
    }

    public function items(): HasMany
    {
        return $this->hasMany(OrderItem::class);
    }

    public function shipments(): HasMany
    {
        return $this->hasMany(OrderShipment::class);
    }

    public function payments(): HasMany
    {
        return $this->hasMany(Payment::class);
    }

    public function scopeSearch(Builder $query, ?string $term): Builder
    {
        if (blank($term)) {
            return $query;
        }

        return $query->where(function (Builder $query) use ($term) {
            $query->where('number', 'like', "%{$term}%")
                ->orWhere('customer_name', 'like', "%{$term}%")
                ->orWhere('customer_email', 'like', "%{$term}%");
        });
    }

    public function getStatusLabelAttribute(): string
    {
        return match ($this->status) {
            self::STATUS_PENDING => 'Aguardando pagamento',
            self::STATUS_PAID => 'Pago',
            self::STATUS_PROCESSING => 'Em separação',
            self::STATUS_SHIPPED => 'Enviado',
            self::STATUS_DELIVERED => 'Entregue',
            self::STATUS_CANCELLED => 'Cancelado',
            default => ucfirst($this->status),
        };
    }

    public function getPaymentStatusLabelAttribute(): string
    {
        return match ($this->payment_status) {
            self::PAYMENT_PENDING => 'Pendente',
            self::PAYMENT_PAID => 'Aprovado',
            self::PAYMENT_FAILED => 'Recusado',
            self::PAYMENT_REFUNDED => 'Estornado',
            default => ucfirst($this->payment_status),
        };
    }

    public static function statuses(): array
    {
        return [
            self::STATUS_PENDING,
            self::STATUS_PAID,
            self::STATUS_PROCESSING,
            self::STATUS_SHIPPED,
            self::STATUS_DELIVERED,
            self::STATUS_CANCELLED,
        ];
    }
}
