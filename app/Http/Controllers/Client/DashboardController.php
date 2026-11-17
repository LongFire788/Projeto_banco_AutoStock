<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\Controller;
use App\Models\Order;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class DashboardController extends Controller
{
    public function __invoke(): View
    {
        $email = Auth::user()->email;
        $baseQuery = Order::where('customer_email', $email);

        $stats = [
            'orders' => (clone $baseQuery)->count(),
            'spent' => (float) (clone $baseQuery)
                ->whereNotIn('status', [Order::STATUS_CANCELLED])
                ->sum('total'),
            'delivered' => (clone $baseQuery)->where('status', Order::STATUS_DELIVERED)->count(),
        ];

        $orders = (clone $baseQuery)
            ->with(['items', 'shipments'])
            ->latest('placed_at')
            ->paginate(10);

        return view('client.dashboard', [
            'stats' => $stats,
            'orders' => $orders,
        ]);
    }
}
