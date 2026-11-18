@extends('layouts.store')

@section('title', 'Pedido confirmado')

@section('content')
    <div class="mx-auto max-w-3xl">
        <div class="rounded-3xl border border-emerald-200 bg-white p-8 text-center shadow-sm">
            <div class="mx-auto flex h-14 w-14 items-center justify-center rounded-full bg-emerald-100 text-2xl text-emerald-700">✓</div>
            <h1 class="mt-4 text-2xl font-bold text-slate-900">Pedido realizado com sucesso!</h1>
            <p class="mt-1 text-sm text-slate-500">Guardamos seu pedido com o número <span class="font-mono font-semibold text-slate-800">{{ $order->number }}</span>.</p>
            <p class="mt-3 inline-block rounded-full bg-amber-100 px-3 py-1 text-xs font-semibold text-amber-700">
                Pagamento {{ strtolower($order->payment_status_label) }} · {{ $order->payment_method ? $order->payment_method_label : '—' }}
            </p>
        </div>

        @if ($order->payment_method === 'pix' && $order->payment_status === \App\Models\Order::PAYMENT_PENDING && $pixQrSvg)
            <div class="mt-6 rounded-2xl border border-emerald-200 bg-white p-6 shadow-sm"
                 x-data="{
                     copied: false,
                     copy() {
                         const input = this.$refs.payload;
                         const done = () => { this.copied = true; setTimeout(() => this.copied = false, 2000); };
                         if (navigator.clipboard && window.isSecureContext) {
                             navigator.clipboard.writeText(input.value).then(done).catch(() => { input.select(); document.execCommand('copy'); done(); });
                         } else {
                             input.select();
                             document.execCommand('copy');
                             done();
                         }
                     }
                 }">
                <div class="flex flex-wrap items-start justify-between gap-3">
                    <div>
                        <h2 class="text-lg font-bold text-slate-900">Pague com Pix</h2>
                        <p class="mt-1 text-sm text-slate-500">Escaneie o QR Code ou use o Pix copia e cola. O pedido será confirmado após o pagamento.</p>
                    </div>
                    <span class="rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-700">Aguardando pagamento</span>
                </div>

                <div class="mt-5 grid gap-6 md:grid-cols-[220px_1fr]">
                    <div class="mx-auto w-full max-w-[220px] rounded-2xl border border-slate-200 bg-white p-3">
                        {!! $pixQrSvg !!}
                    </div>

                    <div class="space-y-4 text-sm">
                        <div>
                            <p class="text-xs font-semibold uppercase tracking-wide text-slate-400">Valor do Pix</p>
                            <p class="text-2xl font-bold text-slate-900">R$ {{ number_format((float) $order->total, 2, ',', '.') }}</p>
                        </div>

                        @if ($order->pix_expires_at)
                            <p class="text-xs text-slate-500">
                                Válido até <strong class="text-slate-700">{{ $order->pix_expires_at->format('d/m/Y \à\s H:i') }}</strong>
                            </p>
                        @endif

                        <div>
                            <label for="pix-payload" class="text-xs font-semibold uppercase tracking-wide text-slate-400">Pix copia e cola</label>
                            <div class="mt-1 flex flex-col gap-2 sm:flex-row">
                                <input id="pix-payload" x-ref="payload" readonly value="{{ $order->pix_payload }}"
                                       class="w-full rounded-lg border border-slate-300 bg-slate-50 px-3 py-2 font-mono text-xs text-slate-700">
                                <button type="button" @click="copy()"
                                        class="shrink-0 rounded-lg bg-emerald-600 px-4 py-2 text-xs font-semibold text-white hover:bg-emerald-500">
                                    <span x-show="!copied">Copiar código</span>
                                    <span x-show="copied" x-cloak>Código copiado!</span>
                                </button>
                            </div>
                        </div>

                        @if (config('payments.pix.is_demo'))
                            <p class="rounded-lg bg-red-50 px-3 py-2 text-xs text-red-700">
                                <strong>Chave Pix de demonstração.</strong> O QR Code é lido pelos aplicativos, mas não pode ser pago porque
                                <code>pagamentos@autostock.test</code> não está registrada no DICT. Defina <code>PIX_KEY</code> com uma chave real
                                e rode <code>php artisan pix:regenerate</code>.
                            </p>
                        @else
                            <p class="rounded-lg bg-amber-50 px-3 py-2 text-xs text-amber-700">
                                A confirmação automática do Pix depende da integração com um PSP. O pedido fica pendente até a conciliação.
                            </p>
                        @endif
                    </div>
                </div>
            </div>
        @endif

        <div class="mt-6 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
            <h2 class="font-bold text-slate-900">Itens do pedido</h2>
            <div class="mt-4 space-y-3">
                @foreach ($order->items as $item)
                    <div class="flex flex-wrap items-center justify-between gap-2 border-b border-slate-100 pb-3 text-sm">
                        <div>
                            <p class="font-medium text-slate-800">{{ $item->product_name }}</p>
                            <p class="text-xs text-slate-400">{{ $item->variant_name }} · {{ $item->sku }} · {{ $item->quantity }} un. · {{ $item->seller?->trade_name }}</p>
                        </div>
                        <p class="font-semibold">R$ {{ number_format((float) $item->total, 2, ',', '.') }}</p>
                    </div>
                @endforeach
            </div>

            <dl class="mt-4 space-y-2 text-sm">
                <div class="flex justify-between"><dt class="text-slate-500">Subtotal</dt><dd>R$ {{ number_format((float) $order->subtotal, 2, ',', '.') }}</dd></div>
                <div class="flex justify-between"><dt class="text-slate-500">Frete</dt><dd>R$ {{ number_format((float) $order->shipping_total, 2, ',', '.') }}</dd></div>
                <div class="flex justify-between border-t border-slate-100 pt-2 text-base font-bold"><dt>Total</dt><dd>R$ {{ number_format((float) $order->total, 2, ',', '.') }}</dd></div>
            </dl>
        </div>

        <div class="mt-6 grid gap-6 md:grid-cols-2">
            <div class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <h2 class="font-bold text-slate-900">Envios</h2>
                <div class="mt-3 space-y-4">
                    @foreach ($order->shipments as $shipment)
                        <div class="rounded-xl border border-slate-100 bg-slate-50 p-3 text-sm">
                            <p class="font-semibold text-slate-800">{{ $shipment->seller?->trade_name }}</p>
                            <p class="text-xs text-slate-500">{{ $shipment->shipping_method }} · R$ {{ number_format((float) $shipment->shipping_cost, 2, ',', '.') }}</p>
                            <p class="mt-1 text-xs text-slate-400">
                                Rastreio: {{ $shipment->tracking_code ?: 'aguardando postagem' }}
                                @if ($shipment->estimated_delivery_date)
                                    · previsão {{ $shipment->estimated_delivery_date->format('d/m/Y') }}
                                @endif
                            </p>
                        </div>
                    @endforeach
                </div>
            </div>

            <div class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <h2 class="font-bold text-slate-900">Split de pagamento</h2>
                <div class="mt-3 space-y-3">
                    @foreach ($order->payments as $payment)
                        <div class="rounded-xl border border-slate-100 bg-slate-50 p-3 text-sm">
                            <div class="flex justify-between">
                                <p class="font-semibold text-slate-800">{{ $payment->seller?->trade_name }}</p>
                                <p class="font-semibold">R$ {{ number_format((float) $payment->seller_amount, 2, ',', '.') }}</p>
                            </div>
                            <p class="text-xs text-slate-400">Repasse ao vendedor · taxa R$ {{ number_format((float) $payment->platform_fee, 2, ',', '.') }}</p>
                        </div>
                    @endforeach
                </div>
            </div>
        </div>

        <div class="mt-8 text-center">
            <a href="{{ route('home') }}" class="inline-block rounded-lg bg-slate-900 px-5 py-2.5 text-sm font-semibold text-white hover:bg-slate-800">Voltar ao catálogo</a>
        </div>
    </div>
@endsection
