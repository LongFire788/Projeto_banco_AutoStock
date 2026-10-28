# AGENTS.md — AutoStock Marketplace Automotivo

Este documento serve como guia de contexto, arquitetura, regras de negócio e roteiro de implementação (*To-Do*) para agentes de IA e desenvolvedores trabalhando no **AutoStock** — um marketplace nichado em acessórios, estética e equipamentos automotivos/motociclísticos (ex.: capacetes, adesivos automotivos, produtos de limpeza e estética *detailing*).

---

## 1. Visão Geral do Projeto e Stack Tecnológica

- **Nome do Projeto:** AutoStock (`Projeto_banco_AutoStock`)
- **Domínio:** Marketplace multi-lojista (*multi-vendor*) focado em produtos automotivos e motociclísticos.
- **Ambiente:** XAMPP / Apache + PHP 8.x + MySQL / MariaDB.
- **Padrões de Código PHP:**
  - Utilizar **PDO** com *prepared statements* para todas as consultas ao banco de dados (prevenção contra SQL Injection).
  - Seguir arquitetura **MVC** (Models, Views, Controllers) ou separação clara em camadas (`config/`, `src/Models/`, `src/Controllers/`, `src/Services/`, `views/`, `public/`).
  - Nomes de classes em `PascalCase`, métodos e variáveis em `camelCase`, tabelas e colunas do banco em `snake_case`.
  - Senhas sempre criptografadas com `password_hash($senha, PASSWORD_DEFAULT)` e verificadas com `password_verify()`.

---

## 2. Estrutura de Diretórios Recomendada

```text
Projeto_banco_AutoStock/
├── config/
│   └── Database.php          # Conexão Singleton/Estática via PDO
├── database/
│   ├── schema.sql            # Criação das tabelas (DDL)
│   └── seeds.sql             # Dados iniciais de categorias e produtos de teste (DML)
├── src/
│   ├── Models/               # Entidades e acesso a dados (User, Seller, Product, Order, etc.)
│   ├── Controllers/          # Controle de fluxo e requisições
│   └── Services/             # Regras de negócio (Estoque, Frete, Comissões, Validações)
├── views/
│   ├── layouts/              # Header, Footer, Navbar
│   ├── catalog/              # Listagem, filtros nichados e página de produto
│   ├── cart/                 # Carrinho e Checkout
│   ├── seller/               # Painel do Lojista (gestão de estoque, produtos e vendas)
│   └── admin/                # Painel Administrativo do Marketplace
├── public/
│   ├── index.php             # Front Controller / Ponto de entrada
│   └── assets/               # CSS, JS e uploads de imagens de produtos
├── AGENTS.md                 # Instruções para agentes e regras do projeto
└── README.md
```

---

## 3. Regras de Negócio (RN)

### 3.1. Perfis de Usuário e Lojistas (Multi-Vendor)
- **RN01 — Tipos de Conta:** O sistema deve suportar 3 perfis: **Cliente (Comprador)**, **Lojista (Seller)** e **Administrador da Plataforma**.
- **RN02 — Cadastro de Lojista:** Para vender no marketplace, o lojista deve possuir CPF ou CNPJ válido, nome fantasia da loja, dados bancários/Pix para repasse e estar com status `ATIVO` (aprovado pelo Admin).
- **RN03 — Comissão do Marketplace:** A plataforma retém uma taxa percentual configurável (ex.: 10% a 15%) sobre o valor de cada item vendido antes de programar o repasse ao lojista.

