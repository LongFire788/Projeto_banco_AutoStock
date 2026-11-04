<?php

namespace Tests\Unit;

use App\Services\Payments\PixPayloadBuilder;
use PHPUnit\Framework\TestCase;

class PixPayloadBuilderTest extends TestCase
{
    private function builder(): PixPayloadBuilder
    {
        return new PixPayloadBuilder(
            key: 'pagamentos@autostock.test',
            merchantName: 'AUTOSTOCK',
            merchantCity: 'SAO PAULO',
            expirationMinutes: 30,
        );
    }

    public function test_crc16_matches_the_reference_value(): void
    {
        $this->assertSame('29B1', $this->builder()->crc16('123456789'));
    }

    public function test_payload_contains_the_required_emv_fields_and_a_valid_crc(): void
    {
        $builder = $this->builder();
        $payload = $builder->payload(881.14, 'ORD-20261029-FW3ZDP');

        $this->assertStringStartsWith('000201', $payload);
        $this->assertStringContainsString('br.gov.bcb.pix', $payload);
        $this->assertStringContainsString('pagamentos@autostock.test', $payload);
        $this->assertStringContainsString('5303986', $payload);
        $this->assertStringContainsString('5406881.14', $payload);
        $this->assertStringContainsString('5802BR', $payload);
        $this->assertStringContainsString('5909AUTOSTOCK', $payload);
        $this->assertStringContainsString('6009SAO PAULO', $payload);
        $this->assertStringContainsString('6304', $payload);

        $withoutCrc = substr($payload, 0, -4);

        $this->assertSame($builder->crc16($withoutCrc), substr($payload, -4));
        $this->assertMatchesRegularExpression('/^[0-9A-F]{4}$/', substr($payload, -4));
    }

    public function test_txid_is_sanitized_and_limited_to_25_characters(): void
    {
        $builder = $this->builder();
        $payload = $builder->payload(10.0, 'ORD-2026/10/29-FW3ZDP-EXTRA-EXTRA-EXTRA');

        $this->assertStringContainsString('62290525ORD20261029FW3ZDPEXTRAEXT', $payload);
        $this->assertStringNotContainsString('ORD-2026', $payload);
    }

    public function test_email_and_uuid_keys_are_normalized_to_lowercase(): void
    {
        $email = new PixPayloadBuilder('PAGAMENTOS@AUTOSTOCK.TEST', 'AUTOSTOCK', 'SAO PAULO');
        $this->assertStringContainsString('0125pagamentos@autostock.test', $email->payload(10.0, 'ABC'));

        $uuid = new PixPayloadBuilder(
            '123E4567-E12B-12D1-A456-426655440000',
            'AUTOSTOCK',
            'SAO PAULO',
        );
        $this->assertStringContainsString(
            '0136123e4567-e12b-12d1-a456-426655440000',
            $uuid->payload(10.0, 'ABC'),
        );
    }

    public function test_formatted_cpf_cnpj_and_phone_keys_are_normalized(): void
    {
        $cpf = new PixPayloadBuilder('123.456.789-09', 'AUTOSTOCK', 'SAO PAULO');
        $this->assertStringContainsString('011112345678909', $cpf->payload(10.0, 'ABC'));

        $cnpj = new PixPayloadBuilder('12.345.678/0001-95', 'AUTOSTOCK', 'SAO PAULO');
        $this->assertStringContainsString('011412345678000195', $cnpj->payload(10.0, 'ABC'));

        $phone = new PixPayloadBuilder('+55 (11) 99999-0000', 'AUTOSTOCK', 'SAO PAULO');
        $this->assertStringContainsString('0114+5511999990000', $phone->payload(10.0, 'ABC'));
    }

    public function test_qr_code_is_rendered_as_inline_svg(): void
    {
        $svg = $this->builder()->qrCodeSvg('000201-test-payload');

        $this->assertStringContainsString('<svg', $svg);
        $this->assertStringContainsString('</svg>', $svg);
        $this->assertStringNotContainsString('data:image', $svg);
    }
}
