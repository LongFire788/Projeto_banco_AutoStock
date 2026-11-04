<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('variant_attributes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('product_variant_id')->constrained()->cascadeOnDelete();
            $table->string('name', 60);
            $table->string('value', 120);

            $table->timestamps();

            $table->unique(['product_variant_id', 'name']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('variant_attributes');
    }
};
