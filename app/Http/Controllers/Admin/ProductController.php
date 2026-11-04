<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProductRequest;
use App\Models\Product;
use App\Models\Seller;
use App\Models\VehicleModel;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;

class ProductController extends Controller
{
    public function index(Request $request): View
    {
        $products = Product::query()
            ->with('seller')
            ->withCount('variants')
            ->withMin('variants', 'price')
            ->search($request->string('q')->toString())
            ->when($request->filled('seller_id'), fn ($query) => $query->where('seller_id', $request->integer('seller_id')))
            ->when($request->filled('active'), fn ($query) => $query->where('active', $request->boolean('active')))
            ->latest()
            ->paginate(12)
            ->withQueryString();

        return view('admin.products.index', [
            'products' => $products,
            'sellers' => Seller::orderBy('trade_name')->get(),
        ]);
    }

    public function create(): View
    {
        return view('admin.products.form', [
            'product' => new Product(['active' => true]),
            'sellers' => Seller::active()->orderBy('trade_name')->get(),
            'vehicleModels' => VehicleModel::orderBy('brand')->orderBy('model')->get(),
            'selectedVehicleIds' => [],
        ]);
    }

    public function store(ProductRequest $request): RedirectResponse
    {
        $validated = $request->validated();
        $vehicleIds = $validated['vehicle_model_ids'] ?? [];

        $product = DB::transaction(function () use ($validated, $vehicleIds) {
            $data = collect($validated)->except('vehicle_model_ids')->all();
            $data['slug'] = Product::uniqueSlug($data['slug'] ?: $data['name']);

            $product = Product::create($data);
            $product->compatibilities()->sync($vehicleIds);

            return $product;
        });

        return redirect()
            ->route('admin.products.show', $product)
            ->with('success', 'Produto cadastrado com sucesso.');
    }

    public function show(Product $product): View
    {
        $product->load([
            'seller',
            'variants' => fn ($query) => $query->with('attributes')->latest(),
            'compatibilities',
        ]);

        return view('admin.products.show', [
            'product' => $product,
            'availableVehicleModels' => VehicleModel::query()
                ->whereNotIn('id', $product->compatibilities->pluck('id'))
                ->orderBy('brand')
                ->orderBy('model')
                ->get(),
        ]);
    }

    public function edit(Product $product): View
    {
        $product->load('compatibilities');

        return view('admin.products.form', [
            'product' => $product,
            'sellers' => Seller::active()->orderBy('trade_name')->get(),
            'vehicleModels' => VehicleModel::orderBy('brand')->orderBy('model')->get(),
            'selectedVehicleIds' => $product->compatibilities->pluck('id')->all(),
        ]);
    }

    public function update(ProductRequest $request, Product $product): RedirectResponse
    {
        $validated = $request->validated();
        $vehicleIds = $validated['vehicle_model_ids'] ?? [];

        DB::transaction(function () use ($validated, $vehicleIds, $product) {
            $data = collect($validated)->except('vehicle_model_ids')->all();
            $data['slug'] = Product::uniqueSlug($data['slug'] ?: $data['name'], $product->id);

            $product->update($data);
            $product->compatibilities()->sync($vehicleIds);
        });

        return redirect()
            ->route('admin.products.show', $product)
            ->with('success', 'Produto atualizado com sucesso.');
    }

    public function destroy(Product $product): RedirectResponse
    {
        $product->delete();

        return redirect()
            ->route('admin.products.index')
            ->with('success', 'Produto removido.');
    }
}
