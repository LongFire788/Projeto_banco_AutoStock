<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class ProductVariantRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $attributes = collect($this->input('attributes', []))
            ->map(fn (array $attribute) => [
                'name' => trim((string) ($attribute['name'] ?? '')),
                'value' => trim((string) ($attribute['value'] ?? '')),
            ])
            ->filter(fn (array $attribute) => $attribute['name'] !== '' && $attribute['value'] !== '')
            ->values()
            ->all();

        $this->merge([
            'sku' => strtoupper(trim((string) $this->input('sku'))),
            'active' => $this->boolean('active'),
            'attributes' => $attributes,
        ]);
    }

    public function rules(): array
    {
        $variant = $this->route('variant');

        return [
            'sku' => [
                'required',
                'string',
                'max:64',
                Rule::unique('product_variants', 'sku')->ignore($variant),
            ],
            'name' => ['required', 'string', 'max:120'],
            'price' => ['required', 'numeric', 'min:0.01', 'max:9999999.99'],
            'compare_at_price' => ['nullable', 'numeric', 'min:0'],
            'stock' => ['required', 'integer', 'min:0'],
            'weight_grams' => ['required', 'integer', 'min:1', 'max:100000'],
            'length_cm' => ['required', 'integer', 'min:1', 'max:200'],
            'width_cm' => ['required', 'integer', 'min:1', 'max:200'],
            'height_cm' => ['required', 'integer', 'min:1', 'max:200'],
            'active' => ['boolean'],
            'attributes' => ['nullable', 'array'],
            'attributes.*.name' => ['required', 'string', 'max:60'],
            'attributes.*.value' => ['required', 'string', 'max:120'],
        ];
    }

    public function messages(): array
    {
        return [
            'sku.unique' => 'Este SKU já está em uso.',
        ];
    }
}
