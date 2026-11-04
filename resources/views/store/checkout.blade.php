@extends('layouts.store')

@section('title', 'Checkout')

@section('content')
    @php
        $groups = $quote['groups'] ?? [];
        $defaultPrices = collect($groups)->mapWithKeys(function (array $group) {
            $selectedCode = old('selected_services.' . $group['seller_id'], $group['default_service_code']);
            $option = collect($group['options'])->firstWhere('service_code', $selectedCode)
                ?? collect($group['options'])->first();

            return [$group['seller_id'] => (float) ($option['price'] ?? 0)];
        })->all();
    @endphp

    <div class="mb-6">
        <p class="text-xs font-semibold uppercase tracking-wide text-slate-400">Finalizar compra</p>
        <h1 class="text-2xl font-bold text-slate-900">Checkout</h1>
        <p class="mt-1 text-sm text-slate-500">O frete é calculado separadamente para cada vendedor (origem).</p>
    </div>

    <div class="mb-6 rounded-2xl border border-slate-200 bg-white p-5 shadow-sm">
        <form method="GET" action="{{ route('checkout.index') }}" class="flex flex-wrap items-end gap-3">
            <div class="w-48">
                <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">CEP de entrega</label>
                <input name="zip" value="{{ $zipCode }}" maxlength="9" placeholder="00000-000" required
                       class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
            </div>
            <button class="rounded-lg bg-slate-900 px-4 py-2 text-sm font-semibold text-white hover:bg-slate-800">Calcular frete</button>
            @if ($quote)
                <p class="text-xs text-emerald-600">Frete calculado para {{ $zipCode }}.</p>
            @endif
        </form>
        @if ($quoteError)
            <p class="mt-3 text-sm font-medium text-rose-600">{{ $quoteError }}</p>
        @endif
    </div>

    @if (! $quote)
        <div class="rounded-2xl border border-dashed border-slate-300 bg-white px-6 py-12 text-center">
            <p class="font-semibold text-slate-700">Informe o CEP para ver as opções de frete.</p>
            <p class="mt-1 text-sm text-slate-500">Cada vendedor terá suas próprias opções de envio.</p>
        </div>
    @else
        <form method="POST" action="{{ route('checkout.store') }}"
              x-data="{ shipping: @js($defaultPrices) }"
              class="grid gap-6 lg:grid-cols-3">
            @csrf

            <div class="space-y-6 lg:col-span-2">
                <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h2 class="mb-4 font-bold text-slate-900">Seus dados</h2>
                    <div class="grid gap-4 sm:grid-cols-2">
                        <div class="sm:col-span-2">
                            <label class="mb-1 block text-sm font-medium text-slate-700">Nome completo *</label>
                            <input name="customer_name" value="{{ old('customer_name') }}" required
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                        </div>
                        <div>
                            <label class="mb-1 block text-sm font-medium text-slate-700">E-mail *</label>
                            <input type="email" name="customer_email" value="{{ old('customer_email') }}" required
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                        </div>
                        <div>
                            <label class="mb-1 block text-sm font-medium text-slate-700">CPF / CNPJ</label>
                            <input name="customer_document" value="{{ old('customer_document') }}"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        </div>
                        <div>
                            <label class="mb-1 block text-sm font-medium text-slate-700">Telefone</label>
                            <input name="customer_phone" value="{{ old('customer_phone') }}"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        </div>
                        <div>
                            <label class="mb-1 block text-sm font-medium text-slate-700">CEP *</label>
                            <input name="shipping_zip_code" value="{{ old('shipping_zip_code', $zipCode) }}" required maxlength="9"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        </div>
                        <div class="sm:col-span-2">
                            <label class="mb-1 block text-sm font-medium text-slate-700">Rua *</label>
                            <input name="shipping_street" value="{{ old('shipping_street') }}" required
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        </div>
                        <div>
                            <label class="mb-1 block text-sm font-medium text-slate-700">Número *</label>
                            <input name="shipping_number" value="{{ old('shipping_number') }}" required
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        </div>
                        <div>
                            <label class="mb-1 block text-sm font-medium text-slate-700">Complemento</label>
                            <input name="shipping_complement" value="{{ old('shipping_complement') }}"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        </div>
                        <div>
                            <label class="mb-1 block text-sm font-medium text-slate-700">Bairro *</label>
                            <input name="shipping_neighborhood" value="{{ old('shipping_neighborhood') }}" required
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        </div>
                        <div>
                            <label class="mb-1 block text-sm font-medium text-slate-700">Cidade *</label>
                            <input name="shipping_city" value="{{ old('shipping_city') }}" required
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        </div>
                        <div>
                            <label class="mb-1 block text-sm font-medium text-slate-700">UF *</label>
                            <input name="shipping_state" value="{{ old('shipping_state') }}" required maxlength="2"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm uppercase">
                        </div>
                        <div class="sm:col-span-2">
                            <label class="mb-1 block text-sm font-medium text-slate-700">Observações</label>
                            <textarea name="notes" rows="2" class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">{{ old('notes') }}</textarea>
                        </div>
                    </div>
                </section>

                <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h2 class="font-bold text-slate-900">Frete por vendedor</h2>
                    <p class="mb-5 text-xs text-slate-500">Pacotes consolidados por origem de despacho.</p>

                    <div class="space-y-5">
                        @foreach ($groups as $group)
                            <div class="rounded-xl border border-slate-200 p-4">
                                <div class="mb-3 flex flex-wrap items-start justify-between gap-2">
                                    <div>
                                        <p class="font-semibold text-slate-900">{{ $group['seller_name'] }}</p>
                                        <p class="text-xs text-slate-400">
                                            Origem: CEP {{ $group['origin_zip_code'] }} · {{ number_format($group['billable_weight_grams'] / 1000, 2, ',', '.') }} kg
                                            · {{ $group['dimensions']['length_cm'] }}×{{ $group['dimensions']['width_cm'] }}×{{ $group['dimensions']['height_cm'] }} cm
                                        </p>
                                    </div>
                                    <p class="text-xs text-slate-400">{{ $group['items'] ? count($group['items']) : 0 }} SKU(s)</p>
                                </div>

                                <div class="grid gap-2 sm:grid-cols-3">
                                    @foreach ($group['options'] as $option)
                                        <label class="flex cursor-pointer items-start gap-2 rounded-lg border border-slate-200 px-3 py-2 text-sm hover:border-amber-400">
                                            <input type="radio"
                                                   name="selected_services[{{ $group['seller_id'] }}]"
                                                   value="{{ $option['service_code'] }}"
                                                   class="mt-0.5"
                                                   @change="shipping[{{ $group['seller_id'] }}] = {{ (float) $option['price'] }}"
                                                   @checked(old('selected_services.' . $group['seller_id'], $group['default_service_code']) === $option['service_code'])>
                                            <span>
                                                <span class="block font-medium text-slate-800">{{ $option['service_name'] }}</span>
                                                <span class="block text-xs text-slate-400">
                                                    {{ $option['delivery_days'] > 0 ? $option['delivery_days'] . ' dias úteis' : 'Retirada' }}
                                                    · {{ $option['price'] > 0 ? 'R$ ' . number_format($option['price'], 2, ',', '.') : 'Grátis' }}
                                                </span>
                                            </span>
                                        </label>
                                    @endforeach
                                </div>
                            </div>
                        @endforeach
                    </div>
                </section>

                <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                    <h2 class="mb-4 font-bold text-slate-900">Pagamento</h2>
                    <div class="grid gap-2 sm:grid-cols-3">
                        @php
                            $methods = [
                                'pix' => ['label' => 'Pix', 'hint' => 'Aprovação imediata'],
                                'credit_card' => ['label' => 'Cartão de crédito', 'hint' => 'Split por vendedor'],
                                'boleto' => ['label' => 'Boleto', 'hint' => 'Compensação em 1-2 dias'],
                            ];
                        @endphp
                        @foreach ($methods as $value => $method)
                            <label class="flex cursor-pointer items-start gap-2 rounded-lg border border-slate-200 px-3 py-3 text-sm hover:border-amber-400">
                                <input type="radio" name="payment_method" value="{{ $value }}" class="mt-0.5"
                                       @checked(old('payment_method', 'pix') === $value)>
                                <span>
                                    <span class="block font-medium text-slate-800">{{ $method['label'] }}</span>
                                    <span class="block text-xs text-slate-400">{{ $method['hint'] }}</span>
                                </span>
                            </label>
                        @endforeach
                    </div>
                </section>
            </div>

            <aside class="h-fit rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
                <h2 class="font-bold text-slate-900">Resumo do pedido</h2>

                <div class="mt-4 space-y-3">
                    @foreach ($items as $item)
                        <div class="flex justify-between gap-3 text-sm">
                            <div>
                                <p class="font-medium text-slate-800">{{ $item->variant->product->name }}</p>
                                <p class="text-xs text-slate-400">{{ $item->variant->name }} × {{ $item->quantity }}</p>
                            </div>
                            <p class="shrink-0 font-medium">R$ {{ number_format($item->subtotal(), 2, ',', '.') }}</p>
                        </div>
                    @endforeach
                </div>

                <dl class="mt-4 space-y-2 border-t border-slate-100 pt-4 text-sm">
                    <div class="flex justify-between"><dt class="text-slate-500">Subtotal</dt><dd>R$ {{ number_format($subtotal, 2, ',', '.') }}</dd></div>
                    <div class="flex justify-between">
                        <dt class="text-slate-500">Frete</dt>
                        <dd x-text="'R$ ' + Object.values(shipping).reduce((a, b) => a + Number(b), 0).toFixed(2).replace('.', ',')"></dd>
                    </div>
                    <div class="flex justify-between border-t border-slate-100 pt-2 text-base font-bold">
                        <dt>Total</dt>
                        <dd x-text="'R$ ' + ({{ (float) $subtotal }} + Object.values(shipping).reduce((a, b) => a + Number(b), 0)).toFixed(2).replace('.', ',')"></dd>
                    </div>
                </dl>

                <button class="mt-5 w-full rounded-lg bg-amber-500 px-4 py-3 text-sm font-bold text-slate-900 hover:bg-amber-400">
                    Finalizar pedido
                </button>
                <p class="mt-3 text-center text-[11px] leading-relaxed text-slate-400">
                    Ao finalizar, o estoque é reservado com lock pessimista e o pagamento é dividido entre os vendedores.
                </p>
            </aside>
        </form>
    @endif
@endsection
