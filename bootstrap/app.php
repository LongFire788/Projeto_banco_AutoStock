<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        // Atrás do proxy do Vercel, confiar nos headers X-Forwarded-* garante
        // que o Laravel gere URLs HTTPS (evita redirects e cookies inseguros).
        $middleware->trustProxies(at: '*');

        // Evita "Página expirada" (419) ao sair com sessão/token desatualizado.
        $middleware->validateCsrfTokens(except: [
            'logout',
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        //
    })->create();
