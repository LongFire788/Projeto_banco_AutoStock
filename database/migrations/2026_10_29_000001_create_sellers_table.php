<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('sellers', function (Blueprint $table) {
            $table->id();
            $table->string('legal_name');
            $table->string('trade_name');
            $table->string('document', 18)->unique();
            $table->string('email')->unique();
            $table->string('phone', 20)->nullable();

            // Endereço de despacho (origem do frete)
            $table->string('zip_code', 8)->index();
            $table->string('address_street');
            $table->string('address_number', 20);
            $table->string('address_complement')->nullable();
            $table->string('address_neighborhood');
            $table->string('address_city');
            $table->string('address_state', 2)->index();

            // Subconta no gateway de pagamento (split)
            $table->string('gateway_receiver_id')->nullable()->index();
            $table->boolean('active')->default(true)->index();

            $table->timestamps();
            $table->softDeletes();

            $table->index(['active', 'address_state']);
            $table->index(['address_city', 'address_state']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('sellers');
    }
};
