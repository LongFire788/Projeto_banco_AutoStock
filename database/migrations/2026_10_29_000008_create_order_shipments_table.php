<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('order_shipments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('order_id')->constrained()->cascadeOnDelete();
            $table->foreignId('seller_id')->constrained()->restrictOnDelete();

            $table->string('shipping_method', 80);
            $table->string('shipping_service_code', 40)->nullable();
            $table->string('tracking_code', 80)->nullable()->index();
            $table->decimal('shipping_cost', 12, 2)->default(0);
            $table->string('status', 30)->default('pending')->index();
            $table->date('estimated_delivery_date')->nullable();
            $table->json('payload')->nullable();

            $table->timestamps();

            $table->unique(['order_id', 'seller_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('order_shipments');
    }
};
