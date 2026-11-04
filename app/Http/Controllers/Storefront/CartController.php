<?php

namespace App\Http\Controllers\Storefront;

use App\Http\Controllers\Controller;
use App\Models\ProductVariant;
use App\Services\CartService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class CartController extends Controller
{
    public function __construct(
        private readonly CartService $cart,
    ) {
    }

    public function index(): View
    {
        return view('store.cart', [
            'items' => $this->cart->items(),
            'subtotal' => $this->cart->subtotal(),
        ]);
    }

    public function add(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'variant_id' => ['required', 'integer', 'exists:product_variants,id'],
            'quantity' => ['nullable', 'integer', 'min:1', 'max:99'],
        ]);

        $variant = ProductVariant::with('product.seller')->findOrFail($validated['variant_id']);

        if (! $variant->active || ! $variant->product?->active || ! $variant->product->seller?->active) {
            return back()->with('error', 'Este produto não está disponível.');
        }

        if (! $variant->isInStock()) {
            return back()->with('error', 'Produto sem estoque.');
        }

        $this->cart->add($variant, (int) ($validated['quantity'] ?? 1));

        return redirect()->route('cart.index')->with('success', 'Produto adicionado ao carrinho.');
    }

    public function update(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'variant_id' => ['required', 'integer', 'exists:product_variants,id'],
            'quantity' => ['required', 'integer', 'min:0', 'max:99'],
        ]);

        $variant = ProductVariant::findOrFail($validated['variant_id']);
        $this->cart->update($variant, (int) $validated['quantity']);

        return redirect()->route('cart.index')->with('success', 'Carrinho atualizado.');
    }

    public function remove(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'variant_id' => ['required', 'integer'],
        ]);

        $this->cart->remove((int) $validated['variant_id']);

        return redirect()->route('cart.index')->with('success', 'Item removido do carrinho.');
    }

    public function clear(): RedirectResponse
    {
        $this->cart->clear();

        return redirect()->route('cart.index')->with('success', 'Carrinho esvaziado.');
    }
}
