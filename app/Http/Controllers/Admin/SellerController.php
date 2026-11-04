<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\SellerRequest;
use App\Models\Seller;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class SellerController extends Controller
{
    public function index(Request $request): View
    {
        $sellers = Seller::query()
            ->withCount('products')
            ->search($request->string('q')->toString())
            ->when($request->filled('active'), fn ($query) => $query->where('active', $request->boolean('active')))
            ->latest()
            ->paginate(12)
            ->withQueryString();

        return view('admin.sellers.index', compact('sellers'));
    }

    public function create(): View
    {
        return view('admin.sellers.form', ['seller' => new Seller(['active' => true])]);
    }

    public function store(SellerRequest $request): RedirectResponse
    {
        $seller = Seller::create($request->validated());

        return redirect()
            ->route('admin.sellers.show', $seller)
            ->with('success', 'Vendedor cadastrado com sucesso.');
    }

    public function show(Seller $seller): View
    {
        $seller->loadCount('products')->load(['products' => fn ($query) => $query->latest()->take(10)]);

        return view('admin.sellers.show', compact('seller'));
    }

    public function edit(Seller $seller): View
    {
        return view('admin.sellers.form', compact('seller'));
    }

    public function update(SellerRequest $request, Seller $seller): RedirectResponse
    {
        $seller->update($request->validated());

        return redirect()
            ->route('admin.sellers.show', $seller)
            ->with('success', 'Vendedor atualizado com sucesso.');
    }

    public function destroy(Seller $seller): RedirectResponse
    {
        if ($seller->orderShipments()->exists()) {
            return back()->with('error', 'Não é possível excluir um vendedor com pedidos vinculados.');
        }

        $seller->delete();

        return redirect()
            ->route('admin.sellers.index')
            ->with('success', 'Vendedor removido.');
    }
}
