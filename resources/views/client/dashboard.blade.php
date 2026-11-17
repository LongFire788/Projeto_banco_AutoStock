@extends('layouts.store')

@section('title', 'Minha conta')

@section('content')
    <div class="mb-8">
        <p class="text-xs font-semibold uppercase tracking-widest text-amber-600">Área do cliente</p>
        <h1 class="mt-1 text-2xl font-bold text-slate-900">Olá, {{ auth()->user()->name }}</h1>
        <p class="mt-1 text-sm text-slate-500">Acompanhe aqui os pedidos feitos com {{ auth()->user()->email }}.</p>
    </div>

    <div class="mb-8 grid gap-4 sm:grid-cols-3">
        <div class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
            <p class="text-xs font-semibold uppercase tracking-wide text-slate-400">Meus pedidos</p>
            <p class="mt-2 text-2xl font-bold text-slate-900">{{ $stats['orders'] }}</p>
        </div>
        <div class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
            <p class="text-xs font-semibold uppercase tracking-wide text-slate-400">Entregues</p>
            <p class="mt-2 text-2xl font-bold text-slate-900">{{ $stats['delivered'] }}</p>
        </div>
        <div class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
            <p class="text-xs font-semibold uppercase tracking-wide text-slate-400">Total gasto</p>
            <p class="mt-2 text-2xl font-bold text-slate-900">R$ {{ number_format($stats['spent'], 2, ',', '.') }}</p>
        </div>
    </div>

    <section class="overflow-hidden rounded-2xl border border-slate-200 bg-white shadow-sm">
        <div class="border-b border-slate-100 px-5 py-4">
            <h2 class="font-semibold text-slate-900">Meus pedidos</h2>
        </div>

        @forelse ($orders as $order)
            <div class="divide-y divide-slate-100">
                <article class="px-5 py-4">
                    <div class="flex flex-wrap items-start justify-between gap-3">
                        <div>
                            <p class="font-semibold text-slate-900">Pedido {{ $order->number }}</p>
                            <p class="text-xs text-slate-500">
                                {{ optional($order->placed_at)->format('d/m/Y H:i') ?? $order->created_at->format('d/m/Y H:i') }}
                                · {{ $order->items->count() }} item(s)
                            </p>
                        </div>
                        <div class="text-right">
                            <p class="font-bold text-slate-900">R$ {{ number_format((float) $order->total, 2, ',', '.') }}</p>
                            <span class="mt-1 inline-block rounded-full bg-amber-50 px-2 py-0.5 text-[11px] font-semibold text-amber-800">
                                {{ $order->status_label }}
                            </span>
                        </div>
                    </div>

                    <ul class="mt-3 space-y-1 text-xs text-slate-600">
                        @foreach ($order->items->take(3) as $item)
                            <li>{{ $item->quantity }}× {{ $item->product_name }}{{ $item->variant_name ? ' — '.$item->variant_name : '' }}</li>
                        @endforeach
                        @if ($order->items->count() > 3)
                            <li class="text-slate-400">+ {{ $order->items->count() - 3 }} outro(s) item(s)</li>
                        @endif
                    </ul>

                    @if ($order->shipments->isNotEmpty())
                        <p class="mt-3 text-xs text-slate-500">
                            Rastreio:
                            @foreach ($order->shipments as $shipment)
                                <span class="font-semibold text-slate-700">{{ $shipment->tracking_code ?: 'aguardando código' }}</span>{{ $loop->last ? '' : ', ' }}
                            @endforeach
                        </p>
                    @endif
                </article>
            </div>
            <div class="border-t border-slate-100 px-5 py-4">
                {{ $orders->links() }}
            </div>
        @empty
            <div class="px-5 py-12 text-center">
                <p class="font-semibold text-slate-700">Você ainda não tem pedidos.</p>
                <p class="mt-1 text-sm text-slate-500">Quando fizer uma compra, ela aparecerá aqui.</p>
                <a href="{{ route('home') }}" class="mt-4 inline-block rounded-lg bg-slate-900 px-4 py-2 text-sm font-semibold text-white hover:bg-slate-800">
                    Ver catálogo
                </a>
            </div>
        @endforelse
    </section>
@endsection
