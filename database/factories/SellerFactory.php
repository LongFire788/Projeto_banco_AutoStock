<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class SellerFactory extends Factory
{
    public function definition(): array
    {
        return [
            'legal_name' => fake()->company() . ' Ltda',
            'trade_name' => fake()->company(),
            'document' => fake()->numerify('##.###.###/####-##'),
            'email' => fake()->unique()->safeEmail(),
            'phone' => fake()->numerify('(11) 9####-####'),
            'zip_code' => fake()->numerify('########'),
            'address_street' => fake()->streetName(),
            'address_number' => (string) fake()->buildingNumber(),
            'address_complement' => null,
            'address_neighborhood' => fake()->citySuffix(),
            'address_city' => fake()->city(),
            'address_state' => fake()->randomElement(['SP', 'RJ', 'MG', 'PR', 'RS']),
            'gateway_receiver_id' => 'recv_' . fake()->unique()->bothify('????????????'),
            'active' => true,
        ];
    }
}
