<?php

namespace App\Http\Controllers\Storefront;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\VehicleModel;
use Illuminate\Http\Request;
use Illuminate\View\View;

class HomeController extends Controller
{
    public function index(Request $request): View
    {
        $products = Product::query()
            ->active()
            ->whereHas('seller', fn ($query) => $query->where('active', true))
            ->with([
                'seller',
                'variants' => fn ($query) => $query->where('active', true)->orderBy('price'),
            ])
            ->search($request->string('q')->toString())
            ->compatibleWith($request->filled('vehicle_model_id') ? $request->integer('vehicle_model_id') : null)
            ->when($request->filled('category'), fn ($query) => $query->where('category', $request->string('category')))
            ->latest()
            ->paginate(12)
            ->withQueryString();

        return view('store.home', [
            'products' => $products,
            'vehicleModels' => VehicleModel::orderBy('brand')->orderBy('model')->get(),
            'categories' => Product::active()->whereNotNull('category')->distinct()->orderBy('category')->pluck('category'),
        ]);
    }

    public function show(Product $product): View
    {
        abort_unless($product->active && $product->seller?->active, 404);

        $product->load([
            'seller',
            'variants' => fn ($query) => $query->where('active', true)->with('attributes')->orderBy('price'),
            'compatibilities',
        ]);

        return view('store.products.show', compact('product'));
    }
}
