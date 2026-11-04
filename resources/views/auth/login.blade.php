@extends('layouts.guest')

@section('title', 'Entrar')

@section('content')
    <div class="mx-auto max-w-md rounded-2xl border border-slate-200 bg-white p-8 shadow-sm">
        <p class="mb-6 text-sm text-slate-500">Use as credenciais do administrador para gerenciar o marketplace.</p>

        <form method="POST" action="{{ route('login.store') }}" class="space-y-5">
            @csrf

            <div>
                <label for="email" class="mb-1 block text-sm font-medium text-slate-700">E-mail</label>
                <input id="email" name="email" type="email" value="{{ old('email') }}" required autofocus
                       class="w-full rounded-lg border border-slate-300 px-3 py-2.5 text-sm focus:border-amber-500 focus:outline-none focus:ring-2 focus:ring-amber-200">
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
            <p class="font-semibold text-slate-700">Credenciais do seed</p>
            <p>admin@autostock.test · password</p>
        </div>
    </div>
@endsection
