<?php

namespace App\Services\Shipping;

use App\Services\Shipping\DTO\ShipmentGroup;
use App\Services\Shipping\DTO\ShippingItem;

class MelhorEnvioPayloadBuilder
{
    /**
     * Estrutura o payload no formato aceito pelo endpoint
     * POST /api/v2/me/shipment/calculate do Melhor Envio.
     */
    public function forGroup(ShipmentGroup $group, string $destinationZipCode): array
    {
        return [
            'from' => [
                'postal_code' => $this->normalizeZipCode($group->seller->zip_code),
            ],
            'to' => [
                'postal_code' => $this->normalizeZipCode($destinationZipCode),
            ],
            'products' => $group->items->map(function (ShippingItem $item) {
                $variant = $item->variant;

                return [
                    'id' => $variant->sku,
                    'width' => $variant->width_cm,
                    'height' => $variant->height_cm,
                    'length' => $variant->length_cm,
                    'weight' => round($variant->effective_weight_grams / 1000, 3),
                    'insurance_value' => (float) $variant->price,
                    'quantity' => $item->quantity,
                ];
            })->values()->all(),
            'volumes' => [
                [
                    'width' => $group->widthCm,
                    'height' => $group->heightCm,
                    'length' => $group->lengthCm,
                    'weight' => $group->billableWeightKg(),
                ],
            ],
            'options' => [
                'receipt' => false,
                'own_hand' => false,
                'collect' => false,
                'insurance_value' => round($group->subtotal, 2),
            ],
        ];
    }

    private function normalizeZipCode(string $zipCode): string
    {
        return preg_replace('/\D/', '', $zipCode) ?? '';
    }
}
