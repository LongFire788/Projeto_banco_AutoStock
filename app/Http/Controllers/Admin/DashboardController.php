<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\OrderShipment;
use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\Seller;
use Illuminate\View\View;

class DashboardController extends Controller
{
    public function __invoke(): View
    {
        return view('admin.dashboard', [
            'stats' => [
                'sellers' => Seller::active()->count(),
                'products' => Product::active()->count(),
                'orders' => Order::count(),
                'revenue' => (float) Order::where('payment_status', Order::PAYMENT_PAID)->sum('total'),
                'pending_shipments' => OrderShipment::whereIn('status', [
                    OrderShipment::STATUS_PENDING,
                    OrderShipment::STATUS_LABEL_GENERATED,
                ])->count(),
            ],
            'recentOrders' => Order::latest()->take(8)->get(),
            'lowStock' => ProductVariant::with('product')
                ->where('active', true)
                ->where('stock', '<=', 5)
                ->orderBy('stock')
                ->take(8)
                ->get(),
        ]);
    }
}
