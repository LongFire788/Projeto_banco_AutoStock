<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Restaura os campos de perfil e os dados de cliente que existiam no
     * autostock.sql original (a tabela users do esquema atual nao os tinha).
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table): void {
            $table->string('role')->default('cliente');
            $table->string('document')->nullable();
            $table->string('phone')->nullable();
            $table->string('zip_code')->nullable();
            $table->string('address_street')->nullable();
            $table->string('address_number')->nullable();
            $table->string('address_complement')->nullable();
            $table->string('address_neighborhood')->nullable();
            $table->string('address_city')->nullable();
            $table->string('address_state')->nullable();
        });

        DB::table('users')->where('email', 'admin@autostock.test')->update([
            'role' => 'admin',
        ]);

        DB::table('users')->where('email', 'cliente@autostock.test')->update([
            'role' => 'cliente',
            'document' => '12345678901',
            'phone' => '(19) 99999-0000',
            'zip_code' => '13450000',
            'address_street' => 'Rua das Peças',
            'address_number' => '100',
            'address_complement' => null,
            'address_neighborhood' => 'Centro',
            'address_city' => "Santa Bárbara D'Oeste",
            'address_state' => 'SP',
        ]);

        DB::table('users')->where('email', 'Yasminmagalhaes124@gmail.com')->update([
            'role' => 'cliente',
            'document' => '51166199584',
            'phone' => '199938567965',
        ]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table): void {
            $table->dropColumn([
                'role',
                'document',
                'phone',
                'zip_code',
                'address_street',
                'address_number',
                'address_complement',
                'address_neighborhood',
                'address_city',
                'address_state',
            ]);
        });
    }
};
