<?php

namespace App\Exceptions;

use RuntimeException;

class InsufficientStockException extends RuntimeException
{
    public function __construct(
        public readonly string $sku,
        public readonly int $requested,
        public readonly int $available,
    ) {
        parent::__construct(
            "Estoque insuficiente para o SKU {$sku}. Solicitado: {$requested}, disponível: {$available}."
        );
    }
}
