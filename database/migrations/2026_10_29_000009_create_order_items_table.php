<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('order_items', function (Blueprint $table) {
            $table->id();
            $table->foreignId('order_id')->constrained()->cascadeOnDelete();
            $table->foreignId('order_shipment_id')->nullable()->constrained()->nullOnDelete();
            $table->foreignId('seller_id')->constrained()->restrictOnDelete();
            $table->foreignId('product_id')->constrained()->restrictOnDelete();
            $table->foreignId('product_variant_id')->constrained()->restrictOnDelete();

            // Snapshot dos dados no momento da compra
            $table->string('product_name');
            $table->string('variant_name', 120);
            $table->string('sku', 64);
            $table->unsignedInteger('quantity');
            $table->decimal('unit_price', 12, 2);
            $table->decimal('total', 12, 2);
            $table->unsignedInteger('weight_grams');
            $table->unsignedSmallInteger('length_cm');
            $table->unsignedSmallInteger('width_cm');
            $table->unsignedSmallInteger('height_cm');

            $table->timestamps();

            $table->index(['order_id', 'seller_id']);
            $table->index('product_variant_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('order_items');
    }
};
