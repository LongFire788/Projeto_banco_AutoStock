<?php

namespace App\Services\Shipping\Gateways;

use App\Services\Shipping\Contracts\ShippingGateway;
use App\Services\Shipping\DTO\ShipmentGroup;

/**
 * Gateway determinístico para desenvolvimento/testes, sem dependência externa.
 * Mantém o mesmo contrato do gateway real.
 */
class LocalShippingGateway implements ShippingGateway
{
    public function quote(ShipmentGroup $group, string $destinationZipCode): array
    {
        $weightKg = max(0.3, $group->billableWeightKg());
        $items = max(1, $group->itemCount());

        $economico = round(14.90 + ($weightKg * 2.35) + ($items * 1.50), 2);
        $expresso = round($economico * 1.65, 2);

        return [
            [
                'service_code' => 'PAC',
                'service_name' => 'Econômico (PAC)',
                'price' => $economico,
                'delivery_days' => 4 + (int) ceil($weightKg / 2),
                'is_pickup' => false,
            ],
            [
                'service_code' => 'SEDEX',
                'service_name' => 'Expresso (SEDEX)',
                'price' => $expresso,
                'delivery_days' => 2 + (int) ceil($weightKg / 4),
                'is_pickup' => false,
            ],
            [
                'service_code' => 'PICKUP',
                'service_name' => 'Retirar no lojista',
                'price' => 0.0,
                'delivery_days' => 0,
                'is_pickup' => true,
            ],
        ];
    }
}
