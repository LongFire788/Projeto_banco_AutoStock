<?php

namespace App\Services\Shipping\Gateways;

use App\Services\Shipping\Contracts\ShippingGateway;
use App\Services\Shipping\DTO\ShipmentGroup;
use App\Services\Shipping\MelhorEnvioPayloadBuilder;
use Illuminate\Support\Facades\Http;
use RuntimeException;

class MelhorEnvioGateway implements ShippingGateway
{
    public function __construct(
        private readonly MelhorEnvioPayloadBuilder $payloadBuilder,
        private readonly string $token,
        private readonly string $baseUrl,
    ) {
    }

    public function quote(ShipmentGroup $group, string $destinationZipCode): array
    {
        if (blank($this->token)) {
            throw new RuntimeException('Token do Melhor Envio não configurado.');
        }

        $response = Http::withToken($this->token)
            ->acceptJson()
            ->timeout(15)
            ->post(
                rtrim($this->baseUrl, '/') . '/api/v2/me/shipment/calculate',
                $this->payloadBuilder->forGroup($group, $destinationZipCode)
            )
            ->throw();

        return collect($response->json())
            ->filter(fn (array $option) => empty($option['error']))
            ->map(fn (array $option) => [
                'service_code' => (string) ($option['id'] ?? $option['service'] ?? ''),
                'service_name' => (string) ($option['name'] ?? 'Frete'),
                'price' => round((float) ($option['custom_price'] ?? $option['price'] ?? 0), 2),
                'delivery_days' => (int) ($option['custom_delivery_time'] ?? $option['delivery_time'] ?? 0),
                'is_pickup' => false,
            ])
            ->values()
            ->all();
    }
}
