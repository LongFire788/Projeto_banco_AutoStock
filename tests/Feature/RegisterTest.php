<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class RegisterTest extends TestCase
{
    use RefreshDatabase;

    public function test_tela_de_login_tem_o_cadastro_de_cliente(): void
    {
        $this->get(route('login'))
            ->assertOk()
            ->assertSee('Cadastrar conta de cliente')
            ->assertSee(route('register.store'), false);
    }

    public function test_cliente_se_cadastra_e_ja_entra_como_cliente(): void
    {
        $response = $this->post(route('register.store'), [
            'name' => 'Ana Souza',
            'email' => 'ana@example.test',
            'password' => 'senha12345',
            'password_confirmation' => 'senha12345',
            'role' => 'admin', // tentativa de escalada de perfil
        ]);

        $response->assertRedirect(route('cliente.dashboard'));

        $user = User::firstWhere('email', 'ana@example.test');
        $this->assertNotNull($user);
        $this->assertSame(User::ROLE_CLIENTE, $user->role);
        $this->assertSame('cliente', $user->role);
        $this->assertAuthenticatedAs($user);

        $this->actingAs($user)->get(route('admin.dashboard'))
            ->assertRedirect(route('cliente.dashboard'));
    }

    public function test_cadastro_valida_email_unico_e_confirmacao_de_senha(): void
    {
        User::factory()->create(['email' => 'existe@example.test']);

        $this->from(route('login'))
            ->post(route('register.store'), [
                'name' => 'Ana',
                'email' => 'existe@example.test',
                'password' => 'senha12345',
                'password_confirmation' => 'outra-senha',
            ])
            ->assertRedirect(route('login'))
            ->assertSessionHasErrors(['email', 'password']);

        $this->assertGuest();
    }
}
