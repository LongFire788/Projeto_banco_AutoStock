<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\OrderShipment;
use App\Services\InventoryService;
use App\Services\Payments\PixPayloadBuilder;
use App\Services\SplitPaymentService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;

class OrderController extends Controller
{
    public function __construct(
        private readonly InventoryService $inventory,
        private readonly SplitPaymentService $splitPayments,
    ) {
    }

    public function index(Request $request): View
    {
        $orders = Order::query()
            ->withCount('items')
            ->search($request->string('q')->toString())
            ->when($request->filled('status'), fn ($query) => $query->where('status', $request->string('status')))
            ->latest()
            ->paginate(15)
            ->withQueryString();

        return view('admin.orders.index', [
            'orders' => $orders,
            'statuses' => Order::statuses(),
        ]);
    }

    public function show(Order $order, PixPayloadBuilder $pix): View
    {
        $order->load([
            'items.seller',
            'shipments.seller',
            'shipments.items',
            'payments.seller',
        ]);

        $pixQrSvg = null;

        if ($order->payment_method === 'pix') {
            if (filled($order->pix_payload)) {
                $pixQrSvg = $pix->qrCodeSvg($order->pix_payload, 5);
            } elseif ($order->payment_status === Order::PAYMENT_PENDING) {
                $pixQrSvg = $pix->qrCodeSvgFor($order, 5);
            }
        }

        return view('admin.orders.show', [
            'order' => $order,
            'statuses' => Order::statuses(),
            'shipmentStatuses' => OrderShipment::statuses(),
            'pixQrSvg' => $pixQrSvg,
        ]);
    }

    public function updateStatus(Request $request, Order $order): RedirectResponse
    {
        $validated = $request->validate([
            'status' => ['required', 'in:' . implode(',', Order::statuses())],
        ]);

        DB::transaction(function () use ($validated, $order) {
            /** @var Order $lockedOrder */
            $lockedOrder = Order::whereKey($order->id)->lockForUpdate()->firstOrFail();
            $newStatus = $validated['status'];

            if ($newStatus === Order::STATUS_CANCELLED && $lockedOrder->status !== Order::STATUS_CANCELLED) {
                $this->inventory->restoreForOrder($lockedOrder);
            }

            $lockedOrder->update(['status' => $newStatus]);

            if ($newStatus === Order::STATUS_PAID && $lockedOrder->payment_status !== Order::PAYMENT_PAID) {
                $this->splitPayments->approve($lockedOrder);
            }
        });

        return back()->with('success', 'Status do pedido atualizado.');
    }

    public function updateShipment(Request $request, Order $order, OrderShipment $shipment): RedirectResponse
    {
        abort_unless($shipment->order_id === $order->id, 404);

        $validated = $request->validate([
            'status' => ['required', 'in:' . implode(',', OrderShipment::statuses())],
            'tracking_code' => ['nullable', 'string', 'max:80'],
            'estimated_delivery_date' => ['nullable', 'date'],
        ]);

        $shipment->update($validated);

        return back()->with('success', 'Envio atualizado.');
    }
}
