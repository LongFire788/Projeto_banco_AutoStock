<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', 'AutoStock') · AutoStock</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <style>
        [x-cloak] { display: none !important; }
        body { font-family: ui-sans-serif, system-ui, -apple-system, "Segoe UI", sans-serif; }
        .qr-svg { display: block; width: 100%; height: auto; }
    </style>
</head>
<body class="flex min-h-screen flex-col bg-slate-50 text-slate-800">
    <header class="border-b border-slate-800 bg-slate-900 text-white">
        <div class="mx-auto flex h-16 max-w-7xl items-center justify-between gap-6 px-4">
            <a href="{{ route('home') }}" class="flex items-center gap-3">
                <span class="flex h-9 w-9 items-center justify-center rounded-lg bg-amber-500 font-black text-slate-900">A</span>
                <span class="text-lg font-bold tracking-tight">AutoStock</span>
            </a>

            <nav class="flex items-center gap-5 text-sm">
                <a href="{{ route('home') }}" class="text-slate-300 hover:text-white">Catálogo</a>
                @auth
                    @if (auth()->user()->isAdmin())
                        <a href="{{ route('admin.dashboard') }}" class="text-slate-300 hover:text-white">Painel admin</a>
                    @else
                        <a href="{{ route('cliente.dashboard') }}" class="text-slate-300 hover:text-white">Minha conta</a>
                    @endif
                    <form method="POST" action="{{ route('logout') }}">
                        @csrf
                        <button type="submit" class="text-slate-300 hover:text-white">Sair</button>
                    </form>
                @else
                    <a href="{{ route('login') }}" class="text-slate-300 hover:text-white">Entrar</a>
                @endauth
                @inject('cartService', 'App\Services\CartService')
                <a href="{{ route('cart.index') }}" class="rounded-lg bg-amber-500 px-4 py-2 font-semibold text-slate-900 hover:bg-amber-400">
                    Carrinho ({{ $cartService->count() }})
                </a>
            </nav>
        </div>
    </header>

    <main class="mx-auto w-full max-w-7xl flex-1 px-4 py-8">
        @include('partials.flash')
        @yield('content')
    </main>

    <footer class="border-t border-slate-200 bg-white">
        <div class="mx-auto flex max-w-7xl flex-col gap-2 px-4 py-6 text-xs text-slate-500 sm:flex-row sm:items-center sm:justify-between">
            <p>AutoStock — marketplace de autopeças e acessórios automotivos.</p>
            <p>Frete multi-origem · Split de pagamento · Estoque com lock pessimista</p>
        </div>
    </footer>
</body>
</html>
