<?php

namespace App\Http\Requests;

use App\Rules\CpfCnpj;
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
            'customer_document' => ['required', 'string', new CpfCnpj()],
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

    /**
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'customer_name.required' => 'Informe seu nome completo.',
            'customer_email.required' => 'Informe seu e-mail.',
            'customer_email.email' => 'Informe um e-mail válido.',
            'customer_document.required' => 'Informe o CPF ou CNPJ.',
            'shipping_zip_code.required' => 'Informe o CEP de entrega.',
            'shipping_zip_code.digits' => 'O CEP deve conter exatamente 8 dígitos.',
            'shipping_street.required' => 'Informe a rua.',
            'shipping_number.required' => 'Informe o número.',
            'shipping_neighborhood.required' => 'Informe o bairro.',
            'shipping_city.required' => 'Informe a cidade.',
            'shipping_state.required' => 'Informe a UF.',
            'shipping_state.size' => 'A UF deve ter 2 letras.',
            'payment_method.required' => 'Escolha a forma de pagamento.',
        ];
    }
}
