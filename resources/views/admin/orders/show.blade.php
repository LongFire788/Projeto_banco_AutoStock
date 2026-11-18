@extends('layouts.app')

@section('title', 'Pedido ' . $order->number)
@section('eyebrow', 'Pedidos')
@section('heading', 'Pedido ' . $order->number)

@section('actions')
    <span class="rounded-full bg-slate-900 px-4 py-2 text-xs font-semibold text-white">{{ $order->status_label }}</span>
    <span class="rounded-full px-4 py-2 text-xs font-semibold {{ $order->payment_status === 'paid' ? 'bg-emerald-100 text-emerald-700' : 'bg-amber-100 text-amber-700' }}">
        Pagamento: {{ $order->payment_status_label }}
    </span>
@endsection

@section('content')
    <div class="grid gap-6 xl:grid-cols-3">
        <div class="space-y-6 xl:col-span-2">
            <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <div class="mb-4 flex flex-wrap items-center justify-between gap-3">
                    <h2 class="font-semibold text-slate-900">Dados do cliente</h2>
                    <p class="text-xs text-slate-400">Realizado em {{ $order->created_at->format('d/m/Y H:i') }}</p>
                </div>
                <dl class="grid gap-4 text-sm sm:grid-cols-2">
                    <div><dt class="text-xs uppercase tracking-wide text-slate-400">Nome</dt><dd class="mt-1 font-medium">{{ $order->customer_name }}</dd></div>
                    <div><dt class="text-xs uppercase tracking-wide text-slate-400">E-mail</dt><dd class="mt-1 font-medium">{{ $order->customer_email }}</dd></div>
                    <div><dt class="text-xs uppercase tracking-wide text-slate-400">Documento</dt><dd class="mt-1 font-medium">{{ $order->customer_document ?: '—' }}</dd></div>
                    <div><dt class="text-xs uppercase tracking-wide text-slate-400">Telefone</dt><dd class="mt-1 font-medium">{{ $order->customer_phone ?: '—' }}</dd></div>
                    <div class="sm:col-span-2">
                        <dt class="text-xs uppercase tracking-wide text-slate-400">Endereço de entrega</dt>
                        <dd class="mt-1 font-medium">
                            {{ $order->shipping_street }}, {{ $order->shipping_number }}{{ $order->shipping_complement ? ' - ' . $order->shipping_complement : '' }}<br>
                            {{ $order->shipping_neighborhood }} · {{ $order->shipping_city }}/{{ $order->shipping_state }} · CEP {{ $order->shipping_zip_code }}
                        </dd>
                    </div>
                </dl>
                @if ($order->notes)
                    <p class="mt-4 rounded-lg bg-slate-50 px-4 py-3 text-sm text-slate-600"><span class="font-semibold">Observações:</span> {{ $order->notes }}</p>
                @endif
            </section>

            @foreach ($order->shipments as $shipment)
                <section class="rounded-2xl border border-slate-200 bg-white shadow-sm">
                    <div class="flex flex-wrap items-start justify-between gap-3 border-b border-slate-100 px-5 py-4">
                        <div>
                            <h2 class="font-semibold text-slate-900">Envio · {{ $shipment->seller?->trade_name }}</h2>
                            <p class="text-xs text-slate-400">
                                Origem: {{ $shipment->seller?->address_city }}/{{ $shipment->seller?->address_state }} · {{ $shipment->shipping_method }}
                                @if ($shipment->shipping_service_code) ({{ $shipment->shipping_service_code }}) @endif
                            </p>
                        </div>
                        <div class="text-right">
                            <p class="font-semibold text-slate-900">R$ {{ number_format((float) $shipment->shipping_cost, 2, ',', '.') }}</p>
                            <span class="rounded-full bg-slate-100 px-2.5 py-1 text-xs font-semibold text-slate-700">{{ $shipment->status_label }}</span>
                        </div>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-sm">
                            <thead class="bg-slate-50 text-xs uppercase tracking-wide text-slate-500">
                                <tr>
                                    <th class="px-5 py-2.5">Item</th>
                                    <th class="px-5 py-2.5">SKU</th>
                                    <th class="px-5 py-2.5">Qtd.</th>
                                    <th class="px-5 py-2.5">Unitário</th>
                                    <th class="px-5 py-2.5">Total</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100">
                                @foreach ($shipment->items as $item)
                                    <tr>
                                        <td class="px-5 py-3">
                                            <p class="font-medium">{{ $item->product_name }}</p>
                                            <p class="text-xs text-slate-400">{{ $item->variant_name }}</p>
                                        </td>
                                        <td class="px-5 py-3 font-mono text-xs">{{ $item->sku }}</td>
                                        <td class="px-5 py-3">{{ $item->quantity }}</td>
                                        <td class="px-5 py-3">R$ {{ number_format((float) $item->unit_price, 2, ',', '.') }}</td>
                                        <td class="px-5 py-3 font-semibold">R$ {{ number_format((float) $item->total, 2, ',', '.') }}</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>

                    <form method="POST" action="{{ route('admin.orders.shipments.update', [$order, $shipment]) }}"
                          class="grid gap-3 border-t border-slate-100 bg-slate-50/60 p-5 sm:grid-cols-4">
                        @csrf
                        @method('PATCH')
                        <div>
                            <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Status do envio</label>
                            <select name="status" class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                                @foreach ($shipmentStatuses as $status)
                                    <option value="{{ $status }}" @selected($shipment->status === $status)>{{ $shipmentStatusLabels[$status] ?? ucfirst(str_replace('_', ' ', $status)) }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div>
                            <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Rastreio</label>
                            <input name="tracking_code" value="{{ $shipment->tracking_code }}" placeholder="BR123456789"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        </div>
                        <div>
                            <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Previsão</label>
                            <input type="date" name="estimated_delivery_date" value="{{ $shipment->estimated_delivery_date?->format('Y-m-d') }}"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        </div>
                        <div class="flex items-end">
                            <button class="w-full rounded-lg bg-slate-900 px-4 py-2 text-sm font-semibold text-white hover:bg-slate-800">Atualizar envio</button>
                        </div>
                    </form>
                </section>
            @endforeach
        </div>

        <div class="space-y-6">
            <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <h2 class="mb-4 font-semibold text-slate-900">Resumo</h2>
                <dl class="space-y-2 text-sm">
                    <div class="flex justify-between"><dt class="text-slate-500">Subtotal</dt><dd>R$ {{ number_format((float) $order->subtotal, 2, ',', '.') }}</dd></div>
                    <div class="flex justify-between"><dt class="text-slate-500">Frete</dt><dd>R$ {{ number_format((float) $order->shipping_total, 2, ',', '.') }}</dd></div>
                    <div class="flex justify-between"><dt class="text-slate-500">Desconto</dt><dd>− R$ {{ number_format((float) $order->discount_total, 2, ',', '.') }}</dd></div>
                    <div class="flex justify-between border-t border-slate-100 pt-2 text-base font-bold"><dt>Total</dt><dd>R$ {{ number_format((float) $order->total, 2, ',', '.') }}</dd></div>
                </dl>
                <p class="mt-3 text-xs text-slate-400">Pagamento: {{ $order->payment_method ? $order->payment_method_label : '—' }}</p>
            </section>

            @if ($order->payment_method === 'pix')
                <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                    <div class="mb-4 flex items-center justify-between gap-3">
                        <h2 class="font-semibold text-slate-900">Pix</h2>
                        <span class="rounded-full px-2.5 py-1 text-xs font-semibold {{ $order->payment_status === 'paid' ? 'bg-emerald-100 text-emerald-700' : 'bg-amber-100 text-amber-700' }}">
                            {{ $order->payment_status_label }}
                        </span>
                    </div>

                    @if ($pixQrSvg)
                        <div class="mx-auto w-full max-w-[180px] rounded-xl border border-slate-200 bg-white p-2">
                            {!! $pixQrSvg !!}
                        </div>

                        <dl class="mt-4 space-y-1 text-sm">
                            <div class="flex justify-between"><dt class="text-slate-500">Valor</dt><dd class="font-semibold">R$ {{ number_format((float) $order->total, 2, ',', '.') }}</dd></div>
                            @if ($order->pix_expires_at)
                                <div class="flex justify-between"><dt class="text-slate-500">Expira em</dt><dd>{{ $order->pix_expires_at->format('d/m/Y H:i') }}</dd></div>
                            @endif
                        </dl>

                        @if (config('payments.pix.is_demo'))
                            <p class="mt-4 rounded-lg bg-red-50 px-3 py-2 text-xs text-red-700">
                                Chave Pix de demonstração: o QR é lido, mas não pode ser pago. Configure <code>PIX_KEY</code> e rode
                                <code>php artisan pix:regenerate</code>.
                            </p>
                        @endif

                        <label class="mt-4 block text-xs font-semibold uppercase tracking-wide text-slate-400">Copia e cola</label>
                        <textarea readonly rows="4" class="mt-1 w-full rounded-lg border border-slate-300 bg-slate-50 px-3 py-2 font-mono text-[11px] text-slate-600">{{ $order->pix_payload }}</textarea>
                    @else
                        <p class="text-sm text-slate-500">Nenhum payload Pix registrado para este pedido.</p>
                    @endif
                </section>
            @endif

            <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <h2 class="mb-4 font-semibold text-slate-900">Atualizar status</h2>
                <form method="POST" action="{{ route('admin.orders.status', $order) }}" class="space-y-3">
                    @csrf
                    @method('PATCH')
                    <select name="status" class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        @foreach ($statuses as $status)
                            <option value="{{ $status }}" @selected($order->status === $status)>{{ $statusLabels[$status] ?? ucfirst(str_replace('_', ' ', $status)) }}</option>
                        @endforeach
                    </select>
                    <p class="text-xs text-slate-400">Ao definir como <strong>Pago</strong>, os pagamentos pendentes são aprovados. Ao cancelar, o estoque é devolvido.</p>
                    <button class="w-full rounded-lg bg-amber-500 px-4 py-2 text-sm font-semibold text-slate-900 hover:bg-amber-400">Salvar status</button>
                </form>
            </section>

            <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <h2 class="mb-4 font-semibold text-slate-900">Split de pagamento</h2>
                <div class="space-y-4">
                    @forelse ($order->payments as $payment)
                        <div class="rounded-xl border border-slate-100 bg-slate-50 p-3 text-sm">
                            <div class="flex items-center justify-between">
                                <p class="font-semibold text-slate-900">{{ $payment->seller?->trade_name }}</p>
                                <span class="text-xs font-semibold {{ $payment->status === 'paid' ? 'text-emerald-600' : 'text-amber-600' }}">{{ $payment->status_label }}</span>
                            </div>
                            <p class="mt-1 font-mono text-[11px] text-slate-400">{{ $payment->gateway_receiver_id ?: 'sem receiver_id' }}</p>
                            <dl class="mt-2 space-y-1 text-xs">
                                <div class="flex justify-between"><dt class="text-slate-500">Cobrado</dt><dd>R$ {{ number_format((float) $payment->amount, 2, ',', '.') }}</dd></div>
                                <div class="flex justify-between"><dt class="text-slate-500">Taxa plataforma</dt><dd>− R$ {{ number_format((float) $payment->platform_fee, 2, ',', '.') }}</dd></div>
                                <div class="flex justify-between font-semibold"><dt>Repasse seller</dt><dd>R$ {{ number_format((float) $payment->seller_amount, 2, ',', '.') }}</dd></div>
                            </dl>
                        </div>
                    @empty
                        <p class="text-sm text-slate-500">Nenhum pagamento registrado.</p>
                    @endforelse
                </div>
            </section>
        </div>
    </div>
@endsection
