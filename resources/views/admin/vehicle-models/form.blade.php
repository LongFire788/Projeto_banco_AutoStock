@extends('layouts.app')

@section('title', $vehicleModel->exists ? 'Editar veículo' : 'Novo veículo')
@section('eyebrow', 'Veículos')
@section('heading', $vehicleModel->exists ? 'Editar veículo' : 'Novo veículo')

@section('content')
    <form method="POST"
          action="{{ $vehicleModel->exists ? route('admin.vehicle-models.update', $vehicleModel) : route('admin.vehicle-models.store') }}"
          class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
        @csrf
        @if ($vehicleModel->exists)
            @method('PUT')
        @endif

        <div class="grid gap-4 md:grid-cols-2">
            <div>
                <label class="mb-1 block text-sm font-medium text-slate-700">Marca *</label>
                <input name="brand" value="{{ old('brand', $vehicleModel->brand) }}" required placeholder="Volkswagen"
                       class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
            </div>
            <div>
                <label class="mb-1 block text-sm font-medium text-slate-700">Modelo *</label>
                <input name="model" value="{{ old('model', $vehicleModel->model) }}" required placeholder="Gol"
                       class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
            </div>
            <div>
                <label class="mb-1 block text-sm font-medium text-slate-700">Ano inicial *</label>
                <input name="year_start" type="number" min="1900" max="2100" value="{{ old('year_start', $vehicleModel->year_start) }}" required
                       class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
            </div>
            <div>
                <label class="mb-1 block text-sm font-medium text-slate-700">Ano final *</label>
                <input name="year_end" type="number" min="1900" max="2100" value="{{ old('year_end', $vehicleModel->year_end) }}" required
                       class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm">
            </div>
            <div class="md:col-span-2">
                <label class="mb-1 block text-sm font-medium text-slate-700">Motorização</label>
                <input name="engine" value="{{ old('engine', $vehicleModel->engine) }}" placeholder="ex.: 1.0 12V Flex"
                       class="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-amber-500 focus:outline-none">
            </div>
        </div>

        <div class="mt-6 flex items-center justify-end gap-3">
            <a href="{{ route('admin.vehicle-models.index') }}" class="text-sm text-slate-500 hover:text-slate-800">Cancelar</a>
            <button class="rounded-lg bg-slate-900 px-5 py-2.5 text-sm font-semibold text-white hover:bg-slate-800">
                {{ $vehicleModel->exists ? 'Salvar alterações' : 'Cadastrar veículo' }}
            </button>
        </div>
    </form>
@endsection
