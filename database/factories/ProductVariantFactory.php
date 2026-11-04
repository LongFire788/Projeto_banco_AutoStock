<?php

namespace Database\Factories;

use App\Models\Product;
use Illuminate\Database\Eloquent\Factories\Factory;

class ProductVariantFactory extends Factory
{
    public function definition(): array
    {
        return [
            'product_id' => Product::factory(),
            'sku' => 'SKU-' . fake()->unique()->bothify('####??##'),
            'name' => fake()->randomElement(['Lado Direito', 'Lado Esquerdo', 'Dianteiro', 'Traseiro']),
            'price' => fake()->randomFloat(2, 50, 1200),
            'compare_at_price' => null,
            'stock' => fake()->numberBetween(0, 50),
            'weight_grams' => fake()->numberBetween(500, 8000),
            'length_cm' => fake()->numberBetween(15, 80),
            'width_cm' => fake()->numberBetween(10, 50),
            'height_cm' => fake()->numberBetween(5, 40),
            'active' => true,
        ];
    }
}
