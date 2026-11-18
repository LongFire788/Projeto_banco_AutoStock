<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Throwable;

class CepLookupService
{
    /**
     * Consulta o ViaCEP e devolve os campos usados no checkout.
     * Qualquer falha de rede/API é tratada aqui: o cliente preenche manualmente.
     *
     * @return array{zip_code: string, street: string, neighborhood: string, city: string, state: string, complement: string}|null
     */
    public function find(string $cep): ?array
    {
        $zipCode = preg_replace('/\D/', '', $cep) ?? '';

        if (strlen($zipCode) !== 8) {
            return null;
        }

        try {
            $response = Http::timeout(5)
                ->acceptJson()
                ->get(config('services.viacep.url', 'https://viacep.com.br/ws')."/{$zipCode}/json/");

            if ($response->failed()) {
                return null;
            }

            $data = $response->json();

            if (! is_array($data) || ! empty($data['erro'])) {
                return null;
            }

            return [
                'zip_code' => $zipCode,
                'street' => (string) ($data['logradouro'] ?? ''),
                'neighborhood' => (string) ($data['bairro'] ?? ''),
                'city' => (string) ($data['localidade'] ?? ''),
                'state' => (string) ($data['uf'] ?? ''),
                'complement' => (string) ($data['complemento'] ?? ''),
            ];
        } catch (Throwable $exception) {
            report($exception);

            return null;
        }
    }
}
