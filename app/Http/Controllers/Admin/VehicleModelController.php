<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\VehicleModelRequest;
use App\Models\VehicleModel;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class VehicleModelController extends Controller
{
    public function index(Request $request): View
    {
        $vehicleModels = VehicleModel::query()
            ->withCount('products')
            ->search($request->string('q')->toString())
            ->orderBy('brand')
            ->orderBy('model')
            ->paginate(15)
            ->withQueryString();

        return view('admin.vehicle-models.index', compact('vehicleModels'));
    }

    public function create(): View
    {
        return view('admin.vehicle-models.form', ['vehicleModel' => new VehicleModel()]);
    }

    public function store(VehicleModelRequest $request): RedirectResponse
    {
        VehicleModel::create($request->validated());

        return redirect()
            ->route('admin.vehicle-models.index')
            ->with('success', 'Veículo cadastrado com sucesso.');
    }

    public function edit(VehicleModel $vehicleModel): View
    {
        return view('admin.vehicle-models.form', compact('vehicleModel'));
    }

    public function update(VehicleModelRequest $request, VehicleModel $vehicleModel): RedirectResponse
    {
        $vehicleModel->update($request->validated());

        return redirect()
            ->route('admin.vehicle-models.index')
            ->with('success', 'Veículo atualizado com sucesso.');
    }

    public function destroy(VehicleModel $vehicleModel): RedirectResponse
    {
        $vehicleModel->delete();

        return redirect()
            ->route('admin.vehicle-models.index')
            ->with('success', 'Veículo removido.');
    }
}
