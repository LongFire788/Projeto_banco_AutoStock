<?php

namespace Database\Factories;

use App\Models\Seller;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

class ProductFactory extends Factory
{
    public function definition(): array
    {
        $name = 'Amortecedor ' . fake()->word() . ' ' . fake()->randomElement(['Cofap', 'Monroe', 'Nakata']);

        return [
            'seller_id' => Seller::factory(),
            'name' => $name,
            'slug' => Str::slug($name) . '-' . fake()->unique()->numerify('####'),
            'brand' => fake()->randomElement(['Cofap', 'Monroe', 'Nakata', 'Bosch']),
            'category' => fake()->randomElement(['Suspensão', 'Freios', 'Motor', 'Elétrica']),
            'description' => fake()->paragraph(),
            'image_url' => null,
            'active' => true,
        ];
    }
}
