<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class CheckoutRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'customer_document' => preg_replace('/\D/', '', (string) $this->input('customer_document')),
            'shipping_zip_code' => preg_replace('/\D/', '', (string) $this->input('shipping_zip_code')),
            'shipping_state' => strtoupper((string) $this->input('shipping_state')),
        ]);
    }

    public function rules(): array
    {
        return [
            'customer_name' => ['required', 'string', 'max:255'],
            'customer_email' => ['required', 'email', 'max:255'],
            'customer_document' => ['nullable', 'string', 'min:11', 'max:14'],
            'customer_phone' => ['nullable', 'string', 'max:20'],
            'shipping_zip_code' => ['required', 'digits:8'],
            'shipping_street' => ['required', 'string', 'max:255'],
            'shipping_number' => ['required', 'string', 'max:20'],
            'shipping_complement' => ['nullable', 'string', 'max:255'],
            'shipping_neighborhood' => ['required', 'string', 'max:255'],
            'shipping_city' => ['required', 'string', 'max:255'],
            'shipping_state' => ['required', 'string', 'size:2'],
            'payment_method' => ['required', 'in:pix,credit_card,boleto'],
            'notes' => ['nullable', 'string', 'max:1000'],
            'selected_services' => ['nullable', 'array'],
            'selected_services.*' => ['string', 'max:40'],
        ];
    }
}