### 3.2. Catálogo e Especificidades do Nicho Automotivo
- **RN04 — Categorias e Atributos Específicos por Nicho:**
  - **Capacetes e Equipamentos de Proteção:**
    - Obrigatório informar **Tamanho** (ex.: 56, 58, 60, 62), **Tipo** (Fechado/Integral, Articulado/Escamoteável, Aberto, Off-Road), **Cor/Grafismo** e **Registro/Selo INMETRO** (campo obrigatório para comercialização legal no Brasil).
  - **Adesivos e Personalização (Estética Visual):**
    - Obrigatório informar **Dimensões** (Altura x Largura em cm), **Material** (ex.: Vinil Automotivo, Fibra de Carbono 3D/4D, Refletivo, Resinado), **Resistência UV/Água** e **Local de Aplicação** (Lataria, Vidro, Roda, Tanque de Moto, Universal).
  - **Produtos de Limpeza e Estética (*Detailing*):**
    - Obrigatório informar **Volume/Peso** (ex.: 500ml, 1.5L, 5L, 200g), **Diluição Recomendada** (ex.: Pronto uso, 1:10, 1:100), **pH** (Neutro, Alcalino, Ácido), **Superfície Indicada** (Pintura, Vidros, Pneus/Plásticos, Couro, Motor) e alerta de inflamabilidade/químico para cálculo de transporte.
- **RN05 — Compatibilidade Veicular:** Produtos podem ser marcados como **Uso Universal** (ex.: shampoo automotivo, cera, adesivo universal, capacete) ou **Específicos por Veículo** (ex.: adesivo de faixa lateral para modelo/ano específico), permitindo filtro por *Tipo de Veículo (Carro, Moto, Caminhão) / Marca / Modelo / Ano*.
- **RN06 — Variações de Produto (SKUs):** O controle de estoque e preço deve ser feito no nível da variação (SKU). Exemplo: *Capacete Modelo X - Tamanho 58* possui estoque independente do *Tamanho 60*.

### 3.3. Estoque, Carrinho e Pedidos (AutoStock Core)
- **RN07 — Validação e Reserva de Estoque:**
  - Um produto com `estoque <= 0` não pode ser adicionado ao carrinho e deve ser exibido como "Esgotado".
  - No momento do checkout, a baixa de estoque deve ocorrer dentro de uma **transação de banco de dados (`BEGIN` / `COMMIT` / `ROLLBACK`)** com bloqueio de leitura (`SELECT ... FOR UPDATE`) para evitar venda duplicada do último item (*overselling*).
- **RN08 — Pedido Multi-Lojista (Split de Pedido):**
  - O comprador pode adicionar ao mesmo carrinho um *Capacete* (Loja A), um *Kit de Adesivos* (Loja B) e um *Shampoo Automotivo* (Loja C).
  - Ao finalizar a compra, é gerado um **Pedido Principal** (`orders`) para o cliente e **Sub-pedidos** (`sub_orders`) separados para cada lojista gerenciar seu próprio envio e nota fiscal.
- **RN09 — Restrições de Envio e Cubagem:**
  - Produtos químicos líquidos (limpeza/estética) acima de determinado volume ou classificados como inflamáveis devem restringir modalidades de frete aéreo, permitindo apenas transporte rodoviário.
  - Todo SKU deve ter peso (kg) e dimensões da embalagem (A x L x C em cm) cadastrados para cálculo de frete.
- **RN10 — Avaliações Verificadas:** Apenas clientes que tiveram o pedido com status `ENTREGUE` podem avaliar o produto e o lojista (nota de 1 a 5 estrelas + comentário).

---

## 4. Instruções para Agentes de IA

1. **Verifique antes de criar:** Antes de criar novas tabelas ou classes, inspecione `config/Database.php` e a pasta `database/` para manter consistência com os nomes das colunas e credenciais do banco.
2. **Integridade Transacional:** Qualquer operação que altere saldo de estoque (`stock_movements`), criação de pedidos (`orders`) ou divisão de pagamento (`order_splits`) **deve** usar `PDO::beginTransaction()`, `PDO::commit()` e `PDO::rollBack()` em bloco `try/catch`.
3. **Tratamento de Erros:** Nunca exiba erros brutos de SQL (`PDOException`) na interface do usuário. Registre no log e retorne mensagens amigáveis.
4. **Segurança e Validação:** Sanitize e valide todos os inputs (`filter_input`, tipagem estrita). Valide formatos de atributos obrigatórios por categoria antes de persistir o produto.

---

