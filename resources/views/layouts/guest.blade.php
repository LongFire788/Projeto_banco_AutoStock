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
        body { font-family: ui-sans-serif, system-ui, -apple-system, "Segoe UI", sans-serif; }
        [x-cloak] { display: none !important; }
    </style>
</head>
<body class="flex min-h-screen flex-col bg-slate-100 text-slate-800">
    <header class="border-b border-slate-800 bg-slate-900 text-white">
        <div class="mx-auto flex h-16 max-w-7xl items-center justify-between px-4">
            <a href="{{ route('home') }}" class="flex items-center gap-3">
                <span class="flex h-9 w-9 items-center justify-center rounded-lg bg-amber-500 font-black text-slate-900">A</span>
                <span class="text-lg font-bold tracking-tight">AutoStock</span>
            </a>
            <a href="{{ route('home') }}" class="text-sm text-slate-300 hover:text-white">Voltar à loja</a>
        </div>
    </header>

    <main class="mx-auto w-full max-w-7xl flex-1 px-4 py-10">
        @include('partials.flash')
        @yield('content')
    </main>

    <footer class="border-t border-slate-200 bg-white py-5 text-center text-xs text-slate-500">
        AutoStock — marketplace de autopeças e acessórios.
    </footer>
</body>
</html>
