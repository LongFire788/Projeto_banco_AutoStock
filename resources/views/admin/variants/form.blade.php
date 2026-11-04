@extends('layouts.app')

@section('title', $variant->exists ? 'Editar variação' : 'Nova variação')
@section('eyebrow', $product->name)
@section('heading', $variant->exists ? 'Editar variação' : 'Nova variação')

@section('content')
    @php
        $attributeRows = old('attributes', $variant->attributes->map(fn ($attribute) => [
            'name' => $attribute->name,
            'value' => $attribute->value,
        ])->all());
    @endphp

    <form method="POST"
          action="{{ $variant->exists
              ? route('admin.products.variants.update', [$product, $variant])
              : route('admin.products.variants.store', $product) }}"
          class="space-y-6">
        @csrf
        @if ($variant->exists)
            @method('PUT')
        @endif

        <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
            <h2 class="mb-4 font-semibold text-slate-900">Identificação e preço</h2>
            <div class="grid gap-4 md:grid-cols-2">
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">SKU *</label>
                    <input name="sku" value="{{ old('sku', $variant->sku) }}" required placeholder="ex.: AMORT-DIR-COFAP"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm uppercase focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Nome da variação *</label>
                    <input name="name" value="{{ old('name', $variant->name) }}" required placeholder="ex.: Lado Direito"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Preço de venda (R$) *</label>
                    <input name="price" type="number" step="0.01" min="0.01" value="{{ old('price', $variant->price) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Preço "de" (opcional)</label>
                    <input name="compare_at_price" type="number" step="0.01" min="0" value="{{ old('compare_at_price', $variant->compare_at_price) }}"
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Estoque (unidades) *</label>
                    <input name="stock" type="number" min="0" value="{{ old('stock', $variant->stock ?? 0) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
                </div>
                <div class="flex items-end">
                    <label class="flex items-center gap-2 text-sm font-medium text-slate-700">
                        <input type="hidden" name="active" value="0">
                        <input type="checkbox" name="active" value="1" class="rounded border-slate-300" @checked(old('active', $variant->active ?? true))>
                        Variação ativa
                    </label>
                </div>
            </div>
        </section>

        <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
            <h2 class="mb-1 font-semibold text-slate-900">Dados logísticos</h2>
            <p class="mb-4 text-xs text-slate-500">Peso e dimensões do SKU unitário, usados na cubagem e no frete.</p>
            <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Peso (gramas) *</label>
                    <input name="weight_grams" type="number" min="1" value="{{ old('weight_grams', $variant->weight_grams) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Comprimento (cm) *</label>
                    <input name="length_cm" type="number" min="1" max="200" value="{{ old('length_cm', $variant->length_cm) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Largura (cm) *</label>
                    <input name="width_cm" type="number" min="1" max="200" value="{{ old('width_cm', $variant->width_cm) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                </div>
                <div>
                    <label class="mb-1 block text-sm font-medium text-slate-700">Altura (cm) *</label>
                    <input name="height_cm" type="number" min="1" max="200" value="{{ old('height_cm', $variant->height_cm) }}" required
                           class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                </div>
            </div>
        </section>

        <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm"
                 x-data="{
                     attributes: @js(array_values($attributeRows)),
                     add() { this.attributes.push({ name: '', value: '' }); },
                     remove(index) { this.attributes.splice(index, 1); }
                 }"
                 x-init="if (attributes.length === 0) add()">
            <div class="mb-4 flex items-center justify-between">
                <div>
                    <h2 class="font-semibold text-slate-900">Atributos dinâmicos</h2>
                    <p class="text-xs text-slate-500">Ex.: Posição = Direito, Cor = Preto, Material = Aço.</p>
                </div>
                <button type="button" @click="add()" class="rounded-lg border border-slate-300 px-3 py-1.5 text-xs font-semibold text-slate-700 hover:bg-slate-50">+ Atributo</button>
            </div>

            <div class="space-y-3">
                <template x-for="(attribute, index) in attributes" :key="index">
                    <div class="flex items-end gap-3">
                        <div class="flex-1">
                            <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Nome</label>
                            <input :name="`attributes[${index}][name]`" x-model="attribute.name" placeholder="Posição"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        </div>
                        <div class="flex-1">
                            <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Valor</label>
                            <input :name="`attributes[${index}][value]`" x-model="attribute.value" placeholder="Direito"
                                   class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
                        </div>
                        <button type="button" @click="remove(index)" class="rounded-lg border border-rose-200 px-3 py-2 text-xs font-semibold text-rose-600 hover:bg-rose-50">Remover</button>
                    </div>
                </template>
            </div>
        </section>

        <section class="flex items-center justify-end gap-3 rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
            <a href="{{ route('admin.products.show', $product) }}" class="text-sm text-slate-500 hover:text-slate-800">Cancelar</a>
            <button class="rounded-lg bg-slate-900 px-5 py-2.5 text-sm font-semibold text-white hover:bg-slate-800">
                {{ $variant->exists ? 'Salvar alterações' : 'Cadastrar variação' }}
            </button>
        </section>
    </form>
@endsection