## 5. Lista "To-Do" de Desenvolvimento (Roadmap)

### Fase 1: Infraestrutura e Banco de Dados
- [ ] **1.1.** Finalizar a classe `Database` em [`config/Database.php`](file:///c:/xampp/php/www/Projeto_banco_AutoStock/config/Database.php) com conexão PDO, configuração de `ERRMODE_EXCEPTION`, `DEFAULT_FETCH_MODE => FETCH_ASSOC` e `charset=utf8mb4`.
- [ ] **1.2.** Criar o script `database/schema.sql` contendo as tabelas principais:
  - `users` (clientes, lojistas, admins)
  - `sellers` (dados da loja, CNPJ/CPF, comissão, status)
  - `categories` (Capacetes, Adesivos, Limpeza/Estética, Acessórios)
  - `products` (dados gerais, lojista dono, categoria, compatibilidade universal/específica)
  - `product_skus` (variações: tamanho, cor, volume, código SKU, preço, estoque, peso/dimensões)
  - `product_attributes` (atributos específicos do nicho: selo INMETRO, diluição, pH, material do vinil)
  - `orders`, `sub_orders` e `order_items` (pedidos, divisão por lojista e itens)
  - `stock_movements` (histórico de entrada, saída e estorno de estoque)
  - `reviews` (avaliações de produtos comprados)
- [ ] **1.3.** Criar o script `database/seeds.sql` com dados reais do nicho (ex.: 2 lojistas, capacetes tam. 58/60 com INMETRO, adesivos resinados/fibra de carbono, shampoos neutros, ceras de carnaúba e limpa-pneus).

### Fase 2: Autenticação e Gestão de Lojistas
- [ ] **2.1.** Criar Model e Controller de `User` (Cadastro, Login, Logout, Sessão).
- [ ] **2.2.** Criar fluxo de cadastro de Lojista (`Seller`) e aprovação pelo Administrador.
- [ ] **2.3.** Implementar middleware/verificação de permissões por perfil (`cliente`, `lojista`, `admin`).

### Fase 3: Catálogo Nichado e Gestão de Estoque (AutoStock)
- [ ] **3.1.** Criar CRUD de Produtos e Variações (SKUs) no painel do lojista.
- [ ] **3.2.** Implementar validação condicional por categoria (ex.: exigir numeração e selo INMETRO ao cadastrar Capacete; exigir volume e pH/diluição para Produtos de Limpeza; exigir dimensões e material para Adesivos).
- [ ] **3.3.** Criar serviço de controle de estoque (`StockService`) com registro de movimentações (entrada manual, reserva em pedido, baixa definitiva e estorno em cancelamento).
- [ ] **3.4.** Criar vitrine pública com busca e filtros específicos (filtrar por categoria, faixa de preço, tamanho de capacete, tipo de superfície de limpeza, aplicação de adesivo).

### Fase 4: Carrinho, Checkout e Split Multi-Vendor
- [ ] **4.1.** Implementar Carrinho de Compras (em sessão/banco) com verificação em tempo real de disponibilidade de estoque.
- [ ] **4.2.** Implementar cálculo básico de frete considerando peso/cubagem e restrição de produtos químicos líquidos.
- [ ] **4.3.** Criar o processador de Checkout transacional:
  - Validar estoque com bloqueio.
  - Criar pedido principal e dividir automaticamente em `sub_orders` por lojista.
  - Calcular e registrar a comissão do marketplace e o valor líquido de cada lojista.
  - Baixar estoque e registrar em `stock_movements`.

### Fase 5: Pós-Venda e Painéis de Controle
- [ ] **5.1.** Criar painel do Cliente ("Meus Pedidos", status de entrega e formulário de avaliação de produtos entregues).
- [ ] **5.2.** Criar Dashboard do Lojista (alerta de estoque baixo, lista de vendas a enviar, atualização de código de rastreio e resumo financeiro).
- [ ] **5.3.** Criar Dashboard do Admin (total transacionado no marketplace - GMV, comissões retidas, moderação de lojistas e anúncios).
