@extends('layouts.app')

@section('title', 'Pedidos')
@section('heading', 'Pedidos')

@section('content')
    <div class="rounded-2xl border border-slate-200 bg-white shadow-sm">
        <form method="GET" class="flex flex-wrap items-end gap-3 border-b border-slate-100 p-5">
            <div class="min-w-64 flex-1">
                <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Buscar</label>
                <input name="q" value="{{ request('q') }}" placeholder="Número, cliente ou e-mail"
                       class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
            </div>
            <div>
                <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Status</label>
                <select name="status" class="rounded-lg border border-slate-300 px-3 py-2 text-sm">
                    <option value="">Todos</option>
                    @foreach ($statuses as $status)
                        <option value="{{ $status }}" @selected(request('status') === $status)>{{ ucfirst($status) }}</option>
                    @endforeach
                </select>
            </div>
            <button class="rounded-lg border border-slate-300 px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">Filtrar</button>
            <a href="{{ route('admin.orders.index') }}" class="px-2 py-2 text-sm text-slate-500 hover:text-slate-800">Limpar</a>
        </form>

        <div class="overflow-x-auto">
            <table class="w-full text-left text-sm">
                <thead class="bg-slate-50 text-xs uppercase tracking-wide text-slate-500">
                    <tr>
                        <th class="px-5 py-3">Pedido</th>
                        <th class="px-5 py-3">Cliente</th>
                        <th class="px-5 py-3">Itens</th>
                        <th class="px-5 py-3">Total</th>
                        <th class="px-5 py-3">Pagamento</th>
                        <th class="px-5 py-3">Status</th>
                        <th class="px-5 py-3 text-right">Ações</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    @forelse ($orders as $order)
                        <tr class="hover:bg-slate-50">
                            <td class="px-5 py-3">
                                <a href="{{ route('admin.orders.show', $order) }}" class="font-semibold text-slate-900 hover:text-amber-600">{{ $order->number }}</a>
                                <p class="text-xs text-slate-400">{{ $order->created_at->format('d/m/Y H:i') }}</p>
                            </td>
                            <td class="px-5 py-3">
                                <p class="font-medium">{{ $order->customer_name }}</p>
                                <p class="text-xs text-slate-400">{{ $order->customer_email }}</p>
                            </td>
                            <td class="px-5 py-3 text-slate-600">{{ $order->items_count }}</td>
                            <td class="px-5 py-3 font-semibold">R$ {{ number_format((float) $order->total, 2, ',', '.') }}</td>
                            <td class="px-5 py-3">
                                <span class="rounded-full px-2.5 py-1 text-xs font-semibold {{ $order->payment_status === 'paid' ? 'bg-emerald-100 text-emerald-700' : 'bg-amber-100 text-amber-700' }}">
                                    {{ $order->payment_status_label }}
                                </span>
                            </td>
                            <td class="px-5 py-3">
                                <span class="rounded-full bg-slate-100 px-2.5 py-1 text-xs font-semibold text-slate-700">{{ $order->status_label }}</span>
                            </td>
                            <td class="px-5 py-3 text-right">
                                <a href="{{ route('admin.orders.show', $order) }}" class="text-xs font-semibold text-slate-600 hover:text-amber-600">Detalhes</a>
                            </td>
                        </tr>
                    @empty
                        <tr><td colspan="7" class="px-5 py-10 text-center text-sm text-slate-500">Nenhum pedido encontrado.</td></tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        <div class="border-t border-slate-100 px-5 py-4">{{ $orders->links() }}</div>
    </div>
@endsection
