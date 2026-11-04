<?php

namespace App\Http\Controllers\Storefront;

use App\Exceptions\InsufficientStockException;
use App\Http\Controllers\Controller;
use App\Http\Requests\CheckoutRequest;
use App\Models\Order;
use App\Services\CartService;
use App\Services\CheckoutService;
use App\Services\Payments\PixPayloadBuilder;
use App\Services\Shipping\ShippingCalculationService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Throwable;

class CheckoutController extends Controller
{
    public function __construct(
        private readonly CartService $cart,
        private readonly ShippingCalculationService $shipping,
        private readonly CheckoutService $checkout,
    ) {
    }

    public function index(Request $request): View|RedirectResponse
    {
        $items = $this->cart->items();

        if ($items->isEmpty()) {
            return redirect()->route('cart.index')->with('error', 'Seu carrinho está vazio.');
        }

        $zipCode = preg_replace(
            '/\D/',
            '',
            (string) $request->query('zip', session('checkout_zip', ''))
        ) ?? '';

        $quote = null;
        $quoteError = null;

        if (strlen($zipCode) === 8) {
            try {
                $quote = $this->shipping->quoteCart($items, $zipCode);
                session()->put('checkout_zip', $zipCode);
            } catch (Throwable $exception) {
                report($exception);
                $quoteError = 'Não foi possível calcular o frete para este CEP. Tente novamente.';
            }
        }

        return view('store.checkout', [
            'items' => $items,
            'subtotal' => $this->cart->subtotal(),
            'quote' => $quote,
            'zipCode' => $zipCode,
            'quoteError' => $quoteError,
        ]);
    }

    public function store(CheckoutRequest $request): RedirectResponse
    {
        $items = $this->cart->items();

        if ($items->isEmpty()) {
            return redirect()->route('cart.index')->with('error', 'Seu carrinho está vazio.');
        }

        $validated = $request->validated();

        try {
            $order = $this->checkout->placeOrder(
                $validated,
                $items,
                $validated['payment_method'],
                $validated['selected_services'] ?? [],
            );
        } catch (InsufficientStockException $exception) {
            return back()
                ->withInput()
                ->withErrors(['cart' => $exception->getMessage()]);
        } catch (Throwable $exception) {
            report($exception);

            return back()
                ->withInput()
                ->withErrors(['checkout' => 'Não foi possível concluir o pedido. Revise os dados e tente novamente.']);
        }

        $this->cart->clear();
        session()->forget('checkout_zip');

        return redirect()
            ->route('checkout.success', $order)
            ->with('success', 'Pedido realizado com sucesso!');
    }

    public function success(Order $order, PixPayloadBuilder $pix): View
    {
        $order->load(['items.seller', 'shipments.seller', 'payments.seller']);

        $pixQrSvg = null;

        if ($order->payment_method === 'pix' && $order->payment_status === Order::PAYMENT_PENDING) {
            $pixQrSvg = $pix->qrCodeSvgFor($order);
        }

        return view('store.checkout-success', compact('order', 'pixQrSvg'));
    }
}
