<?php

namespace App\Http\Controllers\Storefront;

use App\Http\Controllers\Controller;
use App\Services\CepLookupService;
use Illuminate\Http\JsonResponse;

class CepController extends Controller
{
    public function __invoke(string $cep, CepLookupService $lookup): JsonResponse
    {
        $zipCode = preg_replace('/\D/', '', $cep) ?? '';

        if (strlen($zipCode) !== 8) {
            return response()->json(['message' => 'Informe um CEP com 8 dígitos.'], 422);
        }

        $address = $lookup->find($zipCode);

        if ($address === null) {
            return response()->json(['message' => 'CEP não encontrado. Preencha o endereço manualmente.'], 404);
        }

        return response()->json($address);
    }
}
