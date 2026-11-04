<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class SellerRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'document' => preg_replace('/\D/', '', (string) $this->input('document')),
            'zip_code' => preg_replace('/\D/', '', (string) $this->input('zip_code')),
            'address_state' => strtoupper((string) $this->input('address_state')),
        ]);
    }

    public function rules(): array
    {
        $seller = $this->route('seller');

        return [
            'legal_name' => ['required', 'string', 'max:255'],
            'trade_name' => ['required', 'string', 'max:255'],
            'document' => [
                'required',
                'string',
                'min:11',
                'max:14',
                Rule::unique('sellers', 'document')->ignore($seller),
            ],
            'email' => [
                'required',
                'email',
                'max:255',
                Rule::unique('sellers', 'email')->ignore($seller),
            ],
            'phone' => ['nullable', 'string', 'max:20'],
            'zip_code' => ['required', 'digits:8'],
            'address_street' => ['required', 'string', 'max:255'],
            'address_number' => ['required', 'string', 'max:20'],
            'address_complement' => ['nullable', 'string', 'max:255'],
            'address_neighborhood' => ['required', 'string', 'max:255'],
            'address_city' => ['required', 'string', 'max:255'],
            'address_state' => ['required', 'string', 'size:2'],
            'gateway_receiver_id' => ['nullable', 'string', 'max:120'],
            'active' => ['boolean'],
        ];
    }

    public function messages(): array
    {
        return [
            'document.unique' => 'Já existe um vendedor com este documento.',
            'email.unique' => 'Já existe um vendedor com este e-mail.',
            'zip_code.digits' => 'O CEP deve conter exatamente 8 dígitos.',
        ];
    }
}
