<?php

namespace App\Services\Shipping\Contracts;

use App\Services\Shipping\DTO\ShipmentGroup;

interface ShippingGateway
{
    /**
     * Retorna as opções de frete para um pacote de um único vendedor.
     *
     * @return array<int, array{
     *     service_code: string,
     *     service_name: string,
     *     price: float,
     *     delivery_days: int,
     *     is_pickup: bool
     * }>
     */
    public function quote(ShipmentGroup $group, string $destinationZipCode): array;
}
