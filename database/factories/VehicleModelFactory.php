<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class VehicleModelFactory extends Factory
{
    public function definition(): array
    {
        return [
            'brand' => fake()->randomElement(['Volkswagen', 'Chevrolet', 'Fiat', 'Ford', 'Toyota', 'Honda']),
            'model' => fake()->randomElement(['Gol', 'Onix', 'Argo', 'Ka', 'Corolla', 'Civic']),
            'year_start' => fake()->numberBetween(2000, 2018),
            'year_end' => fake()->numberBetween(2019, 2026),
            'engine' => fake()->randomElement(['1.0', '1.4', '1.6', '2.0', null]),
        ];
    }
}
