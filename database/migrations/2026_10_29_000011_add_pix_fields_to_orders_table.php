<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->text('pix_payload')->nullable()->after('payment_method');
            $table->timestamp('pix_expires_at')->nullable()->after('pix_payload');
        });
    }

    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropColumn(['pix_payload', 'pix_expires_at']);
        });
    }
};
