<?php

namespace App\Services\Payments;

use App\Models\Order;
use Carbon\CarbonInterface;
use chillerlan\QRCode\Common\EccLevel;
use chillerlan\QRCode\QRCode;
use chillerlan\QRCode\QROptions;
use Illuminate\Support\Str;

/**
 * Gera o BR Code (Pix estático) no padrão EMV do Banco Central e o QR Code.
 *
 * Estrutura: ID (2) + tamanho (2) + valor, com CRC16-CCITT-FALSE no final.
 *
 * @see https://www.bcb.gov.br/content/estabilidadefinanceira/pix/Regulamento_Pix.pdf
 */
class PixPayloadBuilder
{
    public function __construct(
        private readonly string $key,
        private readonly string $merchantName,
        private readonly string $merchantCity,
        private readonly int $expirationMinutes = 30,
    ) {
    }

    public function forOrder(Order $order): string
    {
        return $this->payload((float) $order->total, $this->txidFor($order));
    }

    public function expiresAt(): CarbonInterface
    {
        return now()->addMinutes($this->expirationMinutes);
    }

    /**
     * Retorna o payload do pedido, gerando e persistindo se ainda não existir.
     * Útil para pedidos criados antes dos campos Pix ou para reexibição.
     */
    public function ensureForOrder(Order $order): string
    {
        if (blank($order->pix_payload)) {
            $order->forceFill([
                'pix_payload' => $this->forOrder($order),
                'pix_expires_at' => $order->pix_expires_at ?? $this->expiresAt(),
            ])->save();
        }

        return (string) $order->pix_payload;
    }

    public function qrCodeSvgFor(Order $order, int $scale = 6): string
    {
        return $this->qrCodeSvg($this->ensureForOrder($order), $scale);
    }

    /**
     * Monta o payload "copia e cola" completo, com CRC.
     */
    public function payload(float $amount, string $txid): string
    {
        $merchantAccount = $this->field('00', 'br.gov.bcb.pix')
            . $this->field('01', $this->normalizeKey($this->key));

        $payload = $this->field('00', '01')
            . $this->field('26', $merchantAccount)
            . $this->field('52', '0000')
            . $this->field('53', '986')
            . $this->field('54', number_format($amount, 2, '.', ''))
            . $this->field('58', 'BR')
            . $this->field('59', $this->sanitize($this->merchantName, 25))
            . $this->field('60', $this->sanitize($this->merchantCity, 15))
            . $this->field('62', $this->field('05', $this->sanitizeTxid($txid)));

        $payload .= '6304';

        return $payload . $this->crc16($payload);
    }

    public function qrCodeSvg(string $payload, int $scale = 6): string
    {
        $options = new QROptions([
            'outputType' => QRCode::OUTPUT_MARKUP_SVG,
            'outputBase64' => false,
            'eccLevel' => EccLevel::M,
            'scale' => $scale,
        ]);

        return (new QRCode($options))->render($payload);
    }

    public function txidFor(Order $order): string
    {
        return Str::upper(preg_replace('/[^A-Za-z0-9]/', '', $order->number) ?? '');
    }

    /**
     * CRC16-CCITT-FALSE (poly 0x1021, init 0xFFFF, sem reflexão).
     * Valor de verificação para "123456789": 29B1.
     */
    public function crc16(string $payload): string
    {
        $crc = 0xFFFF;
        $length = strlen($payload);

        for ($i = 0; $i < $length; $i++) {
            $crc ^= ord($payload[$i]) << 8;

            for ($bit = 0; $bit < 8; $bit++) {
                $crc = ($crc & 0x8000) ? (($crc << 1) ^ 0x1021) : ($crc << 1);
                $crc &= 0xFFFF;
            }
        }

        return strtoupper(str_pad(dechex($crc), 4, '0', STR_PAD_LEFT));
    }

    private function field(string $id, string $value): string
    {
        return $id . str_pad((string) strlen($value), 2, '0', STR_PAD_LEFT) . $value;
    }

    /**
     * E-mail e chave aleatória (UUID) devem estar em minúsculas no DICT.
     */
    private function normalizeKey(string $key): string
    {
        $key = trim($key);

        // CPF/CNPJ formatados: o DICT exige somente os dígitos.
        if (preg_match('/^\d{3}\.\d{3}\.\d{3}-\d{2}$/', $key) === 1
            || preg_match('/^\d{2}\.\d{3}\.\d{3}\/\d{4}-\d{2}$/', $key) === 1) {
            return preg_replace('/\D/', '', $key) ?? $key;
        }

        // Telefone com +55 e pontuação: normaliza para +55DDDNUMERO.
        if (preg_match('/^\+?55[\s().-]*\d{2}[\s().-]*\d{4,5}[\s().-]*\d{4}$/', $key) === 1) {
            return '+' . preg_replace('/\D/', '', $key);
        }

        if (str_contains($key, '@')) {
            return Str::lower($key);
        }

        $uuidPattern = '/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i';

        return preg_match($uuidPattern, $key) === 1 ? Str::lower($key) : $key;
    }

    private function sanitize(string $value, int $max): string
    {
        $ascii = Str::ascii($value);
        $clean = preg_replace('/[^A-Za-z0-9 ]/', '', $ascii) ?? '';
        $clean = trim(preg_replace('/\s+/', ' ', $clean) ?? '');

        return Str::upper(Str::substr($clean, 0, $max));
    }

    private function sanitizeTxid(string $txid): string
    {
        $clean = preg_replace('/[^A-Za-z0-9]/', '', $txid) ?? '';

        return $clean === '' ? '***' : Str::substr($clean, 0, 25);
    }
}
