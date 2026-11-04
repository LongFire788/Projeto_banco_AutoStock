@extends('layouts.app')

@section('title', 'Dashboard')
@section('heading', 'Visão geral')

@section('actions')
    <a href="{{ route('admin.products.create') }}"
       class="rounded-lg bg-slate-900 px-4 py-2 text-sm font-semibold text-white hover:bg-slate-800">
        + Novo produto
    </a>
    <a href="{{ route('admin.orders.index') }}"
       class="rounded-lg border border-slate-300 bg-white px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">
        Ver pedidos
    </a>
@endsection

@section('content')
    @php
        $cards = [
            ['label' => 'Vendedores ativos', 'value' => $stats['sellers'], 'hint' => 'Origens de despacho'],
            ['label' => 'Produtos ativos', 'value' => $stats['products'], 'hint' => 'Catálogo publicado'],
            ['label' => 'Pedidos', 'value' => $stats['orders'], 'hint' => 'Todos os status'],
            ['label' => 'Receita aprovada', 'value' => 'R$ ' . number_format($stats['revenue'], 2, ',', '.'), 'hint' => 'Pagamentos aprovados'],
            ['label' => 'Envios pendentes', 'value' => $stats['pending_shipments'], 'hint' => 'Aguardando postagem'],
        ];
    @endphp

    <div class="mb-8 grid gap-4 sm:grid-cols-2 xl:grid-cols-5">
        @foreach ($cards as $card)
            <div class="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
                <p class="text-xs font-semibold uppercase tracking-wide text-slate-400">{{ $card['label'] }}</p>
                <p class="mt-2 text-2xl font-bold text-slate-900">{{ $card['value'] }}</p>
                <p class="mt-1 text-xs text-slate-500">{{ $card['hint'] }}</p>
            </div>
        @endforeach
    </div>

    <div class="grid gap-6 xl:grid-cols-3">
        <section class="rounded-2xl border border-slate-200 bg-white shadow-sm xl:col-span-2">
            <div class="flex items-center justify-between border-b border-slate-100 px-5 py-4">
                <h2 class="font-semibold text-slate-900">Pedidos recentes</h2>
                <a href="{{ route('admin.orders.index') }}" class="text-xs font-semibold text-amber-600 hover:text-amber-700">Ver todos</a>
            </div>
            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm">
                    <thead class="bg-slate-50 text-xs uppercase tracking-wide text-slate-500">
                        <tr>
                            <th class="px-5 py-3">Pedido</th>
                            <th class="px-5 py-3">Cliente</th>
                            <th class="px-5 py-3">Total</th>
                            <th class="px-5 py-3">Status</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        @forelse ($recentOrders as $order)
                            <tr class="hover:bg-slate-50">
                                <td class="px-5 py-3">
                                    <a href="{{ route('admin.orders.show', $order) }}" class="font-semibold text-slate-900 hover:text-amber-600">
                                        {{ $order->number }}
                                    </a>
                                    <p class="text-xs text-slate-400">{{ $order->created_at->format('d/m/Y H:i') }}</p>
                                </td>
                                <td class="px-5 py-3">
                                    <p class="font-medium">{{ $order->customer_name }}</p>
                                    <p class="text-xs text-slate-400">{{ $order->customer_email }}</p>
                                </td>
                                <td class="px-5 py-3 font-semibold">R$ {{ number_format((float) $order->total, 2, ',', '.') }}</td>
                                <td class="px-5 py-3">
                                    <span class="rounded-full bg-slate-100 px-2.5 py-1 text-xs font-semibold text-slate-700">{{ $order->status_label }}</span>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="px-5 py-8 text-center text-sm text-slate-500">Nenhum pedido registrado ainda.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </section>

        <section class="rounded-2xl border border-slate-200 bg-white shadow-sm">
            <div class="flex items-center justify-between border-b border-slate-100 px-5 py-4">
                <h2 class="font-semibold text-slate-900">Estoque crítico</h2>
                <a href="{{ route('admin.products.index') }}" class="text-xs font-semibold text-amber-600 hover:text-amber-700">Catálogo</a>
            </div>
            <div class="divide-y divide-slate-100">
                @forelse ($lowStock as $variant)
                    <div class="flex items-center justify-between gap-3 px-5 py-3">
                        <div class="min-w-0">
                            <p class="truncate text-sm font-medium text-slate-900">{{ $variant->product?->name }}</p>
                            <p class="text-xs text-slate-400">{{ $variant->sku }} · {{ $variant->name }}</p>
                        </div>
                        <span class="shrink-0 rounded-full px-2.5 py-1 text-xs font-bold {{ $variant->stock === 0 ? 'bg-rose-100 text-rose-700' : 'bg-amber-100 text-amber-700' }}">
                            {{ $variant->stock }} un.
                        </span>
                    </div>
                @empty
                    <p class="px-5 py-8 text-center text-sm text-slate-500">Nenhum SKU com estoque baixo.</p>
                @endforelse
            </div>
        </section>
    </div>
@endsection
