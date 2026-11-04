@extends('layouts.app')

@section('title', $product->name)
@section('eyebrow', 'Produtos')
@section('heading', $product->name)

@section('actions')
    <a href="{{ route('products.show', $product) }}" target="_blank" class="rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">Ver na loja</a>
    <a href="{{ route('admin.products.edit', $product) }}" class="rounded-lg bg-slate-900 px-4 py-2 text-sm font-semibold text-white hover:bg-slate-800">Editar</a>
    <form method="POST" action="{{ route('admin.products.destroy', $product) }}" onsubmit="return confirm('Excluir este produto?')">
        @csrf
        @method('DELETE')
        <button class="rounded-lg border border-rose-200 bg-white px-4 py-2 text-sm font-semibold text-rose-600 hover:bg-rose-50">Excluir</button>
    </form>
@endsection

@section('content')
    <div class="grid gap-6 lg:grid-cols-3">
        <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm lg:col-span-2">
            <div class="flex flex-wrap items-start justify-between gap-4">
                <div>
                    <p class="text-xs font-semibold uppercase tracking-wide text-slate-400">{{ $product->brand ?: 'Sem marca' }} · {{ $product->category ?: 'Sem categoria' }}</p>
                    <p class="mt-1 text-sm text-slate-600">{{ $product->seller?->trade_name }}</p>
                </div>
                <span class="rounded-full px-3 py-1 text-xs font-semibold {{ $product->active ? 'bg-emerald-100 text-emerald-700' : 'bg-slate-100 text-slate-500' }}">
                    {{ $product->active ? 'Ativo' : 'Inativo' }}
                </span>
            </div>
            <p class="mt-4 whitespace-pre-line text-sm leading-relaxed text-slate-600">{{ $product->description ?: 'Sem descrição cadastrada.' }}</p>
        </section>

        <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
            <p class="text-xs font-semibold uppercase tracking-wide text-slate-400">Slug</p>
            <p class="mt-1 break-all font-mono text-xs text-slate-600">{{ $product->slug }}</p>
            <p class="mt-4 text-xs font-semibold uppercase tracking-wide text-slate-400">Variações</p>
            <p class="mt-1 text-2xl font-bold text-slate-900">{{ $product->variants->count() }}</p>
        </section>
    </div>

    <section class="mt-6 rounded-2xl border border-slate-200 bg-white shadow-sm">
        <div class="flex flex-wrap items-center justify-between gap-3 border-b border-slate-100 px-5 py-4">
            <h2 class="font-semibold text-slate-900">Variações (SKUs)</h2>
            <a href="{{ route('admin.products.variants.create', $product) }}" class="rounded-lg bg-amber-500 px-4 py-2 text-sm font-semibold text-slate-900 hover:bg-amber-400">+ Nova variação</a>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full text-left text-sm">
                <thead class="bg-slate-50 text-xs uppercase tracking-wide text-slate-500">
                    <tr>
                        <th class="px-5 py-3">SKU</th>
                        <th class="px-5 py-3">Variação</th>
                        <th class="px-5 py-3">Preço</th>
                        <th class="px-5 py-3">Estoque</th>
                        <th class="px-5 py-3">Logística</th>
                        <th class="px-5 py-3 text-right">Ações</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    @forelse ($product->variants as $variant)
                        <tr class="hover:bg-slate-50">
                            <td class="px-5 py-3 font-mono text-xs">{{ $variant->sku }}</td>
                            <td class="px-5 py-3">
                                <p class="font-medium">{{ $variant->name }}</p>
                                @if ($variant->attributes->isNotEmpty())
                                    <p class="text-xs text-slate-400">{{ $variant->attributes->map(fn ($attribute) => "{$attribute->name}: {$attribute->value}")->join(' · ') }}</p>
                                @endif
                            </td>
                            <td class="px-5 py-3 font-semibold">R$ {{ number_format((float) $variant->price, 2, ',', '.') }}</td>
                            <td class="px-5 py-3">
                                <span class="rounded-full px-2.5 py-1 text-xs font-semibold {{ $variant->stock === 0 ? 'bg-rose-100 text-rose-700' : ($variant->stock <= 5 ? 'bg-amber-100 text-amber-700' : 'bg-emerald-100 text-emerald-700') }}">
                                    {{ $variant->stock }} un.
                                </span>
                            </td>
                            <td class="px-5 py-3 text-xs text-slate-500">
                                {{ $variant->weight_grams }} g · {{ $variant->dimensions_label }}
                            </td>
                            <td class="px-5 py-3 text-right">
                                <a href="{{ route('admin.products.variants.edit', [$product, $variant]) }}" class="text-xs font-semibold text-slate-600 hover:text-amber-600">Editar</a>
                                <form method="POST" action="{{ route('admin.products.variants.destroy', [$product, $variant]) }}" class="ml-2 inline" onsubmit="return confirm('Excluir esta variação?')">
                                    @csrf
                                    @method('DELETE')
                                    <button class="text-xs font-semibold text-rose-500 hover:text-rose-700">Excluir</button>
                                </form>
                            </td>
                        </tr>
                    @empty
                        <tr><td colspan="6" class="px-5 py-10 text-center text-sm text-slate-500">Nenhuma variação cadastrada. Cadastre ao menos um SKU vendável.</td></tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </section>

    <section class="mt-6 rounded-2xl border border-slate-200 bg-white shadow-sm">
        <div class="border-b border-slate-100 px-5 py-4">
            <h2 class="font-semibold text-slate-900">Compatibilidade veicular</h2>
        </div>
        <div class="p-5">
            <div class="mb-4 flex flex-wrap gap-2">
                @forelse ($product->compatibilities as $vehicleModel)
                    <span class="inline-flex items-center gap-2 rounded-full bg-slate-100 px-3 py-1.5 text-xs font-medium text-slate-700">
                        {{ $vehicleModel->display_name }}
                        <form method="POST" action="{{ route('admin.products.compatibilities.destroy', [$product, $vehicleModel]) }}">
                            @csrf
                            @method('DELETE')
                            <button class="text-rose-500 hover:text-rose-700" title="Remover">×</button>
                        </form>
                    </span>
                @empty
                    <p class="text-sm text-slate-500">Nenhum veículo vinculado.</p>
                @endforelse
            </div>

            <form method="POST" action="{{ route('admin.products.compatibilities.store', $product) }}" class="flex flex-wrap items-end gap-3">
                @csrf
                <div class="min-w-72 flex-1">
                    <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Adicionar veículo</label>
                    <select name="vehicle_model_id" required class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        <option value="">Selecione um modelo</option>
                        @foreach ($availableVehicleModels as $vehicleModel)
                            <option value="{{ $vehicleModel->id }}">{{ $vehicleModel->display_name }}</option>
                        @endforeach
                    </select>
                </div>
                <button class="rounded-lg border border-slate-300 px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">Vincular</button>
            </form>
        </div>
    </section>
@endsection
