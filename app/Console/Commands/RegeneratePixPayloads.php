<?php

namespace App\Console\Commands;

use App\Models\Order;
use App\Services\Payments\PixPayloadBuilder;
use Illuminate\Console\Command;

class RegeneratePixPayloads extends Command
{
    protected $signature = 'pix:regenerate
                            {order? : Número do pedido (ex.: ORD-20261029-FW3ZDP)}';

    protected $description = 'Regenera o BR Code Pix dos pedidos após alterar PIX_KEY ou os dados do recebedor';

    public function handle(PixPayloadBuilder $pix): int
    {
        $query = Order::query()->where('payment_method', 'pix');

        if ($number = $this->argument('order')) {
            $query->where('number', $number);
        } else {
            $query->where('payment_status', Order::PAYMENT_PENDING);
        }

        $orders = $query->get();

        if ($orders->isEmpty()) {
            $this->warn('Nenhum pedido Pix encontrado. Informe o número do pedido ou verifique se há pedidos pendentes.');

            return self::SUCCESS;
        }

        $orders->each(function (Order $order) use ($pix): void {
            $order->forceFill([
                'pix_payload' => $pix->forOrder($order),
                'pix_expires_at' => $pix->expiresAt(),
            ])->save();

            $this->line("Pedido {$order->number}: BR Code regenerado.");
        });

        $this->info("{$orders->count()} pedido(s) atualizado(s) com a chave Pix atual.");

        return self::SUCCESS;
    }
}
