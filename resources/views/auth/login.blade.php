@extends('layouts.guest')

@section('title', 'Entrar')

@section('content')
    <div class="mx-auto max-w-md rounded-2xl border border-slate-200 bg-white p-8 shadow-sm">
        <p class="mb-6 text-sm text-slate-500">Escolha seu perfil e entre com seu e-mail e senha.</p>

        <form method="POST" action="{{ route('login.store') }}" class="space-y-5">
            @csrf

            <fieldset>
                <legend class="mb-2 text-sm font-medium text-slate-700">Quer entrar como?</legend>
                <div class="grid grid-cols-2 gap-3">
                    <div>
                        <input type="radio" name="role" id="role-cliente" value="cliente"
                               class="peer sr-only"
                               {{ old('role', 'cliente') === 'cliente' ? 'checked' : '' }}>
                        <label for="role-cliente"
                               class="block cursor-pointer rounded-lg border border-slate-300 px-3 py-3 text-center text-sm font-semibold text-slate-700 transition hover:border-amber-400 peer-checked:border-amber-500 peer-checked:bg-amber-50 peer-checked:text-amber-800 peer-focus-visible:ring-2 peer-focus-visible:ring-amber-300">
                            🛒 Cliente
                            <span class="mt-1 block text-[11px] font-normal text-slate-500">Acompanhar pedidos</span>
                        </label>
                    </div>
                    <div>
                        <input type="radio" name="role" id="role-admin" value="admin"
                               class="peer sr-only"
                               {{ old('role') === 'admin' ? 'checked' : '' }}>
                        <label for="role-admin"
                               class="block cursor-pointer rounded-lg border border-slate-300 px-3 py-3 text-center text-sm font-semibold text-slate-700 transition hover:border-amber-400 peer-checked:border-amber-500 peer-checked:bg-amber-50 peer-checked:text-amber-800 peer-focus-visible:ring-2 peer-focus-visible:ring-amber-300">
                            ⚙️ Administrador
                            <span class="mt-1 block text-[11px] font-normal text-slate-500">Gerenciar a loja</span>
                        </label>
                    </div>
                </div>
                @error('role')
                    <p class="mt-2 text-xs text-rose-600">{{ $message }}</p>
                @enderror
            </fieldset>

            <div>
                <label for="email" class="mb-1 block text-sm font-medium text-slate-700">E-mail</label>
                <input id="email" name="email" type="email" value="{{ old('email') }}" required autofocus
                       class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm focus:border-amber-500 focus:outline-none focus:ring-2 focus:ring-amber-200">
                @error('email')
                    <p class="mt-1 text-xs text-rose-600">{{ $message }}</p>
                @enderror
            </div>

            <div>
                <label for="password" class="mb-1 block text-sm font-medium text-slate-700">Senha</label>
                <input id="password" name="password" type="password" required
                       class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm focus:border-amber-500 focus:outline-none focus:ring-2 focus:ring-amber-200">
            </div>

            <label class="flex items-center gap-2 text-sm text-slate-600">
                <input type="checkbox" name="remember" value="1" class="rounded border-slate-300">
                Lembrar de mim
            </label>

            <button class="w-full rounded-lg bg-slate-900 px-4 py-2.5 text-sm font-semibold text-white hover:bg-slate-800">
                Entrar
            </button>
        </form>

        <div class="mt-6 rounded-lg bg-slate-50 px-4 py-3 text-xs text-slate-500">
            <p class="mb-1 font-semibold text-slate-700">Credenciais de demonstração</p>
            <p><span class="font-semibold">Cliente:</span> cliente@autostock.test · password</p>
            <p><span class="font-semibold">Administrador:</span> admin@autostock.test · password</p>
        </div>
    </div>
@endsection
