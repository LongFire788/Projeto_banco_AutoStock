<?php

namespace App\Providers;

use App\Services\Payments\PixPayloadBuilder;
use App\Services\Shipping\Contracts\ShippingGateway;
use App\Services\Shipping\Gateways\LocalShippingGateway;
use App\Services\Shipping\Gateways\MelhorEnvioGateway;
use App\Services\Shipping\MelhorEnvioPayloadBuilder;
use App\Services\SplitPaymentService;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        $this->app->bind(ShippingGateway::class, function () {
            if (config('shipping.driver') === 'melhor_envio') {
                return new MelhorEnvioGateway(
                    new MelhorEnvioPayloadBuilder(),
                    (string) config('shipping.melhor_envio.token'),
                    (string) config('shipping.melhor_envio.base_url'),
                );
            }

            return new LocalShippingGateway();
        });

        $this->app->bind(SplitPaymentService::class, fn () => new SplitPaymentService(
            (float) config('shipping.platform_fee_percent')
        ));

        $this->app->bind(PixPayloadBuilder::class, fn () => new PixPayloadBuilder(
            (string) config('payments.pix.key'),
            (string) config('payments.pix.merchant_name'),
            (string) config('payments.pix.merchant_city'),
            (int) config('payments.pix.expiration_minutes'),
        ));
    }

    public function boot(): void
    {
        //
    }
}
