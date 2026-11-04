@extends('layouts.app')

@section('title', 'Produtos')
@section('heading', 'Produtos')

@section('actions')
    <a href="{{ route('admin.products.create') }}" class="rounded-lg bg-slate-900 px-4 py-2 text-sm font-semibold text-white hover:bg-slate-800">+ Novo produto</a>
@endsection

@section('content')
    <div class="rounded-2xl border border-slate-200 bg-white shadow-sm">
        <form method="GET" class="flex flex-wrap items-end gap-3 border-b border-slate-100 p-5">
            <div class="min-w-64 flex-1">
                <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Buscar</label>
                <input name="q" value="{{ request('q') }}" placeholder="Nome, marca ou categoria"
                       class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
            </div>
            <div>
                <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Vendedor</label>
                <select name="seller_id" class="rounded-lg border border-slate-300 px-3 py-2 text-sm">
                    <option value="">Todos</option>
                    @foreach ($sellers as $seller)
                        <option value="{{ $seller->id }}" @selected((string) request('seller_id') === (string) $seller->id)>{{ $seller->trade_name }}</option>
                    @endforeach
                </select>
            </div>
            <div>
                <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Status</label>
                <select name="active" class="rounded-lg border border-slate-300 px-3 py-2 text-sm">
                    <option value="">Todos</option>
                    <option value="1" @selected(request('active') === '1')>Ativos</option>
                    <option value="0" @selected(request('active') === '0')>Inativos</option>
                </select>
            </div>
            <button class="rounded-lg border border-slate-300 px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">Filtrar</button>
            <a href="{{ route('admin.products.index') }}" class="px-2 py-2 text-sm text-slate-500 hover:text-slate-800">Limpar</a>
        </form>

        <div class="overflow-x-auto">
            <table class="w-full text-left text-sm">
                <thead class="bg-slate-50 text-xs uppercase tracking-wide text-slate-500">
                    <tr>
                        <th class="px-5 py-3">Produto</th>
                        <th class="px-5 py-3">Vendedor</th>
                        <th class="px-5 py-3">Variações</th>
                        <th class="px-5 py-3">A partir de</th>
                        <th class="px-5 py-3">Status</th>
                        <th class="px-5 py-3 text-right">Ações</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    @forelse ($products as $product)
                        <tr class="hover:bg-slate-50">
                            <td class="px-5 py-3">
                                <a href="{{ route('admin.products.show', $product) }}" class="font-semibold text-slate-900 hover:text-amber-600">{{ $product->name }}</a>
                                <p class="text-xs text-slate-400">{{ $product->brand ?: 'Sem marca' }} · {{ $product->category ?: 'Sem categoria' }}</p>
                            </td>
                            <td class="px-5 py-3 text-slate-600">{{ $product->seller?->trade_name }}</td>
                            <td class="px-5 py-3 font-medium">{{ $product->variants_count }}</td>
                            <td class="px-5 py-3">
                                @if ($product->variants_min_price !== null)
                                    R$ {{ number_format((float) $product->variants_min_price, 2, ',', '.') }}
                                @else
                                    <span class="text-slate-400">—</span>
                                @endif
                            </td>
                            <td class="px-5 py-3">
                                <span class="rounded-full px-2.5 py-1 text-xs font-semibold {{ $product->active ? 'bg-emerald-100 text-emerald-700' : 'bg-slate-100 text-slate-500' }}">
                                    {{ $product->active ? 'Ativo' : 'Inativo' }}
                                </span>
                            </td>
                            <td class="px-5 py-3 text-right">
                                <a href="{{ route('admin.products.edit', $product) }}" class="text-xs font-semibold text-slate-600 hover:text-amber-600">Editar</a>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="6" class="px-5 py-10 text-center text-sm text-slate-500">Nenhum produto encontrado.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        <div class="border-t border-slate-100 px-5 py-4">{{ $products->links() }}</div>
    </div>
@endsection
