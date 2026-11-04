@extends('layouts.app')

@section('title', 'Vendedores')
@section('heading', 'Vendedores')

@section('actions')
    <a href="{{ route('admin.sellers.create') }}"
       class="rounded-lg bg-slate-900 px-4 py-2 text-sm font-semibold text-white hover:bg-slate-800">
        + Novo vendedor
    </a>
@endsection

@section('content')
    <div class="rounded-2xl border border-slate-200 bg-white shadow-sm">
        <form method="GET" class="flex flex-wrap items-end gap-3 border-b border-slate-100 p-5">
            <div class="min-w-64 flex-1">
                <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Buscar</label>
                <input name="q" value="{{ request('q') }}" placeholder="Nome, documento, e-mail ou cidade"
                       class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
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
            <a href="{{ route('admin.sellers.index') }}" class="px-2 py-2 text-sm text-slate-500 hover:text-slate-800">Limpar</a>
        </form>

        <div class="overflow-x-auto">
            <table class="w-full text-left text-sm">
                <thead class="bg-slate-50 text-xs uppercase tracking-wide text-slate-500">
                    <tr>
                        <th class="px-5 py-3">Vendedor</th>
                        <th class="px-5 py-3">Documento</th>
                        <th class="px-5 py-3">Despacho</th>
                        <th class="px-5 py-3">Produtos</th>
                        <th class="px-5 py-3">Status</th>
                        <th class="px-5 py-3 text-right">Ações</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    @forelse ($sellers as $seller)
                        <tr class="hover:bg-slate-50">
                            <td class="px-5 py-3">
                                <a href="{{ route('admin.sellers.show', $seller) }}" class="font-semibold text-slate-900 hover:text-amber-600">
                                    {{ $seller->trade_name }}
                                </a>
                                <p class="text-xs text-slate-400">{{ $seller->legal_name }}</p>
                            </td>
                            <td class="px-5 py-3 text-slate-600">{{ $seller->document }}</td>
                            <td class="px-5 py-3">
                                <p class="text-slate-700">{{ $seller->address_city }}/{{ $seller->address_state }}</p>
                                <p class="text-xs text-slate-400">CEP {{ $seller->zip_code }}</p>
                            </td>
                            <td class="px-5 py-3 font-medium">{{ $seller->products_count }}</td>
                            <td class="px-5 py-3">
                                <span class="rounded-full px-2.5 py-1 text-xs font-semibold {{ $seller->active ? 'bg-emerald-100 text-emerald-700' : 'bg-slate-100 text-slate-500' }}">
                                    {{ $seller->active ? 'Ativo' : 'Inativo' }}
                                </span>
                            </td>
                            <td class="px-5 py-3 text-right">
                                <a href="{{ route('admin.sellers.edit', $seller) }}" class="text-xs font-semibold text-slate-600 hover:text-amber-600">Editar</a>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="6" class="px-5 py-10 text-center text-sm text-slate-500">Nenhum vendedor encontrado.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        <div class="border-t border-slate-100 px-5 py-4">{{ $sellers->links() }}</div>
    </div>
@endsection
