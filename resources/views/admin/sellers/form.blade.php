@extends('layouts.app')

@section('title', $seller->exists ? 'Editar vendedor' : 'Novo vendedor')
@section('eyebrow', 'Vendedores')
@section('heading', $seller->exists ? 'Editar vendedor' : 'Novo vendedor')

@section('content')
    @php
        $states = ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'];
    @endphp

    <form method="POST"
          action="{{ $seller->exists ? route('admin.sellers.update', $seller) : route('admin.sellers.store') }}"
          class="space-y-6">
        @csrf
        @if ($seller->exists)
            @method('PUT')
        @endif

        <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
            <h2 class="mb-4 font-semibold text-slate-900">Dados cadastrais</h2>
            <div class="grid gap-4 md:grid-cols-2">
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Razão social *</label>
                    <input name="legal_name" value="{{ old('legal_name', $seller->legal_name) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Nome fantasia *</label>
                    <input name="trade_name" value="{{ old('trade_name', $seller->trade_name) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">CNPJ / CPF *</label>
                    <input name="document" value="{{ old('document', $seller->document) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">E-mail *</label>
                    <input type="email" name="email" value="{{ old('email', $seller->email) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Telefone</label>
                    <input name="phone" value="{{ old('phone', $seller->phone) }}"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">ID do recebedor no gateway</label>
                    <input name="gateway_receiver_id" value="{{ old('gateway_receiver_id', $seller->gateway_receiver_id) }}"
                           placeholder="ex.: recv_abc123"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                    <p class="mt-1 text-xs text-slate-400">Usado no split de pagamento (subconta do seller).</p>
                </div>
            </div>
        </section>

        <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
            <h2 class="mb-1 font-semibold text-slate-900">Endereço de despacho</h2>
            <p class="mb-4 text-xs text-slate-500">Este CEP é a origem usada no cálculo de frete multi-origem.</p>
            <div class="grid gap-4 md:grid-cols-6">
                <div class="md:col-span-2">
                    <label class="mb-1 block text-sm font-medium text-slate-700">CEP *</label>
                    <input name="zip_code" value="{{ old('zip_code', $seller->zip_code) }}" required maxlength="9"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div class="md:col-span-3">
                    <label class="mb-1 block text-sm font-medium text-slate-700">Rua *</label>
                    <input name="address_street" value="{{ old('address_street', $seller->address_street) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Número *</label>
                    <input name="address_number" value="{{ old('address_number', $seller->address_number) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div class="md:col-span-2">
                    <label class="mb-1 block text-sm font-medium text-slate-700">Complemento</label>
                    <input name="address_complement" value="{{ old('address_complement', $seller->address_complement) }}"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div class="md:col-span-2">
                    <label class="mb-1 block text-sm font-medium text-slate-700">Bairro *</label>
                    <input name="address_neighborhood" value="{{ old('address_neighborhood', $seller->address_neighborhood) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div class="md:col-span-2">
                    <label class="mb-1 block text-sm font-medium text-slate-700">Cidade *</label>
                    <input name="address_city" value="{{ old('address_city', $seller->address_city) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">UF *</label>
                    <select name="address_state" required class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        @foreach ($states as $state)
                            <option value="{{ $state }}" @selected(old('address_state', $seller->address_state) === $state)>{{ $state }}</option>
                        @endforeach
                    </select>
                </div>
            </div>
        </section>

        <section class="flex items-center justify-between rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
            <label class="flex items-center gap-2 text-sm font-medium text-slate-700">
                <input type="hidden" name="active" value="0">
                <input type="checkbox" name="active" value="1" class="rounded border-slate-300" @checked(old('active', $seller->active))>
                Vendedor ativo (aparece na loja)
            </label>
            <div class="flex items-center gap-3">
                <a href="{{ route('admin.sellers.index') }}" class="text-sm text-slate-500 hover:text-slate-800">Cancelar</a>
                <button class="rounded-lg bg-slate-900 px-5 py-2.5 text-sm font-semibold text-white hover:bg-slate-800">
                    {{ $seller->exists ? 'Salvar alterações' : 'Cadastrar vendedor' }}
                </button>
            </div>
        </section>
    </form>
@endsection
