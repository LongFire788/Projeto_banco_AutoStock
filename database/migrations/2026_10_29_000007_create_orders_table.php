<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->string('number', 32)->unique();

            // Snapshot do cliente (checkout como visitante)
            $table->string('customer_name');
            $table->string('customer_email');
            $table->string('customer_document', 18)->nullable();
            $table->string('customer_phone', 20)->nullable();

            // Snapshot do endereço de entrega
            $table->string('shipping_zip_code', 8);
            $table->string('shipping_street');
            $table->string('shipping_number', 20);
            $table->string('shipping_complement')->nullable();
            $table->string('shipping_neighborhood');
            $table->string('shipping_city');
            $table->string('shipping_state', 2);

            $table->decimal('subtotal', 12, 2);
            $table->decimal('shipping_total', 12, 2)->default(0);
            $table->decimal('discount_total', 12, 2)->default(0);
            $table->decimal('total', 12, 2);

            $table->string('status', 30)->default('pending')->index();
            $table->string('payment_status', 30)->default('pending')->index();
            $table->string('payment_method', 30)->nullable();

            $table->text('notes')->nullable();
            $table->timestamp('placed_at')->nullable()->index();

            $table->timestamps();

            $table->index(['customer_email', 'created_at']);
            $table->index('created_at');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
