<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Pix (BR Code estático)
    |--------------------------------------------------------------------------
    | A chave informada aqui recebe o valor total do pedido. O split entre os
    | vendedores continua registrado em `payments` e é repassado pela
    | plataforma (modelo marketplace).
    */
    'pix' => [
        'key' => env('PIX_KEY', 'pagamentos@autostock.test'),

        // Chave de exemplo: o QR é lido, mas não pode ser pago porque não
        // existe no DICT. A UI usa esta flag para avisar o operador.
        'is_demo' => env('PIX_KEY', 'pagamentos@autostock.test') === 'pagamentos@autostock.test',

        'merchant_name' => env('PIX_MERCHANT_NAME', 'AUTOSTOCK'),
        'merchant_city' => env('PIX_MERCHANT_CITY', 'SAO PAULO'),
        'expiration_minutes' => (int) env('PIX_EXPIRATION_MINUTES', 30),
    ],

];
