@extends('layouts.app')

@section('title', 'Veículos')
@section('heading', 'Veículos compatíveis')

@section('actions')
    <a href="{{ route('admin.vehicle-models.create') }}" class="rounded-lg bg-slate-900 px-4 py-2 text-sm font-semibold text-white hover:bg-slate-800">+ Novo veículo</a>
@endsection

@section('content')
    <div class="rounded-2xl border border-slate-200 bg-white shadow-sm">
        <form method="GET" class="flex flex-wrap items-end gap-3 border-b border-slate-100 p-5">
            <div class="min-w-64 flex-1">
                <label class="mb-1 block text-xs font-semibold uppercase tracking-wide text-slate-400">Buscar</label>
                <input name="q" value="{{ request('q') }}" placeholder="Marca, modelo ou motorização"
                       class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
            </div>
            <button class="rounded-lg border border-slate-300 px-4 py-2 text-sm font-semibold text-slate-700 hover:bg-slate-50">Filtrar</button>
            <a href="{{ route('admin.vehicle-models.index') }}" class="px-2 py-2 text-sm text-slate-500 hover:text-slate-800">Limpar</a>
        </form>

        <div class="overflow-x-auto">
            <table class="w-full text-left text-sm">
                <thead class="bg-slate-50 text-xs uppercase tracking-wide text-slate-500">
                    <tr>
                        <th class="px-5 py-3">Veículo</th>
                        <th class="px-5 py-3">Anos</th>
                        <th class="px-5 py-3">Motorização</th>
                        <th class="px-5 py-3">Produtos vinculados</th>
                        <th class="px-5 py-3 text-right">Ações</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    @forelse ($vehicleModels as $vehicleModel)
                        <tr class="hover:bg-slate-50">
                            <td class="px-5 py-3 font-semibold text-slate-900">{{ $vehicleModel->brand }} {{ $vehicleModel->model }}</td>
                            <td class="px-5 py-3 text-slate-600">{{ $vehicleModel->year_start }} – {{ $vehicleModel->year_end }}</td>
                            <td class="px-5 py-3 text-slate-600">{{ $vehicleModel->engine ?: '—' }}</td>
                            <td class="px-5 py-3 font-medium">{{ $vehicleModel->products_count }}</td>
                            <td class="px-5 py-3 text-right">
                                <a href="{{ route('admin.vehicle-models.edit', $vehicleModel) }}" class="text-xs font-semibold text-slate-600 hover:text-amber-600">Editar</a>
                                <form method="POST" action="{{ route('admin.vehicle-models.destroy', $vehicleModel) }}" class="ml-2 inline" onsubmit="return confirm('Excluir este veículo?')">
                                    @csrf
                                    @method('DELETE')
                                    <button class="text-xs font-semibold text-rose-500 hover:text-rose-700">Excluir</button>
                                </form>
                            </td>
                        </tr>
                    @empty
                        <tr><td colspan="5" class="px-5 py-10 text-center text-sm text-slate-500">Nenhum veículo cadastrado.</td></tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        <div class="border-t border-slate-100 px-5 py-4">{{ $vehicleModels->links() }}</div>
    </div>
@endsection
