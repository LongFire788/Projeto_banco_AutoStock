<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class VehicleModelRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'brand' => ['required', 'string', 'max:80'],
            'model' => ['required', 'string', 'max:120'],
            'year_start' => ['required', 'integer', 'between:1900,2100'],
            'year_end' => ['required', 'integer', 'between:1900,2100', 'gte:year_start'],
            'engine' => ['nullable', 'string', 'max:80'],
        ];
    }
}
