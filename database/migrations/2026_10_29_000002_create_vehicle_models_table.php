<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('vehicle_models', function (Blueprint $table) {
            $table->id();
            $table->string('brand', 80);
            $table->string('model', 120);
            $table->unsignedSmallInteger('year_start');
            $table->unsignedSmallInteger('year_end');
            $table->string('engine', 80)->nullable();

            $table->timestamps();

            $table->index(['brand', 'model']);
            $table->index(['year_start', 'year_end']);
            $table->unique(['brand', 'model', 'year_start', 'year_end', 'engine'], 'vehicle_models_unique_spec');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('vehicle_models');
    }
};
