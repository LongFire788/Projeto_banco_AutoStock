@extends('layouts.store')

@section('title', $product->name)

@section('content')
    <nav class="mb-5 text-xs text-slate-500">
        <a href="{{ route('home') }}" class="hover:text-amber-600">Catálogo</a>
        <span class="mx-2">/</span>
        <span class="text-slate-700">{{ $product->name }}</span>
    </nav>

    <div class="grid gap-8 lg:grid-cols-2">
        <div class="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm">
            @if ($product->image_url)
                <img src="{{ $product->image_url }}" alt="{{ $product->name }}" class="h-full max-h-[420px] w-full object-cover">
            @else
                <div class="flex h-80 items-center justify-center bg-gradient-to-br from-slate-200 to-slate-100 text-7xl font-black text-slate-300">A</div>
            @endif
        </div>

        <div>
            <p class="text-xs font-semibold uppercase tracking-wide text-amber-600">{{ $product->brand ?: 'Autopeças' }} · {{ $product->category ?: 'Geral' }}</p>
            <h1 class="mt-2 text-2xl font-bold text-slate-900">{{ $product->name }}</h1>
            <p class="mt-2 text-sm text-slate-500">Vendido e despachado por <span class="font-semibold text-slate-700">{{ $product->seller?->trade_name }}</span></p>
            <p class="mt-4 whitespace-pre-line text-sm leading-relaxed text-slate-600">{{ $product->description ?: 'Sem descrição cadastrada.' }}</p>

            <div class="mt-6">
                <h2 class="mb-3 text-sm font-bold uppercase tracking-wide text-slate-500">Escolha a variação</h2>
                <div class="space-y-3">
                    @forelse ($product->variants as $variant)
                        <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm">
                            <div class="flex flex-wrap items-start justify-between gap-3">
                                <div>
                                    <p class="font-semibold text-slate-900">{{ $variant->name }}</p>
                                    <p class="font-mono text-[11px] text-slate-400">SKU {{ $variant->sku }}</p>
                                    @if ($variant->attributes->isNotEmpty())
                                        <div class="mt-2 flex flex-wrap gap-1.5">
                                            @foreach ($variant->attributes as $attribute)
                                                <span class="rounded-full bg-slate-100 px-2 py-0.5 text-[11px] font-medium text-slate-600">{{ $attribute->name }}: {{ $attribute->value }}</span>
                                            @endforeach
                                        </div>
                                    @endif
                                    <p class="mt-2 text-xs text-slate-400">{{ $variant->weight_grams }} g · {{ $variant->dimensions_label }}</p>
                                </div>
                                <div class="text-right">
                                    @if ($variant->compare_at_price)
                                        <p class="text-xs text-slate-400 line-through">R$ {{ number_format((float) $variant->compare_at_price, 2, ',', '.') }}</p>
                                    @endif
                                    <p class="text-xl font-bold text-slate-900">R$ {{ number_format((float) $variant->price, 2, ',', '.') }}</p>
                                    <p class="text-xs {{ $variant->stock > 0 ? 'text-emerald-600' : 'text-rose-500' }}">
                                        {{ $variant->stock > 0 ? $variant->stock . ' em estoque' : 'Sem estoque' }}
                                    </p>
                                </div>
                            </div>

                            @if ($variant->stock > 0)
                                <form method="POST" action="{{ route('cart.add') }}" class="mt-3 flex items-end gap-2">
                                    @csrf
                                    <input type="hidden" name="variant_id" value="{{ $variant->id }}">
                                    <div class="w-24">
                                        <label class="mb-1 block text-[11px] font-semibold uppercase tracking-wide text-slate-400">Qtd.</label>
                                        <input type="number" name="quantity" value="1" min="1" max="{{ min(99, $variant->stock) }}"
                                               class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                                    </div>
                                    <button class="flex-1 rounded-lg bg-amber-500 px-4 py-2 text-sm font-bold text-slate-900 hover:bg-amber-400">
                                        Adicionar ao carrinho
                                    </button>
                                </form>
                            @else
                                <p class="mt-3 rounded-lg bg-rose-50 px-3 py-2 text-xs font-semibold text-rose-600">Temporariamente indisponível.</p>
                            @endif
                        </div>
                    @empty
                        <p class="rounded-xl border border-dashed border-slate-300 bg-white px-4 py-8 text-center text-sm text-slate-500">Nenhuma variação disponível.</p>
                    @endforelse
                </div>
            </div>
        </div>
    </div>

    <section class="mt-10 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
        <h2 class="font-bold text-slate-900">Compatibilidade veicular</h2>
        <p class="mb-4 text-xs text-slate-500">Confira se este produto é compatível com o seu veículo.</p>
        <div class="flex flex-wrap gap-2">
            @forelse ($product->compatibilities as $vehicleModel)
                <span class="rounded-full border border-slate-200 bg-slate-50 px-3 py-1.5 text-xs font-medium text-slate-700">{{ $vehicleModel->display_name }}</span>
            @empty
                <p class="text-sm text-slate-500">Compatibilidade não informada pelo vendedor.</p>
            @endforelse
        </div>
    </section>
@endsection
