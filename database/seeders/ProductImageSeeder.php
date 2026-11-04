<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

/**
 * Associa as fotos locais de public/images/products aos produtos.
 *
 * Os arquivos seguem o padrão <tipo>-<n>.jpg (ex.: pastilha-1.jpg, pastilha-2.jpg).
 * O tipo é descoberto pelo nome do produto e, quando não há correspondência,
 * pela categoria. Produtos que já têm image_url definida não são alterados.
 */
class ProductImageSeeder extends Seeder
{
    private const IMAGE_DIRECTORY = 'images/products';

    public function run(): void
    {
        $images = $this->localImages();

        if ($images === []) {
            $this->command?->warn('ProductImageSeeder: nenhuma foto encontrada em public/' . self::IMAGE_DIRECTORY . '.');

            return;
        }

        $keywords = $this->keywordGroups();
        $categories = $this->categoryGroups();
        $updated = 0;

        Product::query()->orderBy('id')->chunkById(100, function ($products) use ($images, $keywords, $categories, &$updated) {
            foreach ($products as $product) {
                if (filled($product->image_url) && str_starts_with($product->image_url, '/' . self::IMAGE_DIRECTORY . '/')) {
                    continue;
                }

                $prefix = $this->resolvePrefix($product, $images, $keywords, $categories);

                if ($prefix === null) {
                    continue;
                }

                $files = $images[$prefix];
                $file = $files[abs(crc32((string) $product->slug)) % count($files)];

                $product->forceFill([
                    'image_url' => '/' . self::IMAGE_DIRECTORY . '/' . $file,
                ])->saveQuietly();

                $updated++;
            }
        });

        $this->command?->info("ProductImageSeeder: {$updated} produto(s) receberam foto.");
    }

    /**
     * @return array<string, array<int, string>>
     */
    private function localImages(): array
    {
        $images = [];

        foreach (glob(public_path(self::IMAGE_DIRECTORY . '/*.jpg')) ?: [] as $path) {
            if (preg_match('/^(.+)-\d+\.jpg$/', basename($path), $matches) !== 1) {
                continue;
            }

            $images[$matches[1]][] = basename($path);
        }

        foreach ($images as &$files) {
            sort($files);
        }

        return $images;
    }

    /**
     * Ordem importa: termos mais específicos vêm antes dos genéricos.
     *
     * @return array<string, array<int, string>>
     */
    private function keywordGroups(): array
    {
        return [
            'coifa' => ['coifa'],
            'homocinetica' => ['homocinetica'],
            'bucha' => ['bucha'],
            'bandeja' => ['bandeja'],
            'amortecedor' => ['amortecedor'],
            'mola' => ['mola helicoidal'],
            'pivo' => ['pivo'],
            'terminal-direcao' => ['terminal axial', 'terminal de direcao'],
            'barra-estabilizadora' => ['barra estabilizadora'],
            'coxim' => ['coxim'],
            'pastilha' => ['pastilha'],
            'disco-freio' => ['disco de freio'],
            'tambor' => ['tambor'],
            'lona' => ['lona'],
            'flexivel-freio' => ['flexivel de freio'],
            'cilindro-roda' => ['cilindro de roda'],
            'kit-freio' => ['kit freio'],
            'fluido-freio' => ['fluido de freio'],
            'filtro-oleo' => ['filtro de oleo'],
            'filtro-ar' => ['filtro de ar'],
            'filtro-combustivel' => ['filtro de combustivel'],
            'tensor' => ['tensor'],
            'correia' => ['correia'],
            'vela' => ['vela de ignicao'],
            'bomba-agua' => ["bomba d'agua"],
            'bomba-combustivel' => ['bomba de combustivel'],
            'junta' => ['junta'],
            'bateria' => ['bateria'],
            'alternador' => ['alternador'],
            'motor-partida' => ['motor de partida'],
            'sensor' => ['sensor', 'remap'],
            'bobina' => ['bobina'],
            'lampada' => ['lampada'],
            'ventilador' => ['ventilador', 'eletroventilador'],
            'mangueira' => ['mangueira'],
            'radiador' => ['radiador'],
            'valvula-termostatica' => ['valvula termostatica'],
            'reservatorio' => ['reservatorio'],
            'embreagem' => ['embreagem'],
            'palheta' => ['palheta'],
            'tapete' => ['tapete'],
            'capa-volante' => ['capa de volante'],
            'antena' => ['antena'],
            'calota' => ['calota'],
            'protetor-carter' => ['protetor de carter'],
            'ferramentas' => ['ferramentas'],
            'caixa-direcao' => ['caixa de direcao'],
            'bomba-direcao' => ['bomba de direcao'],
        ];
    }

    /**
     * @return array<string, string>
     */
    private function categoryGroups(): array
    {
        return [
            'suspensao' => 'suspensao',
            'freios' => 'freios',
            'motor' => 'motor',
            'eletrica' => 'eletrica',
            'eletronicos' => 'eletrica',
            'arrefecimento' => 'arrefecimento',
            'transmissao' => 'transmissao',
            'acessorios' => 'acessorios',
            'direcao' => 'direcao',
        ];
    }

    /**
     * @param  array<string, array<int, string>>  $images
     * @param  array<string, array<int, string>>  $keywords
     * @param  array<string, string>  $categories
     */
    private function resolvePrefix(Product $product, array $images, array $keywords, array $categories): ?string
    {
        $name = Str::lower(Str::ascii((string) $product->name));

        foreach ($keywords as $prefix => $terms) {
            if (! isset($images[$prefix])) {
                continue;
            }

            foreach ($terms as $term) {
                if (Str::contains($name, $term)) {
                    return $prefix;
                }
            }
        }

        $category = $categories[Str::lower(Str::ascii((string) $product->category))] ?? null;

        if ($category !== null && isset($images[$category])) {
            return $category;
        }

        return null;
    }
}
