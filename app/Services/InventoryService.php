<?php

namespace App\Services;

use App\Exceptions\InsufficientStockException;
use App\Models\Order;
use App\Models\ProductVariant;
use App\Services\Shipping\DTO\ShippingItem;
use Illuminate\Support\Collection;

class InventoryService
{
    /**
     * Reserva (decrementa) o estoque com lock pessimista.
     *
     * DEVE ser chamado dentro de uma DB::transaction(). O SELECT ... FOR UPDATE
     * impede que duas requisições concorrentes leiam o mesmo estoque antes do
     * decremento (overselling). A ordenação por id evita deadlocks.
     *
     * @param  Collection<int, ShippingItem>  $items
     * @return Collection<int, ProductVariant>
     *
     * @throws InsufficientStockException
     */
    public function reserve(Collection $items): Collection
    {
        $quantities = $items
            ->groupBy(fn (ShippingItem $item) => $item->variant->id)
            ->map(fn (Collection $group) => (int) $group->sum('quantity'));

        $variants = ProductVariant::query()
            ->with('product')
            ->whereIn('id', $quantities->keys())
            ->orderBy('id')
            ->lockForUpdate()
            ->get()
            ->keyBy('id');

        foreach ($quantities as $variantId => $quantity) {
            $variant = $variants->get($variantId);

            if (! $variant || ! $variant->active || ! $variant->product?->active) {
                throw new InsufficientStockException((string) $variantId, $quantity, 0);
            }

            if ($variant->stock < $quantity) {
                throw new InsufficientStockException($variant->sku, $quantity, $variant->stock);
            }
        }

        foreach ($quantities as $variantId => $quantity) {
            $variants->get($variantId)->decrement('stock', $quantity);
        }

        return $variants;
    }

    /**
     * Devolve ao estoque os itens de um pedido cancelado.
     * Deve ser executado dentro de uma transação e apenas uma vez por pedido.
     */
    public function restoreForOrder(Order $order): void
    {
        $order->loadMissing('items');

        $order->items
            ->groupBy('product_variant_id')
            ->each(function ($items, $variantId) {
                ProductVariant::withTrashed()
                    ->whereKey($variantId)
                    ->increment('stock', (int) $items->sum('quantity'));
            });
    }
}
