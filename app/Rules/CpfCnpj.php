<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class CpfCnpj implements ValidationRule
{
    private string $message = 'Informe um CPF ou CNPJ válido.';

    /**
     * Valida os dígitos verificadores de CPF (11) ou CNPJ (14).
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        $document = preg_replace('/\D/', '', (string) $value) ?? '';

        if ($document === '') {
            return;
        }

        if (strlen($document) === 11) {
            if (! $this->isValidCpf($document)) {
                $this->message = 'CPF inválido.';
                $fail($this->message);
            }

            return;
        }

        if (strlen($document) === 14) {
            if (! $this->isValidCnpj($document)) {
                $this->message = 'CNPJ inválido.';
                $fail($this->message);
            }

            return;
        }

        $this->message = 'Informe um CPF (11 dígitos) ou CNPJ (14 dígitos) válido.';
        $fail($this->message);
    }

    public function message(): string
    {
        return $this->message;
    }

    private function isValidCpf(string $cpf): bool
    {
        if (preg_match('/^(\d)\1{10}$/', $cpf)) {
            return false;
        }

        for ($length = 9; $length < 11; $length++) {
            $sum = 0;

            for ($index = 0; $index < $length; $index++) {
                $sum += (int) $cpf[$index] * ($length + 1 - $index);
            }

            $remainder = $sum % 11;
            $expected = $remainder < 2 ? 0 : 11 - $remainder;

            if ((int) $cpf[$length] !== $expected) {
                return false;
            }
        }

        return true;
    }

    private function isValidCnpj(string $cnpj): bool
    {
        if (preg_match('/^(\d)\1{13}$/', $cnpj)) {
            return false;
        }

        $firstWeights = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
        $secondWeights = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

        foreach ([[12, $firstWeights, 12], [13, $secondWeights, 13]] as [$length, $weights, $position]) {
            $sum = 0;

            for ($index = 0; $index < $length; $index++) {
                $sum += (int) $cnpj[$index] * $weights[$index];
            }

            $remainder = $sum % 11;
            $expected = $remainder < 2 ? 0 : 11 - $remainder;

            if ((int) $cnpj[$position] !== $expected) {
                return false;
            }
        }

        return true;
    }
}
