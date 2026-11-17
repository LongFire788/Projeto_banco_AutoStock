<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureUserIsCliente
{
    /**
     * Garante que apenas clientes acessem a area "Minha conta".
     */
    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();

        if (! $user) {
            return redirect()->route('login');
        }

        if (! $user->isCliente()) {
            return redirect()->route('admin.dashboard')
                ->with('info', 'Você está logado como administrador.');
        }

        return $next($request);
    }
}
