<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('product_variants', function (Blueprint $table) {
            $table->id();
            $table->foreignId('product_id')->constrained()->cascadeOnDelete();
            $table->string('sku', 64)->unique();
            $table->string('name', 120);

            $table->decimal('price', 12, 2);
            $table->decimal('compare_at_price', 12, 2)->nullable();

            // Estoque unitário real e dados logísticos do SKU
            $table->unsignedInteger('stock')->default(0);
            $table->unsignedInteger('weight_grams');
            $table->unsignedSmallInteger('length_cm');
            $table->unsignedSmallInteger('width_cm');
            $table->unsignedSmallInteger('height_cm');

            $table->boolean('active')->default(true);

            $table->timestamps();
            $table->softDeletes();

            $table->index(['product_id', 'active']);
            $table->index('price');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('product_variants');
    }
};
