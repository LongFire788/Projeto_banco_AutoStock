<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->foreignId('seller_id')->constrained()->cascadeOnDelete();
            $table->string('name');
            $table->string('slug')->unique();
            $table->string('brand', 100)->nullable();
            $table->string('category', 100)->nullable();
            $table->text('description')->nullable();
            $table->string('image_url', 2048)->nullable();
            $table->boolean('active')->default(true);

            $table->timestamps();
            $table->softDeletes();

            $table->index(['seller_id', 'active']);
            $table->index(['brand', 'active']);
            $table->index(['category', 'active']);
            $table->index('name');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
