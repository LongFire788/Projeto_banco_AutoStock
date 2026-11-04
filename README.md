# AutoStock — Marketplace de Autopeças

Sistema de marketplace e-commerce focado em autopeças e acessórios automotivos, construído em **Laravel 12 / PHP 8.2**. Inclui catálogo multi-lojista, variações (SKUs) com estoque real, compatibilidade veicular, frete multi-origem, checkout com reserva de estoque por lock pessimista e split de pagamento por vendedor.

---

## Índice

- [Stack](#stack)
- [Como rodar](#como-rodar)
- [Credenciais](#credenciais)
- [Funcionalidades](#funcionalidades)
- [Modelagem de dados](#modelagem-de-dados)
- [Arquitetura dos serviços](#arquitetura-dos-serviços)
- [Frete multi-origem](#frete-multi-origem)
- [Concorrência de estoque (lock pessimista)](#concorrência-de-estoque-lock-pessimista)
- [Split de pagamento](#split-de-pagamento)
- [Pagamento Pix](#pagamento-pix)
- [Rotas principais](#rotas-principais)
- [Testes](#testes)
- [Configuração](#configuração)
- [Limitações e próximos passos](#limitações-e-próximos-passos)

---

## Stack

| Item | Versão |
|------|--------|
| PHP | 8.2+ |
| Laravel | 12.x |
| Banco (runtime) | SQLite (`database/database.sqlite`) |
| Banco (compatível) | MySQL 8 / MariaDB — migrations usam tipos portáveis |
| Frontend | Blade + Tailwind CSS (CDN) + Alpine.js (CDN), sem build |
| Pix | BR Code EMV gerado no servidor + QR Code com `chillerlan/php-qrcode` |
| Testes | PHPUnit 11 |

Não há dependência de Node/Vite para rodar a aplicação.

---

## Como rodar

Pré-requisitos: PHP 8.2+ com `pdo_sqlite` (ou `pdo_mysql`) e Composer.

```bash
# 1. Dependências
composer install

# 2. Ambiente
cp .env.example .env
php artisan key:generate

# 3. Banco SQLite (padrão)
#    O arquivo já é criado abaixo; em MySQL, ajuste DB_* no .env
type nul > database/database.sqlite      # Windows (PowerShell: New-Item database/database.sqlite)
# touch database/database.sqlite         # Linux/macOS

# 4. Schema + dados de demonstração
php artisan migrate:fresh --seed

# 5. Servidor local
php artisan serve
```

Acesse:

- Loja: <http://127.0.0.1:8000>
- Painel: <http://127.0.0.1:8000/admin> (redireciona para `/login`)

### Usando MySQL

No `.env`:

```dotenv
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=autostock
DB_USERNAME=root
DB_PASSWORD=
```

Depois: `php artisan migrate:fresh --seed`.

---

## Credenciais

O seeder cria o administrador:

| E-mail | Senha |
|--------|-------|
| `admin@autostock.test` | `password` |

Além do catálogo curado (5 produtos com 7 SKUs), o `MockDataSeeder` popula a base de demonstração com **200 produtos** (variações/SKUs, atributos e compatibilidade veicular) e **200 pedidos** (itens, envios por vendedor, split de pagamento e Pix), distribuídos entre 8 vendedores e 17 modelos de veículos.

Para gerar apenas esses dados mockados, sem recriar o banco:

```bash
php artisan db:seed --class=MockDataSeeder
```

O seeder é idempotente: se a base já tiver 200 produtos e 200 pedidos, ele não duplica os registros.

### Fotos dos produtos

Os 200 produtos recebem fotos locais de autopeças em `public/images/products`, associadas pelo tipo de peça no nome (com fallback por categoria) pelo `ProductImageSeeder`.

```bash
php artisan db:seed --class=ProductImageSeeder
```

As imagens são arquivos Creative Commons baixados do Wikimedia Commons, com autoria e licença documentadas em `public/images/products/CREDITS.md`. Nada é carregado de links externos em tempo de execução. Para trocar uma foto, basta substituir o arquivo mantendo o nome (`<tipo>-<n>.jpg`) ou informar outro caminho/URL no campo **Imagem** do cadastro de produto no painel.

---

## Funcionalidades

### Loja
- Catálogo com busca textual (nome, marca, categoria), filtro por veículo compatível e por categoria.
- Página de produto com todas as variações, atributos dinâmicos, preço, estoque e dados logísticos.
- Carrinho em sessão com limite de quantidade pelo estoque disponível.
- Checkout com CEP, cotação de frete por vendedor, escolha do serviço por origem e forma de pagamento.
- Página de sucesso com itens, envios, divisão de pagamento e **QR Code Pix** (com copia e cola) quando o pagamento é por Pix.

### Painel administrativo
- Dashboard com indicadores, pedidos recentes e estoque crítico.
- CRUD de vendedores (dados cadastrais, endereço de despacho/CEP de origem, `gateway_receiver_id`).
- CRUD de produtos com vínculo N:N a modelos de veículo.
- CRUD de variações (SKU) aninhado ao produto, com atributos dinâmicos (nome/valor).
- CRUD de modelos de veículos (marca, modelo, anos, motorização).
- Gestão de pedidos: status do pedido, status de envio, código de rastreio e previsão de entrega.
- Cancelamento de pedido devolve automaticamente o estoque reservado.

---

## Modelagem de dados

```
sellers
  └─< products
        ├─< product_variants
        │     └─< variant_attributes
        └─>< vehicle_models        (via product_compatibilities)

orders
  ├─< order_shipments   (1 por seller)
  ├─< order_items       (vinculados ao shipment e ao SKU)
  └─< payments          (1 por seller — split)
```

### Tabelas

| Tabela | Papel |
|--------|-------|
| `sellers` | Lojista, endereço de despacho (`zip_code` = origem do frete) e `gateway_receiver_id` (subconta). |
| `products` | Produto pai (genérico), pertence a um seller, N:N com veículos. |
| `product_variants` | SKU vendável: preço, estoque unitário, peso (g) e dimensões (cm). |
| `variant_attributes` | Atributos dinâmicos do SKU (`name`/`value`, ex.: Posição = Direito). |
| `vehicle_models` | Marca, modelo, ano inicial/final e motorização. |
| `product_compatibilities` | Pivô N:N produto ↔ veículo (único por par). |
| `orders` | Pedido com snapshot do cliente, endereço, totais e dados do Pix (`pix_payload`, `pix_expires_at`). |
| `order_shipments` | Pacote por vendedor: método, serviço, rastreio, custo e status. Único por `(order_id, seller_id)`. |
| `order_items` | Snapshot do item (nome, SKU, preço, dimensões) ligado ao pedido, ao envio e ao SKU. |
| `payments` | Parte do pagamento de cada seller: valor, taxa da plataforma, repasse e status. |

### Decisões de modelagem

- **Somente o SKU tem estoque, preço e logística.** O produto pai é apenas agrupador comercial.
- **Snapshots no pedido.** Nome, SKU, preço e dimensões são copiados para `order_items`, preservando o histórico mesmo se o catálogo mudar.
- **Um pacote consolidado por seller por pedido.** `order_shipments` tem `unique(order_id, seller_id)`.
- **Índices** em FKs, status, CEP, cidade/UF, marca/categoria e `created_at` para consultas do catálogo e do painel.
- **Soft deletes** em sellers, produtos e variações; pedidos e pagamentos são históricos e não são removidos.

---

## Arquitetura dos serviços

```
app/Services
├─ CartService.php                 # carrinho em sessão -> ShippingItem[]
├─ CheckoutService.php             # orquestra cotação, transação, pedido, envios e split
├─ InventoryService.php            # reserve() com lockForUpdate + restoreForOrder()
├─ SplitPaymentService.php         # criação/aprovação das parcelas por seller
├─ Payments
│  └─ PixPayloadBuilder.php        # BR Code EMV (CRC16) + QR Code SVG
└─ Shipping
   ├─ ShippingCalculationService.php  # agrupa por seller e cota
   ├─ MelhorEnvioPayloadBuilder.php   # payload no formato Melhor Envio
   ├─ Contracts/ShippingGateway.php   # contrato de cotação
   ├─ Gateways/LocalShippingGateway.php
   ├─ Gateways/MelhorEnvioGateway.php
   └─ DTO/{ShippingItem,ShipmentGroup}.php
```

O `ShippingGateway` é resolvido no `AppServiceProvider` conforme `SHIPPING_DRIVER`, então trocar o gateway local pelo Melhor Envio não exige mudança nos controllers.

---

## Frete multi-origem

`ShippingCalculationService::groupBySeller()` recebe os itens do carrinho e:

1. Agrupa por `seller_id` (origem = CEP de despacho do seller).
2. Consolida peso real e cubagem do pacote (`comprimento × largura × altura / 6`, em gramas).
3. Soma o subtotal por vendedor.
4. Gera **um payload por origem** no formato do Melhor Envio:

```json
{
  "from": { "postal_code": "01310100" },
  "to":   { "postal_code": "20040020" },
  "products": [
    {
      "id": "AMORT-COF-DIR",
      "width": 18, "height": 18, "length": 60,
      "weight": 3.2,
      "insurance_value": 389.9,
      "quantity": 2
    }
  ],
  "volumes": [
    { "width": 18, "height": 36, "length": 60, "weight": 6.4 }
  ],
  "options": { "receipt": false, "own_hand": false, "collect": false, "insurance_value": 779.8 }
}
```

`quoteCart()` devolve, por seller, o pacote (`items`, pesos, dimensões) e as opções de serviço, além do `shipping_total` padrão. O checkout exibe as opções de cada vendedor e envia o serviço escolhido em `selected_services[seller_id]`.

### Gateways

- **`local`** (padrão): cálculo determinístico, sem rede — ideal para desenvolvimento e testes.
- **`melhor_envio`**: `POST {base_url}/api/v2/me/shipment/calculate` com token Bearer.

```dotenv
SHIPPING_DRIVER=melhor_envio
MELHOR_ENVIO_TOKEN=seu_token
MELHOR_ENVIO_BASE_URL=https://sandbox.melhorenvio.com.br
```

---

## Concorrência de estoque (lock pessimista)

O decremento acontece dentro de `DB::transaction()` no `CheckoutService`, chamando `InventoryService::reserve()`:

```php
$variants = ProductVariant::query()
    ->whereIn('id', $quantities->keys())
    ->orderBy('id')          // ordem fixa evita deadlock entre transações
    ->lockForUpdate()        // SELECT ... FOR UPDATE
    ->get()
    ->keyBy('id');

foreach ($quantities as $variantId => $quantity) {
    $variant = $variants->get($variantId);

    if ($variant->stock < $quantity) {
        throw new InsufficientStockException($variant->sku, $quantity, $variant->stock);
    }
}

foreach ($quantities as $variantId => $quantity) {
    $variants->get($variantId)->decrement('stock', $quantity);
}
```

Garantias:

- Duas requisições simultâneas para o mesmo SKU são serializadas pelo banco: a segunda só lê o estoque após a primeira commitar.
- Se qualquer item não tiver estoque, a exceção aborta a transação inteira — nenhum pedido parcial é criado e nenhum estoque é decrementado.
- A cotação de frete (I/O externo) roda **antes** da transação, para não manter locks durante chamadas HTTP.
- `attempts: 3` no `DB::transaction` trata deadlocks transitórios.
- Cancelamento chama `restoreForOrder()`, devolvendo as quantidades uma única vez.

> Em SQLite, `lockForUpdate()` é aceito mas não bloqueia linhas. O comportamento real de lock pessimista é exercido em MySQL/PostgreSQL, alvo de produção.

---

## Split de pagamento

`SplitPaymentService` cria uma linha em `payments` por vendedor:

```
amount        = itens do seller + frete do seller
platform_fee  = itens do seller × PLATFORM_FEE_PERCENT / 100
seller_amount = amount - platform_fee
```

- O frete é **repassado integralmente** ao seller; a taxa incide apenas sobre os itens.
- `gateway_receiver_id` é copiado do seller para o pagamento.
- Ao marcar o pedido como `paid` no painel, todas as parcelas pendentes são aprovadas com `paid_at`.
- A soma de `payments.amount` fecha com `orders.total`.

A integração real com um gateway (Pagar.me, Asaas, Mercado Pago etc.) entra no lugar do `SIM-<ULID>` em `gateway_payment_id`, mantendo o mesmo contrato.

---

## Pagamento Pix

Quando o cliente escolhe **Pix**, o `CheckoutService` gera e persiste o BR Code no próprio pedido (`orders.pix_payload`), com validade em `orders.pix_expires_at`. A página de sucesso renderiza:

- QR Code em SVG, gerado no servidor (sem chamada a serviço externo);
- o código **copia e cola** com botão de cópia;
- valor total e horário de expiração.

O payload segue o padrão EMV do Banco Central:

```
00 02 01                         # payload format indicator
26 .. br.gov.bcb.pix + chave     # merchant account information
52 04 0000                       # merchant category code
53 03 986                        # moeda BRL
54 .. valor                      # ex.: 881.14
58 02 BR
59 .. nome do recebedor
60 .. cidade do recebedor
62 .. 05 <txid>                  # txid = número do pedido sem separadores
63 04 <CRC16-CCITT-FALSE>
```

O CRC16 usa polinômio `0x1021`, inicialização `0xFFFF` e sem reflexão; o valor de referência para `"123456789"` é `29B1`. A chave configurada em `PIX_KEY` recebe o valor total; o split por vendedor continua registrado em `payments` e o repasse é responsabilidade da plataforma.

> O BR Code é válido para pagamento real, mas a **confirmação automática** (webhook do PSP) ainda não está implementada: no ambiente de demonstração o pedido continua pendente até ser aprovado manualmente no painel.

Configuração:

```dotenv
PIX_KEY=pagamentos@autostock.test
PIX_MERCHANT_NAME=AUTOSTOCK
PIX_MERCHANT_CITY="SAO PAULO"
PIX_EXPIRATION_MINUTES=30
```

As configurações ficam em `config/payments.php`. Pedidos antigos sem payload recebem um novo BR Code ao abrir a página de sucesso (`PixPayloadBuilder::ensureForOrder()`).

### QR lido, mas recusado no app do banco / Mercado Pago

O payload é estruturalmente válido (CRC conferido), mas o Pix **exige que a chave exista no DICT**. Com a chave de exemplo `pagamentos@autostock.test`, o app consegue ler o QR e falha ao consultar a chave, exibindo o código como inválido. Para pagar de verdade:

1. Cadastre/consulte uma chave Pix real no seu banco ou PSP (CPF/CNPJ, e-mail, telefone ou aleatória).
2. Preencha `PIX_KEY` no `.env` no formato do DICT:
   - CPF/CNPJ: somente dígitos;
   - e-mail: minúsculo;
   - telefone: `+55DDDNUMERO`;
   - aleatória: UUID (o builder converte e-mail/UUID para minúsculas automaticamente).
3. Rode `php artisan config:clear` e `php artisan pix:regenerate` para atualizar os pedidos pendentes (ou `php artisan pix:regenerate ORD-...` para um pedido específico).
4. Abra novamente a confirmação do pedido.

O nome e a cidade do recebedor são informativos; o app pagador exibe o titular retornado pelo DICT. A tela de sucesso e o painel mostram um aviso vermelho enquanto a chave de demonstração estiver configurada.

---

## Rotas principais

### Loja

| Método | Rota | Ação |
|--------|------|------|
| GET | `/` | Catálogo |
| GET | `/produtos/{slug}` | Detalhe do produto |
| GET/POST/PATCH/DELETE | `/carrinho` | Carrinho |
| GET/POST | `/checkout` | Checkout |
| GET | `/checkout/sucesso/{number}` | Confirmação |

### Painel (`auth`)

| Recurso | Rotas |
|---------|-------|
| Dashboard | `GET /admin` |
| Sellers | `resource` completo |
| Products | `resource` completo |
| Variants | `resource` aninhado (`products.variants`, exceto index/show) |
| Vehicle models | `resource` (exceto show) |
| Compatibilidades | `POST/DELETE /admin/products/{product}/compatibilities` |
| Orders | index, show, `PATCH .../status`, `PATCH .../shipments/{shipment}` |

---

## Testes

```bash
php artisan test
```

Cobertura atual — **22 testes / 134 asserções**:

- `ShippingCalculationServiceTest`: agrupamento por seller, consolidação de peso/cubagem e payload por origem.
- `CheckoutStockTest`: decremento de estoque, split por seller, rollback por estoque insuficiente e devolução no cancelamento.
- `AdminCrudTest`: autenticação, criação de seller, produto com compatibilidade e variação com atributos.
- `StorefrontCheckoutTest`: fluxo completo catálogo → carrinho → cotação → pedido → sucesso.
- `PixPayloadBuilderTest`: CRC16 de referência, campos EMV, txid, normalização de e-mail/UUID/CPF/CNPJ/telefone e geração do SVG.
- `PixCheckoutTest`: payload persistido no checkout Pix, QR na página de sucesso, ausência de Pix em outros métodos, regeneração de pedidos antigos, exibição no painel, aviso de chave de demonstração e comando `pix:regenerate`.
- `ExampleTest`: home responde 200.

Os testes usam SQLite `:memory:` (`phpunit.xml`) e `RefreshDatabase`.

---

## Configuração

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `SHIPPING_DRIVER` | `local` | `local` ou `melhor_envio`. |
| `MELHOR_ENVIO_TOKEN` | vazio | Token Bearer da API. |
| `MELHOR_ENVIO_BASE_URL` | sandbox | URL da API. |
| `PLATFORM_FEE_PERCENT` | `10` | Taxa da plataforma sobre os itens. |
| `PIX_KEY` | `pagamentos@autostock.test` | Chave Pix que recebe o valor total do pedido. |
| `PIX_MERCHANT_NAME` | `AUTOSTOCK` | Nome do recebedor no BR Code (máx. 25, ASCII). |
| `PIX_MERCHANT_CITY` | `SAO PAULO` | Cidade do recebedor (máx. 15, ASCII). |
| `PIX_EXPIRATION_MINUTES` | `30` | Validade do QR Code exibida ao cliente. |
| `APP_TIMEZONE` | `America/Sao_Paulo` | Fuso usado em datas e prazos. |
| `APP_LOCALE` | `pt_BR` | Locale da aplicação. |

As configurações ficam em `config/shipping.php` e `config/payments.php` e são lidas via `config()` — rode `php artisan config:clear` após alterar o `.env`.

---

## Limitações e próximos passos

- **Pagamento sem PSP.** O Pix gera um BR Code EMV válido, mas não há webhook de confirmação; cartão e boleto continuam simulados. O split é registrado e aprovado manualmente no painel.
- **Sem autenticação de cliente.** Checkout como visitante; não há área "meus pedidos".
- **Carrinho em sessão.** Suficiente para o escopo; para múltiplos dispositivos, migrar para tabela `carts`.
- **Cotação não é persistida como cache.** Cada checkout recota; um cache curto por CEP/seller reduziria chamadas à API.
- **Etiquetas e rastreio manuais.** O painel permite informar código e status; geração automática de etiqueta é um próximo passo.
- **Frontend via CDN.** Para produção, compilar Tailwind/Alpine e remover a dependência de CDN.
- **Autorização por perfil.** Hoje todo usuário autenticado é administrador; um papel `seller` restringiria o painel por lojista.
