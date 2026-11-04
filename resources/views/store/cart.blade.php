@extends('layouts.store')

@section('title', 'Carrinho')

@section('content')
    @php
        $sellerCount = $items->map(fn ($item) => $item->variant->product->seller_id)->unique()->count();
    @endphp

    <div class="mb-6 flex items-center justify-between">
        <div>
            <p class="text-xs font-semibold uppercase tracking-wide text-slate-400">Seu pedido</p>
            <h1 class="text-2xl font-bold text-slate-900">Carrinho</h1>
        </div>
        @if ($items->isNotEmpty())
            <form method="POST" action="{{ route('cart.clear') }}" onsubmit="return confirm('Esvaziar o carrinho?')">
                @csrf
                @method('DELETE')
                <button class="text-xs font-semibold text-rose-500 hover:text-rose-700">Esvaziar carrinho</button>
            </form>
        @endif
    </div>

    @if ($items->isEmpty())
        <div class="rounded-2xl border border-dashed border-slate-300 bg-white px-6 py-16 text-center">
            <p class="text-lg font-semibold text-slate-700">Seu carrinho está vazio.</p>
            <p class="mt-1 text-sm text-slate-500">Explore o catálogo e adicione peças ao pedido.</p>
            <a href="{{ route('home') }}" class="mt-5 inline-block rounded-lg bg-amber-500 px-5 py-2.5 text-sm font-bold text-slate-900 hover:bg-amber-400">Ver catálogo</a>
        </div>
    @else
        <div class="grid gap-6 lg:grid-cols-3">
            <div class="space-y-4 lg:col-span-2">
                @foreach ($items as $item)
                    @php($variant = $item->variant)
                    <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm">
                        <div class="flex flex-wrap items-start gap-4">
                            <div class="h-20 w-20 shrink-0 overflow-hidden rounded-xl bg-slate-100">
                                @if ($variant->product->image_url)
                                    <img src="{{ $variant->product->image_url }}" alt="" class="h-full w-full object-cover">
                                @else
                                    <div class="flex h-full items-center justify-center text-2xl font-black text-slate-300">A</div>
                                @endif
                            </div>

                            <div class="min-w-48 flex-1">
                                <a href="{{ route('products.show', $variant->product) }}" class="font-semibold text-slate-900 hover:text-amber-600">{{ $variant->product->name }}</a>
                                <p class="text-xs text-slate-500">{{ $variant->name }} · {{ $variant->sku }}</p>
                                <p class="mt-1 text-xs text-slate-400">Vendido por {{ $variant->product->seller?->trade_name }}</p>
                                <p class="mt-1 text-xs text-slate-400">{{ $variant->weight_grams }} g · {{ $variant->dimensions_label }}</p>
                            </div>

                            <div class="w-32">
                                <form method="POST" action="{{ route('cart.update') }}" class="flex items-center gap-2">
                                    @csrf
                                    @method('PATCH')
                                    <input type="hidden" name="variant_id" value="{{ $variant->id }}">
                                    <input type="number" name="quantity" value="{{ $item->quantity }}" min="0" max="{{ min(99, max(1, $variant->stock)) }}"
                                           class="w-16 rounded-lg border border-slate-300 px-2 py-1.5 text-sm">
                                    <button class="text-xs font-semibold text-slate-500 hover:text-amber-600">OK</button>
                                </form>
                                <form method="POST" action="{{ route('cart.remove') }}" class="mt-2">
                                    @csrf
                                    @method('DELETE')
                                    <input type="hidden" name="variant_id" value="{{ $variant->id }}">
                                    <button class="text-xs font-semibold text-rose-500 hover:text-rose-700">Remover</button>
                                </form>
                            </div>

                            <div class="w-28 text-right">
                                <p class="text-xs text-slate-400">R$ {{ number_format((float) $variant->price, 2, ',', '.') }} / un.</p>
                                <p class="text-lg font-bold text-slate-900">R$ {{ number_format($item->subtotal(), 2, ',', '.') }}</p>
                            </div>
                        </div>
                    </div>
                @endforeach
            </div>

            <aside class="h-fit rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <h2 class="font-bold text-slate-900">Resumo</h2>
                <dl class="mt-4 space-y-2 text-sm">
                    <div class="flex justify-between"><dt class="text-slate-500">Subtotal</dt><dd>R$ {{ number_format($subtotal, 2, ',', '.') }}</dd></div>
                    <div class="flex justify-between"><dt class="text-slate-500">Frete</dt><dd class="text-xs text-slate-400">calculado no checkout</dd></div>
                    <div class="flex justify-between border-t border-slate-100 pt-2 text-base font-bold"><dt>Total parcial</dt><dd>R$ {{ number_format($subtotal, 2, ',', '.') }}</dd></div>
                </dl>
                <p class="mt-3 text-xs text-slate-400">Itens de {{ $sellerCount }} vendedor(es). O frete é calculado separadamente por origem.</p>
                <a href="{{ route('checkout.index') }}" class="mt-5 block rounded-lg bg-amber-500 px-4 py-3 text-center text-sm font-bold text-slate-900 hover:bg-amber-400">
                    Continuar para o checkout
                </a>
                <a href="{{ route('home') }}" class="mt-3 block text-center text-xs font-semibold text-slate-500 hover:text-slate-800">Continuar comprando</a>
            </aside>
        </div>
    @endif
@endsection
