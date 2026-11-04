<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\VehicleModel;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;

class ProductCompatibilityController extends Controller
{
    public function store(Request $request, Product $product): RedirectResponse
    {
        $validated = $request->validate([
            'vehicle_model_id' => ['required', 'integer', 'exists:vehicle_models,id'],
        ]);

        $product->compatibilities()->syncWithoutDetaching([$validated['vehicle_model_id']]);

        return back()->with('success', 'Compatibilidade adicionada.');
    }

    public function destroy(Product $product, VehicleModel $vehicleModel): RedirectResponse
    {
        $product->compatibilities()->detach($vehicleModel->id);

        return back()->with('success', 'Compatibilidade removida.');
    }
}
