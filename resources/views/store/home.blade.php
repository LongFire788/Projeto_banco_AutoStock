@extends('layouts.store')

@section('title', 'Catálogo de autopeças')

@section('content')
    <section class="mb-8 overflow-hidden rounded-3xl bg-slate-900 px-6 py-10 text-white sm:px-10">
        <div class="max-w-2xl">
            <p class="text-xs font-semibold uppercase tracking-[0.2em] text-amber-400">Marketplace multi-lojista</p>
            <h1 class="mt-2 text-3xl font-bold tracking-tight sm:text-4xl">A peça certa, para o carro certo.</h1>
            <p class="mt-3 text-sm leading-relaxed text-slate-300">
                Autopeças e acessórios de vendedores especializados, com compatibilidade veicular e frete calculado por origem.
            </p>
        </div>
    </section>

    <form method="GET" class="mb-8 rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
        <div class="grid gap-3 md:grid-cols-12">
            <div class="md:col-span-5">
                <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Buscar peça</label>
                <input name="q" value="{{ request('q') }}" placeholder="Ex.: amortecedor Cofap"
                       class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm focus:border-amber-500 focus:outline-none">
            </div>
            <div class="md:col-span-4">
                <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Meu veículo</label>
                <select name="vehicle_model_id" class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm">
                    <option value="">Todos os veículos</option>
                    @foreach ($vehicleModels as $vehicleModel)
                        <option value="{{ $vehicleModel->id }}" @selected((string) request('vehicle_model_id') === (string) $vehicleModel->id)>
                            {{ $vehicleModel->display_name }}
                        </option>
                    @endforeach
                </select>
            </div>
            <div class="md:col-span-2">
                <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Categoria</label>
                <select name="category" class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm">
                    <option value="">Todas</option>
                    @foreach ($categories as $category)
                        <option value="{{ $category }}" @selected(request('category') === $category)>{{ $category }}</option>
                    @endforeach
                </select>
            </div>
            <div class="flex items-end md:col-span-1">
                <button class="w-full rounded-lg bg-amber-500 px-4 py-2.5 text-sm font-bold text-slate-900 hover:bg-amber-400">Buscar</button>
            </div>
        </div>
    </form>

    <div class="mb-4 flex items-center justify-between">
        <h2 class="text-lg font-bold text-slate-900">Produtos</h2>
        <p class="text-xs text-slate-500">{{ $products->total() }} resultado(s)</p>
    </div>

    <div class="grid gap-5 sm:grid-cols-2 lg:grid-cols-4">
        @forelse ($products as $product)
            <article class="flex flex-col overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-sm transition hover:-translate-y-0.5 hover:shadow-md">
                <a href="{{ route('products.show', $product) }}" class="block h-44 overflow-hidden bg-slate-100">
                    @if ($product->image_url)
                        <img src="{{ $product->image_url }}" alt="{{ $product->name }}" class="h-full w-full object-cover">
                    @else
                        <div class="flex h-full items-center justify-center bg-gradient-to-br from-slate-200 to-slate-100 text-4xl font-black text-slate-300">A</div>
                    @endif
                </a>
                <div class="flex flex-1 flex-col p-4">
                    <p class="text-[11px] font-semibold uppercase tracking-wide text-amber-600">{{ $product->brand ?: $product->category ?: 'Autopeças' }}</p>
                    <a href="{{ route('products.show', $product) }}" class="mt-1 line-clamp-2 font-semibold text-slate-900 hover:text-amber-600">{{ $product->name }}</a>
                    <p class="mt-1 text-xs text-slate-400">Vendido por {{ $product->seller?->trade_name }}</p>

                    <div class="mt-auto pt-4">
                        <p class="text-lg font-bold text-slate-900">
                            @if ($product->price_from !== null)
                                R$ {{ number_format($product->price_from, 2, ',', '.') }}
                            @else
                                Indisponível
                            @endif
                        </p>
                        <p class="text-xs text-slate-400">{{ $product->variants->count() }} variação(ões)</p>
                        <a href="{{ route('products.show', $product) }}"
                           class="mt-3 block rounded-lg bg-slate-900 px-4 py-2 text-center text-sm font-semibold text-white hover:bg-slate-800">
                            Ver detalhes
                        </a>
                    </div>
                </div>
            </article>
        @empty
            <div class="col-span-full rounded-2xl border border-dashed border-slate-300 bg-white px-6 py-16 text-center">
                <p class="font-semibold text-slate-700">Nenhum produto encontrado.</p>
                <p class="mt-1 text-sm text-slate-500">Ajuste os filtros ou cadastre produtos no painel.</p>
            </div>
        @endforelse
    </div>

    <div class="mt-8">{{ $products->links() }}</div>
@endsection
