<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('order_id')->constrained()->cascadeOnDelete();
            $table->foreignId('seller_id')->constrained()->restrictOnDelete();

            $table->string('gateway', 40)->default('sandbox');
            $table->string('gateway_payment_id', 120)->nullable()->index();
            $table->string('gateway_receiver_id', 120)->nullable();

            $table->decimal('amount', 12, 2);
            $table->decimal('platform_fee', 12, 2)->default(0);
            $table->decimal('seller_amount', 12, 2);

            $table->string('status', 30)->default('pending')->index();
            $table->timestamp('paid_at')->nullable();
            $table->json('payload')->nullable();

            $table->timestamps();

            $table->index(['order_id', 'seller_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
