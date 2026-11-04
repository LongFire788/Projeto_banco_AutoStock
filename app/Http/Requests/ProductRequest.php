<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ProductRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'active' => $this->boolean('active'),
        ]);
    }

    public function rules(): array
    {
        $product = $this->route('product');

        return [
            'seller_id' => ['required', 'exists:sellers,id'],
            'name' => ['required', 'string', 'max:255'],
            'slug' => [
                'nullable',
                'string',
                'max:255',
                Rule::unique('products', 'slug')->ignore($product),
            ],
            'brand' => ['nullable', 'string', 'max:100'],
            'category' => ['nullable', 'string', 'max:100'],
            'description' => ['nullable', 'string'],
            'image_url' => ['nullable', 'string', 'max:2048'],
            'active' => ['boolean'],
            'vehicle_model_ids' => ['nullable', 'array'],
            'vehicle_model_ids.*' => ['integer', 'exists:vehicle_models,id'],
        ];
    }
}
