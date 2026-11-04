@extends('layouts.app')

@section('title', $product->exists ? 'Editar produto' : 'Novo produto')
@section('eyebrow', 'Produtos')
@section('heading', $product->exists ? 'Editar produto' : 'Novo produto')

@section('content')
    @php
        $selectedVehicleIds = collect(old('vehicle_model_ids', $selectedVehicleIds))->map(fn ($id) => (int) $id)->all();
    @endphp

    <form method="POST"
          action="{{ $product->exists ? route('admin.products.update', $product) : route('admin.products.store') }}"
          class="space-y-6">
        @csrf
        @if ($product->exists)
            @method('PUT')
        @endif

        <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
            <h2 class="mb-4 font-semibold text-slate-900">Dados do produto</h2>
            <div class="grid gap-4 md:grid-cols-2">
                <div class="md:col-span-2">
                    <label class="mb-1 block text-sm font-medium text-slate-700">Nome *</label>
                    <input name="name" value="{{ old('name', $product->name) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Vendedor *</label>
                    <select name="seller_id" required class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        <option value="">Selecione</option>
                        @foreach ($sellers as $seller)
                            <option value="{{ $seller->id }}" @selected((string) old('seller_id', $product->seller_id) === (string) $seller->id)>{{ $seller->trade_name }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Slug</label>
                    <input name="slug" value="{{ old('slug', $product->slug) }}" placeholder="gerado automaticamente"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Marca</label>
                    <input name="brand" value="{{ old('brand', $product->brand) }}"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Categoria</label>
                    <input name="category" value="{{ old('category', $product->category) }}" placeholder="ex.: Suspensão"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div class="md:col-span-2">
                    <label class="mb-1 block text-sm font-medium text-slate-700">URL da imagem</label>
                    <input name="image_url" type="text" value="{{ old('image_url', $product->image_url) }}" placeholder="/images/products/pastilha-1.jpg ou https://..."
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div class="md:col-span-2">
                    <label class="mb-1 block text-sm font-medium text-slate-700">Descrição</label>
                    <textarea name="description" rows="4"
                              class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">{{ old('description', $product->description) }}</textarea>
                </div>
            </div>
        </section>

        <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
            <h2 class="font-semibold text-slate-900">Compatibilidade veicular</h2>
            <p class="mb-4 text-xs text-slate-500">Selecione os modelos de veículos compatíveis com este produto.</p>
            <div class="grid max-h-72 gap-2 overflow-y-auto rounded-lg border border-slate-200 p-3 sm:grid-cols-2 lg:grid-cols-3">
                @forelse ($vehicleModels as $vehicleModel)
                    <label class="flex items-start gap-2 rounded-lg px-2 py-1.5 text-sm hover:bg-slate-50">
                        <input type="checkbox" name="vehicle_model_ids[]" value="{{ $vehicleModel->id }}"
                               class="mt-0.5 rounded border-slate-300" @checked(in_array($vehicleModel->id, $selectedVehicleIds, true))>
                        <span>{{ $vehicleModel->display_name }}</span>
                    </label>
                @empty
                    <p class="col-span-full text-sm text-slate-500">Nenhum veículo cadastrado. <a href="{{ route('admin.vehicle-models.create') }}" class="font-semibold text-amber-600">Cadastrar veículo</a></p>
                @endforelse
            </div>
        </section>

        <section class="flex items-center justify-between rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
            <label class="flex items-center gap-2 text-sm font-medium text-slate-700">
                <input type="hidden" name="active" value="0">
                <input type="checkbox" name="active" value="1" class="rounded border-slate-300" @checked(old('active', $product->active))>
                Produto ativo
            </label>
            <div class="flex items-center gap-3">
                <a href="{{ route('admin.products.index') }}" class="text-sm text-slate-500 hover:text-slate-800">Cancelar</a>
                <button class="rounded-lg bg-slate-900 px-5 py-2.5 text-sm font-semibold text-white hover:bg-slate-800">
                    {{ $product->exists ? 'Salvar alterações' : 'Cadastrar produto' }}
                </button>
            </div>
        </section>
    </form>
@endsection
