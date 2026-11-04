<?php

namespace App\Services;

use App\Models\ProductVariant;
use App\Services\Shipping\DTO\ShippingItem;
use Illuminate\Support\Collection;

class CartService
{
    private const SESSION_KEY = 'cart';

    /**
     * @return array<int, int> variant_id => quantity
     */
    public function raw(): array
    {
        $cart = session()->get(self::SESSION_KEY, []);

        return collect($cart)
            ->mapWithKeys(fn ($quantity, $variantId) => [(int) $variantId => max(0, (int) $quantity)])
            ->filter(fn (int $quantity) => $quantity > 0)
            ->all();
    }

    /**
     * @return Collection<int, ShippingItem>
     */
    public function items(): Collection
    {
        $raw = $this->raw();

        if ($raw === []) {
            return collect();
        }

        $variants = ProductVariant::query()
            ->with(['product.seller'])
            ->whereIn('id', array_keys($raw))
            ->get()
            ->keyBy('id');

        return collect($raw)
            ->map(function (int $quantity, int $variantId) use ($variants) {
                $variant = $variants->get($variantId);

                if (! $variant || ! $variant->active || ! $variant->product?->active) {
                    return null;
                }

                return new ShippingItem($variant, min($quantity, $variant->stock));
            })
            ->filter()
            ->values();
    }

    public function add(ProductVariant $variant, int $quantity = 1): void
    {
        $cart = $this->raw();
        $current = $cart[$variant->id] ?? 0;
        $cart[$variant->id] = min($variant->stock, $current + max(1, $quantity));

        session()->put(self::SESSION_KEY, $cart);
    }

    public function update(ProductVariant $variant, int $quantity): void
    {
        $cart = $this->raw();

        if ($quantity <= 0) {
            unset($cart[$variant->id]);
        } else {
            $cart[$variant->id] = min($variant->stock, $quantity);
        }

        session()->put(self::SESSION_KEY, $cart);
    }

    public function remove(int $variantId): void
    {
        $cart = $this->raw();
        unset($cart[$variantId]);

        session()->put(self::SESSION_KEY, $cart);
    }

    public function clear(): void
    {
        session()->forget(self::SESSION_KEY);
    }

    public function count(): int
    {
        return (int) array_sum($this->raw());
    }

    public function subtotal(): float
    {
        return round((float) $this->items()->sum(fn (ShippingItem $item) => $item->subtotal()), 2);
    }
}
