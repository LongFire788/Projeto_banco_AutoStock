@extends('layouts.app')

@section('title', $seller->trade_name)
@section('eyebrow', 'Vendedores')
@section('heading', $seller->trade_name)

@section('actions')
    <a href="{{ route('admin.sellers.edit', $seller) }}" class="rounded-lg bg-slate-900 px-4 py-2 text-sm font-semibold text-white hover:bg-slate-800">Editar</a>
    <form method="POST" action="{{ route('admin.sellers.destroy', $seller) }}" onsubmit="return confirm('Excluir este vendedor?')">
        @csrf
        @method('DELETE')
        <button class="rounded-lg border border-rose-200 bg-white px-4 py-2 text-sm font-semibold text-rose-600 hover:bg-rose-50">Excluir</button>
    </form>
@endsection

@section('content')
    <div class="grid gap-6 lg:grid-cols-3">
        <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm lg:col-span-2">
            <h2 class="mb-4 font-semibold text-slate-900">Dados do vendedor</h2>
            <dl class="grid gap-4 sm:grid-cols-2 text-sm">
                <div><dt class="text-xs uppercase tracking-wide text-slate-400">Razão social</dt><dd class="mt-1 font-medium">{{ $seller->legal_name }}</dd></div>
                <div><dt class="text-xs uppercase tracking-wide text-slate-400">Documento</dt><dd class="mt-1 font-medium">{{ $seller->document }}</dd></div>
                <div><dt class="text-xs uppercase tracking-wide text-slate-400">E-mail</dt><dd class="mt-1 font-medium">{{ $seller->email }}</dd></div>
                <div><dt class="text-xs uppercase tracking-wide text-slate-400">Telefone</dt><dd class="mt-1 font-medium">{{ $seller->phone ?: '—' }}</dd></div>
                <div class="sm:col-span-2"><dt class="text-xs uppercase tracking-wide text-slate-400">Endereço de despacho</dt><dd class="mt-1 font-medium">{{ $seller->full_address }}</dd></div>
                <div><dt class="text-xs uppercase tracking-wide text-slate-400">Recebedor no gateway</dt><dd class="mt-1 font-mono text-xs">{{ $seller->gateway_receiver_id ?: 'Não configurado' }}</dd></div>
                <div><dt class="text-xs uppercase tracking-wide text-slate-400">Status</dt><dd class="mt-1"><span class="rounded-full px-2.5 py-1 text-xs font-semibold {{ $seller->active ? 'bg-emerald-100 text-emerald-700' : 'bg-slate-100 text-slate-500' }}">{{ $seller->active ? 'Ativo' : 'Inativo' }}</span></dd></div>
            </dl>
        </section>

        <section class="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm">
            <p class="text-xs font-semibold uppercase tracking-wide text-slate-400">Produtos</p>
            <p class="mt-2 text-3xl font-bold text-slate-900">{{ $seller->products_count }}</p>
            <a href="{{ route('admin.products.index', ['seller_id' => $seller->id]) }}" class="mt-3 inline-block text-sm font-semibold text-amber-600 hover:text-amber-700">Ver catálogo →</a>
        </section>
    </div>

    <section class="mt-6 rounded-2xl border border-slate-200 bg-white shadow-sm">
        <div class="border-b border-slate-100 px-5 py-4">
            <h2 class="font-semibold text-slate-900">Últimos produtos</h2>
        </div>
        <div class="divide-y divide-slate-100">
            @forelse ($seller->products as $product)
                <div class="flex items-center justify-between px-5 py-3 text-sm">
                    <div>
                        <a href="{{ route('admin.products.show', $product) }}" class="font-medium text-slate-900 hover:text-amber-600">{{ $product->name }}</a>
                        <p class="text-xs text-slate-400">{{ $product->brand ?: 'Sem marca' }} · {{ $product->category ?: 'Sem categoria' }}</p>
                    </div>
                    <span class="text-xs text-slate-400">{{ $product->created_at->format('d/m/Y') }}</span>
                </div>
            @empty
                <p class="px-5 py-8 text-center text-sm text-slate-500">Este vendedor ainda não tem produtos.</p>
            @endforelse
        </div>
    </section>
@endsection
