<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProductVariantRequest;
use App\Models\Product;
use App\Models\ProductVariant;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;

class ProductVariantController extends Controller
{
    public function create(Product $product): View
    {
        return view('admin.variants.form', [
            'product' => $product,
            'variant' => new ProductVariant(['active' => true]),
        ]);
    }

    public function store(ProductVariantRequest $request, Product $product): RedirectResponse
    {
        DB::transaction(function () use ($request, $product) {
            $validated = $request->validated();
            $attributes = $validated['attributes'] ?? [];
            unset($validated['attributes']);

            $variant = $product->variants()->create($validated);
            $variant->attributes()->createMany($attributes);
        });

        return redirect()
            ->route('admin.products.show', $product)
            ->with('success', 'Variação cadastrada com sucesso.');
    }

    public function edit(Product $product, ProductVariant $variant): View
    {
        $this->ensureVariantBelongsToProduct($product, $variant);
        $variant->load('attributes');

        return view('admin.variants.form', compact('product', 'variant'));
    }

    public function update(ProductVariantRequest $request, Product $product, ProductVariant $variant): RedirectResponse
    {
        $this->ensureVariantBelongsToProduct($product, $variant);

        DB::transaction(function () use ($request, $variant) {
            $validated = $request->validated();
            $attributes = $validated['attributes'] ?? [];
            unset($validated['attributes']);

            $variant->update($validated);
            $variant->attributes()->delete();
            $variant->attributes()->createMany($attributes);
        });

        return redirect()
            ->route('admin.products.show', $product)
            ->with('success', 'Variação atualizada com sucesso.');
    }

    public function destroy(Product $product, ProductVariant $variant): RedirectResponse
    {
        $this->ensureVariantBelongsToProduct($product, $variant);
        $variant->delete();

        return redirect()
            ->route('admin.products.show', $product)
            ->with('success', 'Variação removida.');
    }

    private function ensureVariantBelongsToProduct(Product $product, ProductVariant $variant): void
    {
        abort_unless($variant->product_id === $product->id, 404);
    }
}
