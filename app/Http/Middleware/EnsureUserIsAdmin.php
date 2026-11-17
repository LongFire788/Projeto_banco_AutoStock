<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class EnsureUserIsAdmin
{
    /**
     * Garante que apenas administradores acessem o painel administrativo.
     */
    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();

        if (! $user) {
            return redirect()->route('login');
        }

        if (! $user->isAdmin()) {
            return redirect()->route('cliente.dashboard')
                ->with('error', 'Essa área é exclusiva para administradores.');
        }

        return $next($request);
    }
}
