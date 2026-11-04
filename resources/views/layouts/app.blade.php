<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', 'Painel') · AutoStock</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <style>
        [x-cloak] { display: none !important; }
        body { font-family: ui-sans-serif, system-ui, -apple-system, "Segoe UI", sans-serif; }
        .qr-svg { display: block; width: 100%; height: auto; }
    </style>
</head>
<body class="min-h-screen bg-slate-100 text-slate-800">
    <aside class="fixed inset-y-0 left-0 z-20 w-64 bg-slate-900 text-slate-300">
        <div class="flex h-16 items-center gap-3 border-b border-slate-800 px-6">
            <span class="flex h-9 w-9 items-center justify-center rounded-lg bg-amber-500 font-black text-slate-900">A</span>
            <div>
                <p class="text-sm font-bold tracking-wide text-white">AutoStock</p>
                <p class="text-[11px] uppercase tracking-widest text-slate-500">Marketplace</p>
            </div>
        </div>

        <nav class="space-y-1 px-3 py-5 text-sm">
            @php
                $links = [
                    ['route' => 'admin.dashboard', 'label' => 'Dashboard', 'pattern' => 'admin.dashboard'],
                    ['route' => 'admin.sellers.index', 'label' => 'Vendedores', 'pattern' => 'admin.sellers.*'],
                    ['route' => 'admin.products.index', 'label' => 'Produtos', 'pattern' => 'admin.products.*'],
                    ['route' => 'admin.vehicle-models.index', 'label' => 'Veículos', 'pattern' => 'admin.vehicle-models.*'],
                    ['route' => 'admin.orders.index', 'label' => 'Pedidos', 'pattern' => 'admin.orders.*'],
                ];
            @endphp
            @foreach ($links as $link)
                <a href="{{ route($link['route']) }}"
                   class="flex items-center gap-3 rounded-lg px-3 py-2.5 transition {{ request()->routeIs($link['pattern']) ? 'bg-amber-500 font-semibold text-slate-900' : 'hover:bg-slate-800 hover:text-white' }}">
                    <span class="h-1.5 w-1.5 rounded-full {{ request()->routeIs($link['pattern']) ? 'bg-slate-900' : 'bg-slate-600' }}"></span>
                    {{ $link['label'] }}
                </a>
            @endforeach
        </nav>

        <div class="absolute inset-x-0 bottom-0 border-t border-slate-800 p-4">
            <a href="{{ route('home') }}" target="_blank" class="mb-3 block text-xs text-slate-400 hover:text-amber-400">↗ Ver loja</a>
            <p class="truncate text-sm font-medium text-white">{{ auth()->user()->name ?? 'Administrador' }}</p>
            <p class="truncate text-xs text-slate-500">{{ auth()->user()->email ?? '' }}</p>
            <form method="POST" action="{{ route('logout') }}" class="mt-3">
                @csrf
                <button class="text-xs font-semibold text-rose-400 hover:text-rose-300">Sair da conta</button>
            </form>
        </div>
    </aside>

    <main class="ml-64 min-h-screen p-8">
        <div class="mb-6 flex flex-wrap items-center justify-between gap-4">
            <div>
                <p class="text-xs font-semibold uppercase tracking-widest text-slate-400">@yield('eyebrow', 'Painel administrativo')</p>
                <h1 class="text-2xl font-bold text-slate-900">@yield('heading', 'Dashboard')</h1>
            </div>
            <div class="flex items-center gap-2">@yield('actions')</div>
        </div>

        @include('partials.flash')

        @yield('content')
    </main>
</body>
</html>
