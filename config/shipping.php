<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Driver de cotação de frete
    |--------------------------------------------------------------------------
    | local        -> cálculo determinístico para desenvolvimento/testes
    | melhor_envio -> API real/sandbox do Melhor Envio
    */
    'driver' => env('SHIPPING_DRIVER', 'local'),

    'melhor_envio' => [
        'base_url' => env('MELHOR_ENVIO_BASE_URL', 'https://sandbox.melhorenvio.com.br'),
        'token' => env('MELHOR_ENVIO_TOKEN'),
    ],

    /*
    |--------------------------------------------------------------------------
    | Split de pagamento
    |--------------------------------------------------------------------------
    | Percentual retido pela plataforma sobre o valor dos itens de cada seller.
    */
    'platform_fee_percent' => (float) env('PLATFORM_FEE_PERCENT', 10),

];
