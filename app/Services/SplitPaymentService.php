<?php

namespace App\Services;

use App\Models\Order;
use App\Models\Payment;
use App\Models\Seller;
use Illuminate\Support\Str;

class SplitPaymentService
{
    public function __construct(
        private readonly float $platformFeePercent,
    ) {
    }

    /**
     * Cria a parte do pagamento destinada a um vendedor (split).
     * O frete é repassado ao vendedor; a taxa da plataforma incide só sobre os itens.
     */
    public function createForSeller(
        Order $order,
        Seller $seller,
        float $itemsSubtotal,
        float $shippingCost,
        string $paymentMethod,
    ): Payment {
        $amount = round($itemsSubtotal + $shippingCost, 2);
        $platformFee = round($itemsSubtotal * ($this->platformFeePercent / 100), 2);
        $sellerAmount = round($amount - $platformFee, 2);

        return Payment::create([
            'order_id' => $order->id,
            'seller_id' => $seller->id,
            'gateway' => 'sandbox',
            'gateway_payment_id' => 'SIM-' . Str::ulid(),
            'gateway_receiver_id' => $seller->gateway_receiver_id,
            'amount' => $amount,
            'platform_fee' => $platformFee,
            'seller_amount' => $sellerAmount,
            'status' => Payment::STATUS_PENDING,
            'payload' => [
                'payment_method' => $paymentMethod,
                'split' => [
                    'receiver_id' => $seller->gateway_receiver_id,
                    'seller_amount' => $sellerAmount,
                    'platform_fee' => $platformFee,
                    'platform_fee_percent' => $this->platformFeePercent,
                ],
            ],
        ]);
    }

    /**
     * Simula a confirmação do gateway para todos os recebedores do pedido.
     */
    public function approve(Order $order): void
    {
        $order->payments()->where('status', Payment::STATUS_PENDING)->update([
            'status' => Payment::STATUS_PAID,
            'paid_at' => now(),
        ]);

        $order->update([
            'payment_status' => Order::PAYMENT_PAID,
            'status' => Order::STATUS_PAID,
        ]);
    }
}
