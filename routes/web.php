<?php

use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\OrderController;
use App\Http\Controllers\Admin\ProductCompatibilityController;
use App\Http\Controllers\Admin\ProductController;
use App\Http\Controllers\Admin\ProductVariantController;
use App\Http\Controllers\Admin\SellerController;
use App\Http\Controllers\Admin\VehicleModelController;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Storefront\CartController;
use App\Http\Controllers\Storefront\CheckoutController;
use App\Http\Controllers\Storefront\HomeController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Loja
|--------------------------------------------------------------------------
*/
Route::get('/', [HomeController::class, 'index'])->name('home');
Route::get('/produtos/{product}', [HomeController::class, 'show'])->name('products.show');

Route::prefix('carrinho')->name('cart.')->group(function () {
    Route::get('/', [CartController::class, 'index'])->name('index');
    Route::post('/', [CartController::class, 'add'])->name('add');
    Route::patch('/', [CartController::class, 'update'])->name('update');
    Route::delete('/', [CartController::class, 'remove'])->name('remove');
    Route::delete('/limpar', [CartController::class, 'clear'])->name('clear');
});

Route::get('/checkout', [CheckoutController::class, 'index'])->name('checkout.index');
Route::post('/checkout', [CheckoutController::class, 'store'])->name('checkout.store');
Route::get('/checkout/sucesso/{order:number}', [CheckoutController::class, 'success'])->name('checkout.success');

/*
|--------------------------------------------------------------------------
| Autenticação do painel
|--------------------------------------------------------------------------
*/
Route::get('/login', [LoginController::class, 'showLoginForm'])->name('login');
Route::post('/login', [LoginController::class, 'login'])->name('login.store');
Route::post('/logout', [LoginController::class, 'logout'])->name('logout');

/*
|--------------------------------------------------------------------------
| Painel administrativo
|--------------------------------------------------------------------------
*/
Route::middleware('auth')->prefix('admin')->name('admin.')->group(function () {
    Route::get('/', DashboardController::class)->name('dashboard');

    Route::resource('sellers', SellerController::class);
    Route::resource('products', ProductController::class);
    Route::resource('products.variants', ProductVariantController::class)
        ->except(['index', 'show'])
        ->scoped(['product' => 'slug']);
    Route::resource('vehicle-models', VehicleModelController::class)->except(['show']);

    Route::post('products/{product}/compatibilities', [ProductCompatibilityController::class, 'store'])
        ->name('products.compatibilities.store');
    Route::delete('products/{product}/compatibilities/{vehicleModel}', [ProductCompatibilityController::class, 'destroy'])
        ->name('products.compatibilities.destroy');

    Route::get('orders', [OrderController::class, 'index'])->name('orders.index');
    Route::get('orders/{order}', [OrderController::class, 'show'])->name('orders.show');
    Route::patch('orders/{order}/status', [OrderController::class, 'updateStatus'])->name('orders.status');
    Route::patch('orders/{order}/shipments/{shipment}', [OrderController::class, 'updateShipment'])
        ->name('orders.shipments.update');
});
