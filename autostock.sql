--
-- PostgreSQL database dump
--

\restrict OKhBOFkF0EfkdUkGJLaf6PyLdSgUPoR6rXRTBHXiY0bUXGb3MmB9MKiL9Udp7ES

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-15 22:29:05

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 241 (class 1259 OID 17159)
-- Name: atributos_variacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.atributos_variacao (
    id bigint NOT NULL,
    product_variant_id bigint NOT NULL,
    name character varying(60) NOT NULL,
    value character varying(120) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.atributos_variacao OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 17158)
-- Name: atributos_variacao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.atributos_variacao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.atributos_variacao_id_seq OWNER TO postgres;

--
-- TOC entry 5264 (class 0 OID 0)
-- Dependencies: 240
-- Name: atributos_variacao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.atributos_variacao_id_seq OWNED BY public.atributos_variacao.id;


--
-- TOC entry 225 (class 1259 OID 16984)
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16995)
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 17177)
-- Name: compatibilidades_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compatibilidades_produto (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    vehicle_model_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.compatibilidades_produto OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17176)
-- Name: compatibilidades_produto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.compatibilidades_produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.compatibilidades_produto_id_seq OWNER TO postgres;

--
-- TOC entry 5265 (class 0 OID 0)
-- Dependencies: 242
-- Name: compatibilidades_produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.compatibilidades_produto_id_seq OWNED BY public.compatibilidades_produto.id;


--
-- TOC entry 247 (class 1259 OID 17236)
-- Name: envios_pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.envios_pedido (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    seller_id bigint NOT NULL,
    shipping_method character varying(80) NOT NULL,
    shipping_service_code character varying(40),
    tracking_code character varying(80),
    shipping_cost numeric(12,2) DEFAULT '0'::numeric NOT NULL,
    status character varying(30) DEFAULT 'pending'::character varying NOT NULL,
    estimated_delivery_date date,
    payload json,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.envios_pedido OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 17235)
-- Name: envios_pedido_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.envios_pedido_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.envios_pedido_id_seq OWNER TO postgres;

--
-- TOC entry 5266 (class 0 OID 0)
-- Dependencies: 246
-- Name: envios_pedido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.envios_pedido_id_seq OWNED BY public.envios_pedido.id;


--
-- TOC entry 231 (class 1259 OID 17037)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17036)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- TOC entry 5267 (class 0 OID 0)
-- Dependencies: 230
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 249 (class 1259 OID 17267)
-- Name: itens_pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itens_pedido (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    order_shipment_id bigint,
    seller_id bigint NOT NULL,
    product_id bigint NOT NULL,
    product_variant_id bigint NOT NULL,
    product_name character varying(255) NOT NULL,
    variant_name character varying(120) NOT NULL,
    sku character varying(64) NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(12,2) NOT NULL,
    total numeric(12,2) NOT NULL,
    weight_grams integer NOT NULL,
    length_cm smallint NOT NULL,
    width_cm smallint NOT NULL,
    height_cm smallint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.itens_pedido OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 17266)
-- Name: itens_pedido_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.itens_pedido_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.itens_pedido_id_seq OWNER TO postgres;

--
-- TOC entry 5268 (class 0 OID 0)
-- Dependencies: 248
-- Name: itens_pedido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.itens_pedido_id_seq OWNED BY public.itens_pedido.id;


--
-- TOC entry 229 (class 1259 OID 17022)
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17007)
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17006)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- TOC entry 5269 (class 0 OID 0)
-- Dependencies: 227
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 220 (class 1259 OID 16939)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16938)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 5270 (class 0 OID 0)
-- Dependencies: 219
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 235 (class 1259 OID 17088)
-- Name: modelos_veiculo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modelos_veiculo (
    id bigint NOT NULL,
    brand character varying(80) NOT NULL,
    model character varying(120) NOT NULL,
    year_start smallint NOT NULL,
    year_end smallint NOT NULL,
    engine character varying(80),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.modelos_veiculo OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 17087)
-- Name: modelos_veiculo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.modelos_veiculo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.modelos_veiculo_id_seq OWNER TO postgres;

--
-- TOC entry 5271 (class 0 OID 0)
-- Dependencies: 234
-- Name: modelos_veiculo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.modelos_veiculo_id_seq OWNED BY public.modelos_veiculo.id;


--
-- TOC entry 251 (class 1259 OID 17316)
-- Name: pagamentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagamentos (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    seller_id bigint NOT NULL,
    gateway character varying(40) DEFAULT 'sandbox'::character varying NOT NULL,
    gateway_payment_id character varying(120),
    gateway_receiver_id character varying(120),
    amount numeric(12,2) NOT NULL,
    platform_fee numeric(12,2) DEFAULT '0'::numeric NOT NULL,
    seller_amount numeric(12,2) NOT NULL,
    status character varying(30) DEFAULT 'pending'::character varying NOT NULL,
    paid_at timestamp(0) without time zone,
    payload json,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.pagamentos OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 17315)
-- Name: pagamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagamentos_id_seq OWNER TO postgres;

--
-- TOC entry 5272 (class 0 OID 0)
-- Dependencies: 250
-- Name: pagamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagamentos_id_seq OWNED BY public.pagamentos.id;


--
-- TOC entry 223 (class 1259 OID 16963)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 17200)
-- Name: pedidos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedidos (
    id bigint NOT NULL,
    number character varying(32) NOT NULL,
    customer_name character varying(255) NOT NULL,
    customer_email character varying(255) NOT NULL,
    customer_document character varying(18),
    customer_phone character varying(20),
    shipping_zip_code character varying(8) NOT NULL,
    shipping_street character varying(255) NOT NULL,
    shipping_number character varying(20) NOT NULL,
    shipping_complement character varying(255),
    shipping_neighborhood character varying(255) NOT NULL,
    shipping_city character varying(255) NOT NULL,
    shipping_state character varying(2) NOT NULL,
    subtotal numeric(12,2) NOT NULL,
    shipping_total numeric(12,2) DEFAULT '0'::numeric NOT NULL,
    discount_total numeric(12,2) DEFAULT '0'::numeric NOT NULL,
    total numeric(12,2) NOT NULL,
    status character varying(30) DEFAULT 'pending'::character varying NOT NULL,
    payment_status character varying(30) DEFAULT 'pending'::character varying NOT NULL,
    payment_method character varying(30),
    notes text,
    placed_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    pix_payload text,
    pix_expires_at timestamp(0) without time zone,
    user_id bigint
);


ALTER TABLE public.pedidos OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17199)
-- Name: pedidos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pedidos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedidos_id_seq OWNER TO postgres;

--
-- TOC entry 5273 (class 0 OID 0)
-- Dependencies: 244
-- Name: pedidos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pedidos_id_seq OWNED BY public.pedidos.id;


--
-- TOC entry 237 (class 1259 OID 17104)
-- Name: produtos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produtos (
    id bigint NOT NULL,
    seller_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    brand character varying(100),
    category character varying(100),
    description text,
    image_url character varying(2048),
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.produtos OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 17103)
-- Name: produtos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produtos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produtos_id_seq OWNER TO postgres;

--
-- TOC entry 5274 (class 0 OID 0)
-- Dependencies: 236
-- Name: produtos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produtos_id_seq OWNED BY public.produtos.id;


--
-- TOC entry 224 (class 1259 OID 16972)
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16949)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    role character varying(20) DEFAULT 'cliente'::character varying NOT NULL,
    document character varying(18),
    phone character varying(20),
    zip_code character varying(8),
    address_street character varying(255),
    address_number character varying(20),
    address_complement character varying(255),
    address_neighborhood character varying(255),
    address_city character varying(255),
    address_state character varying(2)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16948)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5275 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 239 (class 1259 OID 17130)
-- Name: variacoes_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.variacoes_produto (
    id bigint NOT NULL,
    product_id bigint NOT NULL,
    sku character varying(64) NOT NULL,
    name character varying(120) NOT NULL,
    price numeric(12,2) NOT NULL,
    compare_at_price numeric(12,2),
    stock integer DEFAULT 0 NOT NULL,
    weight_grams integer NOT NULL,
    length_cm smallint NOT NULL,
    width_cm smallint NOT NULL,
    height_cm smallint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.variacoes_produto OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 17129)
-- Name: variacoes_produto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.variacoes_produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.variacoes_produto_id_seq OWNER TO postgres;

--
-- TOC entry 5276 (class 0 OID 0)
-- Dependencies: 238
-- Name: variacoes_produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.variacoes_produto_id_seq OWNED BY public.variacoes_produto.id;


--
-- TOC entry 233 (class 1259 OID 17056)
-- Name: vendedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendedores (
    id bigint NOT NULL,
    legal_name character varying(255) NOT NULL,
    trade_name character varying(255) NOT NULL,
    document character varying(18) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20),
    zip_code character varying(8) NOT NULL,
    address_street character varying(255) NOT NULL,
    address_number character varying(20) NOT NULL,
    address_complement character varying(255),
    address_neighborhood character varying(255) NOT NULL,
    address_city character varying(255) NOT NULL,
    address_state character varying(2) NOT NULL,
    gateway_receiver_id character varying(255),
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE public.vendedores OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17055)
-- Name: vendedores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendedores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendedores_id_seq OWNER TO postgres;

--
-- TOC entry 5277 (class 0 OID 0)
-- Dependencies: 232
-- Name: vendedores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendedores_id_seq OWNED BY public.vendedores.id;


--
-- TOC entry 4955 (class 2604 OID 17162)
-- Name: atributos_variacao id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atributos_variacao ALTER COLUMN id SET DEFAULT nextval('public.atributos_variacao_id_seq'::regclass);


--
-- TOC entry 4956 (class 2604 OID 17180)
-- Name: compatibilidades_produto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compatibilidades_produto ALTER COLUMN id SET DEFAULT nextval('public.compatibilidades_produto_id_seq'::regclass);


--
-- TOC entry 4962 (class 2604 OID 17239)
-- Name: envios_pedido id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.envios_pedido ALTER COLUMN id SET DEFAULT nextval('public.envios_pedido_id_seq'::regclass);


--
-- TOC entry 4945 (class 2604 OID 17040)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 4965 (class 2604 OID 17270)
-- Name: itens_pedido id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido ALTER COLUMN id SET DEFAULT nextval('public.itens_pedido_id_seq'::regclass);


--
-- TOC entry 4944 (class 2604 OID 17010)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 4941 (class 2604 OID 16942)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 4949 (class 2604 OID 17091)
-- Name: modelos_veiculo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modelos_veiculo ALTER COLUMN id SET DEFAULT nextval('public.modelos_veiculo_id_seq'::regclass);


--
-- TOC entry 4966 (class 2604 OID 17319)
-- Name: pagamentos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamentos ALTER COLUMN id SET DEFAULT nextval('public.pagamentos_id_seq'::regclass);


--
-- TOC entry 4957 (class 2604 OID 17203)
-- Name: pedidos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos ALTER COLUMN id SET DEFAULT nextval('public.pedidos_id_seq'::regclass);


--
-- TOC entry 4950 (class 2604 OID 17107)
-- Name: produtos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos ALTER COLUMN id SET DEFAULT nextval('public.produtos_id_seq'::regclass);


--
-- TOC entry 4942 (class 2604 OID 16952)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4952 (class 2604 OID 17133)
-- Name: variacoes_produto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variacoes_produto ALTER COLUMN id SET DEFAULT nextval('public.variacoes_produto_id_seq'::regclass);


--
-- TOC entry 4947 (class 2604 OID 17059)
-- Name: vendedores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedores ALTER COLUMN id SET DEFAULT nextval('public.vendedores_id_seq'::regclass);


--
-- TOC entry 5248 (class 0 OID 17159)
-- Dependencies: 241
-- Data for Name: atributos_variacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.atributos_variacao (id, product_variant_id, name, value, created_at, updated_at) FROM stdin;
1	1	Posição	Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
2	1	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
3	2	Posição	Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
4	2	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
5	3	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
6	3	Material	Cerâmica	2026-11-14 12:39:12	2026-11-14 12:39:12
7	4	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
8	4	Material	Cerâmica	2026-11-14 12:39:12	2026-11-14 12:39:12
9	5	Rosca	3/4-16 UNF	2026-11-14 12:39:12	2026-11-14 12:39:12
10	6	Capacidade	60Ah	2026-11-14 12:39:12	2026-11-14 12:39:12
11	6	Tensão	12V	2026-11-14 12:39:12	2026-11-14 12:39:12
12	7	Tamanho	24/18 polegadas	2026-11-14 12:39:12	2026-11-14 12:39:12
13	8	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
14	8	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
15	8	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
16	8	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
17	9	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
18	9	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
19	9	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
20	10	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
21	10	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
22	10	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
23	11	Posição	Original	2026-11-14 12:39:12	2026-11-14 12:39:12
24	11	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
25	11	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
26	12	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
27	12	Material	Ferro Fundido	2026-11-14 12:39:12	2026-11-14 12:39:12
28	12	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
29	13	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
30	13	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
31	13	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
32	13	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
33	14	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
34	14	Material	Papel	2026-11-14 12:39:12	2026-11-14 12:39:12
35	14	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
36	15	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
37	15	Material	Papel	2026-11-14 12:39:12	2026-11-14 12:39:12
38	15	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
39	16	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
40	16	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
41	16	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
42	17	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
43	17	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
44	17	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
45	18	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
46	18	Material	Cobre	2026-11-14 12:39:12	2026-11-14 12:39:12
47	18	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
48	19	Posição	Original	2026-11-14 12:39:12	2026-11-14 12:39:12
49	19	Material	Plástico	2026-11-14 12:39:12	2026-11-14 12:39:12
50	19	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
51	20	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
52	20	Material	Plástico	2026-11-14 12:39:12	2026-11-14 12:39:12
53	20	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
54	21	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
55	21	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
56	21	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
57	21	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
58	22	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
59	22	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
60	22	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
61	23	Posição	Original	2026-11-14 12:39:12	2026-11-14 12:39:12
62	23	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
63	23	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
64	24	Posição	Original	2026-11-14 12:39:12	2026-11-14 12:39:12
65	24	Material	Plástico	2026-11-14 12:39:12	2026-11-14 12:39:12
66	24	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
67	24	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
68	25	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
69	25	Material	Plástico	2026-11-14 12:39:12	2026-11-14 12:39:12
70	25	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
71	26	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
72	26	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
73	26	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
74	26	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
75	27	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
76	27	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
77	27	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
78	28	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
79	28	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
80	28	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
81	28	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
82	29	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
83	29	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
84	29	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
85	30	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
86	30	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
87	30	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
88	30	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
89	31	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
90	31	Material	Cerâmica	2026-11-14 12:39:12	2026-11-14 12:39:12
91	31	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
92	32	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
93	32	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
94	32	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
95	33	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
96	33	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
97	33	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
98	34	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
99	34	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
100	35	Posição	Original	2026-11-14 12:39:12	2026-11-14 12:39:12
101	35	Material	Plástico	2026-11-14 12:39:12	2026-11-14 12:39:12
102	35	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
103	36	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
104	36	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
105	36	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
106	37	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
107	37	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
108	37	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
109	38	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
110	38	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
111	38	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
112	38	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
113	39	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
114	39	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
115	39	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
116	40	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
117	40	Material	Ferro Fundido	2026-11-14 12:39:12	2026-11-14 12:39:12
118	40	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
119	41	Material	Nylon	2026-11-14 12:39:12	2026-11-14 12:39:12
120	41	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
121	41	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
122	42	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
123	42	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
124	42	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
125	43	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
126	43	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
127	43	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
128	44	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
129	44	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
130	44	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
131	45	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
132	45	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
133	45	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
134	46	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
135	46	Material	Cerâmica	2026-11-14 12:39:12	2026-11-14 12:39:12
136	46	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
137	47	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
138	47	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
139	47	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
140	48	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
141	48	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
142	48	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
143	49	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
144	49	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
145	49	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
146	50	Material	Cobre	2026-11-14 12:39:12	2026-11-14 12:39:12
147	50	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
148	50	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
149	51	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
150	51	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
151	52	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
152	52	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
153	52	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
154	52	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
155	53	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
156	53	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
157	53	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
158	54	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
159	54	Material	Plástico	2026-11-14 12:39:12	2026-11-14 12:39:12
160	54	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
161	54	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
162	55	Posição	Lado Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
163	55	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
164	55	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
165	56	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
166	56	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
167	56	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
168	57	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
169	57	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
170	58	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
171	58	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
172	58	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
173	59	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
174	59	Material	Cerâmica	2026-11-14 12:39:12	2026-11-14 12:39:12
175	59	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
176	60	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
177	60	Material	Cerâmica	2026-11-14 12:39:12	2026-11-14 12:39:12
178	60	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
179	61	Posição	Original	2026-11-14 12:39:12	2026-11-14 12:39:12
180	61	Material	Cerâmica	2026-11-14 12:39:12	2026-11-14 12:39:12
181	61	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
182	62	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
183	62	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
184	63	Posição	Lado Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
185	63	Material	Cobre	2026-11-14 12:39:12	2026-11-14 12:39:12
186	63	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
187	64	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
188	64	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
189	64	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
190	65	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
191	65	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
192	65	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
193	66	Posição	Lado Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
194	66	Material	Plástico	2026-11-14 12:39:12	2026-11-14 12:39:12
195	66	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
196	67	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
197	67	Material	Ferro Fundido	2026-11-14 12:39:12	2026-11-14 12:39:12
198	67	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
199	68	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
200	68	Material	Ferro Fundido	2026-11-14 12:39:12	2026-11-14 12:39:12
201	68	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
202	69	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
203	69	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
204	69	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
205	70	Posição	Lado Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
206	70	Material	Nylon	2026-11-14 12:39:12	2026-11-14 12:39:12
207	70	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
208	70	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
209	71	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
210	71	Material	Nylon	2026-11-14 12:39:12	2026-11-14 12:39:12
211	71	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
212	72	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
213	72	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
214	72	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
215	73	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
216	73	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
217	73	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
218	74	Posição	Lado Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
219	74	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
220	74	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
221	75	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
222	75	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
223	75	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
224	76	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
225	76	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
226	76	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
227	77	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
228	77	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
229	77	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
230	78	Posição	Lado Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
231	78	Material	Cerâmica	2026-11-14 12:39:12	2026-11-14 12:39:12
232	78	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
233	79	Posição	Original	2026-11-14 12:39:12	2026-11-14 12:39:12
234	79	Material	Cerâmica	2026-11-14 12:39:12	2026-11-14 12:39:12
235	79	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
236	80	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
237	80	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
238	80	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
239	81	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
240	81	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
241	81	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
242	82	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
243	82	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
244	82	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
245	83	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
246	83	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
247	84	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
248	84	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
249	84	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
250	85	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
251	85	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
252	85	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
253	86	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
254	86	Material	Plástico	2026-11-14 12:39:12	2026-11-14 12:39:12
255	86	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
256	87	Posição	Lado Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
257	87	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
258	87	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
259	88	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
260	88	Material	Ferro Fundido	2026-11-14 12:39:12	2026-11-14 12:39:12
261	88	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
262	89	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
263	89	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
264	89	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
265	89	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
266	90	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
267	90	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
268	90	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
269	91	Posição	Original	2026-11-14 12:39:12	2026-11-14 12:39:12
270	91	Material	Nylon	2026-11-14 12:39:12	2026-11-14 12:39:12
271	91	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
272	92	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
273	92	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
274	92	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
275	93	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
276	93	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
277	93	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
278	94	Posição	Lado Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
279	94	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
280	94	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
281	95	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
282	95	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
283	95	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
284	96	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
285	96	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
286	96	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
287	97	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
288	97	Material	Ferro Fundido	2026-11-14 12:39:12	2026-11-14 12:39:12
289	97	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
290	97	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
291	98	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
292	98	Material	Cerâmica	2026-11-14 12:39:12	2026-11-14 12:39:12
293	98	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
294	99	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
295	99	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
296	99	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
297	100	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
298	100	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
299	100	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
300	101	Material	Chumbo	2026-11-14 12:39:12	2026-11-14 12:39:12
301	101	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
302	101	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
303	102	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
304	102	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
305	102	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
306	103	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
307	103	Material	Plástico	2026-11-14 12:39:12	2026-11-14 12:39:12
308	103	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
309	104	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
310	104	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
311	104	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
312	105	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
313	105	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
314	105	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
315	106	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
316	106	Material	Ferro Fundido	2026-11-14 12:39:12	2026-11-14 12:39:12
317	106	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
318	107	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
319	107	Material	Ferro Fundido	2026-11-14 12:39:12	2026-11-14 12:39:12
320	107	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
321	108	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
322	108	Material	Plástico	2026-11-14 12:39:12	2026-11-14 12:39:12
323	108	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
324	108	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
325	109	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
326	109	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
327	109	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
328	110	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
329	110	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
330	111	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
331	111	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
332	111	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
333	112	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
334	112	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
335	112	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
336	113	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
337	113	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
338	113	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
339	114	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
340	114	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
341	114	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
342	115	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
343	115	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
344	115	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
345	115	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
346	116	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
347	116	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
348	116	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
349	117	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
350	117	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
351	117	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
352	118	Posição	Lado Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
353	118	Material	Cobre	2026-11-14 12:39:12	2026-11-14 12:39:12
354	118	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
355	119	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
356	119	Material	Cobre	2026-11-14 12:39:12	2026-11-14 12:39:12
357	119	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
358	120	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
359	120	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
360	120	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
361	121	Posição	Lado Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
362	121	Material	Plástico	2026-11-14 12:39:12	2026-11-14 12:39:12
363	121	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
364	122	Posição	Lado Direito	2026-11-14 12:39:12	2026-11-14 12:39:12
365	122	Material	Ferro Fundido	2026-11-14 12:39:12	2026-11-14 12:39:12
366	122	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
367	123	Posição	Original	2026-11-14 12:39:12	2026-11-14 12:39:12
368	123	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
369	123	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
370	124	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
371	124	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
372	124	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
373	125	Material	Nylon	2026-11-14 12:39:12	2026-11-14 12:39:12
374	125	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
375	125	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
376	126	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
377	126	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
378	126	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
379	126	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
380	127	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
381	127	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
382	127	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
383	128	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
384	128	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
385	128	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
386	128	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
387	129	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
388	129	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
389	129	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
390	130	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
391	130	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
392	130	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
393	131	Posição	Dianteiro	2026-11-14 12:39:12	2026-11-14 12:39:12
394	131	Material	Ferro Fundido	2026-11-14 12:39:12	2026-11-14 12:39:12
395	131	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
396	132	Posição	Lado Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
397	132	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
398	132	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
399	133	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
400	133	Material	Cerâmica	2026-11-14 12:39:12	2026-11-14 12:39:12
401	133	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
402	134	Posição	Lado Esquerdo	2026-11-14 12:39:12	2026-11-14 12:39:12
403	134	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
404	134	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
405	135	Posição	HD	2026-11-14 12:39:12	2026-11-14 12:39:12
406	135	Material	Papel	2026-11-14 12:39:12	2026-11-14 12:39:12
407	135	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
408	136	Material	Chumbo	2026-11-14 12:39:12	2026-11-14 12:39:12
409	136	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
410	136	Origem	Importado	2026-11-14 12:39:12	2026-11-14 12:39:12
411	137	Posição	Reforçado	2026-11-14 12:39:12	2026-11-14 12:39:12
412	137	Material	Plástico	2026-11-14 12:39:12	2026-11-14 12:39:12
413	137	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
414	137	Origem	Nacional	2026-11-14 12:39:12	2026-11-14 12:39:12
415	138	Posição	Esportivo	2026-11-14 12:39:12	2026-11-14 12:39:12
416	138	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
417	138	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
418	139	Material	Ferro Fundido	2026-11-14 12:39:12	2026-11-14 12:39:12
419	139	Garantia	6 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
420	140	Posição	Traseiro	2026-11-14 12:39:12	2026-11-14 12:39:12
421	140	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
422	140	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
423	141	Posição	Original	2026-11-14 12:39:12	2026-11-14 12:39:12
424	141	Material	Borracha	2026-11-14 12:39:12	2026-11-14 12:39:12
425	141	Garantia	24 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
426	142	Material	Aço	2026-11-14 12:39:12	2026-11-14 12:39:12
427	142	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
428	143	Posição	Original	2026-11-14 12:39:12	2026-11-14 12:39:12
429	143	Material	Alumínio	2026-11-14 12:39:12	2026-11-14 12:39:12
430	143	Garantia	12 meses	2026-11-14 12:39:12	2026-11-14 12:39:12
431	143	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
432	144	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
433	144	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
434	144	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
435	145	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
436	145	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
437	145	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
438	146	Material	Cerâmica	2026-11-14 12:39:13	2026-11-14 12:39:13
439	146	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
440	147	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
441	147	Material	Papel	2026-11-14 12:39:13	2026-11-14 12:39:13
442	147	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
443	148	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
444	148	Material	Papel	2026-11-14 12:39:13	2026-11-14 12:39:13
445	148	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
446	149	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
447	149	Material	Papel	2026-11-14 12:39:13	2026-11-14 12:39:13
448	149	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
449	150	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
450	150	Material	Cobre	2026-11-14 12:39:13	2026-11-14 12:39:13
451	150	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
452	151	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
453	151	Material	Cobre	2026-11-14 12:39:13	2026-11-14 12:39:13
454	151	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
455	152	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
456	152	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
457	153	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
458	153	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
459	153	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
460	153	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
461	154	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
462	154	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
463	154	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
464	155	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
465	155	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
466	155	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
467	156	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
468	156	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
469	156	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
470	157	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
471	157	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
472	157	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
473	158	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
474	158	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
475	158	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
476	159	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
477	159	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
478	159	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
479	159	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
480	160	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
481	160	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
482	160	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
483	161	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
484	161	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
485	161	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
486	162	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
487	162	Material	Cerâmica	2026-11-14 12:39:13	2026-11-14 12:39:13
488	162	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
489	163	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
490	163	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
491	163	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
492	164	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
493	164	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
494	164	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
495	165	Material	Cobre	2026-11-14 12:39:13	2026-11-14 12:39:13
496	165	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
497	166	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
498	166	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
499	166	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
500	167	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
501	167	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
502	167	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
503	168	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
504	168	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
505	168	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
506	169	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
507	169	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
508	169	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
509	170	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
510	170	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
511	170	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
512	170	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
513	171	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
514	171	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
515	171	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
516	172	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
517	172	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
518	172	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
519	173	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
520	173	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
521	173	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
522	174	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
523	174	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
524	174	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
525	175	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
526	175	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
527	175	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
528	176	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
529	176	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
530	177	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
531	177	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
532	177	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
533	177	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
534	178	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
535	178	Material	Cerâmica	2026-11-14 12:39:13	2026-11-14 12:39:13
536	178	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
537	179	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
538	179	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
539	179	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
540	180	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
541	180	Material	Papel	2026-11-14 12:39:13	2026-11-14 12:39:13
542	180	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
543	181	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
544	181	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
545	181	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
546	182	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
547	182	Material	Chumbo	2026-11-14 12:39:13	2026-11-14 12:39:13
548	182	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
549	182	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
550	183	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
551	183	Material	Cobre	2026-11-14 12:39:13	2026-11-14 12:39:13
552	183	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
553	184	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
554	184	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
555	184	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
556	184	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
557	185	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
558	185	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
559	185	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
560	186	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
561	186	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
562	186	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
563	187	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
564	187	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
565	187	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
566	188	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
567	188	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
568	188	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
569	189	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
570	189	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
571	189	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
572	190	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
573	190	Material	Nylon	2026-11-14 12:39:13	2026-11-14 12:39:13
574	190	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
575	191	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
576	191	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
577	191	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
578	192	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
579	192	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
580	192	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
581	193	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
582	193	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
583	193	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
584	194	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
585	194	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
586	195	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
587	195	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
588	195	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
589	196	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
590	196	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
591	196	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
592	197	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
593	197	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
594	198	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
595	198	Material	Cobre	2026-11-14 12:39:13	2026-11-14 12:39:13
596	198	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
597	199	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
598	199	Material	Chumbo	2026-11-14 12:39:13	2026-11-14 12:39:13
599	199	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
600	200	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
601	200	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
602	201	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
603	201	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
604	201	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
605	201	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
606	202	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
607	202	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
608	202	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
609	203	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
610	203	Material	Nylon	2026-11-14 12:39:13	2026-11-14 12:39:13
611	203	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
612	203	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
613	204	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
614	204	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
615	204	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
616	205	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
617	205	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
618	205	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
619	206	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
620	206	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
621	206	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
622	207	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
623	207	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
624	207	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
625	208	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
626	208	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
627	208	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
628	209	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
629	209	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
630	209	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
631	209	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
632	210	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
633	210	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
634	210	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
635	211	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
636	211	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
637	212	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
638	212	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
639	212	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
640	213	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
641	213	Material	Papel	2026-11-14 12:39:13	2026-11-14 12:39:13
642	213	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
643	214	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
644	214	Material	Chumbo	2026-11-14 12:39:13	2026-11-14 12:39:13
645	214	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
646	215	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
647	215	Material	Chumbo	2026-11-14 12:39:13	2026-11-14 12:39:13
648	215	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
649	216	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
650	216	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
651	216	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
652	217	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
653	217	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
654	217	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
655	218	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
656	218	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
657	218	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
658	219	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
659	219	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
660	220	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
661	220	Material	Nylon	2026-11-14 12:39:13	2026-11-14 12:39:13
662	220	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
663	221	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
664	221	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
665	221	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
666	222	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
667	222	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
668	222	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
669	223	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
670	223	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
671	223	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
672	224	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
673	224	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
674	224	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
675	225	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
676	225	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
677	225	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
678	226	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
679	226	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
680	226	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
681	226	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
682	227	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
683	227	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
684	227	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
685	228	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
686	228	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
687	228	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
688	229	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
689	229	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
690	229	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
691	230	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
692	230	Material	Cerâmica	2026-11-14 12:39:13	2026-11-14 12:39:13
693	230	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
694	231	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
695	231	Material	Cerâmica	2026-11-14 12:39:13	2026-11-14 12:39:13
696	231	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
697	232	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
698	232	Material	Papel	2026-11-14 12:39:13	2026-11-14 12:39:13
699	232	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
700	232	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
701	233	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
702	233	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
703	233	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
704	234	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
705	234	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
706	234	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
707	235	Material	Cobre	2026-11-14 12:39:13	2026-11-14 12:39:13
708	235	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
709	235	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
710	236	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
711	236	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
712	236	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
713	237	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
714	237	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
715	238	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
716	238	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
717	238	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
718	239	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
719	239	Material	Nylon	2026-11-14 12:39:13	2026-11-14 12:39:13
720	239	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
721	240	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
722	240	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
723	241	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
724	241	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
725	241	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
726	241	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
727	242	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
728	242	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
729	242	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
730	243	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
731	243	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
732	243	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
733	244	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
734	244	Material	Cerâmica	2026-11-14 12:39:13	2026-11-14 12:39:13
735	244	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
736	245	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
737	245	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
738	245	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
739	246	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
740	246	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
741	246	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
742	247	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
743	247	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
744	247	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
745	248	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
746	248	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
747	249	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
748	249	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
749	250	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
750	250	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
751	250	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
752	251	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
753	251	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
754	251	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
755	252	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
756	252	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
757	252	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
758	253	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
759	253	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
760	253	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
761	254	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
762	254	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
763	254	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
764	255	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
765	255	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
766	255	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
767	255	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
768	256	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
769	256	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
770	256	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
771	257	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
772	257	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
773	257	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
774	258	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
775	258	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
776	258	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
777	259	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
778	259	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
779	259	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
780	260	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
781	260	Material	Chumbo	2026-11-14 12:39:13	2026-11-14 12:39:13
782	260	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
783	261	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
784	261	Material	Cobre	2026-11-14 12:39:13	2026-11-14 12:39:13
785	261	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
786	262	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
787	262	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
788	262	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
789	263	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
790	263	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
791	263	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
792	264	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
793	264	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
794	264	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
795	265	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
796	265	Material	Nylon	2026-11-14 12:39:13	2026-11-14 12:39:13
797	265	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
798	265	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
799	266	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
800	266	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
801	266	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
802	267	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
803	267	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
804	268	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
805	268	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
806	268	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
807	268	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
808	269	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
809	269	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
810	269	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
811	270	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
812	270	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
813	270	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
814	271	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
815	271	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
816	271	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
817	272	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
818	272	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
819	272	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
820	273	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
821	273	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
822	273	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
823	274	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
824	274	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
825	274	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
826	275	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
827	275	Material	Chumbo	2026-11-14 12:39:13	2026-11-14 12:39:13
828	275	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
829	275	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
830	276	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
831	276	Material	Chumbo	2026-11-14 12:39:13	2026-11-14 12:39:13
832	276	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
833	277	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
834	277	Material	Cobre	2026-11-14 12:39:13	2026-11-14 12:39:13
835	277	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
836	278	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
837	278	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
838	278	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
839	279	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
840	279	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
841	279	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
842	280	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
843	280	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
844	281	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
845	281	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
846	281	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
847	282	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
848	282	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
849	282	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
850	283	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
851	283	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
852	283	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
853	284	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
854	284	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
855	284	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
856	285	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
857	285	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
858	285	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
859	286	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
860	286	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
861	286	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
862	287	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
863	287	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
864	287	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
865	288	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
866	288	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
867	288	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
868	289	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
869	289	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
870	289	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
871	290	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
872	290	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
873	290	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
874	291	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
875	291	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
876	292	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
877	292	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
878	292	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
879	292	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
880	293	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
881	293	Material	Cobre	2026-11-14 12:39:13	2026-11-14 12:39:13
882	293	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
883	294	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
884	294	Material	Chumbo	2026-11-14 12:39:13	2026-11-14 12:39:13
885	294	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
886	295	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
887	295	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
888	296	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
889	296	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
890	296	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
891	296	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
892	297	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
893	297	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
894	297	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
895	298	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
896	298	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
897	298	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
898	299	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
899	299	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
900	299	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
901	300	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
902	300	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
903	300	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
904	301	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
905	301	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
906	301	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
907	302	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
908	302	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
909	303	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
910	303	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
911	304	Material	Cerâmica	2026-11-14 12:39:13	2026-11-14 12:39:13
912	304	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
913	305	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
914	305	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
915	305	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
916	305	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
917	306	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
918	306	Material	Papel	2026-11-14 12:39:13	2026-11-14 12:39:13
919	306	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
920	307	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
921	307	Material	Papel	2026-11-14 12:39:13	2026-11-14 12:39:13
922	307	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
923	308	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
924	308	Material	Chumbo	2026-11-14 12:39:13	2026-11-14 12:39:13
925	308	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
926	308	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
927	309	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
928	309	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
929	309	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
930	310	Posição	Traseiro	2026-11-14 12:39:13	2026-11-14 12:39:13
931	310	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
932	310	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
933	311	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
934	311	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
935	311	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
936	312	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
937	312	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
938	312	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
939	313	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
940	313	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
941	313	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
942	314	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
943	314	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
944	314	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
945	315	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
946	315	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
947	315	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
948	316	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
949	316	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
950	316	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
951	317	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
952	317	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
953	318	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
954	318	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
955	318	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
956	318	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
957	319	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
958	319	Material	Cerâmica	2026-11-14 12:39:13	2026-11-14 12:39:13
959	319	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
960	320	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
961	320	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
962	320	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
963	320	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
964	321	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
965	321	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
966	321	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
967	322	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
968	322	Material	Cobre	2026-11-14 12:39:13	2026-11-14 12:39:13
969	322	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
970	323	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
971	323	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
972	323	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
973	324	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
974	324	Material	Cobre	2026-11-14 12:39:13	2026-11-14 12:39:13
975	324	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
976	325	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
977	325	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
978	325	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
979	326	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
980	326	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
981	326	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
982	327	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
983	327	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
984	328	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
985	328	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
986	328	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
987	328	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
988	329	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
989	329	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
990	329	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
991	330	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
992	330	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
993	330	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
994	331	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
995	331	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
996	331	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
997	332	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
998	332	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
999	332	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1000	333	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
1001	333	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1002	334	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
1003	334	Material	Cerâmica	2026-11-14 12:39:13	2026-11-14 12:39:13
1004	334	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1005	334	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
1006	335	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
1007	335	Material	Cerâmica	2026-11-14 12:39:13	2026-11-14 12:39:13
1008	335	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1009	336	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
1010	336	Material	Cerâmica	2026-11-14 12:39:13	2026-11-14 12:39:13
1011	336	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1012	337	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
1013	337	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
1014	337	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1015	338	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
1016	338	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
1017	338	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1018	339	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
1019	339	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
1020	339	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1021	340	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
1022	340	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
1023	340	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1024	341	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
1025	341	Material	Chumbo	2026-11-14 12:39:13	2026-11-14 12:39:13
1026	341	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1027	342	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
1028	342	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1029	342	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
1030	343	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
1031	343	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1032	344	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
1033	344	Material	Nylon	2026-11-14 12:39:13	2026-11-14 12:39:13
1034	344	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1035	345	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
1036	345	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
1037	345	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1038	346	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
1039	346	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
1040	346	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1041	347	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
1042	347	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
1043	347	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1044	348	Posição	Original	2026-11-14 12:39:13	2026-11-14 12:39:13
1045	348	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
1046	348	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1047	349	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
1048	349	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1049	349	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
1050	350	Material	Aço	2026-11-14 12:39:13	2026-11-14 12:39:13
1051	350	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1052	351	Posição	Reforçado	2026-11-14 12:39:13	2026-11-14 12:39:13
1053	351	Material	Papel	2026-11-14 12:39:13	2026-11-14 12:39:13
1054	351	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1055	352	Posição	Dianteiro	2026-11-14 12:39:13	2026-11-14 12:39:13
1056	352	Material	Papel	2026-11-14 12:39:13	2026-11-14 12:39:13
1057	352	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1058	353	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
1059	353	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
1060	353	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1061	354	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
1062	354	Garantia	6 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1063	354	Origem	Nacional	2026-11-14 12:39:13	2026-11-14 12:39:13
1064	355	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
1065	355	Material	Alumínio	2026-11-14 12:39:13	2026-11-14 12:39:13
1066	355	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1067	356	Posição	Lado Esquerdo	2026-11-14 12:39:13	2026-11-14 12:39:13
1068	356	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
1069	356	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1070	357	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
1071	357	Material	Plástico	2026-11-14 12:39:13	2026-11-14 12:39:13
1072	357	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1073	358	Posição	HD	2026-11-14 12:39:13	2026-11-14 12:39:13
1074	358	Material	Ferro Fundido	2026-11-14 12:39:13	2026-11-14 12:39:13
1075	358	Garantia	12 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1076	358	Origem	Importado	2026-11-14 12:39:13	2026-11-14 12:39:13
1077	359	Posição	Lado Direito	2026-11-14 12:39:13	2026-11-14 12:39:13
1078	359	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
1079	359	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1080	360	Posição	Esportivo	2026-11-14 12:39:13	2026-11-14 12:39:13
1081	360	Material	Borracha	2026-11-14 12:39:13	2026-11-14 12:39:13
1082	360	Garantia	24 meses	2026-11-14 12:39:13	2026-11-14 12:39:13
1083	361	Material	Nylon	2026-11-14 12:39:14	2026-11-14 12:39:14
1084	361	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1085	362	Material	Borracha	2026-11-14 12:39:14	2026-11-14 12:39:14
1086	362	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1087	363	Posição	Traseiro	2026-11-14 12:39:14	2026-11-14 12:39:14
1088	363	Material	Aço	2026-11-14 12:39:14	2026-11-14 12:39:14
1089	363	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1090	363	Origem	Nacional	2026-11-14 12:39:14	2026-11-14 12:39:14
1091	364	Posição	HD	2026-11-14 12:39:14	2026-11-14 12:39:14
1092	364	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1093	364	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1094	365	Posição	Esportivo	2026-11-14 12:39:14	2026-11-14 12:39:14
1095	365	Material	Ferro Fundido	2026-11-14 12:39:14	2026-11-14 12:39:14
1096	365	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1097	366	Posição	Lado Direito	2026-11-14 12:39:14	2026-11-14 12:39:14
1098	366	Material	Cerâmica	2026-11-14 12:39:14	2026-11-14 12:39:14
1099	366	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1100	367	Posição	Lado Direito	2026-11-14 12:39:14	2026-11-14 12:39:14
1101	367	Material	Borracha	2026-11-14 12:39:14	2026-11-14 12:39:14
1102	367	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1103	368	Posição	HD	2026-11-14 12:39:14	2026-11-14 12:39:14
1104	368	Material	Papel	2026-11-14 12:39:14	2026-11-14 12:39:14
1105	368	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1106	369	Posição	Lado Esquerdo	2026-11-14 12:39:14	2026-11-14 12:39:14
1107	369	Material	Borracha	2026-11-14 12:39:14	2026-11-14 12:39:14
1108	369	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1109	370	Posição	Lado Esquerdo	2026-11-14 12:39:14	2026-11-14 12:39:14
1110	370	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1111	370	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1112	371	Posição	Dianteiro	2026-11-14 12:39:14	2026-11-14 12:39:14
1113	371	Material	Cobre	2026-11-14 12:39:14	2026-11-14 12:39:14
1114	371	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1115	372	Posição	Original	2026-11-14 12:39:14	2026-11-14 12:39:14
1116	372	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1117	372	Garantia	6 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1118	373	Posição	Esportivo	2026-11-14 12:39:14	2026-11-14 12:39:14
1119	373	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1120	373	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1121	374	Material	Ferro Fundido	2026-11-14 12:39:14	2026-11-14 12:39:14
1122	374	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1123	375	Material	Plástico	2026-11-14 12:39:14	2026-11-14 12:39:14
1124	375	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1125	375	Origem	Nacional	2026-11-14 12:39:14	2026-11-14 12:39:14
1126	376	Material	Aço	2026-11-14 12:39:14	2026-11-14 12:39:14
1127	376	Garantia	6 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1128	377	Posição	Reforçado	2026-11-14 12:39:14	2026-11-14 12:39:14
1129	377	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1130	377	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1131	378	Posição	Lado Esquerdo	2026-11-14 12:39:14	2026-11-14 12:39:14
1132	378	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1133	378	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1134	379	Posição	Lado Direito	2026-11-14 12:39:14	2026-11-14 12:39:14
1135	379	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1136	379	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1137	380	Posição	Lado Esquerdo	2026-11-14 12:39:14	2026-11-14 12:39:14
1138	380	Material	Ferro Fundido	2026-11-14 12:39:14	2026-11-14 12:39:14
1139	380	Garantia	6 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1140	381	Posição	Reforçado	2026-11-14 12:39:14	2026-11-14 12:39:14
1141	381	Material	Cerâmica	2026-11-14 12:39:14	2026-11-14 12:39:14
1142	381	Garantia	6 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1143	382	Posição	Original	2026-11-14 12:39:14	2026-11-14 12:39:14
1144	382	Material	Aço	2026-11-14 12:39:14	2026-11-14 12:39:14
1145	382	Garantia	6 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1146	382	Origem	Nacional	2026-11-14 12:39:14	2026-11-14 12:39:14
1147	383	Posição	Reforçado	2026-11-14 12:39:14	2026-11-14 12:39:14
1148	383	Material	Aço	2026-11-14 12:39:14	2026-11-14 12:39:14
1149	383	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1150	384	Posição	Esportivo	2026-11-14 12:39:14	2026-11-14 12:39:14
1151	384	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1152	384	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1153	385	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1154	385	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1155	386	Posição	Lado Direito	2026-11-14 12:39:14	2026-11-14 12:39:14
1156	386	Material	Plástico	2026-11-14 12:39:14	2026-11-14 12:39:14
1157	386	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1158	386	Origem	Nacional	2026-11-14 12:39:14	2026-11-14 12:39:14
1159	387	Posição	Traseiro	2026-11-14 12:39:14	2026-11-14 12:39:14
1160	387	Material	Plástico	2026-11-14 12:39:14	2026-11-14 12:39:14
1161	387	Garantia	6 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1162	388	Posição	Lado Esquerdo	2026-11-14 12:39:14	2026-11-14 12:39:14
1163	388	Material	Borracha	2026-11-14 12:39:14	2026-11-14 12:39:14
1164	388	Garantia	6 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1165	389	Posição	Dianteiro	2026-11-14 12:39:14	2026-11-14 12:39:14
1166	389	Material	Aço	2026-11-14 12:39:14	2026-11-14 12:39:14
1167	389	Garantia	6 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1168	390	Posição	Traseiro	2026-11-14 12:39:14	2026-11-14 12:39:14
1169	390	Material	Borracha	2026-11-14 12:39:14	2026-11-14 12:39:14
1170	390	Garantia	6 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1171	391	Posição	Dianteiro	2026-11-14 12:39:14	2026-11-14 12:39:14
1172	391	Material	Borracha	2026-11-14 12:39:14	2026-11-14 12:39:14
1173	391	Garantia	6 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1174	392	Posição	Lado Direito	2026-11-14 12:39:14	2026-11-14 12:39:14
1175	392	Material	Plástico	2026-11-14 12:39:14	2026-11-14 12:39:14
1176	392	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1177	393	Posição	Reforçado	2026-11-14 12:39:14	2026-11-14 12:39:14
1178	393	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1179	393	Garantia	6 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1180	394	Posição	Dianteiro	2026-11-14 12:39:14	2026-11-14 12:39:14
1181	394	Material	Aço	2026-11-14 12:39:14	2026-11-14 12:39:14
1182	394	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1183	395	Posição	Traseiro	2026-11-14 12:39:14	2026-11-14 12:39:14
1184	395	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1185	395	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1186	396	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1187	396	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1188	397	Material	Ferro Fundido	2026-11-14 12:39:14	2026-11-14 12:39:14
1189	397	Garantia	24 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1190	398	Posição	Lado Esquerdo	2026-11-14 12:39:14	2026-11-14 12:39:14
1191	398	Material	Papel	2026-11-14 12:39:14	2026-11-14 12:39:14
1192	398	Garantia	12 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
1193	398	Origem	Nacional	2026-11-14 12:39:14	2026-11-14 12:39:14
1194	399	Posição	Dianteiro	2026-11-14 12:39:14	2026-11-14 12:39:14
1195	399	Material	Alumínio	2026-11-14 12:39:14	2026-11-14 12:39:14
1196	399	Garantia	6 meses	2026-11-14 12:39:14	2026-11-14 12:39:14
\.


--
-- TOC entry 5232 (class 0 OID 16984)
-- Dependencies: 225
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- TOC entry 5233 (class 0 OID 16995)
-- Dependencies: 226
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- TOC entry 5250 (class 0 OID 17177)
-- Dependencies: 243
-- Data for Name: compatibilidades_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compatibilidades_produto (id, product_id, vehicle_model_id, created_at, updated_at) FROM stdin;
1	1	1	2026-11-14 12:39:12	2026-11-14 12:39:12
2	1	2	2026-11-14 12:39:12	2026-11-14 12:39:12
3	1	3	2026-11-14 12:39:12	2026-11-14 12:39:12
4	2	1	2026-11-14 12:39:12	2026-11-14 12:39:12
5	2	2	2026-11-14 12:39:12	2026-11-14 12:39:12
6	2	3	2026-11-14 12:39:12	2026-11-14 12:39:12
7	2	4	2026-11-14 12:39:12	2026-11-14 12:39:12
8	3	1	2026-11-14 12:39:12	2026-11-14 12:39:12
9	3	2	2026-11-14 12:39:12	2026-11-14 12:39:12
10	3	3	2026-11-14 12:39:12	2026-11-14 12:39:12
11	3	4	2026-11-14 12:39:12	2026-11-14 12:39:12
12	3	5	2026-11-14 12:39:12	2026-11-14 12:39:12
13	4	1	2026-11-14 12:39:12	2026-11-14 12:39:12
14	4	2	2026-11-14 12:39:12	2026-11-14 12:39:12
15	4	3	2026-11-14 12:39:12	2026-11-14 12:39:12
16	4	4	2026-11-14 12:39:12	2026-11-14 12:39:12
17	4	5	2026-11-14 12:39:12	2026-11-14 12:39:12
18	5	1	2026-11-14 12:39:12	2026-11-14 12:39:12
19	5	2	2026-11-14 12:39:12	2026-11-14 12:39:12
20	5	3	2026-11-14 12:39:12	2026-11-14 12:39:12
21	5	4	2026-11-14 12:39:12	2026-11-14 12:39:12
22	5	5	2026-11-14 12:39:12	2026-11-14 12:39:12
23	6	1	2026-11-14 12:39:12	2026-11-14 12:39:12
24	7	1	2026-11-14 12:39:12	2026-11-14 12:39:12
25	7	2	2026-11-14 12:39:12	2026-11-14 12:39:12
26	7	5	2026-11-14 12:39:12	2026-11-14 12:39:12
27	7	7	2026-11-14 12:39:12	2026-11-14 12:39:12
28	8	8	2026-11-14 12:39:12	2026-11-14 12:39:12
29	8	15	2026-11-14 12:39:12	2026-11-14 12:39:12
30	9	5	2026-11-14 12:39:12	2026-11-14 12:39:12
31	9	8	2026-11-14 12:39:12	2026-11-14 12:39:12
32	9	12	2026-11-14 12:39:12	2026-11-14 12:39:12
33	10	1	2026-11-14 12:39:12	2026-11-14 12:39:12
34	10	2	2026-11-14 12:39:12	2026-11-14 12:39:12
35	10	7	2026-11-14 12:39:12	2026-11-14 12:39:12
36	10	11	2026-11-14 12:39:12	2026-11-14 12:39:12
37	11	11	2026-11-14 12:39:12	2026-11-14 12:39:12
38	11	14	2026-11-14 12:39:12	2026-11-14 12:39:12
39	11	16	2026-11-14 12:39:12	2026-11-14 12:39:12
40	12	5	2026-11-14 12:39:12	2026-11-14 12:39:12
41	12	13	2026-11-14 12:39:12	2026-11-14 12:39:12
42	12	16	2026-11-14 12:39:12	2026-11-14 12:39:12
43	13	8	2026-11-14 12:39:12	2026-11-14 12:39:12
44	13	15	2026-11-14 12:39:12	2026-11-14 12:39:12
45	13	17	2026-11-14 12:39:12	2026-11-14 12:39:12
46	14	7	2026-11-14 12:39:12	2026-11-14 12:39:12
47	14	13	2026-11-14 12:39:12	2026-11-14 12:39:12
48	14	16	2026-11-14 12:39:12	2026-11-14 12:39:12
49	15	4	2026-11-14 12:39:12	2026-11-14 12:39:12
50	15	6	2026-11-14 12:39:12	2026-11-14 12:39:12
51	15	10	2026-11-14 12:39:12	2026-11-14 12:39:12
52	15	14	2026-11-14 12:39:12	2026-11-14 12:39:12
53	16	5	2026-11-14 12:39:12	2026-11-14 12:39:12
54	16	16	2026-11-14 12:39:12	2026-11-14 12:39:12
55	17	5	2026-11-14 12:39:12	2026-11-14 12:39:12
56	17	6	2026-11-14 12:39:12	2026-11-14 12:39:12
57	17	8	2026-11-14 12:39:12	2026-11-14 12:39:12
58	17	11	2026-11-14 12:39:12	2026-11-14 12:39:12
59	18	4	2026-11-14 12:39:12	2026-11-14 12:39:12
60	18	12	2026-11-14 12:39:12	2026-11-14 12:39:12
61	19	4	2026-11-14 12:39:12	2026-11-14 12:39:12
62	20	2	2026-11-14 12:39:12	2026-11-14 12:39:12
63	20	5	2026-11-14 12:39:12	2026-11-14 12:39:12
64	20	6	2026-11-14 12:39:12	2026-11-14 12:39:12
65	20	15	2026-11-14 12:39:12	2026-11-14 12:39:12
66	21	3	2026-11-14 12:39:12	2026-11-14 12:39:12
67	21	4	2026-11-14 12:39:12	2026-11-14 12:39:12
68	21	9	2026-11-14 12:39:12	2026-11-14 12:39:12
69	21	13	2026-11-14 12:39:12	2026-11-14 12:39:12
70	22	4	2026-11-14 12:39:12	2026-11-14 12:39:12
71	22	12	2026-11-14 12:39:12	2026-11-14 12:39:12
72	22	15	2026-11-14 12:39:12	2026-11-14 12:39:12
73	22	16	2026-11-14 12:39:12	2026-11-14 12:39:12
74	23	3	2026-11-14 12:39:12	2026-11-14 12:39:12
75	23	6	2026-11-14 12:39:12	2026-11-14 12:39:12
76	23	9	2026-11-14 12:39:12	2026-11-14 12:39:12
77	23	10	2026-11-14 12:39:12	2026-11-14 12:39:12
78	24	7	2026-11-14 12:39:12	2026-11-14 12:39:12
79	24	9	2026-11-14 12:39:12	2026-11-14 12:39:12
80	24	13	2026-11-14 12:39:12	2026-11-14 12:39:12
81	25	1	2026-11-14 12:39:12	2026-11-14 12:39:12
82	25	11	2026-11-14 12:39:12	2026-11-14 12:39:12
83	25	15	2026-11-14 12:39:12	2026-11-14 12:39:12
84	25	16	2026-11-14 12:39:12	2026-11-14 12:39:12
85	26	1	2026-11-14 12:39:12	2026-11-14 12:39:12
86	26	3	2026-11-14 12:39:12	2026-11-14 12:39:12
87	26	15	2026-11-14 12:39:12	2026-11-14 12:39:12
88	27	15	2026-11-14 12:39:12	2026-11-14 12:39:12
89	28	6	2026-11-14 12:39:12	2026-11-14 12:39:12
90	28	7	2026-11-14 12:39:12	2026-11-14 12:39:12
91	28	16	2026-11-14 12:39:12	2026-11-14 12:39:12
92	29	6	2026-11-14 12:39:12	2026-11-14 12:39:12
93	29	7	2026-11-14 12:39:12	2026-11-14 12:39:12
94	29	11	2026-11-14 12:39:12	2026-11-14 12:39:12
95	29	15	2026-11-14 12:39:12	2026-11-14 12:39:12
96	30	10	2026-11-14 12:39:12	2026-11-14 12:39:12
97	31	5	2026-11-14 12:39:12	2026-11-14 12:39:12
98	31	6	2026-11-14 12:39:12	2026-11-14 12:39:12
99	31	8	2026-11-14 12:39:12	2026-11-14 12:39:12
100	31	16	2026-11-14 12:39:12	2026-11-14 12:39:12
101	32	3	2026-11-14 12:39:12	2026-11-14 12:39:12
102	32	8	2026-11-14 12:39:12	2026-11-14 12:39:12
103	32	11	2026-11-14 12:39:12	2026-11-14 12:39:12
104	32	13	2026-11-14 12:39:12	2026-11-14 12:39:12
105	33	2	2026-11-14 12:39:12	2026-11-14 12:39:12
106	33	6	2026-11-14 12:39:12	2026-11-14 12:39:12
107	33	9	2026-11-14 12:39:12	2026-11-14 12:39:12
108	34	5	2026-11-14 12:39:12	2026-11-14 12:39:12
109	34	7	2026-11-14 12:39:12	2026-11-14 12:39:12
110	34	14	2026-11-14 12:39:12	2026-11-14 12:39:12
111	35	7	2026-11-14 12:39:12	2026-11-14 12:39:12
112	35	10	2026-11-14 12:39:12	2026-11-14 12:39:12
113	35	13	2026-11-14 12:39:12	2026-11-14 12:39:12
114	36	15	2026-11-14 12:39:12	2026-11-14 12:39:12
115	37	5	2026-11-14 12:39:12	2026-11-14 12:39:12
116	37	12	2026-11-14 12:39:12	2026-11-14 12:39:12
117	37	16	2026-11-14 12:39:12	2026-11-14 12:39:12
118	38	8	2026-11-14 12:39:12	2026-11-14 12:39:12
119	38	15	2026-11-14 12:39:12	2026-11-14 12:39:12
120	39	6	2026-11-14 12:39:12	2026-11-14 12:39:12
121	39	11	2026-11-14 12:39:12	2026-11-14 12:39:12
122	39	16	2026-11-14 12:39:12	2026-11-14 12:39:12
123	40	1	2026-11-14 12:39:12	2026-11-14 12:39:12
124	40	15	2026-11-14 12:39:12	2026-11-14 12:39:12
125	41	4	2026-11-14 12:39:12	2026-11-14 12:39:12
126	41	5	2026-11-14 12:39:12	2026-11-14 12:39:12
127	41	16	2026-11-14 12:39:12	2026-11-14 12:39:12
128	42	1	2026-11-14 12:39:12	2026-11-14 12:39:12
129	42	3	2026-11-14 12:39:12	2026-11-14 12:39:12
130	42	10	2026-11-14 12:39:12	2026-11-14 12:39:12
131	42	17	2026-11-14 12:39:12	2026-11-14 12:39:12
132	43	2	2026-11-14 12:39:12	2026-11-14 12:39:12
133	43	13	2026-11-14 12:39:12	2026-11-14 12:39:12
134	44	10	2026-11-14 12:39:12	2026-11-14 12:39:12
135	44	11	2026-11-14 12:39:12	2026-11-14 12:39:12
136	44	17	2026-11-14 12:39:12	2026-11-14 12:39:12
137	45	1	2026-11-14 12:39:12	2026-11-14 12:39:12
138	45	5	2026-11-14 12:39:12	2026-11-14 12:39:12
139	45	14	2026-11-14 12:39:12	2026-11-14 12:39:12
140	45	17	2026-11-14 12:39:12	2026-11-14 12:39:12
141	46	3	2026-11-14 12:39:12	2026-11-14 12:39:12
142	46	13	2026-11-14 12:39:12	2026-11-14 12:39:12
143	46	15	2026-11-14 12:39:12	2026-11-14 12:39:12
144	46	17	2026-11-14 12:39:12	2026-11-14 12:39:12
145	47	2	2026-11-14 12:39:12	2026-11-14 12:39:12
146	47	8	2026-11-14 12:39:12	2026-11-14 12:39:12
147	47	17	2026-11-14 12:39:12	2026-11-14 12:39:12
148	48	2	2026-11-14 12:39:12	2026-11-14 12:39:12
149	48	3	2026-11-14 12:39:12	2026-11-14 12:39:12
150	48	7	2026-11-14 12:39:12	2026-11-14 12:39:12
151	48	9	2026-11-14 12:39:12	2026-11-14 12:39:12
152	49	2	2026-11-14 12:39:12	2026-11-14 12:39:12
153	49	8	2026-11-14 12:39:12	2026-11-14 12:39:12
154	49	13	2026-11-14 12:39:12	2026-11-14 12:39:12
155	49	15	2026-11-14 12:39:12	2026-11-14 12:39:12
156	50	3	2026-11-14 12:39:12	2026-11-14 12:39:12
157	50	5	2026-11-14 12:39:12	2026-11-14 12:39:12
158	50	15	2026-11-14 12:39:12	2026-11-14 12:39:12
159	51	4	2026-11-14 12:39:12	2026-11-14 12:39:12
160	51	17	2026-11-14 12:39:12	2026-11-14 12:39:12
161	52	11	2026-11-14 12:39:12	2026-11-14 12:39:12
162	53	17	2026-11-14 12:39:12	2026-11-14 12:39:12
163	54	9	2026-11-14 12:39:12	2026-11-14 12:39:12
164	54	13	2026-11-14 12:39:12	2026-11-14 12:39:12
165	54	15	2026-11-14 12:39:12	2026-11-14 12:39:12
166	55	6	2026-11-14 12:39:12	2026-11-14 12:39:12
167	55	9	2026-11-14 12:39:12	2026-11-14 12:39:12
168	55	15	2026-11-14 12:39:12	2026-11-14 12:39:12
169	55	16	2026-11-14 12:39:12	2026-11-14 12:39:12
170	56	2	2026-11-14 12:39:12	2026-11-14 12:39:12
171	57	11	2026-11-14 12:39:12	2026-11-14 12:39:12
172	58	2	2026-11-14 12:39:12	2026-11-14 12:39:12
173	58	3	2026-11-14 12:39:12	2026-11-14 12:39:12
174	58	11	2026-11-14 12:39:12	2026-11-14 12:39:12
175	59	15	2026-11-14 12:39:12	2026-11-14 12:39:12
176	60	7	2026-11-14 12:39:12	2026-11-14 12:39:12
177	61	1	2026-11-14 12:39:12	2026-11-14 12:39:12
178	61	8	2026-11-14 12:39:12	2026-11-14 12:39:12
179	61	10	2026-11-14 12:39:12	2026-11-14 12:39:12
180	62	2	2026-11-14 12:39:12	2026-11-14 12:39:12
181	62	17	2026-11-14 12:39:12	2026-11-14 12:39:12
182	63	11	2026-11-14 12:39:12	2026-11-14 12:39:12
183	64	1	2026-11-14 12:39:12	2026-11-14 12:39:12
184	64	17	2026-11-14 12:39:12	2026-11-14 12:39:12
185	65	7	2026-11-14 12:39:12	2026-11-14 12:39:12
186	66	2	2026-11-14 12:39:12	2026-11-14 12:39:12
187	66	6	2026-11-14 12:39:12	2026-11-14 12:39:12
188	66	12	2026-11-14 12:39:12	2026-11-14 12:39:12
189	67	11	2026-11-14 12:39:12	2026-11-14 12:39:12
190	67	12	2026-11-14 12:39:12	2026-11-14 12:39:12
191	68	6	2026-11-14 12:39:12	2026-11-14 12:39:12
192	68	8	2026-11-14 12:39:12	2026-11-14 12:39:12
193	68	11	2026-11-14 12:39:12	2026-11-14 12:39:12
194	69	15	2026-11-14 12:39:12	2026-11-14 12:39:12
195	70	7	2026-11-14 12:39:12	2026-11-14 12:39:12
196	70	13	2026-11-14 12:39:12	2026-11-14 12:39:12
197	70	14	2026-11-14 12:39:12	2026-11-14 12:39:12
198	70	16	2026-11-14 12:39:12	2026-11-14 12:39:12
199	71	2	2026-11-14 12:39:13	2026-11-14 12:39:13
200	71	10	2026-11-14 12:39:13	2026-11-14 12:39:13
201	71	11	2026-11-14 12:39:13	2026-11-14 12:39:13
202	72	14	2026-11-14 12:39:13	2026-11-14 12:39:13
203	73	2	2026-11-14 12:39:13	2026-11-14 12:39:13
204	73	10	2026-11-14 12:39:13	2026-11-14 12:39:13
205	73	15	2026-11-14 12:39:13	2026-11-14 12:39:13
206	73	16	2026-11-14 12:39:13	2026-11-14 12:39:13
207	74	14	2026-11-14 12:39:13	2026-11-14 12:39:13
208	75	4	2026-11-14 12:39:13	2026-11-14 12:39:13
209	75	17	2026-11-14 12:39:13	2026-11-14 12:39:13
210	76	9	2026-11-14 12:39:13	2026-11-14 12:39:13
211	76	10	2026-11-14 12:39:13	2026-11-14 12:39:13
212	76	13	2026-11-14 12:39:13	2026-11-14 12:39:13
213	77	15	2026-11-14 12:39:13	2026-11-14 12:39:13
214	78	6	2026-11-14 12:39:13	2026-11-14 12:39:13
215	78	9	2026-11-14 12:39:13	2026-11-14 12:39:13
216	79	10	2026-11-14 12:39:13	2026-11-14 12:39:13
217	79	11	2026-11-14 12:39:13	2026-11-14 12:39:13
218	80	5	2026-11-14 12:39:13	2026-11-14 12:39:13
219	81	10	2026-11-14 12:39:13	2026-11-14 12:39:13
220	81	13	2026-11-14 12:39:13	2026-11-14 12:39:13
221	82	1	2026-11-14 12:39:13	2026-11-14 12:39:13
222	82	3	2026-11-14 12:39:13	2026-11-14 12:39:13
223	82	11	2026-11-14 12:39:13	2026-11-14 12:39:13
224	83	7	2026-11-14 12:39:13	2026-11-14 12:39:13
225	84	2	2026-11-14 12:39:13	2026-11-14 12:39:13
226	84	6	2026-11-14 12:39:13	2026-11-14 12:39:13
227	84	16	2026-11-14 12:39:13	2026-11-14 12:39:13
228	84	17	2026-11-14 12:39:13	2026-11-14 12:39:13
229	85	11	2026-11-14 12:39:13	2026-11-14 12:39:13
230	86	4	2026-11-14 12:39:13	2026-11-14 12:39:13
231	86	5	2026-11-14 12:39:13	2026-11-14 12:39:13
232	86	7	2026-11-14 12:39:13	2026-11-14 12:39:13
233	86	11	2026-11-14 12:39:13	2026-11-14 12:39:13
234	87	1	2026-11-14 12:39:13	2026-11-14 12:39:13
235	87	2	2026-11-14 12:39:13	2026-11-14 12:39:13
236	87	7	2026-11-14 12:39:13	2026-11-14 12:39:13
237	87	11	2026-11-14 12:39:13	2026-11-14 12:39:13
238	88	12	2026-11-14 12:39:13	2026-11-14 12:39:13
239	89	1	2026-11-14 12:39:13	2026-11-14 12:39:13
240	89	14	2026-11-14 12:39:13	2026-11-14 12:39:13
241	90	2	2026-11-14 12:39:13	2026-11-14 12:39:13
242	90	6	2026-11-14 12:39:13	2026-11-14 12:39:13
243	90	11	2026-11-14 12:39:13	2026-11-14 12:39:13
244	91	9	2026-11-14 12:39:13	2026-11-14 12:39:13
245	91	14	2026-11-14 12:39:13	2026-11-14 12:39:13
246	91	17	2026-11-14 12:39:13	2026-11-14 12:39:13
247	92	6	2026-11-14 12:39:13	2026-11-14 12:39:13
248	93	16	2026-11-14 12:39:13	2026-11-14 12:39:13
249	93	17	2026-11-14 12:39:13	2026-11-14 12:39:13
250	94	2	2026-11-14 12:39:13	2026-11-14 12:39:13
251	94	4	2026-11-14 12:39:13	2026-11-14 12:39:13
252	94	12	2026-11-14 12:39:13	2026-11-14 12:39:13
253	94	16	2026-11-14 12:39:13	2026-11-14 12:39:13
254	95	1	2026-11-14 12:39:13	2026-11-14 12:39:13
255	95	3	2026-11-14 12:39:13	2026-11-14 12:39:13
256	96	1	2026-11-14 12:39:13	2026-11-14 12:39:13
257	96	4	2026-11-14 12:39:13	2026-11-14 12:39:13
258	96	7	2026-11-14 12:39:13	2026-11-14 12:39:13
259	96	13	2026-11-14 12:39:13	2026-11-14 12:39:13
260	97	7	2026-11-14 12:39:13	2026-11-14 12:39:13
261	97	10	2026-11-14 12:39:13	2026-11-14 12:39:13
262	97	11	2026-11-14 12:39:13	2026-11-14 12:39:13
263	98	1	2026-11-14 12:39:13	2026-11-14 12:39:13
264	98	5	2026-11-14 12:39:13	2026-11-14 12:39:13
265	98	10	2026-11-14 12:39:13	2026-11-14 12:39:13
266	98	12	2026-11-14 12:39:13	2026-11-14 12:39:13
267	99	15	2026-11-14 12:39:13	2026-11-14 12:39:13
268	100	6	2026-11-14 12:39:13	2026-11-14 12:39:13
269	101	2	2026-11-14 12:39:13	2026-11-14 12:39:13
270	101	11	2026-11-14 12:39:13	2026-11-14 12:39:13
271	101	12	2026-11-14 12:39:13	2026-11-14 12:39:13
272	101	15	2026-11-14 12:39:13	2026-11-14 12:39:13
273	102	3	2026-11-14 12:39:13	2026-11-14 12:39:13
274	102	14	2026-11-14 12:39:13	2026-11-14 12:39:13
275	103	3	2026-11-14 12:39:13	2026-11-14 12:39:13
276	103	4	2026-11-14 12:39:13	2026-11-14 12:39:13
277	103	6	2026-11-14 12:39:13	2026-11-14 12:39:13
278	103	11	2026-11-14 12:39:13	2026-11-14 12:39:13
279	104	8	2026-11-14 12:39:13	2026-11-14 12:39:13
280	105	1	2026-11-14 12:39:13	2026-11-14 12:39:13
281	105	6	2026-11-14 12:39:13	2026-11-14 12:39:13
282	105	8	2026-11-14 12:39:13	2026-11-14 12:39:13
283	105	10	2026-11-14 12:39:13	2026-11-14 12:39:13
284	106	1	2026-11-14 12:39:13	2026-11-14 12:39:13
285	106	6	2026-11-14 12:39:13	2026-11-14 12:39:13
286	106	8	2026-11-14 12:39:13	2026-11-14 12:39:13
287	107	13	2026-11-14 12:39:13	2026-11-14 12:39:13
288	108	7	2026-11-14 12:39:13	2026-11-14 12:39:13
289	108	11	2026-11-14 12:39:13	2026-11-14 12:39:13
290	108	17	2026-11-14 12:39:13	2026-11-14 12:39:13
291	109	1	2026-11-14 12:39:13	2026-11-14 12:39:13
292	109	6	2026-11-14 12:39:13	2026-11-14 12:39:13
293	109	12	2026-11-14 12:39:13	2026-11-14 12:39:13
294	109	17	2026-11-14 12:39:13	2026-11-14 12:39:13
295	110	4	2026-11-14 12:39:13	2026-11-14 12:39:13
296	110	6	2026-11-14 12:39:13	2026-11-14 12:39:13
297	110	10	2026-11-14 12:39:13	2026-11-14 12:39:13
298	110	16	2026-11-14 12:39:13	2026-11-14 12:39:13
299	111	2	2026-11-14 12:39:13	2026-11-14 12:39:13
300	111	3	2026-11-14 12:39:13	2026-11-14 12:39:13
301	112	7	2026-11-14 12:39:13	2026-11-14 12:39:13
302	112	8	2026-11-14 12:39:13	2026-11-14 12:39:13
303	112	9	2026-11-14 12:39:13	2026-11-14 12:39:13
304	112	15	2026-11-14 12:39:13	2026-11-14 12:39:13
305	113	4	2026-11-14 12:39:13	2026-11-14 12:39:13
306	113	8	2026-11-14 12:39:13	2026-11-14 12:39:13
307	113	13	2026-11-14 12:39:13	2026-11-14 12:39:13
308	114	6	2026-11-14 12:39:13	2026-11-14 12:39:13
309	114	11	2026-11-14 12:39:13	2026-11-14 12:39:13
310	114	17	2026-11-14 12:39:13	2026-11-14 12:39:13
311	115	10	2026-11-14 12:39:13	2026-11-14 12:39:13
312	115	15	2026-11-14 12:39:13	2026-11-14 12:39:13
313	115	17	2026-11-14 12:39:13	2026-11-14 12:39:13
314	116	9	2026-11-14 12:39:13	2026-11-14 12:39:13
315	117	6	2026-11-14 12:39:13	2026-11-14 12:39:13
316	117	14	2026-11-14 12:39:13	2026-11-14 12:39:13
317	117	16	2026-11-14 12:39:13	2026-11-14 12:39:13
318	117	17	2026-11-14 12:39:13	2026-11-14 12:39:13
319	118	6	2026-11-14 12:39:13	2026-11-14 12:39:13
320	118	17	2026-11-14 12:39:13	2026-11-14 12:39:13
321	119	2	2026-11-14 12:39:13	2026-11-14 12:39:13
322	120	5	2026-11-14 12:39:13	2026-11-14 12:39:13
323	121	2	2026-11-14 12:39:13	2026-11-14 12:39:13
324	121	8	2026-11-14 12:39:13	2026-11-14 12:39:13
325	121	10	2026-11-14 12:39:13	2026-11-14 12:39:13
326	121	15	2026-11-14 12:39:13	2026-11-14 12:39:13
327	122	1	2026-11-14 12:39:13	2026-11-14 12:39:13
328	122	2	2026-11-14 12:39:13	2026-11-14 12:39:13
329	122	6	2026-11-14 12:39:13	2026-11-14 12:39:13
330	122	9	2026-11-14 12:39:13	2026-11-14 12:39:13
331	123	5	2026-11-14 12:39:13	2026-11-14 12:39:13
332	123	8	2026-11-14 12:39:13	2026-11-14 12:39:13
333	123	10	2026-11-14 12:39:13	2026-11-14 12:39:13
334	123	16	2026-11-14 12:39:13	2026-11-14 12:39:13
335	124	8	2026-11-14 12:39:13	2026-11-14 12:39:13
336	124	9	2026-11-14 12:39:13	2026-11-14 12:39:13
337	124	14	2026-11-14 12:39:13	2026-11-14 12:39:13
338	124	15	2026-11-14 12:39:13	2026-11-14 12:39:13
339	125	2	2026-11-14 12:39:13	2026-11-14 12:39:13
340	125	3	2026-11-14 12:39:13	2026-11-14 12:39:13
341	125	4	2026-11-14 12:39:13	2026-11-14 12:39:13
342	126	6	2026-11-14 12:39:13	2026-11-14 12:39:13
343	127	1	2026-11-14 12:39:13	2026-11-14 12:39:13
344	127	3	2026-11-14 12:39:13	2026-11-14 12:39:13
345	128	11	2026-11-14 12:39:13	2026-11-14 12:39:13
346	128	17	2026-11-14 12:39:13	2026-11-14 12:39:13
347	129	3	2026-11-14 12:39:13	2026-11-14 12:39:13
348	129	5	2026-11-14 12:39:13	2026-11-14 12:39:13
349	129	15	2026-11-14 12:39:13	2026-11-14 12:39:13
350	130	6	2026-11-14 12:39:13	2026-11-14 12:39:13
351	131	3	2026-11-14 12:39:13	2026-11-14 12:39:13
352	131	13	2026-11-14 12:39:13	2026-11-14 12:39:13
353	131	15	2026-11-14 12:39:13	2026-11-14 12:39:13
354	131	17	2026-11-14 12:39:13	2026-11-14 12:39:13
355	132	1	2026-11-14 12:39:13	2026-11-14 12:39:13
356	132	11	2026-11-14 12:39:13	2026-11-14 12:39:13
357	132	17	2026-11-14 12:39:13	2026-11-14 12:39:13
358	133	8	2026-11-14 12:39:13	2026-11-14 12:39:13
359	133	11	2026-11-14 12:39:13	2026-11-14 12:39:13
360	133	15	2026-11-14 12:39:13	2026-11-14 12:39:13
361	134	13	2026-11-14 12:39:13	2026-11-14 12:39:13
362	135	8	2026-11-14 12:39:13	2026-11-14 12:39:13
363	136	15	2026-11-14 12:39:13	2026-11-14 12:39:13
364	137	3	2026-11-14 12:39:13	2026-11-14 12:39:13
365	137	4	2026-11-14 12:39:13	2026-11-14 12:39:13
366	137	6	2026-11-14 12:39:13	2026-11-14 12:39:13
367	138	5	2026-11-14 12:39:13	2026-11-14 12:39:13
368	138	6	2026-11-14 12:39:13	2026-11-14 12:39:13
369	138	11	2026-11-14 12:39:13	2026-11-14 12:39:13
370	138	15	2026-11-14 12:39:13	2026-11-14 12:39:13
371	139	3	2026-11-14 12:39:13	2026-11-14 12:39:13
372	139	7	2026-11-14 12:39:13	2026-11-14 12:39:13
373	139	17	2026-11-14 12:39:13	2026-11-14 12:39:13
374	140	4	2026-11-14 12:39:13	2026-11-14 12:39:13
375	140	11	2026-11-14 12:39:13	2026-11-14 12:39:13
376	141	11	2026-11-14 12:39:13	2026-11-14 12:39:13
377	141	13	2026-11-14 12:39:13	2026-11-14 12:39:13
378	142	3	2026-11-14 12:39:13	2026-11-14 12:39:13
379	142	12	2026-11-14 12:39:13	2026-11-14 12:39:13
380	142	14	2026-11-14 12:39:13	2026-11-14 12:39:13
381	143	15	2026-11-14 12:39:13	2026-11-14 12:39:13
382	144	11	2026-11-14 12:39:13	2026-11-14 12:39:13
383	144	12	2026-11-14 12:39:13	2026-11-14 12:39:13
384	144	15	2026-11-14 12:39:13	2026-11-14 12:39:13
385	145	1	2026-11-14 12:39:13	2026-11-14 12:39:13
386	145	12	2026-11-14 12:39:13	2026-11-14 12:39:13
387	145	14	2026-11-14 12:39:13	2026-11-14 12:39:13
388	146	3	2026-11-14 12:39:13	2026-11-14 12:39:13
389	146	14	2026-11-14 12:39:13	2026-11-14 12:39:13
390	146	17	2026-11-14 12:39:13	2026-11-14 12:39:13
391	147	5	2026-11-14 12:39:13	2026-11-14 12:39:13
392	147	8	2026-11-14 12:39:13	2026-11-14 12:39:13
393	147	12	2026-11-14 12:39:13	2026-11-14 12:39:13
394	148	6	2026-11-14 12:39:13	2026-11-14 12:39:13
395	149	1	2026-11-14 12:39:13	2026-11-14 12:39:13
396	149	5	2026-11-14 12:39:13	2026-11-14 12:39:13
397	149	9	2026-11-14 12:39:13	2026-11-14 12:39:13
398	150	7	2026-11-14 12:39:13	2026-11-14 12:39:13
399	150	11	2026-11-14 12:39:13	2026-11-14 12:39:13
400	150	17	2026-11-14 12:39:13	2026-11-14 12:39:13
401	151	3	2026-11-14 12:39:13	2026-11-14 12:39:13
402	151	4	2026-11-14 12:39:13	2026-11-14 12:39:13
403	151	17	2026-11-14 12:39:13	2026-11-14 12:39:13
404	152	3	2026-11-14 12:39:13	2026-11-14 12:39:13
405	152	4	2026-11-14 12:39:13	2026-11-14 12:39:13
406	152	5	2026-11-14 12:39:13	2026-11-14 12:39:13
407	152	8	2026-11-14 12:39:13	2026-11-14 12:39:13
408	153	4	2026-11-14 12:39:13	2026-11-14 12:39:13
409	153	10	2026-11-14 12:39:13	2026-11-14 12:39:13
410	153	13	2026-11-14 12:39:13	2026-11-14 12:39:13
411	153	17	2026-11-14 12:39:13	2026-11-14 12:39:13
412	154	2	2026-11-14 12:39:13	2026-11-14 12:39:13
413	154	11	2026-11-14 12:39:13	2026-11-14 12:39:13
414	154	12	2026-11-14 12:39:13	2026-11-14 12:39:13
415	154	15	2026-11-14 12:39:13	2026-11-14 12:39:13
416	155	6	2026-11-14 12:39:13	2026-11-14 12:39:13
417	155	8	2026-11-14 12:39:13	2026-11-14 12:39:13
418	155	10	2026-11-14 12:39:13	2026-11-14 12:39:13
419	155	17	2026-11-14 12:39:13	2026-11-14 12:39:13
420	156	3	2026-11-14 12:39:13	2026-11-14 12:39:13
421	156	10	2026-11-14 12:39:13	2026-11-14 12:39:13
422	156	17	2026-11-14 12:39:13	2026-11-14 12:39:13
423	157	9	2026-11-14 12:39:13	2026-11-14 12:39:13
424	157	10	2026-11-14 12:39:13	2026-11-14 12:39:13
425	158	2	2026-11-14 12:39:13	2026-11-14 12:39:13
426	158	10	2026-11-14 12:39:13	2026-11-14 12:39:13
427	158	13	2026-11-14 12:39:13	2026-11-14 12:39:13
428	158	16	2026-11-14 12:39:13	2026-11-14 12:39:13
429	159	1	2026-11-14 12:39:13	2026-11-14 12:39:13
430	159	12	2026-11-14 12:39:13	2026-11-14 12:39:13
431	160	2	2026-11-14 12:39:13	2026-11-14 12:39:13
432	160	8	2026-11-14 12:39:13	2026-11-14 12:39:13
433	160	17	2026-11-14 12:39:13	2026-11-14 12:39:13
434	161	15	2026-11-14 12:39:13	2026-11-14 12:39:13
435	162	3	2026-11-14 12:39:13	2026-11-14 12:39:13
436	162	6	2026-11-14 12:39:13	2026-11-14 12:39:13
437	162	11	2026-11-14 12:39:13	2026-11-14 12:39:13
438	163	6	2026-11-14 12:39:13	2026-11-14 12:39:13
439	164	8	2026-11-14 12:39:13	2026-11-14 12:39:13
440	164	10	2026-11-14 12:39:13	2026-11-14 12:39:13
441	164	17	2026-11-14 12:39:13	2026-11-14 12:39:13
442	165	4	2026-11-14 12:39:13	2026-11-14 12:39:13
443	165	6	2026-11-14 12:39:13	2026-11-14 12:39:13
444	165	7	2026-11-14 12:39:13	2026-11-14 12:39:13
445	165	10	2026-11-14 12:39:13	2026-11-14 12:39:13
446	166	5	2026-11-14 12:39:13	2026-11-14 12:39:13
447	166	6	2026-11-14 12:39:13	2026-11-14 12:39:13
448	167	6	2026-11-14 12:39:13	2026-11-14 12:39:13
449	168	6	2026-11-14 12:39:13	2026-11-14 12:39:13
450	168	8	2026-11-14 12:39:13	2026-11-14 12:39:13
451	169	6	2026-11-14 12:39:13	2026-11-14 12:39:13
452	169	13	2026-11-14 12:39:13	2026-11-14 12:39:13
453	170	2	2026-11-14 12:39:13	2026-11-14 12:39:13
454	170	11	2026-11-14 12:39:13	2026-11-14 12:39:13
455	170	17	2026-11-14 12:39:13	2026-11-14 12:39:13
456	171	5	2026-11-14 12:39:13	2026-11-14 12:39:13
457	171	13	2026-11-14 12:39:13	2026-11-14 12:39:13
458	171	14	2026-11-14 12:39:13	2026-11-14 12:39:13
459	171	15	2026-11-14 12:39:13	2026-11-14 12:39:13
460	172	2	2026-11-14 12:39:13	2026-11-14 12:39:13
461	173	3	2026-11-14 12:39:13	2026-11-14 12:39:13
462	173	6	2026-11-14 12:39:13	2026-11-14 12:39:13
463	174	3	2026-11-14 12:39:13	2026-11-14 12:39:13
464	174	15	2026-11-14 12:39:13	2026-11-14 12:39:13
465	174	17	2026-11-14 12:39:13	2026-11-14 12:39:13
466	175	12	2026-11-14 12:39:13	2026-11-14 12:39:13
467	175	14	2026-11-14 12:39:13	2026-11-14 12:39:13
468	175	15	2026-11-14 12:39:13	2026-11-14 12:39:13
469	176	4	2026-11-14 12:39:13	2026-11-14 12:39:13
470	176	13	2026-11-14 12:39:13	2026-11-14 12:39:13
471	176	14	2026-11-14 12:39:13	2026-11-14 12:39:13
472	177	2	2026-11-14 12:39:13	2026-11-14 12:39:13
473	177	3	2026-11-14 12:39:13	2026-11-14 12:39:13
474	177	4	2026-11-14 12:39:13	2026-11-14 12:39:13
475	178	2	2026-11-14 12:39:13	2026-11-14 12:39:13
476	178	5	2026-11-14 12:39:13	2026-11-14 12:39:13
477	178	16	2026-11-14 12:39:13	2026-11-14 12:39:13
478	179	14	2026-11-14 12:39:13	2026-11-14 12:39:13
479	180	6	2026-11-14 12:39:13	2026-11-14 12:39:13
480	180	11	2026-11-14 12:39:13	2026-11-14 12:39:13
481	180	15	2026-11-14 12:39:13	2026-11-14 12:39:13
482	181	6	2026-11-14 12:39:14	2026-11-14 12:39:14
483	181	8	2026-11-14 12:39:14	2026-11-14 12:39:14
484	182	11	2026-11-14 12:39:14	2026-11-14 12:39:14
485	183	5	2026-11-14 12:39:14	2026-11-14 12:39:14
486	183	7	2026-11-14 12:39:14	2026-11-14 12:39:14
487	183	10	2026-11-14 12:39:14	2026-11-14 12:39:14
488	183	16	2026-11-14 12:39:14	2026-11-14 12:39:14
489	184	4	2026-11-14 12:39:14	2026-11-14 12:39:14
490	184	16	2026-11-14 12:39:14	2026-11-14 12:39:14
491	184	17	2026-11-14 12:39:14	2026-11-14 12:39:14
492	185	3	2026-11-14 12:39:14	2026-11-14 12:39:14
493	185	6	2026-11-14 12:39:14	2026-11-14 12:39:14
494	185	12	2026-11-14 12:39:14	2026-11-14 12:39:14
495	186	1	2026-11-14 12:39:14	2026-11-14 12:39:14
496	186	6	2026-11-14 12:39:14	2026-11-14 12:39:14
497	186	7	2026-11-14 12:39:14	2026-11-14 12:39:14
498	186	9	2026-11-14 12:39:14	2026-11-14 12:39:14
499	187	5	2026-11-14 12:39:14	2026-11-14 12:39:14
500	188	7	2026-11-14 12:39:14	2026-11-14 12:39:14
501	188	9	2026-11-14 12:39:14	2026-11-14 12:39:14
502	189	9	2026-11-14 12:39:14	2026-11-14 12:39:14
503	189	10	2026-11-14 12:39:14	2026-11-14 12:39:14
504	189	16	2026-11-14 12:39:14	2026-11-14 12:39:14
505	190	1	2026-11-14 12:39:14	2026-11-14 12:39:14
506	190	2	2026-11-14 12:39:14	2026-11-14 12:39:14
507	190	4	2026-11-14 12:39:14	2026-11-14 12:39:14
508	191	4	2026-11-14 12:39:14	2026-11-14 12:39:14
509	191	7	2026-11-14 12:39:14	2026-11-14 12:39:14
510	192	5	2026-11-14 12:39:14	2026-11-14 12:39:14
511	192	14	2026-11-14 12:39:14	2026-11-14 12:39:14
512	192	15	2026-11-14 12:39:14	2026-11-14 12:39:14
513	192	17	2026-11-14 12:39:14	2026-11-14 12:39:14
514	193	11	2026-11-14 12:39:14	2026-11-14 12:39:14
515	194	2	2026-11-14 12:39:14	2026-11-14 12:39:14
516	194	13	2026-11-14 12:39:14	2026-11-14 12:39:14
517	195	7	2026-11-14 12:39:14	2026-11-14 12:39:14
518	195	15	2026-11-14 12:39:14	2026-11-14 12:39:14
519	195	16	2026-11-14 12:39:14	2026-11-14 12:39:14
520	195	17	2026-11-14 12:39:14	2026-11-14 12:39:14
521	196	2	2026-11-14 12:39:14	2026-11-14 12:39:14
522	196	4	2026-11-14 12:39:14	2026-11-14 12:39:14
523	196	8	2026-11-14 12:39:14	2026-11-14 12:39:14
524	196	11	2026-11-14 12:39:14	2026-11-14 12:39:14
525	197	4	2026-11-14 12:39:14	2026-11-14 12:39:14
526	197	10	2026-11-14 12:39:14	2026-11-14 12:39:14
527	198	1	2026-11-14 12:39:14	2026-11-14 12:39:14
528	198	4	2026-11-14 12:39:14	2026-11-14 12:39:14
529	198	6	2026-11-14 12:39:14	2026-11-14 12:39:14
530	198	9	2026-11-14 12:39:14	2026-11-14 12:39:14
531	199	10	2026-11-14 12:39:14	2026-11-14 12:39:14
532	199	13	2026-11-14 12:39:14	2026-11-14 12:39:14
533	199	16	2026-11-14 12:39:14	2026-11-14 12:39:14
534	200	2	2026-11-14 12:39:14	2026-11-14 12:39:14
535	200	6	2026-11-14 12:39:14	2026-11-14 12:39:14
536	200	16	2026-11-14 12:39:14	2026-11-14 12:39:14
\.


--
-- TOC entry 5254 (class 0 OID 17236)
-- Dependencies: 247
-- Data for Name: envios_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.envios_pedido (id, order_id, seller_id, shipping_method, shipping_service_code, tracking_code, shipping_cost, status, estimated_delivery_date, payload, created_at, updated_at) FROM stdin;
1	1	3	Expresso (SEDEX)	SEDEX	\N	41.45	label_generated	2026-10-29	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":41.45,"delivery_days":3,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"70040900","items_count":2,"weight_kg":3.072}}	2026-11-14 12:39:14	2026-11-14 12:39:14
2	1	1	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"70040900","items_count":1,"weight_kg":9.704}}	2026-11-14 12:39:14	2026-11-14 12:39:14
3	2	1	Econômico (PAC)	PAC	\N	41.54	label_generated	2026-11-13	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":41.54,"delivery_days":10,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"40015010","items_count":2,"weight_kg":10.06}}	2026-11-14 12:39:14	2026-11-14 12:39:14
4	2	6	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"40015010","items_count":2,"weight_kg":3.552}}	2026-11-14 12:39:14	2026-11-14 12:39:14
5	3	4	Expresso (SEDEX)	SEDEX	\N	65.21	label_generated	2026-09-15	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":65.21,"delivery_days":5,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"74003010","items_count":1,"weight_kg":9.838}}	2026-11-14 12:39:14	2026-11-14 12:39:14
6	3	3	Econômico (PAC)	PAC	\N	31.06	label_generated	2026-09-18	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":31.06,"delivery_days":8,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"74003010","items_count":1,"weight_kg":6.238}}	2026-11-14 12:39:14	2026-11-14 12:39:14
7	4	2	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"80420000","items_count":1,"weight_kg":1.1}}	2026-11-14 12:39:14	2026-11-14 12:39:14
8	4	5	Econômico (PAC)	PAC	\N	69.76	pending	2026-09-15	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":69.76,"delivery_days":15,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"80420000","items_count":4,"weight_kg":20.792}}	2026-11-14 12:39:14	2026-11-14 12:39:14
9	5	4	Econômico (PAC)	PAC	\N	37.85	pending	2026-11-05	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":37.85,"delivery_days":9,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"40015010","items_count":2,"weight_kg":8.488}}	2026-11-14 12:39:14	2026-11-14 12:39:14
10	5	2	Econômico (PAC)	PAC	\N	34.58	pending	2026-11-04	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":34.58,"delivery_days":8,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"40015010","items_count":2,"weight_kg":7.098}}	2026-11-14 12:39:14	2026-11-14 12:39:14
11	6	2	Econômico (PAC)	PAC	\N	41.79	label_generated	2026-10-16	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":41.79,"delivery_days":10,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"01310100","items_count":2,"weight_kg":10.166}}	2026-11-14 12:39:14	2026-11-14 12:39:14
12	7	3	Expresso (SEDEX)	SEDEX	Y5883792294BR	30.74	posted	2026-10-28	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":30.74,"delivery_days":3,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"13010111","items_count":1,"weight_kg":0.95}}	2026-11-14 12:39:14	2026-11-14 12:39:14
13	8	2	Econômico (PAC)	PAC	YK844185547BR	34.42	delivered	2026-08-12	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":34.42,"delivery_days":8,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"70040900","items_count":1,"weight_kg":7.668}}	2026-11-14 12:39:14	2026-11-14 12:39:14
14	8	5	Econômico (PAC)	PAC	YK844185547BR	68.95	delivered	2026-08-21	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":68.95,"delivery_days":15,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"70040900","items_count":2,"weight_kg":21.724}}	2026-11-14 12:39:14	2026-11-14 12:39:14
15	9	4	Econômico (PAC)	PAC	6Z457926018BR	84.62	posted	2026-10-29	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":84.62,"delivery_days":19,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"50030230","items_count":2,"weight_kg":28.39}}	2026-11-14 12:39:14	2026-11-14 12:39:14
16	9	6	Econômico (PAC)	PAC	6Z457926018BR	20.42	posted	2026-10-09	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":20.42,"delivery_days":5,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"50030230","items_count":1,"weight_kg":1.71}}	2026-11-14 12:39:14	2026-11-14 12:39:14
17	10	2	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"88010400","items_count":2,"weight_kg":2.8}}	2026-11-14 12:39:14	2026-11-14 12:39:14
18	10	1	Econômico (PAC)	PAC	\N	31.07	label_generated	2026-11-25	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":31.07,"delivery_days":8,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"88010400","items_count":1,"weight_kg":6.242}}	2026-11-14 12:39:14	2026-11-14 12:39:14
19	10	6	Econômico (PAC)	PAC	\N	28.05	label_generated	2026-11-24	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.05,"delivery_days":7,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"88010400","items_count":2,"weight_kg":4.32}}	2026-11-14 12:39:14	2026-11-14 12:39:14
20	11	1	Expresso (SEDEX)	SEDEX	\N	52.02	pending	2026-09-08	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":52.02,"delivery_days":4,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"88010400","items_count":1,"weight_kg":6.44}}	2026-11-14 12:39:14	2026-11-14 12:39:14
21	11	6	Expresso (SEDEX)	SEDEX	\N	69.88	pending	2026-09-09	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":69.88,"delivery_days":5,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"88010400","items_count":1,"weight_kg":11.043}}	2026-11-14 12:39:14	2026-11-14 12:39:14
22	12	3	Expresso (SEDEX)	SEDEX	\N	77.09	pending	2026-07-29	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":77.09,"delivery_days":6,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"60060180","items_count":1,"weight_kg":12.904}}	2026-11-14 12:39:14	2026-11-14 12:39:14
23	13	5	Econômico (PAC)	PAC	\N	32.78	label_generated	2026-11-19	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":32.78,"delivery_days":8,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"13010111","items_count":1,"weight_kg":6.97}}	2026-11-14 12:39:14	2026-11-14 12:39:14
24	13	2	Econômico (PAC)	PAC	\N	33.39	label_generated	2026-11-19	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":33.39,"delivery_days":8,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"13010111","items_count":1,"weight_kg":7.231}}	2026-11-14 12:39:14	2026-11-14 12:39:14
25	14	8	Econômico (PAC)	PAC	\N	28.29	pending	2026-10-26	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.29,"delivery_days":7,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"40015010","items_count":1,"weight_kg":5.058}}	2026-11-14 12:39:14	2026-11-14 12:39:14
26	14	4	Expresso (SEDEX)	SEDEX	\N	76.30	pending	2026-10-23	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":76.3,"delivery_days":6,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"40015010","items_count":2,"weight_kg":12.06}}	2026-11-14 12:39:14	2026-11-14 12:39:14
27	14	3	Expresso (SEDEX)	SEDEX	\N	64.81	pending	2026-10-22	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":64.81,"delivery_days":5,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"40015010","items_count":1,"weight_kg":9.738}}	2026-11-14 12:39:14	2026-11-14 12:39:14
28	15	5	Econômico (PAC)	PAC	\N	32.40	pending	2026-07-29	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":32.4,"delivery_days":8,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"90010150","items_count":1,"weight_kg":6.808}}	2026-11-14 12:39:14	2026-11-14 12:39:14
29	15	6	Expresso (SEDEX)	SEDEX	\N	44.39	pending	2026-07-23	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":44.39,"delivery_days":4,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"90010150","items_count":1,"weight_kg":4.469}}	2026-11-14 12:39:14	2026-11-14 12:39:14
30	16	4	Retirar no lojista	PICKUP	\N	0.00	cancelled	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"90010150","items_count":2,"weight_kg":4.68}}	2026-11-14 12:39:14	2026-11-14 12:39:14
31	17	5	Retirar no lojista	PICKUP	MG506861688BR	0.00	delivered	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"01310100","items_count":3,"weight_kg":29.483}}	2026-11-14 12:39:14	2026-11-14 12:39:14
32	17	7	Expresso (SEDEX)	SEDEX	MG506861688BR	53.54	delivered	2026-07-23	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":53.54,"delivery_days":4,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"01310100","items_count":2,"weight_kg":6.192}}	2026-11-14 12:39:14	2026-11-14 12:39:14
33	18	8	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"20040020","items_count":2,"weight_kg":12.54}}	2026-11-14 12:39:14	2026-11-14 12:39:14
34	19	6	Econômico (PAC)	PAC	\N	28.99	pending	2026-09-08	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.99,"delivery_days":7,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"40015010","items_count":2,"weight_kg":4.718}}	2026-11-14 12:39:14	2026-11-14 12:39:14
35	19	4	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"40015010","items_count":2,"weight_kg":10.642}}	2026-11-14 12:39:14	2026-11-14 12:39:14
36	20	4	Econômico (PAC)	PAC	\N	33.32	label_generated	2026-07-31	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":33.32,"delivery_days":8,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"80420000","items_count":2,"weight_kg":6.562}}	2026-11-14 12:39:14	2026-11-14 12:39:14
37	20	5	Econômico (PAC)	PAC	\N	25.35	label_generated	2026-07-29	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":25.35,"delivery_days":6,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"80420000","items_count":1,"weight_kg":3.809}}	2026-11-14 12:39:14	2026-11-14 12:39:14
38	20	2	Econômico (PAC)	PAC	\N	36.28	label_generated	2026-08-03	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":36.28,"delivery_days":9,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"80420000","items_count":1,"weight_kg":8.461}}	2026-11-14 12:39:14	2026-11-14 12:39:14
39	21	7	Expresso (SEDEX)	SEDEX	\N	34.78	pending	2026-09-10	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":34.78,"delivery_days":3,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"80420000","items_count":2,"weight_kg":1.354}}	2026-11-14 12:39:14	2026-11-14 12:39:14
40	21	2	Econômico (PAC)	PAC	\N	38.72	pending	2026-09-18	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":38.72,"delivery_days":9,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"80420000","items_count":1,"weight_kg":9.496}}	2026-11-14 12:39:14	2026-11-14 12:39:14
41	21	4	Econômico (PAC)	PAC	\N	20.51	pending	2026-09-14	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":20.51,"delivery_days":5,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"80420000","items_count":1,"weight_kg":1.748}}	2026-11-14 12:39:14	2026-11-14 12:39:14
42	22	8	Retirar no lojista	PICKUP	H2164634495BR	0.00	delivered	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"30130010","items_count":2,"weight_kg":13.694}}	2026-11-14 12:39:14	2026-11-14 12:39:14
43	22	2	Econômico (PAC)	PAC	H2164634495BR	55.84	delivered	2026-10-07	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":55.84,"delivery_days":13,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"30130010","items_count":2,"weight_kg":16.146}}	2026-11-14 12:39:14	2026-11-14 12:39:14
44	22	3	Econômico (PAC)	PAC	H2164634495BR	34.39	delivered	2026-09-30	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":34.39,"delivery_days":8,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"30130010","items_count":1,"weight_kg":7.657}}	2026-11-14 12:39:14	2026-11-14 12:39:14
45	23	6	Econômico (PAC)	PAC	\N	20.28	label_generated	2026-09-23	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":20.28,"delivery_days":5,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"20040020","items_count":1,"weight_kg":1.653}}	2026-11-14 12:39:14	2026-11-14 12:39:14
46	24	6	Expresso (SEDEX)	SEDEX	CD494226839BR	49.65	posted	2026-11-17	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":49.65,"delivery_days":4,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"20040020","items_count":2,"weight_kg":5.188}}	2026-11-14 12:39:14	2026-11-14 12:39:14
47	24	4	Retirar no lojista	PICKUP	CD494226839BR	0.00	posted	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"20040020","items_count":2,"weight_kg":10.642}}	2026-11-14 12:39:14	2026-11-14 12:39:14
48	25	4	Econômico (PAC)	PAC	DI083786232BR	37.85	posted	2026-11-26	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":37.85,"delivery_days":9,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"74003010","items_count":2,"weight_kg":8.488}}	2026-11-14 12:39:14	2026-11-14 12:39:14
49	26	5	Econômico (PAC)	PAC	\N	44.30	label_generated	2026-08-14	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":44.3,"delivery_days":10,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"01310100","items_count":3,"weight_kg":10.594}}	2026-11-14 12:39:14	2026-11-14 12:39:14
50	26	1	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"01310100","items_count":1,"weight_kg":9.704}}	2026-11-14 12:39:14	2026-11-14 12:39:14
51	27	4	Econômico (PAC)	PAC	\N	54.99	pending	2026-08-14	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":54.99,"delivery_days":12,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"60060180","items_count":3,"weight_kg":15.145}}	2026-11-14 12:39:14	2026-11-14 12:39:14
52	27	5	Econômico (PAC)	PAC	\N	27.40	pending	2026-08-07	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":27.4,"delivery_days":7,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"60060180","items_count":1,"weight_kg":4.68}}	2026-11-14 12:39:14	2026-11-14 12:39:14
53	28	3	Econômico (PAC)	PAC	\N	32.34	label_generated	2026-11-20	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":32.34,"delivery_days":8,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"88010400","items_count":2,"weight_kg":6.146}}	2026-11-14 12:39:14	2026-11-14 12:39:14
54	29	8	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"01310100","items_count":1,"weight_kg":6.847}}	2026-11-14 12:39:14	2026-11-14 12:39:14
55	29	5	Econômico (PAC)	PAC	\N	29.84	pending	2026-10-05	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":29.84,"delivery_days":7,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"01310100","items_count":1,"weight_kg":5.721}}	2026-11-14 12:39:14	2026-11-14 12:39:14
56	30	2	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"13010111","items_count":1,"weight_kg":7.806}}	2026-11-14 12:39:14	2026-11-14 12:39:14
57	30	8	Econômico (PAC)	PAC	\N	30.58	pending	2026-11-20	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":30.58,"delivery_days":8,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"13010111","items_count":1,"weight_kg":6.036}}	2026-11-14 12:39:14	2026-11-14 12:39:14
58	30	1	Econômico (PAC)	PAC	\N	91.19	pending	2026-12-08	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":91.19,"delivery_days":20,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"13010111","items_count":2,"weight_kg":31.186}}	2026-11-14 12:39:14	2026-11-14 12:39:14
59	31	7	Expresso (SEDEX)	SEDEX	\N	46.78	pending	2026-07-23	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":46.78,"delivery_days":4,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"40015010","items_count":2,"weight_kg":4.446}}	2026-11-14 12:39:14	2026-11-14 12:39:14
60	31	3	Econômico (PAC)	PAC	\N	47.90	pending	2026-08-03	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":47.9,"delivery_days":11,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"40015010","items_count":2,"weight_kg":12.764}}	2026-11-14 12:39:14	2026-11-14 12:39:14
61	32	3	Econômico (PAC)	PAC	SG914961991BR	26.80	delivered	2026-10-22	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":26.8,"delivery_days":7,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"74003010","items_count":1,"weight_kg":4.426}}	2026-11-14 12:39:14	2026-11-14 12:39:14
62	32	2	Econômico (PAC)	PAC	SG914961991BR	54.04	delivered	2026-10-29	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":54.04,"delivery_days":12,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"74003010","items_count":3,"weight_kg":14.739}}	2026-11-14 12:39:14	2026-11-14 12:39:14
63	33	1	Expresso (SEDEX)	SEDEX	\N	46.74	pending	2026-09-22	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":46.74,"delivery_days":4,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"90010150","items_count":2,"weight_kg":4.438}}	2026-11-14 12:39:14	2026-11-14 12:39:14
64	34	1	Expresso (SEDEX)	SEDEX	MI477891743BR	52.31	delivered	2026-07-22	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":52.31,"delivery_days":4,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"90010150","items_count":1,"weight_kg":6.512}}	2026-11-14 12:39:14	2026-11-14 12:39:14
65	35	4	Expresso (SEDEX)	SEDEX	\N	73.87	label_generated	2026-07-27	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":73.87,"delivery_days":6,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"90010150","items_count":1,"weight_kg":12.071}}	2026-11-14 12:39:14	2026-11-14 12:39:14
66	36	5	Econômico (PAC)	PAC	\N	34.22	pending	2026-09-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":34.22,"delivery_days":8,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"20040020","items_count":1,"weight_kg":7.585}}	2026-11-14 12:39:14	2026-11-14 12:39:14
67	36	1	Expresso (SEDEX)	SEDEX	\N	36.66	pending	2026-09-21	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":36.66,"delivery_days":3,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"20040020","items_count":2,"weight_kg":1.84}}	2026-11-14 12:39:14	2026-11-14 12:39:14
68	37	2	Econômico (PAC)	PAC	0T849235385BR	26.05	posted	2026-11-11	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":26.05,"delivery_days":7,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"01310100","items_count":1,"weight_kg":4.105}}	2026-11-14 12:39:14	2026-11-14 12:39:14
69	37	8	Econômico (PAC)	PAC	0T849235385BR	64.24	posted	2026-11-20	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":64.24,"delivery_days":14,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"01310100","items_count":2,"weight_kg":19.72}}	2026-11-14 12:39:14	2026-11-14 12:39:14
70	37	7	Econômico (PAC)	PAC	0T849235385BR	34.73	posted	2026-11-12	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":34.73,"delivery_days":8,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"01310100","items_count":2,"weight_kg":7.162}}	2026-11-14 12:39:14	2026-11-14 12:39:14
71	38	3	Econômico (PAC)	PAC	\N	46.72	label_generated	2026-08-07	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":46.72,"delivery_days":11,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"74003010","items_count":1,"weight_kg":12.904}}	2026-11-14 12:39:14	2026-11-14 12:39:14
72	38	7	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"74003010","items_count":2,"weight_kg":8.432}}	2026-11-14 12:39:14	2026-11-14 12:39:14
73	38	1	Econômico (PAC)	PAC	\N	31.03	label_generated	2026-08-04	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":31.03,"delivery_days":8,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"74003010","items_count":1,"weight_kg":6.227}}	2026-11-14 12:39:14	2026-11-14 12:39:14
74	39	2	Expresso (SEDEX)	SEDEX	\N	67.60	pending	2026-11-20	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":67.6,"delivery_days":5,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"80420000","items_count":1,"weight_kg":10.454}}	2026-11-14 12:39:14	2026-11-14 12:39:14
75	40	1	Expresso (SEDEX)	SEDEX	\N	51.88	pending	2026-09-21	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":51.88,"delivery_days":4,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"01310100","items_count":2,"weight_kg":5.76}}	2026-11-14 12:39:14	2026-11-14 12:39:14
76	41	3	Econômico (PAC)	PAC	\N	25.03	label_generated	2026-08-03	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":25.03,"delivery_days":6,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"13010111","items_count":2,"weight_kg":3.034}}	2026-11-14 12:39:14	2026-11-14 12:39:14
77	41	5	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"13010111","items_count":1,"weight_kg":5.343}}	2026-11-14 12:39:14	2026-11-14 12:39:14
78	41	8	Econômico (PAC)	PAC	\N	41.41	label_generated	2026-08-07	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":41.41,"delivery_days":10,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"13010111","items_count":2,"weight_kg":10.004}}	2026-11-14 12:39:14	2026-11-14 12:39:14
79	42	6	Retirar no lojista	PICKUP	D5082207622BR	0.00	posted	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"88010400","items_count":1,"weight_kg":2.359}}	2026-11-14 12:39:14	2026-11-14 12:39:14
80	43	3	Econômico (PAC)	PAC	\N	18.25	label_generated	2026-07-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":18.25,"delivery_days":5,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"80420000","items_count":1,"weight_kg":0.787}}	2026-11-14 12:39:14	2026-11-14 12:39:14
81	43	2	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"80420000","items_count":1,"weight_kg":1.229}}	2026-11-14 12:39:14	2026-11-14 12:39:14
82	44	2	Expresso (SEDEX)	SEDEX	\N	49.15	cancelled	2026-08-11	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":49.15,"delivery_days":4,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"01310100","items_count":1,"weight_kg":5.699}}	2026-11-14 12:39:14	2026-11-14 12:39:14
83	44	4	Econômico (PAC)	PAC	\N	35.34	cancelled	2026-08-18	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":35.34,"delivery_days":9,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"01310100","items_count":1,"weight_kg":8.058}}	2026-11-14 12:39:14	2026-11-14 12:39:14
84	45	2	Expresso (SEDEX)	SEDEX	\N	46.76	pending	2026-09-04	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":46.76,"delivery_days":4,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"40015010","items_count":1,"weight_kg":5.082}}	2026-11-14 12:39:14	2026-11-14 12:39:14
85	45	3	Expresso (SEDEX)	SEDEX	\N	35.57	pending	2026-09-03	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":35.57,"delivery_days":3,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"40015010","items_count":1,"weight_kg":2.194}}	2026-11-14 12:39:14	2026-11-14 12:39:14
86	46	2	Econômico (PAC)	PAC	\N	33.39	pending	2026-11-18	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":33.39,"delivery_days":8,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"88010400","items_count":1,"weight_kg":7.231}}	2026-11-14 12:39:14	2026-11-14 12:39:14
87	46	4	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"88010400","items_count":1,"weight_kg":4.355}}	2026-11-14 12:39:14	2026-11-14 12:39:14
88	47	7	Expresso (SEDEX)	SEDEX	\N	47.62	pending	2026-10-22	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":47.62,"delivery_days":4,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"30130010","items_count":1,"weight_kg":5.303}}	2026-11-14 12:39:14	2026-11-14 12:39:14
89	48	5	Expresso (SEDEX)	SEDEX	\N	52.64	cancelled	2026-11-02	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":52.64,"delivery_days":4,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"13010111","items_count":2,"weight_kg":5.956}}	2026-11-14 12:39:14	2026-11-14 12:39:14
90	49	6	Expresso (SEDEX)	SEDEX	\N	74.05	label_generated	2026-11-18	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":74.05,"delivery_days":5,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"90010150","items_count":3,"weight_kg":10.843}}	2026-11-14 12:39:14	2026-11-14 12:39:14
91	49	8	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"90010150","items_count":1,"weight_kg":0.572}}	2026-11-14 12:39:14	2026-11-14 12:39:14
92	50	1	Econômico (PAC)	PAC	ZW555969382BR	29.99	posted	2026-09-17	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":29.99,"delivery_days":7,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"13010111","items_count":2,"weight_kg":5.146}}	2026-11-14 12:39:14	2026-11-14 12:39:14
93	51	6	Expresso (SEDEX)	SEDEX	RB381375748BR	101.05	delivered	2026-09-04	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":101.05,"delivery_days":7,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"80420000","items_count":4,"weight_kg":17.166}}	2026-11-14 12:39:14	2026-11-14 12:39:14
94	51	4	Expresso (SEDEX)	SEDEX	RB381375748BR	58.31	delivered	2026-09-02	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":58.31,"delivery_days":5,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"80420000","items_count":1,"weight_kg":8.058}}	2026-11-14 12:39:14	2026-11-14 12:39:14
95	52	5	Expresso (SEDEX)	SEDEX	\N	70.57	pending	2026-09-03	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":70.57,"delivery_days":5,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"50030230","items_count":2,"weight_kg":10.584}}	2026-11-14 12:39:14	2026-11-14 12:39:14
96	52	1	Econômico (PAC)	PAC	\N	47.23	pending	2026-09-11	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":47.23,"delivery_days":11,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"50030230","items_count":2,"weight_kg":12.48}}	2026-11-14 12:39:14	2026-11-14 12:39:14
97	53	6	Econômico (PAC)	PAC	\N	67.63	pending	2026-11-20	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":67.63,"delivery_days":15,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"90010150","items_count":2,"weight_kg":21.16}}	2026-11-14 12:39:14	2026-11-14 12:39:14
98	54	5	Expresso (SEDEX)	SEDEX	\N	79.38	pending	2026-09-22	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":79.38,"delivery_days":6,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"88010400","items_count":2,"weight_kg":12.856}}	2026-11-14 12:39:14	2026-11-14 12:39:14
99	55	4	Econômico (PAC)	PAC	S6162921856BR	34.88	posted	2026-11-04	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":34.88,"delivery_days":8,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"80420000","items_count":1,"weight_kg":7.864}}	2026-11-14 12:39:14	2026-11-14 12:39:14
100	55	3	Econômico (PAC)	PAC	S6162921856BR	25.00	posted	2026-11-02	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":25,"delivery_days":6,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"80420000","items_count":2,"weight_kg":3.02}}	2026-11-14 12:39:14	2026-11-14 12:39:14
101	56	2	Econômico (PAC)	PAC	0M626419966BR	40.10	delivered	2026-11-20	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":40.1,"delivery_days":10,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"74003010","items_count":1,"weight_kg":10.083}}	2026-11-14 12:39:14	2026-11-14 12:39:14
102	57	2	Econômico (PAC)	PAC	JC436265304BR	35.39	delivered	2026-10-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":35.39,"delivery_days":8,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"60060180","items_count":2,"weight_kg":7.444}}	2026-11-14 12:39:14	2026-11-14 12:39:14
103	58	3	Expresso (SEDEX)	SEDEX	UZ797390268BR	35.77	posted	2026-08-11	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":35.77,"delivery_days":3,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"40015010","items_count":1,"weight_kg":2.246}}	2026-11-14 12:39:14	2026-11-14 12:39:14
104	58	8	Expresso (SEDEX)	SEDEX	UZ797390268BR	54.50	posted	2026-08-12	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":54.5,"delivery_days":4,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"40015010","items_count":2,"weight_kg":6.44}}	2026-11-14 12:39:14	2026-11-14 12:39:14
105	58	5	Expresso (SEDEX)	SEDEX	UZ797390268BR	62.82	posted	2026-08-13	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":62.82,"delivery_days":5,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"40015010","items_count":1,"weight_kg":9.222}}	2026-11-14 12:39:14	2026-11-14 12:39:14
106	59	3	Econômico (PAC)	PAC	\N	60.26	label_generated	2026-08-24	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":60.26,"delivery_days":13,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"74003010","items_count":3,"weight_kg":17.387}}	2026-11-14 12:39:14	2026-11-14 12:39:14
107	60	8	Econômico (PAC)	PAC	\N	36.25	label_generated	2026-09-18	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":36.25,"delivery_days":9,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"60060180","items_count":1,"weight_kg":8.447}}	2026-11-14 12:39:14	2026-11-14 12:39:14
108	60	2	Expresso (SEDEX)	SEDEX	\N	55.24	label_generated	2026-09-11	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":55.24,"delivery_days":4,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"60060180","items_count":1,"weight_kg":7.268}}	2026-11-14 12:39:14	2026-11-14 12:39:14
109	60	7	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"60060180","items_count":1,"weight_kg":2.254}}	2026-11-14 12:39:14	2026-11-14 12:39:14
110	61	1	Expresso (SEDEX)	SEDEX	\N	40.29	pending	2026-11-05	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":40.29,"delivery_days":3,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"60060180","items_count":1,"weight_kg":3.411}}	2026-11-14 12:39:14	2026-11-14 12:39:14
111	61	6	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"60060180","items_count":2,"weight_kg":13.454}}	2026-11-14 12:39:14	2026-11-14 12:39:14
112	62	3	Econômico (PAC)	PAC	BG334115135BR	21.68	delivered	2026-09-10	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":21.68,"delivery_days":6,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"40015010","items_count":1,"weight_kg":2.246}}	2026-11-14 12:39:14	2026-11-14 12:39:14
113	62	1	Expresso (SEDEX)	SEDEX	BG334115135BR	79.38	delivered	2026-09-10	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":79.38,"delivery_days":6,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"40015010","items_count":2,"weight_kg":12.854}}	2026-11-14 12:39:14	2026-11-14 12:39:14
114	63	3	Econômico (PAC)	PAC	\N	85.18	pending	2026-08-27	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":85.18,"delivery_days":19,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"01310100","items_count":2,"weight_kg":28.63}}	2026-11-14 12:39:14	2026-11-14 12:39:14
115	63	4	Expresso (SEDEX)	SEDEX	\N	82.67	pending	2026-08-10	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":82.67,"delivery_days":6,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"01310100","items_count":2,"weight_kg":13.702}}	2026-11-14 12:39:14	2026-11-14 12:39:14
116	63	5	Expresso (SEDEX)	SEDEX	\N	57.65	pending	2026-08-06	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":57.65,"delivery_days":4,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"01310100","items_count":2,"weight_kg":7.25}}	2026-11-14 12:39:14	2026-11-14 12:39:14
117	64	3	Expresso (SEDEX)	SEDEX	\N	33.71	pending	2026-09-09	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":33.71,"delivery_days":3,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"50030230","items_count":1,"weight_kg":1.715}}	2026-11-14 12:39:14	2026-11-14 12:39:14
118	65	4	Expresso (SEDEX)	SEDEX	\N	116.31	label_generated	2026-08-25	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":116.31,"delivery_days":8,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"30130010","items_count":4,"weight_kg":21.104}}	2026-11-14 12:39:14	2026-11-14 12:39:14
119	65	5	Expresso (SEDEX)	SEDEX	\N	113.04	label_generated	2026-08-25	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":113.04,"delivery_days":8,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"30130010","items_count":2,"weight_kg":21.536}}	2026-11-14 12:39:14	2026-11-14 12:39:14
120	66	2	Econômico (PAC)	PAC	\N	23.40	label_generated	2026-09-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":23.4,"delivery_days":6,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"74003010","items_count":1,"weight_kg":2.979}}	2026-11-14 12:39:14	2026-11-14 12:39:14
121	66	3	Expresso (SEDEX)	SEDEX	\N	48.10	label_generated	2026-09-24	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":48.1,"delivery_days":4,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"74003010","items_count":2,"weight_kg":4.786}}	2026-11-14 12:39:14	2026-11-14 12:39:14
122	67	7	Econômico (PAC)	PAC	\N	32.44	pending	2026-08-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":32.44,"delivery_days":8,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"13010111","items_count":2,"weight_kg":6.188}}	2026-11-14 12:39:14	2026-11-14 12:39:14
123	67	8	Econômico (PAC)	PAC	\N	45.54	pending	2026-09-01	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":45.54,"delivery_days":10,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"13010111","items_count":2,"weight_kg":11.76}}	2026-11-14 12:39:14	2026-11-14 12:39:14
124	67	3	Expresso (SEDEX)	SEDEX	\N	82.98	pending	2026-08-26	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":82.98,"delivery_days":6,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"13010111","items_count":2,"weight_kg":13.782}}	2026-11-14 12:39:14	2026-11-14 12:39:14
125	68	6	Expresso (SEDEX)	SEDEX	\N	143.43	label_generated	2026-09-04	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":143.43,"delivery_days":10,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"20040020","items_count":2,"weight_kg":29.376}}	2026-11-14 12:39:14	2026-11-14 12:39:14
126	69	2	Expresso (SEDEX)	SEDEX	\N	107.79	pending	2026-08-28	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":107.79,"delivery_days":8,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"88010400","items_count":2,"weight_kg":20.182}}	2026-11-14 12:39:14	2026-11-14 12:39:14
127	70	5	Expresso (SEDEX)	SEDEX	\N	95.50	pending	2026-07-27	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":95.5,"delivery_days":7,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"40015010","items_count":2,"weight_kg":17.014}}	2026-11-14 12:39:14	2026-11-14 12:39:14
128	71	5	Econômico (PAC)	PAC	\N	29.97	cancelled	2026-07-31	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":29.97,"delivery_days":7,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"40015010","items_count":1,"weight_kg":5.776}}	2026-11-14 12:39:14	2026-11-14 12:39:14
129	72	8	Econômico (PAC)	PAC	\N	36.25	pending	2026-10-01	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":36.25,"delivery_days":9,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"13010111","items_count":1,"weight_kg":8.447}}	2026-11-14 12:39:14	2026-11-14 12:39:14
130	73	1	Expresso (SEDEX)	SEDEX	\N	100.42	label_generated	2026-09-22	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":100.42,"delivery_days":7,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"80420000","items_count":2,"weight_kg":18.28}}	2026-11-14 12:39:14	2026-11-14 12:39:14
131	74	4	Expresso (SEDEX)	SEDEX	\N	50.28	label_generated	2026-10-06	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":50.28,"delivery_days":4,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"60060180","items_count":2,"weight_kg":5.35}}	2026-11-14 12:39:14	2026-11-14 12:39:14
132	74	3	Expresso (SEDEX)	SEDEX	\N	46.81	label_generated	2026-10-06	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":46.81,"delivery_days":4,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"60060180","items_count":1,"weight_kg":5.092}}	2026-11-14 12:39:14	2026-11-14 12:39:14
133	75	1	Econômico (PAC)	PAC	\N	23.17	cancelled	2026-09-21	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":23.17,"delivery_days":6,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"88010400","items_count":1,"weight_kg":2.88}}	2026-11-14 12:39:14	2026-11-14 12:39:14
134	75	8	Econômico (PAC)	PAC	\N	28.51	cancelled	2026-09-22	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.51,"delivery_days":7,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"88010400","items_count":1,"weight_kg":5.155}}	2026-11-14 12:39:14	2026-11-14 12:39:14
135	75	2	Econômico (PAC)	PAC	\N	24.74	cancelled	2026-09-21	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":24.74,"delivery_days":6,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"88010400","items_count":1,"weight_kg":3.549}}	2026-11-14 12:39:14	2026-11-14 12:39:14
136	76	3	Econômico (PAC)	PAC	CH409482674BR	58.12	delivered	2026-08-13	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":58.12,"delivery_days":13,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"70040900","items_count":2,"weight_kg":17.114}}	2026-11-14 12:39:14	2026-11-14 12:39:14
137	76	1	Expresso (SEDEX)	SEDEX	CH409482674BR	129.23	delivered	2026-08-07	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":129.23,"delivery_days":9,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"70040900","items_count":3,"weight_kg":25.073}}	2026-11-14 12:39:14	2026-11-14 12:39:14
138	77	8	Econômico (PAC)	PAC	6R644194030BR	37.26	delivered	2026-10-01	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":37.26,"delivery_days":9,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"88010400","items_count":2,"weight_kg":8.238}}	2026-11-14 12:39:14	2026-11-14 12:39:14
139	77	3	Econômico (PAC)	PAC	6R644194030BR	47.22	delivered	2026-10-05	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":47.22,"delivery_days":11,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"88010400","items_count":2,"weight_kg":12.476}}	2026-11-14 12:39:14	2026-11-14 12:39:14
140	78	2	Econômico (PAC)	PAC	\N	33.19	pending	2026-10-05	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":33.19,"delivery_days":8,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"30130010","items_count":1,"weight_kg":7.146}}	2026-11-14 12:39:14	2026-11-14 12:39:14
141	78	1	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"30130010","items_count":2,"weight_kg":23.558}}	2026-11-14 12:39:14	2026-11-14 12:39:14
142	79	3	Expresso (SEDEX)	SEDEX	\N	30.66	label_generated	2026-07-21	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":30.66,"delivery_days":3,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"50030230","items_count":1,"weight_kg":0.928}}	2026-11-14 12:39:14	2026-11-14 12:39:14
143	80	1	Econômico (PAC)	PAC	\N	33.47	pending	2026-11-05	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":33.47,"delivery_days":8,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"40015010","items_count":2,"weight_kg":6.626}}	2026-11-14 12:39:14	2026-11-14 12:39:14
144	80	2	Econômico (PAC)	PAC	\N	55.52	pending	2026-11-12	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":55.52,"delivery_days":13,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"40015010","items_count":2,"weight_kg":16.01}}	2026-11-14 12:39:14	2026-11-14 12:39:14
145	81	4	Econômico (PAC)	PAC	J9166716936BR	41.39	delivered	2026-11-12	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":41.39,"delivery_days":9,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"74003010","items_count":2,"weight_kg":9.996}}	2026-11-14 12:39:14	2026-11-14 12:39:14
146	82	1	Expresso (SEDEX)	SEDEX	ZZ510410695BR	90.54	posted	2026-09-23	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":90.54,"delivery_days":6,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"20040020","items_count":2,"weight_kg":15.732}}	2026-11-14 12:39:14	2026-11-14 12:39:14
147	83	2	Expresso (SEDEX)	SEDEX	WX464998584BR	55.09	posted	2026-08-20	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":55.09,"delivery_days":4,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"20040020","items_count":1,"weight_kg":7.231}}	2026-11-14 12:39:14	2026-11-14 12:39:14
148	84	7	Expresso (SEDEX)	SEDEX	\N	56.69	pending	2026-11-09	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":56.69,"delivery_days":4,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"50030230","items_count":2,"weight_kg":7.004}}	2026-11-14 12:39:14	2026-11-14 12:39:14
149	84	3	Expresso (SEDEX)	SEDEX	\N	42.83	pending	2026-11-06	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":42.83,"delivery_days":3,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"50030230","items_count":2,"weight_kg":3.43}}	2026-11-14 12:39:14	2026-11-14 12:39:14
150	84	2	Econômico (PAC)	PAC	\N	57.67	pending	2026-11-20	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":57.67,"delivery_days":13,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"50030230","items_count":2,"weight_kg":16.922}}	2026-11-14 12:39:14	2026-11-14 12:39:14
151	85	5	Expresso (SEDEX)	SEDEX	\N	68.81	pending	2026-10-20	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":68.81,"delivery_days":5,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"80420000","items_count":1,"weight_kg":10.768}}	2026-11-14 12:39:14	2026-11-14 12:39:14
152	86	4	Econômico (PAC)	PAC	\N	21.90	pending	2026-10-06	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":21.9,"delivery_days":6,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"74003010","items_count":1,"weight_kg":2.34}}	2026-11-14 12:39:14	2026-11-14 12:39:14
153	86	5	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"74003010","items_count":1,"weight_kg":4.389}}	2026-11-14 12:39:14	2026-11-14 12:39:14
154	86	6	Expresso (SEDEX)	SEDEX	\N	69.88	pending	2026-10-05	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":69.88,"delivery_days":5,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"74003010","items_count":1,"weight_kg":11.043}}	2026-11-14 12:39:14	2026-11-14 12:39:14
155	87	4	Expresso (SEDEX)	SEDEX	\N	43.20	label_generated	2026-10-22	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":43.2,"delivery_days":4,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"50030230","items_count":1,"weight_kg":4.16}}	2026-11-14 12:39:14	2026-11-14 12:39:14
156	87	1	Econômico (PAC)	PAC	\N	23.87	label_generated	2026-10-26	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":23.87,"delivery_days":6,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"50030230","items_count":1,"weight_kg":3.18}}	2026-11-14 12:39:14	2026-11-14 12:39:14
157	87	3	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"50030230","items_count":1,"weight_kg":11.112}}	2026-11-14 12:39:14	2026-11-14 12:39:14
158	88	4	Expresso (SEDEX)	SEDEX	\N	34.11	pending	2026-11-18	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":34.11,"delivery_days":3,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"80420000","items_count":1,"weight_kg":1.819}}	2026-11-14 12:39:14	2026-11-14 12:39:14
159	88	5	Expresso (SEDEX)	SEDEX	\N	65.36	pending	2026-11-20	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":65.36,"delivery_days":5,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"80420000","items_count":2,"weight_kg":9.24}}	2026-11-14 12:39:14	2026-11-14 12:39:14
160	88	6	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"80420000","items_count":1,"weight_kg":14.688}}	2026-11-14 12:39:14	2026-11-14 12:39:14
161	89	5	Expresso (SEDEX)	SEDEX	SL018710109BR	45.82	posted	2026-11-06	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":45.82,"delivery_days":4,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"30130010","items_count":1,"weight_kg":4.839}}	2026-11-14 12:39:14	2026-11-14 12:39:14
162	89	2	Retirar no lojista	PICKUP	SL018710109BR	0.00	posted	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"30130010","items_count":1,"weight_kg":4.105}}	2026-11-14 12:39:14	2026-11-14 12:39:14
163	89	6	Econômico (PAC)	PAC	SL018710109BR	42.35	posted	2026-11-16	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":42.35,"delivery_days":10,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"30130010","items_count":1,"weight_kg":11.043}}	2026-11-14 12:39:14	2026-11-14 12:39:14
164	90	5	Econômico (PAC)	PAC	\N	50.66	label_generated	2026-11-09	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":50.66,"delivery_days":11,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"60060180","items_count":2,"weight_kg":13.94}}	2026-11-14 12:39:14	2026-11-14 12:39:14
165	90	6	Expresso (SEDEX)	SEDEX	\N	93.95	label_generated	2026-11-03	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":93.95,"delivery_days":7,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"60060180","items_count":2,"weight_kg":16.614}}	2026-11-14 12:39:14	2026-11-14 12:39:14
166	90	7	Econômico (PAC)	PAC	\N	28.86	label_generated	2026-11-03	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.86,"delivery_days":7,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"60060180","items_count":1,"weight_kg":5.303}}	2026-11-14 12:39:14	2026-11-14 12:39:14
167	91	6	Expresso (SEDEX)	SEDEX	\N	53.26	cancelled	2026-08-12	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":53.26,"delivery_days":4,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"30130010","items_count":2,"weight_kg":6.12}}	2026-11-14 12:39:14	2026-11-14 12:39:14
168	91	8	Retirar no lojista	PICKUP	\N	0.00	cancelled	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"30130010","items_count":4,"weight_kg":13.192}}	2026-11-14 12:39:14	2026-11-14 12:39:14
169	92	5	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"13010111","items_count":2,"weight_kg":8.778}}	2026-11-14 12:39:14	2026-11-14 12:39:14
170	92	1	Expresso (SEDEX)	SEDEX	\N	74.66	label_generated	2026-10-09	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":74.66,"delivery_days":5,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"13010111","items_count":3,"weight_kg":11}}	2026-11-14 12:39:14	2026-11-14 12:39:14
171	93	1	Econômico (PAC)	PAC	WG685612043BR	29.99	delivered	2026-11-16	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":29.99,"delivery_days":7,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"90010150","items_count":2,"weight_kg":5.146}}	2026-11-14 12:39:14	2026-11-14 12:39:14
172	93	5	Expresso (SEDEX)	SEDEX	WG685612043BR	71.99	delivered	2026-11-12	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":71.99,"delivery_days":5,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"90010150","items_count":2,"weight_kg":10.95}}	2026-11-14 12:39:14	2026-11-14 12:39:14
173	93	3	Expresso (SEDEX)	SEDEX	WG685612043BR	39.44	delivered	2026-11-10	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":39.44,"delivery_days":3,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"90010150","items_count":1,"weight_kg":3.19}}	2026-11-14 12:39:14	2026-11-14 12:39:14
174	94	2	Econômico (PAC)	PAC	TN033807458BR	37.19	delivered	2026-09-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":37.19,"delivery_days":9,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"80420000","items_count":2,"weight_kg":8.21}}	2026-11-14 12:39:14	2026-11-14 12:39:14
175	94	3	Econômico (PAC)	PAC	TN033807458BR	20.28	delivered	2026-09-22	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":20.28,"delivery_days":5,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"80420000","items_count":1,"weight_kg":1.65}}	2026-11-14 12:39:14	2026-11-14 12:39:14
176	95	5	Econômico (PAC)	PAC	\N	67.69	cancelled	2026-08-31	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":67.69,"delivery_days":14,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"30130010","items_count":4,"weight_kg":19.912}}	2026-11-14 12:39:14	2026-11-14 12:39:14
177	96	8	Econômico (PAC)	PAC	\N	26.34	pending	2026-08-24	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":26.34,"delivery_days":6,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"50030230","items_count":2,"weight_kg":3.592}}	2026-11-14 12:39:14	2026-11-14 12:39:14
178	97	5	Econômico (PAC)	PAC	\N	47.91	pending	2026-08-20	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":47.91,"delivery_days":11,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"60060180","items_count":3,"weight_kg":12.132}}	2026-11-14 12:39:14	2026-11-14 12:39:14
179	97	6	Expresso (SEDEX)	SEDEX	\N	66.45	pending	2026-08-12	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":66.45,"delivery_days":5,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"60060180","items_count":2,"weight_kg":9.52}}	2026-11-14 12:39:14	2026-11-14 12:39:14
180	98	4	Expresso (SEDEX)	SEDEX	\N	54.20	pending	2026-09-02	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":54.2,"delivery_days":4,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"50030230","items_count":1,"weight_kg":7}}	2026-11-14 12:39:14	2026-11-14 12:39:14
181	98	3	Expresso (SEDEX)	SEDEX	\N	65.13	pending	2026-09-03	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":65.13,"delivery_days":5,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"50030230","items_count":2,"weight_kg":9.18}}	2026-11-14 12:39:14	2026-11-14 12:39:14
182	98	7	Expresso (SEDEX)	SEDEX	\N	81.76	pending	2026-09-04	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":81.76,"delivery_days":6,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"50030230","items_count":2,"weight_kg":13.468}}	2026-11-14 12:39:14	2026-11-14 12:39:14
183	99	2	Retirar no lojista	PICKUP	VX522280575BR	0.00	delivered	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"60060180","items_count":3,"weight_kg":5.636}}	2026-11-14 12:39:14	2026-11-14 12:39:14
184	99	4	Econômico (PAC)	PAC	VX522280575BR	39.52	delivered	2026-10-29	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":39.52,"delivery_days":9,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"60060180","items_count":1,"weight_kg":9.838}}	2026-11-14 12:39:14	2026-11-14 12:39:14
185	100	3	Econômico (PAC)	PAC	ZN120677642BR	38.59	posted	2026-08-20	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":38.59,"delivery_days":9,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"90010150","items_count":1,"weight_kg":9.443}}	2026-11-14 12:39:14	2026-11-14 12:39:14
186	100	1	Retirar no lojista	PICKUP	ZN120677642BR	0.00	posted	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"90010150","items_count":1,"weight_kg":2.041}}	2026-11-14 12:39:14	2026-11-14 12:39:14
187	100	6	Econômico (PAC)	PAC	ZN120677642BR	26.83	posted	2026-08-18	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":26.83,"delivery_days":7,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"90010150","items_count":1,"weight_kg":4.438}}	2026-11-14 12:39:14	2026-11-14 12:39:14
188	101	2	Econômico (PAC)	PAC	ME864519376BR	28.34	posted	2026-10-13	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.34,"delivery_days":7,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"74003010","items_count":1,"weight_kg":5.082}}	2026-11-14 12:39:14	2026-11-14 12:39:14
189	101	5	Expresso (SEDEX)	SEDEX	ME864519376BR	68.06	posted	2026-10-09	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":68.06,"delivery_days":5,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"74003010","items_count":1,"weight_kg":10.573}}	2026-11-14 12:39:15	2026-11-14 12:39:15
190	102	5	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"88010400","items_count":2,"weight_kg":16.96}}	2026-11-14 12:39:15	2026-11-14 12:39:15
191	102	3	Econômico (PAC)	PAC	\N	23.90	pending	2026-10-05	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":23.9,"delivery_days":6,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"88010400","items_count":1,"weight_kg":3.19}}	2026-11-14 12:39:15	2026-11-14 12:39:15
192	103	1	Econômico (PAC)	PAC	\N	31.07	label_generated	2026-07-31	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":31.07,"delivery_days":8,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"70040900","items_count":1,"weight_kg":6.242}}	2026-11-14 12:39:15	2026-11-14 12:39:15
193	103	6	Econômico (PAC)	PAC	\N	20.28	label_generated	2026-07-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":20.28,"delivery_days":5,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"70040900","items_count":1,"weight_kg":1.653}}	2026-11-14 12:39:15	2026-11-14 12:39:15
194	104	5	Econômico (PAC)	PAC	\N	26.52	pending	2026-09-30	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":26.52,"delivery_days":7,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"50030230","items_count":1,"weight_kg":4.307}}	2026-11-14 12:39:15	2026-11-14 12:39:15
195	104	3	Expresso (SEDEX)	SEDEX	\N	54.27	pending	2026-09-25	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":54.27,"delivery_days":4,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"50030230","items_count":2,"weight_kg":6.38}}	2026-11-14 12:39:15	2026-11-14 12:39:15
196	105	3	Econômico (PAC)	PAC	\N	36.51	pending	2026-09-16	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":36.51,"delivery_days":9,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"50030230","items_count":1,"weight_kg":8.557}}	2026-11-14 12:39:15	2026-11-14 12:39:15
197	105	5	Expresso (SEDEX)	SEDEX	\N	95.50	pending	2026-09-14	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":95.5,"delivery_days":7,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"50030230","items_count":2,"weight_kg":17.014}}	2026-11-14 12:39:15	2026-11-14 12:39:15
198	105	4	Expresso (SEDEX)	SEDEX	\N	47.69	pending	2026-09-09	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":47.69,"delivery_days":4,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"50030230","items_count":1,"weight_kg":5.321}}	2026-11-14 12:39:15	2026-11-14 12:39:15
199	106	3	Expresso (SEDEX)	SEDEX	\N	140.55	pending	2026-10-23	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":140.55,"delivery_days":10,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"74003010","items_count":2,"weight_kg":28.63}}	2026-11-14 12:39:15	2026-11-14 12:39:15
200	106	6	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"74003010","items_count":2,"weight_kg":3.44}}	2026-11-14 12:39:15	2026-11-14 12:39:15
201	107	5	Econômico (PAC)	PAC	\N	41.25	pending	2026-07-31	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":41.25,"delivery_days":10,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"90010150","items_count":1,"weight_kg":10.573}}	2026-11-14 12:39:15	2026-11-14 12:39:15
202	107	1	Econômico (PAC)	PAC	\N	37.57	pending	2026-07-30	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":37.57,"delivery_days":9,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"90010150","items_count":2,"weight_kg":8.372}}	2026-11-14 12:39:15	2026-11-14 12:39:15
203	107	4	Econômico (PAC)	PAC	\N	24.11	pending	2026-07-27	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":24.11,"delivery_days":6,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"90010150","items_count":1,"weight_kg":3.281}}	2026-11-14 12:39:15	2026-11-14 12:39:15
204	108	2	Econômico (PAC)	PAC	\N	32.24	pending	2026-10-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":32.24,"delivery_days":8,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"40015010","items_count":1,"weight_kg":6.741}}	2026-11-14 12:39:15	2026-11-14 12:39:15
205	109	2	Econômico (PAC)	PAC	\N	21.06	pending	2026-08-14	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":21.06,"delivery_days":5,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"50030230","items_count":1,"weight_kg":1.981}}	2026-11-14 12:39:15	2026-11-14 12:39:15
206	109	1	Econômico (PAC)	PAC	\N	31.60	pending	2026-08-19	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":31.6,"delivery_days":8,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"50030230","items_count":1,"weight_kg":6.466}}	2026-11-14 12:39:15	2026-11-14 12:39:15
207	110	3	Expresso (SEDEX)	SEDEX	\N	111.08	pending	2026-11-13	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":111.08,"delivery_days":8,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"60060180","items_count":2,"weight_kg":21.028}}	2026-11-14 12:39:15	2026-11-14 12:39:15
208	111	4	Econômico (PAC)	PAC	\N	38.37	pending	2026-09-24	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":38.37,"delivery_days":9,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"80420000","items_count":2,"weight_kg":8.71}}	2026-11-14 12:39:15	2026-11-14 12:39:15
209	112	5	Econômico (PAC)	PAC	\N	37.94	pending	2026-11-19	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":37.94,"delivery_days":9,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"90010150","items_count":1,"weight_kg":9.164}}	2026-11-14 12:39:15	2026-11-14 12:39:15
210	112	2	Econômico (PAC)	PAC	\N	34.19	pending	2026-11-18	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":34.19,"delivery_days":8,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"90010150","items_count":2,"weight_kg":6.932}}	2026-11-14 12:39:15	2026-11-14 12:39:15
211	113	5	Econômico (PAC)	PAC	\N	17.56	pending	2026-08-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":17.56,"delivery_days":5,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"40015010","items_count":1,"weight_kg":0.495}}	2026-11-14 12:39:15	2026-11-14 12:39:15
212	114	5	Retirar no lojista	PICKUP	DD823133108BR	0.00	posted	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"60060180","items_count":5,"weight_kg":27.339}}	2026-11-14 12:39:15	2026-11-14 12:39:15
213	115	1	Retirar no lojista	PICKUP	GY561463638BR	0.00	delivered	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"90010150","items_count":2,"weight_kg":7.662}}	2026-11-14 12:39:15	2026-11-14 12:39:15
214	116	4	Expresso (SEDEX)	SEDEX	\N	61.53	pending	2026-10-09	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":61.53,"delivery_days":5,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"50030230","items_count":1,"weight_kg":8.889}}	2026-11-14 12:39:15	2026-11-14 12:39:15
215	117	3	Econômico (PAC)	PAC	\N	46.29	pending	2026-10-01	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":46.29,"delivery_days":10,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"90010150","items_count":4,"weight_kg":10.806}}	2026-11-14 12:39:15	2026-11-14 12:39:15
216	117	7	Econômico (PAC)	PAC	\N	24.63	pending	2026-09-25	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":24.63,"delivery_days":6,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"90010150","items_count":1,"weight_kg":3.502}}	2026-11-14 12:39:15	2026-11-14 12:39:15
217	118	6	Expresso (SEDEX)	SEDEX	\N	35.00	label_generated	2026-08-19	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":35,"delivery_days":3,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"70040900","items_count":1,"weight_kg":2.048}}	2026-11-14 12:39:15	2026-11-14 12:39:15
218	119	1	Econômico (PAC)	PAC	\N	21.61	pending	2026-11-12	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":21.61,"delivery_days":6,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"50030230","items_count":1,"weight_kg":2.219}}	2026-11-14 12:39:15	2026-11-14 12:39:15
219	119	8	Expresso (SEDEX)	SEDEX	\N	76.77	pending	2026-11-12	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":76.77,"delivery_days":6,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"50030230","items_count":2,"weight_kg":12.184}}	2026-11-14 12:39:15	2026-11-14 12:39:15
220	120	2	Econômico (PAC)	PAC	\N	30.28	pending	2026-11-17	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":30.28,"delivery_days":7,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"80420000","items_count":2,"weight_kg":5.266}}	2026-11-14 12:39:15	2026-11-14 12:39:15
221	120	1	Econômico (PAC)	PAC	\N	34.02	pending	2026-11-18	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":34.02,"delivery_days":8,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"80420000","items_count":1,"weight_kg":7.499}}	2026-11-14 12:39:15	2026-11-14 12:39:15
222	121	3	Econômico (PAC)	PAC	\N	28.68	label_generated	2026-08-18	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.68,"delivery_days":7,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"80420000","items_count":1,"weight_kg":5.227}}	2026-11-14 12:39:15	2026-11-14 12:39:15
223	121	4	Econômico (PAC)	PAC	\N	41.39	label_generated	2026-08-20	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":41.39,"delivery_days":9,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"80420000","items_count":2,"weight_kg":9.996}}	2026-11-14 12:39:15	2026-11-14 12:39:15
224	121	6	Expresso (SEDEX)	SEDEX	\N	34.49	label_generated	2026-08-12	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":34.49,"delivery_days":3,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"80420000","items_count":1,"weight_kg":1.916}}	2026-11-14 12:39:15	2026-11-14 12:39:15
225	122	5	Expresso (SEDEX)	SEDEX	\N	46.61	pending	2026-10-29	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":46.61,"delivery_days":4,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"80420000","items_count":2,"weight_kg":4.406}}	2026-11-14 12:39:15	2026-11-14 12:39:15
226	123	2	Econômico (PAC)	PAC	\N	36.48	cancelled	2026-11-03	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":36.48,"delivery_days":9,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"88010400","items_count":1,"weight_kg":8.544}}	2026-11-14 12:39:15	2026-11-14 12:39:15
227	123	7	Econômico (PAC)	PAC	\N	24.82	cancelled	2026-10-29	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":24.82,"delivery_days":6,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"88010400","items_count":1,"weight_kg":3.581}}	2026-11-14 12:39:15	2026-11-14 12:39:15
228	124	3	Expresso (SEDEX)	SEDEX	AE135303351BR	44.22	delivered	2026-07-30	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":44.22,"delivery_days":4,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"74003010","items_count":1,"weight_kg":4.426}}	2026-11-14 12:39:15	2026-11-14 12:39:15
229	125	2	Econômico (PAC)	PAC	\N	28.34	label_generated	2026-10-06	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.34,"delivery_days":7,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"20040020","items_count":1,"weight_kg":5.082}}	2026-11-14 12:39:15	2026-11-14 12:39:15
230	126	3	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"13010111","items_count":2,"weight_kg":25.808}}	2026-11-14 12:39:15	2026-11-14 12:39:15
231	126	8	Econômico (PAC)	PAC	\N	33.70	pending	2026-10-14	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":33.7,"delivery_days":8,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"13010111","items_count":1,"weight_kg":7.36}}	2026-11-14 12:39:15	2026-11-14 12:39:15
232	127	3	Econômico (PAC)	PAC	YX441286334BR	59.19	posted	2026-09-02	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":59.19,"delivery_days":13,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"60060180","items_count":4,"weight_kg":16.292}}	2026-11-14 12:39:15	2026-11-14 12:39:15
233	127	2	Econômico (PAC)	PAC	YX441286334BR	57.67	posted	2026-09-02	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":57.67,"delivery_days":13,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"60060180","items_count":2,"weight_kg":16.922}}	2026-11-14 12:39:15	2026-11-14 12:39:15
234	128	4	Expresso (SEDEX)	SEDEX	7T315536971BR	50.37	delivered	2026-10-01	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":50.37,"delivery_days":4,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"20040020","items_count":2,"weight_kg":5.376}}	2026-11-14 12:39:15	2026-11-14 12:39:15
235	128	8	Econômico (PAC)	PAC	7T315536971BR	30.57	delivered	2026-10-06	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":30.57,"delivery_days":7,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"20040020","items_count":2,"weight_kg":5.39}}	2026-11-14 12:39:15	2026-11-14 12:39:15
236	129	8	Econômico (PAC)	PAC	\N	20.59	pending	2026-11-10	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":20.59,"delivery_days":5,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"90010150","items_count":2,"weight_kg":1.144}}	2026-11-14 12:39:15	2026-11-14 12:39:15
237	130	7	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"40015010","items_count":1,"weight_kg":6.512}}	2026-11-14 12:39:15	2026-11-14 12:39:15
238	130	1	Expresso (SEDEX)	SEDEX	\N	52.31	pending	2026-08-26	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":52.31,"delivery_days":4,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"40015010","items_count":1,"weight_kg":6.512}}	2026-11-14 12:39:15	2026-11-14 12:39:15
239	130	4	Econômico (PAC)	PAC	\N	23.30	pending	2026-08-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":23.3,"delivery_days":6,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"40015010","items_count":2,"weight_kg":2.296}}	2026-11-14 12:39:15	2026-11-14 12:39:15
240	131	2	Econômico (PAC)	PAC	\N	62.40	label_generated	2026-08-24	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":62.4,"delivery_days":14,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"01310100","items_count":2,"weight_kg":18.938}}	2026-11-14 12:39:15	2026-11-14 12:39:15
241	132	6	Expresso (SEDEX)	SEDEX	\N	67.07	label_generated	2026-10-02	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":67.07,"delivery_days":5,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"30130010","items_count":2,"weight_kg":9.68}}	2026-11-14 12:39:15	2026-11-14 12:39:15
242	133	5	Econômico (PAC)	PAC	JR354318958BR	43.63	delivered	2026-09-16	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":43.63,"delivery_days":10,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"50030230","items_count":2,"weight_kg":10.95}}	2026-11-14 12:39:15	2026-11-14 12:39:15
243	134	3	Econômico (PAC)	PAC	BP437257637BR	74.13	delivered	2026-08-10	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":74.13,"delivery_days":16,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"90010150","items_count":3,"weight_kg":23.288}}	2026-11-14 12:39:15	2026-11-14 12:39:15
244	134	8	Econômico (PAC)	PAC	BP437257637BR	30.72	delivered	2026-07-29	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":30.72,"delivery_days":8,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"90010150","items_count":1,"weight_kg":6.092}}	2026-11-14 12:39:15	2026-11-14 12:39:15
245	135	4	Expresso (SEDEX)	SEDEX	\N	105.83	pending	2026-11-18	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":105.83,"delivery_days":7,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"50030230","items_count":2,"weight_kg":19.676}}	2026-11-14 12:39:15	2026-11-14 12:39:15
246	135	7	Econômico (PAC)	PAC	\N	28.86	pending	2026-11-18	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.86,"delivery_days":7,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"50030230","items_count":1,"weight_kg":5.303}}	2026-11-14 12:39:15	2026-11-14 12:39:15
247	135	6	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"50030230","items_count":1,"weight_kg":4.76}}	2026-11-14 12:39:15	2026-11-14 12:39:15
248	136	5	Econômico (PAC)	PAC	BG206417951BR	23.31	posted	2026-10-02	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":23.31,"delivery_days":6,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"70040900","items_count":1,"weight_kg":2.94}}	2026-11-14 12:39:15	2026-11-14 12:39:15
249	137	5	Econômico (PAC)	PAC	\N	31.72	pending	2026-09-02	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":31.72,"delivery_days":7,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"30130010","items_count":2,"weight_kg":5.88}}	2026-11-14 12:39:15	2026-11-14 12:39:15
250	137	8	Econômico (PAC)	PAC	\N	30.90	pending	2026-09-02	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":30.9,"delivery_days":7,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"30130010","items_count":3,"weight_kg":4.892}}	2026-11-14 12:39:15	2026-11-14 12:39:15
251	138	3	Econômico (PAC)	PAC	\N	73.45	label_generated	2026-08-31	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":73.45,"delivery_days":16,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"70040900","items_count":2,"weight_kg":23.638}}	2026-11-14 12:39:15	2026-11-14 12:39:15
252	138	6	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"70040900","items_count":2,"weight_kg":5.188}}	2026-11-14 12:39:15	2026-11-14 12:39:15
253	139	5	Econômico (PAC)	PAC	\N	25.48	pending	2026-10-23	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":25.48,"delivery_days":6,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"74003010","items_count":1,"weight_kg":3.862}}	2026-11-14 12:39:15	2026-11-14 12:39:15
254	139	8	Econômico (PAC)	PAC	\N	30.26	pending	2026-10-26	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":30.26,"delivery_days":7,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"74003010","items_count":1,"weight_kg":5.898}}	2026-11-14 12:39:15	2026-11-14 12:39:15
255	139	2	Econômico (PAC)	PAC	\N	28.35	pending	2026-10-26	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.35,"delivery_days":7,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"74003010","items_count":1,"weight_kg":5.083}}	2026-11-14 12:39:15	2026-11-14 12:39:15
256	140	4	Econômico (PAC)	PAC	\N	48.68	pending	2026-09-14	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":48.68,"delivery_days":11,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"90010150","items_count":3,"weight_kg":12.46}}	2026-11-14 12:39:15	2026-11-14 12:39:15
257	140	6	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"90010150","items_count":1,"weight_kg":4.469}}	2026-11-14 12:39:15	2026-11-14 12:39:15
258	141	3	Expresso (SEDEX)	SEDEX	XE133752416BR	41.45	delivered	2026-09-23	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":41.45,"delivery_days":3,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"70040900","items_count":1,"weight_kg":3.711}}	2026-11-14 12:39:15	2026-11-14 12:39:15
259	141	6	Econômico (PAC)	PAC	XE133752416BR	20.44	delivered	2026-09-25	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":20.44,"delivery_days":5,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"70040900","items_count":1,"weight_kg":1.72}}	2026-11-14 12:39:15	2026-11-14 12:39:15
260	142	4	Retirar no lojista	PICKUP	TS534533867BR	0.00	posted	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"74003010","items_count":2,"weight_kg":14.916}}	2026-11-14 12:39:15	2026-11-14 12:39:15
261	142	2	Econômico (PAC)	PAC	TS534533867BR	31.34	posted	2026-10-21	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":31.34,"delivery_days":7,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"74003010","items_count":2,"weight_kg":5.719}}	2026-11-14 12:39:15	2026-11-14 12:39:15
262	143	2	Econômico (PAC)	PAC	\N	39.39	cancelled	2026-10-08	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":39.39,"delivery_days":9,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"20040020","items_count":2,"weight_kg":9.146}}	2026-11-14 12:39:15	2026-11-14 12:39:15
263	144	4	Econômico (PAC)	PAC	\N	30.52	cancelled	2026-10-06	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":30.52,"delivery_days":7,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"80420000","items_count":2,"weight_kg":5.372}}	2026-11-14 12:39:15	2026-11-14 12:39:15
264	145	3	Econômico (PAC)	PAC	BJ720096270BR	36.51	posted	2026-10-16	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":36.51,"delivery_days":9,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"13010111","items_count":1,"weight_kg":8.557}}	2026-11-14 12:39:15	2026-11-14 12:39:15
265	145	2	Econômico (PAC)	PAC	BJ720096270BR	34.75	posted	2026-10-15	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":34.75,"delivery_days":8,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"13010111","items_count":1,"weight_kg":7.81}}	2026-11-14 12:39:15	2026-11-14 12:39:15
266	145	8	Expresso (SEDEX)	SEDEX	BJ720096270BR	43.46	posted	2026-10-08	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":43.46,"delivery_days":3,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"13010111","items_count":2,"weight_kg":3.592}}	2026-11-14 12:39:15	2026-11-14 12:39:15
267	146	1	Expresso (SEDEX)	SEDEX	\N	39.01	label_generated	2026-10-12	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":39.01,"delivery_days":3,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"20040020","items_count":1,"weight_kg":3.08}}	2026-11-14 12:39:15	2026-11-14 12:39:15
268	147	8	Econômico (PAC)	PAC	\N	22.89	label_generated	2026-10-20	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":22.89,"delivery_days":6,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"88010400","items_count":1,"weight_kg":2.76}}	2026-11-14 12:39:15	2026-11-14 12:39:15
269	147	7	Retirar no lojista	PICKUP	\N	0.00	label_generated	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"88010400","items_count":2,"weight_kg":13.468}}	2026-11-14 12:39:15	2026-11-14 12:39:15
270	148	1	Econômico (PAC)	PAC	\N	46.60	label_generated	2026-10-26	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":46.6,"delivery_days":11,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"30130010","items_count":2,"weight_kg":12.214}}	2026-11-14 12:39:15	2026-11-14 12:39:15
271	149	2	Econômico (PAC)	PAC	C2852569245BR	43.94	posted	2026-10-30	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":43.94,"delivery_days":10,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"60060180","items_count":1,"weight_kg":11.721}}	2026-11-14 12:39:15	2026-11-14 12:39:15
272	149	5	Expresso (SEDEX)	SEDEX	C2852569245BR	57.54	posted	2026-10-22	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":57.54,"delivery_days":4,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"60060180","items_count":2,"weight_kg":7.223}}	2026-11-14 12:39:15	2026-11-14 12:39:15
273	150	5	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"01310100","items_count":2,"weight_kg":4.704}}	2026-11-14 12:39:15	2026-11-14 12:39:15
274	150	6	Econômico (PAC)	PAC	\N	50.84	pending	2026-10-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":50.84,"delivery_days":12,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"01310100","items_count":1,"weight_kg":14.657}}	2026-11-14 12:39:15	2026-11-14 12:39:15
275	150	3	Expresso (SEDEX)	SEDEX	\N	53.10	pending	2026-10-16	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":53.1,"delivery_days":4,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"01310100","items_count":2,"weight_kg":6.078}}	2026-11-14 12:39:15	2026-11-14 12:39:15
276	151	3	Econômico (PAC)	PAC	\N	25.55	pending	2026-08-03	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":25.55,"delivery_days":6,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"88010400","items_count":1,"weight_kg":3.893}}	2026-11-14 12:39:15	2026-11-14 12:39:15
277	151	5	Econômico (PAC)	PAC	\N	26.27	pending	2026-08-04	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":26.27,"delivery_days":7,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"88010400","items_count":1,"weight_kg":4.2}}	2026-11-14 12:39:15	2026-11-14 12:39:15
278	151	1	Econômico (PAC)	PAC	\N	30.15	pending	2026-08-04	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":30.15,"delivery_days":7,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"88010400","items_count":2,"weight_kg":5.212}}	2026-11-14 12:39:15	2026-11-14 12:39:15
279	152	1	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"30130010","items_count":2,"weight_kg":6.48}}	2026-11-14 12:39:15	2026-11-14 12:39:15
280	153	8	Econômico (PAC)	PAC	\N	41.85	pending	2026-08-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":41.85,"delivery_days":10,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"80420000","items_count":2,"weight_kg":10.192}}	2026-11-14 12:39:15	2026-11-14 12:39:15
281	153	2	Econômico (PAC)	PAC	\N	51.74	pending	2026-09-01	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":51.74,"delivery_days":12,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"80420000","items_count":2,"weight_kg":14.4}}	2026-11-14 12:39:15	2026-11-14 12:39:15
282	153	3	Econômico (PAC)	PAC	\N	22.11	pending	2026-08-24	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":22.11,"delivery_days":6,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"80420000","items_count":1,"weight_kg":2.43}}	2026-11-14 12:39:15	2026-11-14 12:39:15
283	154	4	Econômico (PAC)	PAC	\N	37.29	label_generated	2026-08-07	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":37.29,"delivery_days":9,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"88010400","items_count":1,"weight_kg":8.889}}	2026-11-14 12:39:15	2026-11-14 12:39:15
284	154	2	Expresso (SEDEX)	SEDEX	\N	41.91	label_generated	2026-07-30	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":41.91,"delivery_days":3,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"88010400","items_count":1,"weight_kg":3.828}}	2026-11-14 12:39:15	2026-11-14 12:39:15
285	155	5	Expresso (SEDEX)	SEDEX	E4023344741BR	46.61	delivered	2026-11-05	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":46.61,"delivery_days":4,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"30130010","items_count":2,"weight_kg":4.406}}	2026-11-14 12:39:15	2026-11-14 12:39:15
286	155	8	Econômico (PAC)	PAC	E4023344741BR	24.82	delivered	2026-11-09	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":24.82,"delivery_days":6,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"30130010","items_count":1,"weight_kg":3.582}}	2026-11-14 12:39:15	2026-11-14 12:39:15
287	155	1	Econômico (PAC)	PAC	E4023344741BR	26.55	delivered	2026-11-10	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":26.55,"delivery_days":7,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"30130010","items_count":1,"weight_kg":4.32}}	2026-11-14 12:39:15	2026-11-14 12:39:15
288	156	3	Expresso (SEDEX)	SEDEX	\N	57.88	pending	2026-10-15	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":57.88,"delivery_days":4,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"80420000","items_count":1,"weight_kg":7.951}}	2026-11-14 12:39:15	2026-11-14 12:39:15
289	156	2	Econômico (PAC)	PAC	\N	43.92	pending	2026-10-23	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":43.92,"delivery_days":10,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"80420000","items_count":1,"weight_kg":11.712}}	2026-11-14 12:39:15	2026-11-14 12:39:15
290	157	8	Econômico (PAC)	PAC	\N	49.50	pending	2026-09-29	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":49.5,"delivery_days":11,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"80420000","items_count":2,"weight_kg":13.448}}	2026-11-14 12:39:15	2026-11-14 12:39:15
291	157	2	Econômico (PAC)	PAC	\N	28.35	pending	2026-09-23	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.35,"delivery_days":7,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"80420000","items_count":1,"weight_kg":5.083}}	2026-11-14 12:39:15	2026-11-14 12:39:15
292	158	8	Expresso (SEDEX)	SEDEX	BO396738764BR	87.83	posted	2026-10-16	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":87.83,"delivery_days":6,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"70040900","items_count":4,"weight_kg":13.758}}	2026-11-14 12:39:15	2026-11-14 12:39:15
293	159	5	Econômico (PAC)	PAC	HF557180983BR	30.49	delivered	2026-10-19	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":30.49,"delivery_days":7,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"30130010","items_count":1,"weight_kg":5.997}}	2026-11-14 12:39:15	2026-11-14 12:39:15
294	159	1	Econômico (PAC)	PAC	HF557180983BR	47.23	delivered	2026-10-23	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":47.23,"delivery_days":11,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"30130010","items_count":2,"weight_kg":12.48}}	2026-11-14 12:39:15	2026-11-14 12:39:15
295	160	7	Expresso (SEDEX)	SEDEX	\N	31.63	pending	2026-09-17	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":31.63,"delivery_days":3,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"90010150","items_count":1,"weight_kg":1.178}}	2026-11-14 12:39:15	2026-11-14 12:39:15
296	160	1	Econômico (PAC)	PAC	\N	32.52	pending	2026-09-23	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":32.52,"delivery_days":7,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"90010150","items_count":3,"weight_kg":5.583}}	2026-11-14 12:39:15	2026-11-14 12:39:15
297	161	2	Retirar no lojista	PICKUP	\N	0.00	cancelled	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"60060180","items_count":1,"weight_kg":3.466}}	2026-11-14 12:39:15	2026-11-14 12:39:15
298	162	5	Expresso (SEDEX)	SEDEX	\N	70.83	label_generated	2026-08-11	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":70.83,"delivery_days":5,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"90010150","items_count":2,"weight_kg":10.65}}	2026-11-14 12:39:15	2026-11-14 12:39:15
299	162	2	Econômico (PAC)	PAC	\N	44.69	label_generated	2026-08-18	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":44.69,"delivery_days":10,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"90010150","items_count":2,"weight_kg":11.398}}	2026-11-14 12:39:15	2026-11-14 12:39:15
300	163	3	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"13010111","items_count":3,"weight_kg":19.655}}	2026-11-14 12:39:15	2026-11-14 12:39:15
301	163	7	Econômico (PAC)	PAC	\N	36.83	pending	2026-10-07	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":36.83,"delivery_days":9,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"13010111","items_count":2,"weight_kg":8.056}}	2026-11-14 12:39:15	2026-11-14 12:39:15
302	164	4	Econômico (PAC)	PAC	\N	23.99	pending	2026-08-04	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":23.99,"delivery_days":6,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"88010400","items_count":2,"weight_kg":2.592}}	2026-11-14 12:39:15	2026-11-14 12:39:15
303	165	4	Expresso (SEDEX)	SEDEX	\N	76.30	label_generated	2026-10-30	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":76.3,"delivery_days":6,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"60060180","items_count":2,"weight_kg":12.06}}	2026-11-14 12:39:15	2026-11-14 12:39:15
304	166	6	Econômico (PAC)	PAC	G1319503224BR	28.05	posted	2026-08-18	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.05,"delivery_days":7,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"40015010","items_count":2,"weight_kg":4.32}}	2026-11-14 12:39:15	2026-11-14 12:39:15
305	167	7	Expresso (SEDEX)	SEDEX	KH858065698BR	37.06	posted	2026-08-04	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":37.06,"delivery_days":3,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"60060180","items_count":1,"weight_kg":2.58}}	2026-11-14 12:39:15	2026-11-14 12:39:15
306	168	1	Econômico (PAC)	PAC	S1568447192BR	24.01	delivered	2026-10-05	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":24.01,"delivery_days":6,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"01310100","items_count":1,"weight_kg":3.24}}	2026-11-14 12:39:15	2026-11-14 12:39:15
307	169	7	Econômico (PAC)	PAC	FV287292166BR	33.28	posted	2026-10-22	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":33.28,"delivery_days":8,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"60060180","items_count":1,"weight_kg":7.182}}	2026-11-14 12:39:15	2026-11-14 12:39:15
308	170	2	Expresso (SEDEX)	SEDEX	NL150480255BR	54.98	posted	2026-09-28	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":54.98,"delivery_days":4,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"88010400","items_count":1,"weight_kg":7.2}}	2026-11-14 12:39:15	2026-11-14 12:39:15
309	171	3	Econômico (PAC)	PAC	SC076206499BR	19.95	delivered	2026-10-26	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":19.95,"delivery_days":5,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"01310100","items_count":1,"weight_kg":1.51}}	2026-11-14 12:39:15	2026-11-14 12:39:15
310	171	8	Econômico (PAC)	PAC	SC076206499BR	25.12	delivered	2026-10-27	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":25.12,"delivery_days":6,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"01310100","items_count":1,"weight_kg":3.712}}	2026-11-14 12:39:15	2026-11-14 12:39:15
311	171	1	Econômico (PAC)	PAC	SC076206499BR	23.42	delivered	2026-10-27	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":23.42,"delivery_days":6,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"01310100","items_count":1,"weight_kg":2.987}}	2026-11-14 12:39:15	2026-11-14 12:39:15
312	172	5	Expresso (SEDEX)	SEDEX	MR923396231BR	69.37	posted	2026-09-11	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":69.37,"delivery_days":5,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"13010111","items_count":2,"weight_kg":10.274}}	2026-11-14 12:39:15	2026-11-14 12:39:15
313	173	5	Econômico (PAC)	PAC	\N	47.28	pending	2026-08-10	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":47.28,"delivery_days":11,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"60060180","items_count":2,"weight_kg":12.504}}	2026-11-14 12:39:15	2026-11-14 12:39:15
314	174	5	Expresso (SEDEX)	SEDEX	UB462753453BR	123.14	delivered	2026-09-29	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":123.14,"delivery_days":9,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"80420000","items_count":2,"weight_kg":24.14}}	2026-11-14 12:39:15	2026-11-14 12:39:15
315	174	2	Expresso (SEDEX)	SEDEX	UB462753453BR	32.88	delivered	2026-09-21	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":32.88,"delivery_days":3,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"80420000","items_count":1,"weight_kg":1.501}}	2026-11-14 12:39:15	2026-11-14 12:39:15
316	175	1	Econômico (PAC)	PAC	5L852458657BR	24.01	delivered	2026-08-31	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":24.01,"delivery_days":6,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"20040020","items_count":1,"weight_kg":3.24}}	2026-11-14 12:39:15	2026-11-14 12:39:15
317	175	4	Expresso (SEDEX)	SEDEX	5L852458657BR	83.82	delivered	2026-08-31	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":83.82,"delivery_days":6,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"20040020","items_count":2,"weight_kg":14}}	2026-11-14 12:39:15	2026-11-14 12:39:15
318	176	8	Econômico (PAC)	PAC	\N	21.71	label_generated	2026-09-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":21.71,"delivery_days":6,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"50030230","items_count":1,"weight_kg":2.258}}	2026-11-14 12:39:15	2026-11-14 12:39:15
319	177	2	Expresso (SEDEX)	SEDEX	\N	123.87	pending	2026-11-11	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":123.87,"delivery_days":8,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"70040900","items_count":3,"weight_kg":23.691}}	2026-11-14 12:39:15	2026-11-14 12:39:15
320	178	1	Expresso (SEDEX)	SEDEX	NV733456037BR	29.58	delivered	2026-09-08	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":29.58,"delivery_days":3,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"88010400","items_count":1,"weight_kg":0.65}}	2026-11-14 12:39:15	2026-11-14 12:39:15
321	178	5	Expresso (SEDEX)	SEDEX	NV733456037BR	72.35	delivered	2026-09-10	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":72.35,"delivery_days":5,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"88010400","items_count":1,"weight_kg":11.682}}	2026-11-14 12:39:15	2026-11-14 12:39:15
322	178	7	Econômico (PAC)	PAC	NV733456037BR	28.49	delivered	2026-09-14	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":28.49,"delivery_days":7,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"88010400","items_count":2,"weight_kg":4.508}}	2026-11-14 12:39:15	2026-11-14 12:39:15
323	179	5	Econômico (PAC)	PAC	Q2512554035BR	31.90	delivered	2026-10-20	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":31.9,"delivery_days":7,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"01310100","items_count":2,"weight_kg":5.956}}	2026-11-14 12:39:15	2026-11-14 12:39:15
324	179	2	Econômico (PAC)	PAC	Q2512554035BR	39.73	delivered	2026-10-22	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":39.73,"delivery_days":9,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"01310100","items_count":3,"weight_kg":8.65}}	2026-11-14 12:39:15	2026-11-14 12:39:15
325	180	6	Expresso (SEDEX)	SEDEX	\N	52.60	label_generated	2026-09-10	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":52.6,"delivery_days":4,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"40015010","items_count":1,"weight_kg":6.587}}	2026-11-14 12:39:15	2026-11-14 12:39:15
326	181	1	Econômico (PAC)	PAC	\N	32.19	pending	2026-10-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":32.19,"delivery_days":8,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"90010150","items_count":1,"weight_kg":6.72}}	2026-11-14 12:39:15	2026-11-14 12:39:15
327	182	5	Expresso (SEDEX)	SEDEX	W9167792026BR	83.95	posted	2026-10-28	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":83.95,"delivery_days":6,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"30130010","items_count":2,"weight_kg":14.032}}	2026-11-14 12:39:15	2026-11-14 12:39:15
328	183	4	Expresso (SEDEX)	SEDEX	\N	54.20	label_generated	2026-08-19	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":54.2,"delivery_days":4,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"40015010","items_count":1,"weight_kg":7}}	2026-11-14 12:39:15	2026-11-14 12:39:15
329	183	3	Econômico (PAC)	PAC	\N	52.50	label_generated	2026-08-31	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":52.5,"delivery_days":12,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"40015010","items_count":1,"weight_kg":15.36}}	2026-11-14 12:39:15	2026-11-14 12:39:15
330	184	3	Expresso (SEDEX)	SEDEX	3F683545176BR	56.66	delivered	2026-07-30	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":56.66,"delivery_days":4,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"01310100","items_count":3,"weight_kg":6.356}}	2026-11-14 12:39:15	2026-11-14 12:39:15
331	184	5	Retirar no lojista	PICKUP	3F683545176BR	0.00	delivered	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"01310100","items_count":2,"weight_kg":10.274}}	2026-11-14 12:39:15	2026-11-14 12:39:15
332	185	2	Econômico (PAC)	PAC	\N	39.39	cancelled	2026-09-22	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":39.39,"delivery_days":9,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"13010111","items_count":2,"weight_kg":9.146}}	2026-11-14 12:39:15	2026-11-14 12:39:15
333	186	8	Econômico (PAC)	PAC	\N	34.05	pending	2026-08-17	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":34.05,"delivery_days":8,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"13010111","items_count":1,"weight_kg":7.511}}	2026-11-14 12:39:15	2026-11-14 12:39:15
334	186	1	Econômico (PAC)	PAC	\N	21.20	pending	2026-08-13	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":21.2,"delivery_days":6,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"13010111","items_count":1,"weight_kg":2.041}}	2026-11-14 12:39:15	2026-11-14 12:39:15
335	187	6	Expresso (SEDEX)	SEDEX	\N	49.65	label_generated	2026-09-15	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":49.65,"delivery_days":4,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"01310100","items_count":2,"weight_kg":5.188}}	2026-11-14 12:39:15	2026-11-14 12:39:15
336	188	3	Econômico (PAC)	PAC	\N	35.08	pending	2026-10-09	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":35.08,"delivery_days":8,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"01310100","items_count":1,"weight_kg":7.951}}	2026-11-14 12:39:15	2026-11-14 12:39:15
337	188	5	Econômico (PAC)	PAC	\N	50.66	pending	2026-10-14	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":50.66,"delivery_days":11,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"01310100","items_count":2,"weight_kg":13.94}}	2026-11-14 12:39:15	2026-11-14 12:39:15
338	189	2	Expresso (SEDEX)	SEDEX	RL082058242BR	68.95	posted	2026-09-24	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":68.95,"delivery_days":5,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"60060180","items_count":2,"weight_kg":10.164}}	2026-11-14 12:39:15	2026-11-14 12:39:15
339	189	7	Expresso (SEDEX)	SEDEX	RL082058242BR	47.31	posted	2026-09-23	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":47.31,"delivery_days":4,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"60060180","items_count":1,"weight_kg":5.223}}	2026-11-14 12:39:15	2026-11-14 12:39:15
340	189	5	Econômico (PAC)	PAC	RL082058242BR	25.71	posted	2026-09-25	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":25.71,"delivery_days":6,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"60060180","items_count":1,"weight_kg":3.963}}	2026-11-14 12:39:15	2026-11-14 12:39:15
341	190	4	Expresso (SEDEX)	SEDEX	P0234113675BR	207.62	delivered	2026-09-15	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":207.62,"delivery_days":14,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"40015010","items_count":4,"weight_kg":44.65}}	2026-11-14 12:39:15	2026-11-14 12:39:15
342	190	5	Econômico (PAC)	PAC	P0234113675BR	37.94	delivered	2026-09-08	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":37.94,"delivery_days":9,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"40015010","items_count":1,"weight_kg":9.164}}	2026-11-14 12:39:15	2026-11-14 12:39:15
343	191	4	Econômico (PAC)	PAC	CJ227373818BR	48.67	delivered	2026-08-14	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":48.67,"delivery_days":10,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"30130010","items_count":4,"weight_kg":11.816}}	2026-11-14 12:39:15	2026-11-14 12:39:15
344	191	7	Expresso (SEDEX)	SEDEX	CJ227373818BR	44.76	delivered	2026-08-06	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":44.76,"delivery_days":4,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"30130010","items_count":1,"weight_kg":4.567}}	2026-11-14 12:39:15	2026-11-14 12:39:15
345	192	3	Econômico (PAC)	PAC	\N	26.80	pending	2026-08-28	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":26.8,"delivery_days":7,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"60060180","items_count":1,"weight_kg":4.426}}	2026-11-14 12:39:15	2026-11-14 12:39:15
346	192	2	Expresso (SEDEX)	SEDEX	\N	47.37	pending	2026-08-25	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":47.37,"delivery_days":4,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"60060180","items_count":2,"weight_kg":4.6}}	2026-11-14 12:39:15	2026-11-14 12:39:15
347	193	2	Expresso (SEDEX)	SEDEX	\N	38.07	pending	2026-11-17	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":38.07,"delivery_days":3,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"80420000","items_count":2,"weight_kg":2.2}}	2026-11-14 12:39:15	2026-11-14 12:39:15
348	193	8	Expresso (SEDEX)	SEDEX	\N	82.90	pending	2026-11-20	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":82.9,"delivery_days":6,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"80420000","items_count":2,"weight_kg":13.76}}	2026-11-14 12:39:15	2026-11-14 12:39:15
349	194	7	Econômico (PAC)	PAC	BS668018924BR	42.82	posted	2026-11-06	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":42.82,"delivery_days":10,"is_pickup":false},"package":{"seller_id":7,"seller_name":"Rosa e Filhos","origin_zip_code":"97182757","destination_zip_code":"74003010","items_count":2,"weight_kg":10.606}}	2026-11-14 12:39:15	2026-11-14 12:39:15
350	194	1	Econômico (PAC)	PAC	BS668018924BR	22.52	posted	2026-11-02	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":22.52,"delivery_days":6,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","destination_zip_code":"74003010","items_count":1,"weight_kg":2.606}}	2026-11-14 12:39:15	2026-11-14 12:39:15
351	195	2	Econômico (PAC)	PAC	\N	39.39	pending	2026-11-20	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":39.39,"delivery_days":9,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"74003010","items_count":2,"weight_kg":9.146}}	2026-11-14 12:39:15	2026-11-14 12:39:15
352	195	3	Econômico (PAC)	PAC	\N	20.01	pending	2026-11-16	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":20.01,"delivery_days":5,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"74003010","items_count":1,"weight_kg":1.536}}	2026-11-14 12:39:15	2026-11-14 12:39:15
353	196	8	Expresso (SEDEX)	SEDEX	QT928509310BR	47.04	delivered	2026-07-23	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":47.04,"delivery_days":4,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"20040020","items_count":1,"weight_kg":5.155}}	2026-11-14 12:39:15	2026-11-14 12:39:15
354	197	5	Expresso (SEDEX)	SEDEX	76630018255BR	69.18	posted	2026-10-13	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":69.18,"delivery_days":5,"is_pickup":false},"package":{"seller_id":5,"seller_name":"Amaral e Filhos","origin_zip_code":"10842268","destination_zip_code":"13010111","items_count":1,"weight_kg":10.862}}	2026-11-14 12:39:15	2026-11-14 12:39:15
355	197	6	Econômico (PAC)	PAC	76630018255BR	48.86	posted	2026-10-21	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":48.86,"delivery_days":11,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"13010111","items_count":2,"weight_kg":13.174}}	2026-11-14 12:39:15	2026-11-14 12:39:15
356	198	8	Expresso (SEDEX)	SEDEX	\N	78.16	pending	2026-10-15	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":78.16,"delivery_days":6,"is_pickup":false},"package":{"seller_id":8,"seller_name":"Tamoio Comercial Ltda.","origin_zip_code":"45094176","destination_zip_code":"20040020","items_count":2,"weight_kg":12.54}}	2026-11-14 12:39:15	2026-11-14 12:39:15
357	198	6	Retirar no lojista	PICKUP	\N	0.00	pending	\N	{"quote":{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"20040020","items_count":1,"weight_kg":0.63}}	2026-11-14 12:39:15	2026-11-14 12:39:15
358	199	3	Expresso (SEDEX)	SEDEX	UK930219152BR	51.25	posted	2026-08-31	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":51.25,"delivery_days":4,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","destination_zip_code":"88010400","items_count":1,"weight_kg":6.238}}	2026-11-14 12:39:15	2026-11-14 12:39:15
359	199	4	Econômico (PAC)	PAC	UK930219152BR	25.68	posted	2026-09-02	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":25.68,"delivery_days":6,"is_pickup":false},"package":{"seller_id":4,"seller_name":"Gon\\u00e7alves-Salgado","origin_zip_code":"45706706","destination_zip_code":"88010400","items_count":2,"weight_kg":3.312}}	2026-11-14 12:39:15	2026-11-14 12:39:15
360	199	2	Expresso (SEDEX)	SEDEX	UK930219152BR	40.38	posted	2026-08-28	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":40.38,"delivery_days":3,"is_pickup":false},"package":{"seller_id":2,"seller_name":"Bosch Parts","origin_zip_code":"80420000","destination_zip_code":"88010400","items_count":1,"weight_kg":3.436}}	2026-11-14 12:39:15	2026-11-14 12:39:15
361	200	6	Expresso (SEDEX)	SEDEX	\N	39.77	pending	2026-07-22	{"quote":{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":39.77,"delivery_days":3,"is_pickup":false},"package":{"seller_id":6,"seller_name":"Marin Comercial Ltda.","origin_zip_code":"29375998","destination_zip_code":"70040900","items_count":1,"weight_kg":3.275}}	2026-11-14 12:39:15	2026-11-14 12:39:15
362	201	3	Econômico (PAC)	PAC	\N	42.51	pending	2026-11-27	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":42.51,"delivery_days":10,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","subtotal":936.52,"weight_grams":11112,"cubic_weight_grams":5752,"billable_weight_grams":11112,"dimensions":{"length_cm":35,"width_cm":34,"height_cm":29},"items":[{"sku":"DENS-00367","quantity":1,"unit_price":936.52,"weight_grams":11112,"dimensions":{"length_cm":35,"width_cm":34,"height_cm":29}}],"options":[{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":42.51,"delivery_days":10,"is_pickup":false},{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":70.14,"delivery_days":5,"is_pickup":false},{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true}],"default_service_code":"PAC"}}	2026-11-14 12:40:18	2026-11-14 12:40:18
364	203	1	Econômico (PAC)	PAC	\N	34.89	pending	2026-11-25	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":34.89,"delivery_days":8,"is_pickup":false},"package":{"seller_id":1,"seller_name":"Cofap Center","origin_zip_code":"01310100","subtotal":949.81,"weight_grams":7866,"cubic_weight_grams":5382,"billable_weight_grams":7866,"dimensions":{"length_cm":69,"width_cm":26,"height_cm":18},"items":[{"sku":"SKF-00369","quantity":1,"unit_price":949.81,"weight_grams":7866,"dimensions":{"length_cm":69,"width_cm":26,"height_cm":18}}],"options":[{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":34.89,"delivery_days":8,"is_pickup":false},{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":57.57,"delivery_days":4,"is_pickup":false},{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true}],"default_service_code":"PAC"}}	2026-11-14 12:59:56	2026-11-14 12:59:56
365	203	3	Econômico (PAC)	PAC	\N	31.01	pending	2026-11-25	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":31.01,"delivery_days":8,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","subtotal":219.78,"weight_grams":6218,"cubic_weight_grams":490,"billable_weight_grams":6218,"dimensions":{"length_cm":20,"width_cm":21,"height_cm":7},"items":[{"sku":"SACH-00358","quantity":1,"unit_price":219.78,"weight_grams":6218,"dimensions":{"length_cm":20,"width_cm":21,"height_cm":7}}],"options":[{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":31.01,"delivery_days":8,"is_pickup":false},{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":51.17,"delivery_days":4,"is_pickup":false},{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true}],"default_service_code":"PAC"}}	2026-11-14 12:59:56	2026-11-14 12:59:56
366	204	3	Econômico (PAC)	PAC	\N	42.51	pending	2026-11-27	{"quote":{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":42.51,"delivery_days":10,"is_pickup":false},"package":{"seller_id":3,"seller_name":"Mann Filter Store","origin_zip_code":"30130010","subtotal":936.52,"weight_grams":11112,"cubic_weight_grams":5752,"billable_weight_grams":11112,"dimensions":{"length_cm":35,"width_cm":34,"height_cm":29},"items":[{"sku":"DENS-00367","quantity":1,"unit_price":936.52,"weight_grams":11112,"dimensions":{"length_cm":35,"width_cm":34,"height_cm":29}}],"options":[{"service_code":"PAC","service_name":"Econ\\u00f4mico (PAC)","price":42.51,"delivery_days":10,"is_pickup":false},{"service_code":"SEDEX","service_name":"Expresso (SEDEX)","price":70.14,"delivery_days":5,"is_pickup":false},{"service_code":"PICKUP","service_name":"Retirar no lojista","price":0,"delivery_days":0,"is_pickup":true}],"default_service_code":"PAC"}}	2026-11-14 13:35:45	2026-11-14 13:35:45
\.


--
-- TOC entry 5238 (class 0 OID 17037)
-- Dependencies: 231
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 5256 (class 0 OID 17267)
-- Dependencies: 249
-- Data for Name: itens_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itens_pedido (id, order_id, order_shipment_id, seller_id, product_id, product_variant_id, product_name, variant_name, sku, quantity, unit_price, total, weight_grams, length_cm, width_cm, height_cm, created_at, updated_at) FROM stdin;
1	1	1	3	148	300	Capa de Volante Gates	Lado Esquerdo	GATE-00293	2	274.29	548.58	1008	32	16	18	2026-11-14 12:39:14	2026-11-14 12:39:14
2	1	2	1	179	358	Junta Homocinética Nakata Série Ouro	HD	NAKA-00351	1	449.22	449.22	9704	35	33	30	2026-11-14 12:39:14	2026-11-14 12:39:14
3	2	3	1	145	293	Sensor de Oxigênio Cofap	Traseiro	COFA-00286	2	542.85	1085.70	5030	36	20	20	2026-11-14 12:39:14	2026-11-14 12:39:14
4	2	4	6	156	313	Calota Monroe Reforçado	Dianteiro	MONR-00306	2	180.64	361.28	1776	75	14	9	2026-11-14 12:39:14	2026-11-14 12:39:14
5	3	5	4	45	93	Caixa de Direção NGK	Traseiro	NGK-00086	1	361.81	361.81	4312	68	31	28	2026-11-14 12:39:14	2026-11-14 12:39:14
6	3	6	3	142	287	Terminal de Direção TRW	Esportivo	TRW-00280	1	657.66	657.66	6238	72	25	19	2026-11-14 12:39:14	2026-11-14 12:39:14
7	4	7	2	2	4	Kit Pastilhas de Freio Bosch	Eixo Traseiro	PAST-BOSCH-TRAS	1	189.90	189.90	1100	22	16	7	2026-11-14 12:39:14	2026-11-14 12:39:14
8	4	8	5	38	75	Barra Estabilizadora Fram	Lado Direito	FRAM-00068	2	231.59	463.18	1805	77	20	18	2026-11-14 12:39:14	2026-11-14 12:39:14
9	4	8	5	70	144	Amortecedor Traseiro Denso Premium	Esportivo	DENS-00137	2	757.42	1514.84	5776	67	18	25	2026-11-14 12:39:14	2026-11-14 12:39:14
10	5	9	4	92	190	Antena Automotiva Monroe	Traseiro	MONR-00183	2	207.75	415.50	729	67	20	19	2026-11-14 12:39:14	2026-11-14 12:39:14
11	5	10	2	192	383	Tensor da Correia Cofap Série Ouro	Reforçado	COFA-00376	2	308.54	617.08	3549	31	11	22	2026-11-14 12:39:14	2026-11-14 12:39:14
12	6	11	2	135	272	Cilindro de Roda Nakata	Lado Direito	NAKA-00265	2	599.81	1199.62	5083	25	25	7	2026-11-14 12:39:14	2026-11-14 12:39:14
13	7	12	3	39	79	Cilindro de Roda Fram	Original	FRAM-00072	1	103.00	103.00	563	30	19	10	2026-11-14 12:39:14	2026-11-14 12:39:14
14	8	13	2	75	153	Coifa da Homocinética Fram Série Ouro	Reforçado	FRAM-00146	1	991.84	991.84	7668	38	31	30	2026-11-14 12:39:14	2026-11-14 12:39:14
15	8	14	5	89	183	Lâmpada Farol Cofap Série Ouro	Original	COFA-00176	2	262.69	525.38	10862	34	18	19	2026-11-14 12:39:14	2026-11-14 12:39:14
16	9	15	4	65	136	Sensor de Rotação Moura	Único	MOUR-00129	2	1199.16	2398.32	14195	35	23	16	2026-11-14 12:39:14	2026-11-14 12:39:14
17	9	16	6	76	155	Calota NGK	Esportivo	NGK-00148	1	185.08	185.08	764	30	18	19	2026-11-14 12:39:14	2026-11-14 12:39:14
18	10	17	2	2	3	Kit Pastilhas de Freio Bosch	Eixo Dianteiro	PAST-BOSCH-DIANT	2	219.90	439.80	1400	25	18	8	2026-11-14 12:39:14	2026-11-14 12:39:14
19	10	18	1	14	29	Pivô de Suspensão Varga	Esportivo	VARG-00022	1	555.59	555.59	6242	69	17	14	2026-11-14 12:39:14	2026-11-14 12:39:14
20	10	19	6	96	197	Bomba d'Água Bosch	Único	BOSC-00190	2	81.84	163.68	448	40	27	12	2026-11-14 12:39:14	2026-11-14 12:39:14
21	11	20	1	54	112	Amortecedor Traseiro NGK	Esportivo	NGK-00105	1	277.37	277.37	5498	70	24	23	2026-11-14 12:39:14	2026-11-14 12:39:14
22	11	21	6	169	340	Alternador NGK Reforçado	Esportivo	NGK-00333	1	1218.10	1218.10	11043	38	17	20	2026-11-14 12:39:14	2026-11-14 12:39:14
23	12	22	3	42	85	Radiador Valeo	HD	VALE-00078	1	820.49	820.49	1570	79	49	20	2026-11-14 12:39:14	2026-11-14 12:39:14
24	13	23	5	43	87	Kit Embreagem Continental Reforçado	Lado Esquerdo	CONT-00080	1	105.52	105.52	6970	38	40	17	2026-11-14 12:39:14	2026-11-14 12:39:14
25	13	24	2	62	130	Mola Helicoidal Heliar	Reforçado	HELI-00123	1	671.85	671.85	5155	68	29	22	2026-11-14 12:39:14	2026-11-14 12:39:14
26	14	25	8	13	27	Bomba de Direção Hidráulica Bosch	Reforçado	BOSC-00020	1	118.15	118.15	5058	40	27	21	2026-11-14 12:39:14	2026-11-14 12:39:14
27	14	26	4	58	121	Reservatório de Água Mann Filter	Lado Esquerdo	MANN-00114	2	598.61	1197.22	3475	68	38	14	2026-11-14 12:39:14	2026-11-14 12:39:14
28	14	27	3	66	138	Reservatório de Água TRW	Esportivo	TRW-00131	1	741.87	741.87	3407	41	57	25	2026-11-14 12:39:14	2026-11-14 12:39:14
29	15	28	5	85	174	Bomba de Direção Hidráulica Gates	HD	GATE-00167	1	274.33	274.33	3387	46	37	24	2026-11-14 12:39:14	2026-11-14 12:39:14
30	15	29	6	169	341	Alternador NGK Reforçado	Dianteiro	NGK-00334	1	1230.28	1230.28	4469	34	15	29	2026-11-14 12:39:14	2026-11-14 12:39:14
31	16	30	4	20	41	Calota Continental	Único	CONT-00034	2	137.47	274.94	383	39	24	15	2026-11-14 12:39:14	2026-11-14 12:39:14
32	17	31	5	82	167	Eletroventilador Moura Original	Reforçado	MOUR-00160	2	380.85	761.70	3130	71	34	30	2026-11-14 12:39:14	2026-11-14 12:39:14
33	17	31	5	85	173	Bomba de Direção Hidráulica Gates	Traseiro	GATE-00166	1	271.67	271.67	5343	34	40	20	2026-11-14 12:39:14	2026-11-14 12:39:14
34	17	32	7	173	347	Coifa de Direção Heliar	Esportivo	HELI-00340	2	659.64	1319.28	1312	43	24	18	2026-11-14 12:39:14	2026-11-14 12:39:14
35	18	33	8	18	36	Válvula Termostática Continental	Lado Direito	CONT-00029	2	498.23	996.46	1883	76	33	15	2026-11-14 12:39:14	2026-11-14 12:39:14
36	19	34	6	76	156	Calota NGK	Dianteiro	NGK-00149	2	174.60	349.20	2359	34	11	8	2026-11-14 12:39:14	2026-11-14 12:39:14
37	19	35	4	190	377	Barra Estabilizadora Valeo	Reforçado	VALE-00370	2	362.90	725.80	5321	53	15	19	2026-11-14 12:39:14	2026-11-14 12:39:14
38	20	36	4	110	226	Terminal de Direção Nakata	Reforçado	NAKA-00219	2	615.81	1231.62	2422	74	19	14	2026-11-14 12:39:14	2026-11-14 12:39:14
39	20	37	5	143	290	Fluido de Freio SKF	Lado Direito	SKF-00283	1	326.15	326.15	3809	31	30	14	2026-11-14 12:39:14	2026-11-14 12:39:14
40	20	38	2	185	370	Alternador SKF	Lado Esquerdo	SKF-00363	1	200.85	200.85	8461	24	19	21	2026-11-14 12:39:14	2026-11-14 12:39:14
41	21	39	7	31	61	Flexível de Freio Varga	Original	VARG-00054	2	322.45	644.90	494	29	28	5	2026-11-14 12:39:14	2026-11-14 12:39:14
42	21	40	2	163	327	Rolamento de Embreagem Continental	Único	CONT-00320	1	436.37	436.37	9496	31	27	28	2026-11-14 12:39:14	2026-11-14 12:39:14
43	21	41	4	164	329	Calota Fram	Reforçado	FRAM-00322	1	234.57	234.57	1748	31	30	11	2026-11-14 12:39:14	2026-11-14 12:39:14
44	22	42	8	67	139	Coifa da Homocinética Mahle Reforçado	Único	MAHL-00132	2	1142.96	2285.92	4994	47	38	23	2026-11-14 12:39:14	2026-11-14 12:39:14
45	22	43	2	101	206	Caixa de Direção Denso	Reforçado	DENS-00199	2	1121.45	2242.90	5910	69	27	26	2026-11-14 12:39:14	2026-11-14 12:39:14
46	22	44	3	142	286	Terminal de Direção TRW	Dianteiro	TRW-00279	1	671.08	671.08	7657	62	30	12	2026-11-14 12:39:14	2026-11-14 12:39:14
47	23	45	6	100	203	Protetor de Carter Mahle	Esportivo	MAHL-00196	1	145.88	145.88	644	38	29	9	2026-11-14 12:39:14	2026-11-14 12:39:14
48	24	46	6	84	171	Antena Automotiva Delphi	Esportivo	DELP-00164	2	275.44	550.88	2098	39	21	19	2026-11-14 12:39:14	2026-11-14 12:39:14
49	24	47	4	190	377	Barra Estabilizadora Valeo	Reforçado	VALE-00370	2	362.90	725.80	5321	53	15	19	2026-11-14 12:39:14	2026-11-14 12:39:14
50	25	48	4	92	190	Antena Automotiva Monroe	Traseiro	MONR-00183	2	207.75	415.50	729	67	20	19	2026-11-14 12:39:14	2026-11-14 12:39:14
51	26	49	5	86	176	Amortecedor Traseiro Gates	Único	GATE-00169	2	355.97	711.94	1804	77	29	13	2026-11-14 12:39:14	2026-11-14 12:39:14
52	26	49	5	104	213	Junta do Cabeçote Valeo Premium	Traseiro	VALE-00206	1	452.63	452.63	358	17	19	17	2026-11-14 12:39:14	2026-11-14 12:39:14
53	26	50	1	179	358	Junta Homocinética Nakata Série Ouro	HD	NAKA-00351	1	449.22	449.22	9704	35	33	30	2026-11-14 12:39:14	2026-11-14 12:39:14
54	27	51	4	23	47	Lonas de Freio Gates	Traseiro	GATE-00040	2	266.21	532.42	3128	29	25	8	2026-11-14 12:39:14	2026-11-14 12:39:14
55	27	51	4	113	235	Bobina de Ignição Mahle Linha Leve	Único	MAHL-00228	1	794.57	794.57	8889	28	26	18	2026-11-14 12:39:14	2026-11-14 12:39:14
56	27	52	5	70	145	Amortecedor Traseiro Denso Premium	Dianteiro	DENS-00138	1	750.00	750.00	2870	65	24	18	2026-11-14 12:39:14	2026-11-14 12:39:14
57	28	53	3	55	114	Flexível de Freio Monroe Série Ouro	Único	MONR-00107	2	407.45	814.90	3073	22	25	13	2026-11-14 12:39:14	2026-11-14 12:39:14
58	29	54	8	67	139	Coifa da Homocinética Mahle Reforçado	Único	MAHL-00132	1	1142.96	1142.96	4994	47	38	23	2026-11-14 12:39:14	2026-11-14 12:39:14
59	29	55	5	155	312	Junta Homocinética Sachs HD	Único	SACH-00305	1	1001.44	1001.44	5721	39	27	26	2026-11-14 12:39:14	2026-11-14 12:39:14
60	30	56	2	51	106	Coifa da Homocinética Cofap Premium	Lado Direito	COFA-00099	1	472.60	472.60	7806	49	27	24	2026-11-14 12:39:14	2026-11-14 12:39:14
61	30	57	8	87	179	Kit Freio Traseiro Delphi	Lado Esquerdo	DELP-00172	1	232.27	232.27	6036	27	16	11	2026-11-14 12:39:14	2026-11-14 12:39:14
62	30	58	1	138	278	Mangueira do Radiador Mann Filter	Esportivo	MANN-00271	2	482.09	964.18	2309	81	55	21	2026-11-14 12:39:14	2026-11-14 12:39:14
63	31	59	7	52	109	Kit Ferramentas Delphi Linha Leve	HD	DELP-00102	2	226.69	453.38	2223	33	12	5	2026-11-14 12:39:14	2026-11-14 12:39:14
64	31	60	3	95	195	Pastilha de Freio SKF	Lado Esquerdo	SKF-00188	2	94.78	189.56	6382	21	24	5	2026-11-14 12:39:14	2026-11-14 12:39:14
65	32	61	3	47	97	Lonas de Freio Bosch Série Ouro	Reforçado	BOSC-00090	1	470.11	470.11	4426	21	15	8	2026-11-14 12:39:14	2026-11-14 12:39:14
66	32	62	2	127	257	Lonas de Freio Cofap Original	Lado Direito	COFA-00250	1	506.08	506.08	4573	32	17	7	2026-11-14 12:39:14	2026-11-14 12:39:14
67	32	62	2	135	272	Cilindro de Roda Nakata	Lado Direito	NAKA-00265	2	599.81	1199.62	5083	25	25	7	2026-11-14 12:39:14	2026-11-14 12:39:14
68	33	63	1	116	238	Capa de Volante Fram	HD	FRAM-00231	2	267.85	535.70	2219	62	17	5	2026-11-14 12:39:14	2026-11-14 12:39:14
69	34	64	1	125	252	Bomba de Direção Hidráulica Denso Linha Leve	Reforçado	DENS-00245	1	225.57	225.57	1170	48	37	22	2026-11-14 12:39:14	2026-11-14 12:39:14
70	35	65	4	57	117	Motor de Partida Bosch	Reforçado	BOSC-00110	1	143.48	143.48	12071	32	28	18	2026-11-14 12:39:14	2026-11-14 12:39:14
71	36	66	5	38	77	Barra Estabilizadora Fram	Reforçado	FRAM-00070	1	246.06	246.06	7585	49	27	19	2026-11-14 12:39:14	2026-11-14 12:39:14
72	36	67	1	191	381	Fluido de Freio Fram	Reforçado	FRAM-00374	2	578.43	1156.86	920	24	17	11	2026-11-14 12:39:14	2026-11-14 12:39:14
73	37	68	2	88	181	Junta do Cabeçote Heliar	Reforçado	HELI-00174	1	137.40	137.40	4105	31	13	14	2026-11-14 12:39:14	2026-11-14 12:39:14
74	37	69	8	90	185	Mangueira do Radiador Fram	Dianteiro	FRAM-00178	2	267.80	535.60	3183	51	58	20	2026-11-14 12:39:14	2026-11-14 12:39:14
75	37	70	7	159	319	Tambor de Freio NGK	Dianteiro	NGK-00312	2	415.20	830.40	3581	31	28	7	2026-11-14 12:39:14	2026-11-14 12:39:14
76	38	71	3	42	85	Radiador Valeo	HD	VALE-00078	1	820.49	820.49	1570	79	49	20	2026-11-14 12:39:14	2026-11-14 12:39:14
77	38	72	7	123	249	Atuador de Embreagem TRW	Único	TRW-00242	2	167.52	335.04	4115	31	34	24	2026-11-14 12:39:14	2026-11-14 12:39:14
78	38	73	1	145	292	Sensor de Oxigênio Cofap	Lado Esquerdo	COFA-00285	1	554.28	554.28	6227	35	24	29	2026-11-14 12:39:14	2026-11-14 12:39:14
79	39	74	2	29	57	Bomba de Direção Hidráulica Magneti Marelli	Único	MAGN-00050	1	741.22	741.22	3058	70	32	28	2026-11-14 12:39:14	2026-11-14 12:39:14
80	40	75	1	138	279	Mangueira do Radiador Mann Filter	Original	MANN-00272	2	486.77	973.54	2142	40	36	12	2026-11-14 12:39:14	2026-11-14 12:39:14
81	41	76	3	71	146	Cilindro de Roda Valeo	Único	VALE-00139	2	174.71	349.42	1517	25	15	9	2026-11-14 12:39:14	2026-11-14 12:39:14
82	41	77	5	85	173	Bomba de Direção Hidráulica Gates	Traseiro	GATE-00166	1	271.67	271.67	5343	34	40	20	2026-11-14 12:39:14	2026-11-14 12:39:14
83	41	78	8	93	192	Bomba de Direção Hidráulica Continental Série Ouro	Lado Direito	CONT-00185	2	605.06	1210.12	3321	44	31	22	2026-11-14 12:39:14	2026-11-14 12:39:14
84	42	79	6	76	156	Calota NGK	Dianteiro	NGK-00149	1	174.60	174.60	2359	34	11	8	2026-11-14 12:39:14	2026-11-14 12:39:14
85	43	80	3	15	32	Pastilha de Freio Monroe	Lado Direito	MONR-00025	1	475.46	475.46	787	27	20	7	2026-11-14 12:39:14	2026-11-14 12:39:14
86	43	81	2	136	273	Vela de Ignição Heliar HD	Esportivo	HELI-00266	1	162.64	162.64	300	21	27	13	2026-11-14 12:39:14	2026-11-14 12:39:14
87	44	82	2	135	271	Cilindro de Roda Nakata	Original	NAKA-00264	1	599.81	599.81	5699	26	23	11	2026-11-14 12:39:14	2026-11-14 12:39:14
88	44	83	4	190	378	Barra Estabilizadora Valeo	Lado Esquerdo	VALE-00371	1	377.86	377.86	8058	51	26	14	2026-11-14 12:39:14	2026-11-14 12:39:14
89	45	84	2	11	22	Coifa da Homocinética NGK HD	Reforçado	NGK-00015	1	521.89	521.89	1112	42	33	22	2026-11-14 12:39:14	2026-11-14 12:39:14
90	45	85	3	44	89	Palheta Limpador Magneti Marelli	Esportivo	MAGN-00082	1	162.66	162.66	2194	32	27	15	2026-11-14 12:39:14	2026-11-14 12:39:14
91	46	86	2	62	130	Mola Helicoidal Heliar	Reforçado	HELI-00123	1	671.85	671.85	5155	68	29	22	2026-11-14 12:39:14	2026-11-14 12:39:14
92	46	87	4	164	328	Calota Fram	Dianteiro	FRAM-00321	1	248.79	248.79	1183	71	23	16	2026-11-14 12:39:14	2026-11-14 12:39:14
93	47	88	7	111	231	Kit Freio Traseiro Moura	HD	MOUR-00224	1	381.82	381.82	5303	33	30	15	2026-11-14 12:39:14	2026-11-14 12:39:14
94	48	89	5	36	70	Kit Ferramentas Magneti Marelli	Lado Esquerdo	MAGN-00063	2	59.21	118.42	1523	44	29	14	2026-11-14 12:39:14	2026-11-14 12:39:14
95	49	90	6	64	135	Tensor da Correia Monroe Reforçado	HD	MONR-00128	2	469.29	938.58	279	30	14	9	2026-11-14 12:39:14	2026-11-14 12:39:14
96	49	90	6	154	311	Válvula Termostática SKF	Lado Direito	SKF-00304	1	454.45	454.45	5418	89	38	17	2026-11-14 12:39:14	2026-11-14 12:39:14
97	49	91	8	72	148	Bomba de Combustível Fram	Traseiro	FRAM-00141	1	387.13	387.13	572	24	12	11	2026-11-14 12:39:14	2026-11-14 12:39:14
98	50	92	1	137	277	Sensor de Rotação Bosch Reforçado	Esportivo	BOSC-00270	2	472.38	944.76	2573	31	19	23	2026-11-14 12:39:14	2026-11-14 12:39:14
99	51	93	6	53	110	Terminal Axial Cofap	Único	COFA-00103	2	721.27	1442.54	3336	40	40	25	2026-11-14 12:39:14	2026-11-14 12:39:14
100	51	93	6	84	170	Antena Automotiva Delphi	Traseiro	DELP-00163	2	264.31	528.62	1916	43	16	10	2026-11-14 12:39:14	2026-11-14 12:39:14
101	51	94	4	190	378	Barra Estabilizadora Valeo	Lado Esquerdo	VALE-00371	1	377.86	377.86	8058	51	26	14	2026-11-14 12:39:14	2026-11-14 12:39:14
102	52	95	5	114	236	Radiador Mann Filter	Único	MANN-00229	2	607.88	1215.76	5292	44	48	12	2026-11-14 12:39:14	2026-11-14 12:39:14
103	52	96	1	116	239	Capa de Volante Fram	Dianteiro	FRAM-00232	2	276.05	552.10	324	78	30	16	2026-11-14 12:39:14	2026-11-14 12:39:14
104	53	97	6	171	343	Junta Homocinética Monroe	Único	MONR-00336	2	724.48	1448.96	10580	39	40	28	2026-11-14 12:39:14	2026-11-14 12:39:14
105	54	98	5	143	289	Fluido de Freio SKF	HD	SKF-00282	2	339.07	678.14	6428	20	27	6	2026-11-14 12:39:14	2026-11-14 12:39:14
106	55	99	4	19	39	Kit Embreagem Continental	Lado Direito	CONT-00032	1	339.92	339.92	7864	36	33	24	2026-11-14 12:39:14	2026-11-14 12:39:14
107	55	100	3	28	56	Calota Moura	Dianteiro	MOUR-00049	2	40.17	80.34	1510	32	15	12	2026-11-14 12:39:14	2026-11-14 12:39:14
108	56	101	2	161	324	Bateria 70Ah Varga	Lado Esquerdo	VARG-00317	1	891.09	891.09	10083	37	27	27	2026-11-14 12:39:14	2026-11-14 12:39:14
109	57	102	2	136	274	Vela de Ignição Heliar HD	Dianteiro	HELI-00267	2	156.56	313.12	2049	35	29	22	2026-11-14 12:39:14	2026-11-14 12:39:14
110	58	103	3	44	91	Palheta Limpador Magneti Marelli	Original	MAGN-00084	1	178.07	178.07	2036	77	25	7	2026-11-14 12:39:14	2026-11-14 12:39:14
111	58	104	8	48	100	Filtro de Óleo SKF Linha Leve	Traseiro	SKF-00093	2	130.72	261.44	3220	39	11	8	2026-11-14 12:39:14	2026-11-14 12:39:14
112	58	105	5	50	103	Eletroventilador Magneti Marelli Original	Lado Direito	MAGN-00096	1	504.46	504.46	4832	76	56	13	2026-11-14 12:39:14	2026-11-14 12:39:14
113	59	106	3	17	34	Bateria 70Ah SKF Original	Único	SKF-00027	1	102.86	102.86	14315	20	19	28	2026-11-14 12:39:14	2026-11-14 12:39:14
114	59	106	3	148	300	Capa de Volante Gates	Lado Esquerdo	GATE-00293	2	274.29	548.58	1008	32	16	18	2026-11-14 12:39:14	2026-11-14 12:39:14
115	60	107	8	30	58	Kit Amortecedores Mahle Reforçado	Único	MAHL-00051	1	754.80	754.80	8447	44	18	17	2026-11-14 12:39:14	2026-11-14 12:39:14
116	60	108	2	77	157	Coifa de Direção Sachs Série Ouro	Dianteiro	SACH-00150	1	421.99	421.99	7268	69	20	17	2026-11-14 12:39:14	2026-11-14 12:39:14
117	60	109	7	111	230	Kit Freio Traseiro Moura	Lado Esquerdo	MOUR-00223	1	366.40	366.40	2254	29	25	11	2026-11-14 12:39:14	2026-11-14 12:39:14
118	61	110	1	112	233	Tensor da Correia Magneti Marelli	Dianteiro	MAGN-00226	1	436.66	436.66	3411	32	26	12	2026-11-14 12:39:14	2026-11-14 12:39:14
119	61	111	6	157	316	Caixa de Direção Continental	HD	CONT-00309	2	388.92	777.84	6727	45	36	19	2026-11-14 12:39:14	2026-11-14 12:39:14
120	62	112	3	44	91	Palheta Limpador Magneti Marelli	Original	MAGN-00084	1	178.07	178.07	2036	77	25	7	2026-11-14 12:39:14	2026-11-14 12:39:14
121	62	113	1	141	283	Coifa de Direção Mann Filter Linha Leve	Esportivo	MANN-00276	2	594.45	1188.90	6427	48	34	17	2026-11-14 12:39:14	2026-11-14 12:39:14
122	63	114	3	17	34	Bateria 70Ah SKF Original	Único	SKF-00027	2	102.86	205.72	14315	20	19	28	2026-11-14 12:39:14	2026-11-14 12:39:14
123	63	115	4	45	92	Caixa de Direção NGK	Reforçado	NGK-00085	2	350.84	701.68	6212	51	31	26	2026-11-14 12:39:14	2026-11-14 12:39:14
124	63	116	5	68	140	Palheta Limpador Varga	Traseiro	VARG-00133	2	233.97	467.94	1891	50	29	15	2026-11-14 12:39:14	2026-11-14 12:39:14
125	64	117	3	148	301	Capa de Volante Gates	Dianteiro	GATE-00294	1	250.78	250.78	1140	70	21	7	2026-11-14 12:39:14	2026-11-14 12:39:14
126	65	118	4	19	39	Kit Embreagem Continental	Lado Direito	CONT-00032	2	339.92	679.84	7864	36	33	24	2026-11-14 12:39:14	2026-11-14 12:39:14
127	65	118	4	92	189	Antena Automotiva Monroe	Lado Direito	MONR-00182	2	212.04	424.08	2478	72	28	8	2026-11-14 12:39:14	2026-11-14 12:39:14
128	65	119	5	50	102	Eletroventilador Magneti Marelli Original	Traseiro	MAGN-00095	2	524.05	1048.10	3132	73	59	15	2026-11-14 12:39:14	2026-11-14 12:39:14
129	66	120	2	88	180	Junta do Cabeçote Heliar	HD	HELI-00173	1	129.69	129.69	2979	28	22	22	2026-11-14 12:39:14	2026-11-14 12:39:14
130	66	121	3	172	346	Palheta Limpador Bosch	Dianteiro	BOSC-00339	2	113.64	227.28	2393	41	18	14	2026-11-14 12:39:14	2026-11-14 12:39:14
131	67	122	7	52	108	Kit Ferramentas Delphi Linha Leve	Dianteiro	DELP-00101	2	222.21	444.42	751	64	29	10	2026-11-14 12:39:14	2026-11-14 12:39:14
132	67	123	8	61	126	Terminal Axial Mahle	HD	MAHL-00119	2	859.19	1718.38	5880	35	33	20	2026-11-14 12:39:14	2026-11-14 12:39:14
133	67	124	3	166	333	Barra Estabilizadora Nakata	Único	NAKA-00326	2	358.51	717.02	6891	58	22	25	2026-11-14 12:39:14	2026-11-14 12:39:14
134	68	125	6	153	309	Lâmpada Farol SKF	Original	SKF-00302	2	1293.32	2586.64	14688	26	21	19	2026-11-14 12:39:14	2026-11-14 12:39:14
135	69	126	2	11	23	Coifa da Homocinética NGK HD	Original	NGK-00016	1	502.38	502.38	11721	42	37	21	2026-11-14 12:39:14	2026-11-14 12:39:14
136	69	126	2	185	370	Alternador SKF	Lado Esquerdo	SKF-00363	1	200.85	200.85	8461	24	19	21	2026-11-14 12:39:14	2026-11-14 12:39:14
137	70	127	5	82	168	Eletroventilador Moura Original	Lado Esquerdo	MOUR-00161	2	355.93	711.86	2393	55	32	29	2026-11-14 12:39:14	2026-11-14 12:39:14
138	71	128	5	70	144	Amortecedor Traseiro Denso Premium	Esportivo	DENS-00137	1	757.42	757.42	5776	67	18	25	2026-11-14 12:39:14	2026-11-14 12:39:14
139	72	129	8	30	58	Kit Amortecedores Mahle Reforçado	Único	MAHL-00051	1	754.80	754.80	8447	44	18	17	2026-11-14 12:39:14	2026-11-14 12:39:14
140	73	130	1	147	297	Atuador de Embreagem Moura	Dianteiro	MOUR-00290	2	293.37	586.74	9140	40	37	26	2026-11-14 12:39:14	2026-11-14 12:39:14
141	74	131	4	23	46	Lonas de Freio Gates	Esportivo	GATE-00039	1	266.21	266.21	995	32	21	8	2026-11-14 12:39:14	2026-11-14 12:39:14
142	74	131	4	164	328	Calota Fram	Dianteiro	FRAM-00321	1	248.79	248.79	1183	71	23	16	2026-11-14 12:39:14	2026-11-14 12:39:14
143	74	132	3	42	84	Radiador Valeo	Esportivo	VALE-00077	1	788.93	788.93	1809	50	47	13	2026-11-14 12:39:14	2026-11-14 12:39:14
144	75	133	1	138	279	Mangueira do Radiador Mann Filter	Original	MANN-00272	1	486.77	486.77	2142	40	36	12	2026-11-14 12:39:14	2026-11-14 12:39:14
145	75	134	8	146	295	Ventilador do Radiador Mahle	Único	MAHL-00288	1	336.44	336.44	1638	61	39	13	2026-11-14 12:39:14	2026-11-14 12:39:14
146	75	135	2	192	383	Tensor da Correia Cofap Série Ouro	Reforçado	COFA-00376	1	308.54	308.54	3549	31	11	22	2026-11-14 12:39:14	2026-11-14 12:39:14
147	76	136	3	46	96	Mola Helicoidal Nakata	HD	NAKA-00089	2	724.93	1449.86	8557	74	16	16	2026-11-14 12:39:14	2026-11-14 12:39:14
148	76	137	1	116	238	Capa de Volante Fram	HD	FRAM-00231	1	267.85	267.85	2219	62	17	5	2026-11-14 12:39:14	2026-11-14 12:39:14
149	76	137	1	179	360	Junta Homocinética Nakata Série Ouro	Esportivo	NAKA-00353	2	411.08	822.16	11427	38	40	29	2026-11-14 12:39:14	2026-11-14 12:39:14
150	77	138	8	56	115	Filtro de Óleo Mann Filter Reforçado	Lado Direito	MANN-00108	2	452.64	905.28	4119	32	29	8	2026-11-14 12:39:14	2026-11-14 12:39:14
151	77	139	3	142	287	Terminal de Direção TRW	Esportivo	TRW-00280	2	657.66	1315.32	6238	72	25	19	2026-11-14 12:39:14	2026-11-14 12:39:14
152	78	140	2	11	21	Coifa da Homocinética NGK HD	Traseiro	NGK-00014	1	458.49	458.49	7146	30	30	27	2026-11-14 12:39:14	2026-11-14 12:39:14
153	78	141	1	137	276	Sensor de Rotação Bosch Reforçado	HD	BOSC-00269	2	454.55	909.10	11779	39	28	26	2026-11-14 12:39:14	2026-11-14 12:39:14
154	79	142	3	119	245	Kit Freio Traseiro Monroe	Lado Esquerdo	MONR-00238	1	687.08	687.08	928	20	25	11	2026-11-14 12:39:14	2026-11-14 12:39:14
155	80	143	1	14	28	Pivô de Suspensão Varga	Dianteiro	VARG-00021	2	538.75	1077.50	3137	53	25	15	2026-11-14 12:39:14	2026-11-14 12:39:14
156	80	144	2	73	151	Lâmpada Farol Mahle	Lado Esquerdo	MAHL-00144	2	143.95	287.90	8005	30	25	24	2026-11-14 12:39:14	2026-11-14 12:39:14
157	81	145	4	45	94	Caixa de Direção NGK	Lado Esquerdo	NGK-00087	2	350.84	701.68	4446	42	34	21	2026-11-14 12:39:14	2026-11-14 12:39:14
158	82	146	1	189	376	Coifa de Direção SKF	Único	SKF-00369	2	949.81	1899.62	7866	69	26	18	2026-11-14 12:39:14	2026-11-14 12:39:14
159	83	147	2	62	130	Mola Helicoidal Heliar	Reforçado	HELI-00123	1	671.85	671.85	5155	68	29	22	2026-11-14 12:39:14	2026-11-14 12:39:14
160	84	148	7	31	59	Flexível de Freio Varga	Esportivo	VARG-00052	2	349.33	698.66	3502	23	23	14	2026-11-14 12:39:14	2026-11-14 12:39:14
161	84	149	3	148	301	Capa de Volante Gates	Dianteiro	GATE-00294	2	250.78	501.56	1140	70	21	7	2026-11-14 12:39:14	2026-11-14 12:39:14
162	84	150	2	185	370	Alternador SKF	Lado Esquerdo	SKF-00363	2	200.85	401.70	8461	24	19	21	2026-11-14 12:39:14	2026-11-14 12:39:14
163	85	151	5	50	102	Eletroventilador Magneti Marelli Original	Traseiro	MAGN-00095	1	524.05	524.05	3132	73	59	15	2026-11-14 12:39:14	2026-11-14 12:39:14
164	86	152	4	20	41	Calota Continental	Único	CONT-00034	1	137.47	137.47	383	39	24	15	2026-11-14 12:39:14	2026-11-14 12:39:14
165	86	153	5	134	270	Amortecedor Dianteiro Mahle	Lado Esquerdo	MAHL-00263	1	526.16	526.16	4389	51	23	18	2026-11-14 12:39:14	2026-11-14 12:39:14
166	86	154	6	169	340	Alternador NGK Reforçado	Esportivo	NGK-00333	1	1218.10	1218.10	11043	38	17	20	2026-11-14 12:39:14	2026-11-14 12:39:14
167	87	155	4	19	38	Kit Embreagem Continental	Traseiro	CONT-00031	1	356.92	356.92	2288	40	26	24	2026-11-14 12:39:14	2026-11-14 12:39:14
168	87	156	1	54	113	Amortecedor Traseiro NGK	Dianteiro	NGK-00106	1	271.87	271.87	1723	53	15	24	2026-11-14 12:39:14	2026-11-14 12:39:14
169	87	157	3	187	374	Junta Homocinética Denso	Único	DENS-00367	1	936.52	936.52	11112	35	34	29	2026-11-14 12:39:14	2026-11-14 12:39:14
170	88	158	4	12	24	Protetor de Carter Valeo	Original	VALE-00017	1	217.28	217.28	1819	65	19	6	2026-11-14 12:39:14	2026-11-14 12:39:14
171	88	159	5	38	75	Barra Estabilizadora Fram	Lado Direito	FRAM-00068	2	231.59	463.18	1805	77	20	18	2026-11-14 12:39:14	2026-11-14 12:39:14
172	88	160	6	153	309	Lâmpada Farol SKF	Original	SKF-00302	1	1293.32	1293.32	14688	26	21	19	2026-11-14 12:39:14	2026-11-14 12:39:14
173	89	161	5	86	176	Amortecedor Traseiro Gates	Único	GATE-00169	1	355.97	355.97	1804	77	29	13	2026-11-14 12:39:14	2026-11-14 12:39:14
174	89	162	2	88	181	Junta do Cabeçote Heliar	Reforçado	HELI-00174	1	137.40	137.40	4105	31	13	14	2026-11-14 12:39:14	2026-11-14 12:39:14
175	89	163	6	169	340	Alternador NGK Reforçado	Esportivo	NGK-00333	1	1218.10	1218.10	11043	38	17	20	2026-11-14 12:39:14	2026-11-14 12:39:14
176	90	164	5	43	87	Kit Embreagem Continental Reforçado	Lado Esquerdo	CONT-00080	2	105.52	211.04	6970	38	40	17	2026-11-14 12:39:14	2026-11-14 12:39:14
177	90	165	6	69	142	Coifa de Direção Mahle	Único	MAHL-00135	2	436.67	873.34	8307	35	31	30	2026-11-14 12:39:14	2026-11-14 12:39:14
178	90	166	7	111	231	Kit Freio Traseiro Moura	HD	MOUR-00224	1	381.82	381.82	5303	33	30	15	2026-11-14 12:39:14	2026-11-14 12:39:14
179	91	167	6	16	33	Filtro de Ar Delphi	Único	DELP-00026	2	325.22	650.44	1359	36	30	17	2026-11-14 12:39:14	2026-11-14 12:39:14
180	91	168	8	18	35	Válvula Termostática Continental	Original	CONT-00028	2	503.53	1007.06	1692	40	40	18	2026-11-14 12:39:14	2026-11-14 12:39:14
181	91	168	8	184	369	Kit Correia Dentada SKF Original	Lado Esquerdo	SKF-00362	2	152.57	305.14	1796	32	12	9	2026-11-14 12:39:14	2026-11-14 12:39:14
182	92	169	5	134	270	Amortecedor Dianteiro Mahle	Lado Esquerdo	MAHL-00263	2	526.16	1052.32	4389	51	23	18	2026-11-14 12:39:14	2026-11-14 12:39:14
183	92	170	1	145	293	Sensor de Oxigênio Cofap	Traseiro	COFA-00286	2	542.85	1085.70	5030	36	20	20	2026-11-14 12:39:14	2026-11-14 12:39:14
184	92	170	1	196	391	Palheta Limpador Heliar	Dianteiro	HELI-00384	1	272.12	272.12	619	47	24	5	2026-11-14 12:39:14	2026-11-14 12:39:14
185	93	171	1	137	277	Sensor de Rotação Bosch Reforçado	Esportivo	BOSC-00270	2	472.38	944.76	2573	31	19	23	2026-11-14 12:39:14	2026-11-14 12:39:14
186	93	172	5	139	280	Junta Homocinética Bosch Linha Leve	Único	BOSC-00273	2	822.40	1644.80	5475	47	32	16	2026-11-14 12:39:14	2026-11-14 12:39:14
187	93	173	3	165	332	Terminal Axial Cofap Original	Lado Esquerdo	COFA-00325	1	1008.35	1008.35	2008	44	29	15	2026-11-14 12:39:14	2026-11-14 12:39:14
188	94	174	2	88	181	Junta do Cabeçote Heliar	Reforçado	HELI-00174	2	137.40	274.80	4105	31	13	14	2026-11-14 12:39:14	2026-11-14 12:39:14
189	94	175	3	119	244	Kit Freio Traseiro Monroe	HD	MONR-00237	1	654.97	654.97	826	30	30	11	2026-11-14 12:39:14	2026-11-14 12:39:14
190	95	176	5	97	198	Sensor de Rotação Heliar	Reforçado	HELI-00191	2	658.66	1317.32	7016	40	20	18	2026-11-14 12:39:14	2026-11-14 12:39:14
191	95	176	5	128	258	Junta do Cabeçote Denso	HD	DENS-00251	2	280.87	561.74	684	35	28	18	2026-11-14 12:39:14	2026-11-14 12:39:14
192	96	177	8	184	369	Kit Correia Dentada SKF Original	Lado Esquerdo	SKF-00362	2	152.57	305.14	1796	32	12	9	2026-11-14 12:39:14	2026-11-14 12:39:14
193	97	178	5	134	268	Amortecedor Dianteiro Mahle	Dianteiro	MAHL-00261	2	499.85	999.70	4640	71	18	25	2026-11-14 12:39:14	2026-11-14 12:39:14
194	97	178	5	176	353	Filtro de Ar Cofap	Lado Direito	COFA-00346	1	417.64	417.64	1068	39	19	12	2026-11-14 12:39:14	2026-11-14 12:39:14
195	97	179	6	195	389	Kit Embreagem Denso	Dianteiro	DENS-00382	2	1299.74	2599.48	2397	40	34	21	2026-11-14 12:39:14	2026-11-14 12:39:14
196	98	180	4	19	40	Kit Embreagem Continental	Reforçado	CONT-00033	1	343.32	343.32	4628	42	40	25	2026-11-14 12:39:14	2026-11-14 12:39:14
197	98	181	3	35	68	Rolamento de Embreagem Bosch Linha Leve	Traseiro	BOSC-00061	2	1010.72	2021.44	2894	45	36	17	2026-11-14 12:39:14	2026-11-14 12:39:14
198	98	182	7	126	253	Kit Amortecedores Continental	HD	CONT-00246	2	802.00	1604.00	4845	74	26	21	2026-11-14 12:39:14	2026-11-14 12:39:14
199	99	183	2	2	4	Kit Pastilhas de Freio Bosch	Eixo Traseiro	PAST-BOSCH-TRAS	2	189.90	379.80	1100	22	16	7	2026-11-14 12:39:14	2026-11-14 12:39:14
200	99	183	2	149	302	Terminal Axial Varga	Único	VARG-00295	1	608.01	608.01	3316	35	31	19	2026-11-14 12:39:14	2026-11-14 12:39:14
201	99	184	4	45	93	Caixa de Direção NGK	Traseiro	NGK-00086	1	361.81	361.81	4312	68	31	28	2026-11-14 12:39:14	2026-11-14 12:39:14
202	100	185	3	66	137	Reservatório de Água TRW	Reforçado	TRW-00130	1	734.74	734.74	3751	71	38	21	2026-11-14 12:39:14	2026-11-14 12:39:14
203	100	186	1	108	221	Kit Ferramentas Moura	Esportivo	MOUR-00214	1	271.21	271.21	2041	34	22	13	2026-11-14 12:39:14	2026-11-14 12:39:14
204	100	187	6	153	308	Lâmpada Farol SKF	Dianteiro	SKF-00301	1	1370.15	1370.15	4438	38	24	29	2026-11-14 12:39:14	2026-11-14 12:39:14
205	101	188	2	11	22	Coifa da Homocinética NGK HD	Reforçado	NGK-00015	1	521.89	521.89	1112	42	33	22	2026-11-14 12:39:14	2026-11-14 12:39:14
206	101	189	5	59	124	Atuador de Embreagem Sachs	Dianteiro	SACH-00117	1	1312.39	1312.39	10573	50	31	30	2026-11-14 12:39:15	2026-11-14 12:39:15
207	102	190	5	134	269	Amortecedor Dianteiro Mahle	Esportivo	MAHL-00262	2	552.47	1104.94	7672	79	28	23	2026-11-14 12:39:15	2026-11-14 12:39:15
208	102	191	3	165	332	Terminal Axial Cofap Original	Lado Esquerdo	COFA-00325	1	1008.35	1008.35	2008	44	29	15	2026-11-14 12:39:15	2026-11-14 12:39:15
209	103	192	1	14	29	Pivô de Suspensão Varga	Esportivo	VARG-00022	1	555.59	555.59	6242	69	17	14	2026-11-14 12:39:15	2026-11-14 12:39:15
210	103	193	6	100	203	Protetor de Carter Mahle	Esportivo	MAHL-00196	1	145.88	145.88	644	38	29	9	2026-11-14 12:39:15	2026-11-14 12:39:15
211	104	194	5	85	175	Bomba de Direção Hidráulica Gates	Lado Esquerdo	GATE-00168	1	276.99	276.99	4123	34	38	20	2026-11-14 12:39:15	2026-11-14 12:39:15
212	104	195	3	165	332	Terminal Axial Cofap Original	Lado Esquerdo	COFA-00325	2	1008.35	2016.70	2008	44	29	15	2026-11-14 12:39:15	2026-11-14 12:39:15
213	105	196	3	46	96	Mola Helicoidal Nakata	HD	NAKA-00089	1	724.93	724.93	8557	74	16	16	2026-11-14 12:39:15	2026-11-14 12:39:15
214	105	197	5	82	168	Eletroventilador Moura Original	Lado Esquerdo	MOUR-00161	2	355.93	711.86	2393	55	32	29	2026-11-14 12:39:15	2026-11-14 12:39:15
215	105	198	4	190	377	Barra Estabilizadora Valeo	Reforçado	VALE-00370	1	362.90	362.90	5321	53	15	19	2026-11-14 12:39:15	2026-11-14 12:39:15
216	106	199	3	17	34	Bateria 70Ah SKF Original	Único	SKF-00027	2	102.86	205.72	14315	20	19	28	2026-11-14 12:39:15	2026-11-14 12:39:15
217	106	200	6	84	172	Antena Automotiva Delphi	HD	DELP-00165	2	286.57	573.14	1256	43	15	16	2026-11-14 12:39:15	2026-11-14 12:39:15
218	107	201	5	59	124	Atuador de Embreagem Sachs	Dianteiro	SACH-00117	1	1312.39	1312.39	10573	50	31	30	2026-11-14 12:39:15	2026-11-14 12:39:15
219	107	202	1	105	214	Motor de Partida Magneti Marelli	Lado Direito	MAGN-00207	2	946.35	1892.70	1288	39	28	23	2026-11-14 12:39:15	2026-11-14 12:39:15
220	107	203	4	110	226	Terminal de Direção Nakata	Reforçado	NAKA-00219	1	615.81	615.81	2422	74	19	14	2026-11-14 12:39:15	2026-11-14 12:39:15
221	108	204	2	101	208	Caixa de Direção Denso	Dianteiro	DENS-00201	1	1132.78	1132.78	6741	45	33	25	2026-11-14 12:39:15	2026-11-14 12:39:15
222	109	205	2	152	306	Bomba de Combustível Sachs	Esportivo	SACH-00299	1	392.97	392.97	1981	18	26	18	2026-11-14 12:39:15	2026-11-14 12:39:15
223	109	206	1	179	359	Junta Homocinética Nakata Série Ouro	Lado Direito	NAKA-00352	1	419.55	419.55	6466	36	34	17	2026-11-14 12:39:15	2026-11-14 12:39:15
224	110	207	3	186	372	Radiador Heliar Premium	Original	HELI-00365	2	205.42	410.84	512	83	40	19	2026-11-14 12:39:15	2026-11-14 12:39:15
225	111	208	4	164	328	Calota Fram	Dianteiro	FRAM-00321	2	248.79	497.58	1183	71	23	16	2026-11-14 12:39:15	2026-11-14 12:39:15
226	112	209	5	89	182	Lâmpada Farol Cofap Série Ouro	Dianteiro	COFA-00175	1	265.29	265.29	9164	29	15	21	2026-11-14 12:39:15	2026-11-14 12:39:15
227	112	210	2	127	256	Lonas de Freio Cofap Original	Dianteiro	COFA-00249	2	547.82	1095.64	3466	22	16	5	2026-11-14 12:39:15	2026-11-14 12:39:15
228	113	211	5	80	163	Filtro de Ar Magneti Marelli Série Ouro	Original	MAGN-00156	1	291.47	291.47	281	27	11	10	2026-11-14 12:39:15	2026-11-14 12:39:15
229	114	212	5	38	77	Barra Estabilizadora Fram	Reforçado	FRAM-00070	1	246.06	246.06	7585	49	27	19	2026-11-14 12:39:15	2026-11-14 12:39:15
230	114	212	5	80	164	Filtro de Ar Magneti Marelli Série Ouro	Esportivo	MAGN-00157	2	291.47	582.94	1370	21	26	9	2026-11-14 12:39:15	2026-11-14 12:39:15
231	114	212	5	82	168	Eletroventilador Moura Original	Lado Esquerdo	MOUR-00161	2	355.93	711.86	2393	55	32	29	2026-11-14 12:39:15	2026-11-14 12:39:15
232	115	213	1	117	240	Coifa de Direção Sachs	Único	SACH-00233	1	655.50	655.50	6243	68	33	16	2026-11-14 12:39:15	2026-11-14 12:39:15
233	115	213	1	180	361	Kit Ferramentas Varga	Único	VARG-00354	1	182.01	182.01	415	76	16	7	2026-11-14 12:39:15	2026-11-14 12:39:15
234	116	214	4	113	235	Bobina de Ignição Mahle Linha Leve	Único	MAHL-00228	1	794.57	794.57	8889	28	26	18	2026-11-14 12:39:15	2026-11-14 12:39:15
235	117	215	3	15	31	Pastilha de Freio Monroe	HD	MONR-00024	2	495.48	990.96	3893	28	20	14	2026-11-14 12:39:15	2026-11-14 12:39:15
236	117	215	3	28	56	Calota Moura	Dianteiro	MOUR-00049	2	40.17	80.34	1510	32	15	12	2026-11-14 12:39:15	2026-11-14 12:39:15
237	117	216	7	31	59	Flexível de Freio Varga	Esportivo	VARG-00052	1	349.33	349.33	3502	23	23	14	2026-11-14 12:39:15	2026-11-14 12:39:15
238	118	217	6	100	205	Protetor de Carter Mahle	Dianteiro	MAHL-00198	1	132.25	132.25	2048	54	15	14	2026-11-14 12:39:15	2026-11-14 12:39:15
239	119	218	1	116	238	Capa de Volante Fram	HD	FRAM-00231	1	267.85	267.85	2219	62	17	5	2026-11-14 12:39:15	2026-11-14 12:39:15
240	119	219	8	178	357	Reservatório de Água Cofap	Lado Direito	COFA-00350	2	745.75	1491.50	3172	85	43	10	2026-11-14 12:39:15	2026-11-14 12:39:15
241	120	220	2	8	13	Filtro de Combustível Mahle	Traseiro	MAHL-00006	2	402.08	804.16	2269	39	27	15	2026-11-14 12:39:15	2026-11-14 12:39:15
242	120	221	1	162	326	Mangueira do Radiador SKF HD	Reforçado	SKF-00319	1	731.55	731.55	1138	76	37	16	2026-11-14 12:39:15	2026-11-14 12:39:15
243	121	222	3	15	30	Pastilha de Freio Monroe	Dianteiro	MONR-00023	1	510.49	510.49	5227	21	20	10	2026-11-14 12:39:15	2026-11-14 12:39:15
244	121	223	4	45	94	Caixa de Direção NGK	Lado Esquerdo	NGK-00087	2	350.84	701.68	4446	42	34	21	2026-11-14 12:39:15	2026-11-14 12:39:15
245	121	224	6	84	170	Antena Automotiva Delphi	Traseiro	DELP-00163	1	264.31	264.31	1916	43	16	10	2026-11-14 12:39:15	2026-11-14 12:39:15
246	122	225	5	36	72	Kit Ferramentas Magneti Marelli	HD	MAGN-00065	2	61.58	123.16	2203	33	23	10	2026-11-14 12:39:15	2026-11-14 12:39:15
247	123	226	2	122	248	Reservatório de Água SKF	Único	SKF-00241	1	162.12	162.12	5786	89	36	16	2026-11-14 12:39:15	2026-11-14 12:39:15
248	123	227	7	159	319	Tambor de Freio NGK	Dianteiro	NGK-00312	1	415.20	415.20	3581	31	28	7	2026-11-14 12:39:15	2026-11-14 12:39:15
249	124	228	3	47	97	Lonas de Freio Bosch Série Ouro	Reforçado	BOSC-00090	1	470.11	470.11	4426	21	15	8	2026-11-14 12:39:15	2026-11-14 12:39:15
250	125	229	2	11	22	Coifa da Homocinética NGK HD	Reforçado	NGK-00015	1	521.89	521.89	1112	42	33	22	2026-11-14 12:39:15	2026-11-14 12:39:15
251	126	230	3	42	85	Radiador Valeo	HD	VALE-00078	2	820.49	1640.98	1570	79	49	20	2026-11-14 12:39:15	2026-11-14 12:39:15
252	126	231	8	178	355	Reservatório de Água Cofap	Esportivo	COFA-00348	1	715.62	715.62	848	80	46	12	2026-11-14 12:39:15	2026-11-14 12:39:15
253	127	232	3	102	210	Barra Estabilizadora Fram Premium	Lado Esquerdo	FRAM-00203	2	668.08	1336.16	7218	46	23	21	2026-11-14 12:39:15	2026-11-14 12:39:15
254	127	232	3	119	245	Kit Freio Traseiro Monroe	Lado Esquerdo	MONR-00238	2	687.08	1374.16	928	20	25	11	2026-11-14 12:39:15	2026-11-14 12:39:15
255	127	233	2	185	370	Alternador SKF	Lado Esquerdo	SKF-00363	2	200.85	401.70	8461	24	19	21	2026-11-14 12:39:15	2026-11-14 12:39:15
256	128	234	4	92	189	Antena Automotiva Monroe	Lado Direito	MONR-00182	2	212.04	424.08	2478	72	28	8	2026-11-14 12:39:15	2026-11-14 12:39:15
257	128	235	8	168	338	Filtro de Óleo Magneti Marelli Série Ouro	HD	MAGN-00331	2	181.24	362.48	2695	34	17	14	2026-11-14 12:39:15	2026-11-14 12:39:15
258	129	236	8	72	148	Bomba de Combustível Fram	Traseiro	FRAM-00141	2	387.13	774.26	572	24	12	11	2026-11-14 12:39:15	2026-11-14 12:39:15
259	130	237	7	91	187	Kit Embreagem Sachs	Reforçado	SACH-00180	1	1230.58	1230.58	4568	44	37	24	2026-11-14 12:39:15	2026-11-14 12:39:15
260	130	238	1	125	252	Bomba de Direção Hidráulica Denso Linha Leve	Reforçado	DENS-00245	1	225.57	225.57	1170	48	37	22	2026-11-14 12:39:15	2026-11-14 12:39:15
261	130	239	4	200	398	Kit Correia Dentada Cofap	Lado Esquerdo	COFA-00391	2	94.54	189.08	794	27	17	15	2026-11-14 12:39:15	2026-11-14 12:39:15
262	131	240	2	106	216	Radiador NGK	Esportivo	NGK-00209	2	265.77	531.54	4952	65	46	19	2026-11-14 12:39:15	2026-11-14 12:39:15
263	132	241	6	34	66	Eletroventilador Fram	Lado Esquerdo	FRAM-00059	2	884.84	1769.68	1772	40	33	22	2026-11-14 12:39:15	2026-11-14 12:39:15
264	133	242	5	139	280	Junta Homocinética Bosch Linha Leve	Único	BOSC-00273	2	822.40	1644.80	5475	47	32	16	2026-11-14 12:39:15	2026-11-14 12:39:15
265	134	243	3	119	243	Kit Freio Traseiro Monroe	Dianteiro	MONR-00236	2	629.29	1258.58	6387	33	26	7	2026-11-14 12:39:15	2026-11-14 12:39:15
266	134	243	3	186	372	Radiador Heliar Premium	Original	HELI-00365	1	205.42	205.42	512	83	40	19	2026-11-14 12:39:15	2026-11-14 12:39:15
267	134	244	8	178	357	Reservatório de Água Cofap	Lado Direito	COFA-00350	1	745.75	745.75	3172	85	43	10	2026-11-14 12:39:15	2026-11-14 12:39:15
268	135	245	4	45	93	Caixa de Direção NGK	Traseiro	NGK-00086	2	361.81	723.62	4312	68	31	28	2026-11-14 12:39:15	2026-11-14 12:39:15
269	135	246	7	111	231	Kit Freio Traseiro Moura	HD	MOUR-00224	1	381.82	381.82	5303	33	30	15	2026-11-14 12:39:15	2026-11-14 12:39:15
270	135	247	6	195	389	Kit Embreagem Denso	Dianteiro	DENS-00382	1	1299.74	1299.74	2397	40	34	21	2026-11-14 12:39:15	2026-11-14 12:39:15
271	136	248	5	128	258	Junta do Cabeçote Denso	HD	DENS-00251	1	280.87	280.87	684	35	28	18	2026-11-14 12:39:15	2026-11-14 12:39:15
272	137	249	5	128	258	Junta do Cabeçote Denso	HD	DENS-00251	2	280.87	561.74	684	35	28	18	2026-11-14 12:39:15	2026-11-14 12:39:15
273	137	250	8	167	334	Cilindro de Roda Heliar	Original	HELI-00327	1	141.83	141.83	895	26	25	12	2026-11-14 12:39:15	2026-11-14 12:39:15
274	137	250	8	184	369	Kit Correia Dentada SKF Original	Lado Esquerdo	SKF-00362	2	152.57	305.14	1796	32	12	9	2026-11-14 12:39:15	2026-11-14 12:39:15
275	138	251	3	81	165	Bobina de Ignição Valeo Linha Leve	Único	VALE-00158	2	189.64	379.28	11819	27	28	24	2026-11-14 12:39:15	2026-11-14 12:39:15
276	138	252	6	84	171	Antena Automotiva Delphi	Esportivo	DELP-00164	2	275.44	550.88	2098	39	21	19	2026-11-14 12:39:15	2026-11-14 12:39:15
277	139	253	5	27	52	Coifa da Homocinética Mann Filter HD	Lado Direito	MANN-00045	1	1088.28	1088.28	3862	36	32	18	2026-11-14 12:39:15	2026-11-14 12:39:15
278	139	254	8	99	201	Junta Homocinética SKF Série Ouro	Lado Esquerdo	SKF-00194	1	944.80	944.80	5898	47	33	21	2026-11-14 12:39:15	2026-11-14 12:39:15
279	139	255	2	135	272	Cilindro de Roda Nakata	Lado Direito	NAKA-00265	1	599.81	599.81	5083	25	25	7	2026-11-14 12:39:15	2026-11-14 12:39:15
280	140	256	4	23	47	Lonas de Freio Gates	Traseiro	GATE-00040	1	266.21	266.21	3128	29	25	8	2026-11-14 12:39:15	2026-11-14 12:39:15
281	140	256	4	49	101	Bobina de Ignição Fram	Único	FRAM-00094	2	572.08	1144.16	4666	28	26	21	2026-11-14 12:39:15	2026-11-14 12:39:15
282	140	257	6	169	341	Alternador NGK Reforçado	Dianteiro	NGK-00334	1	1230.28	1230.28	4469	34	15	29	2026-11-14 12:39:15	2026-11-14 12:39:15
283	141	258	3	37	74	Bomba de Direção Hidráulica Delphi	Lado Esquerdo	DELP-00067	1	489.00	489.00	3580	44	23	22	2026-11-14 12:39:15	2026-11-14 12:39:15
284	141	259	6	84	172	Antena Automotiva Delphi	HD	DELP-00165	1	286.57	286.57	1256	43	15	16	2026-11-14 12:39:15	2026-11-14 12:39:15
285	142	260	4	58	120	Reservatório de Água Mann Filter	HD	MANN-00113	2	575.13	1150.26	1848	47	34	28	2026-11-14 12:39:15	2026-11-14 12:39:15
286	142	261	2	62	128	Mola Helicoidal Heliar	Esportivo	HELI-00121	1	678.31	678.31	4020	70	16	23	2026-11-14 12:39:15	2026-11-14 12:39:15
287	142	261	2	192	382	Tensor da Correia Cofap Série Ouro	Original	COFA-00375	1	344.64	344.64	1425	31	20	10	2026-11-14 12:39:15	2026-11-14 12:39:15
288	143	262	2	127	257	Lonas de Freio Cofap Original	Lado Direito	COFA-00250	2	506.08	1012.16	4573	32	17	7	2026-11-14 12:39:15	2026-11-14 12:39:15
289	144	263	4	132	265	Calota Nakata	Original	NAKA-00258	2	179.69	359.38	2338	79	12	17	2026-11-14 12:39:15	2026-11-14 12:39:15
290	145	264	3	46	96	Mola Helicoidal Nakata	HD	NAKA-00089	1	724.93	724.93	8557	74	16	16	2026-11-14 12:39:15	2026-11-14 12:39:15
291	145	265	2	75	154	Coifa da Homocinética Fram Série Ouro	Lado Direito	FRAM-00147	1	1032.75	1032.75	7810	48	30	21	2026-11-14 12:39:15	2026-11-14 12:39:15
292	145	266	8	184	369	Kit Correia Dentada SKF Original	Lado Esquerdo	SKF-00362	2	152.57	305.14	1796	32	12	9	2026-11-14 12:39:15	2026-11-14 12:39:15
293	146	267	1	108	220	Kit Ferramentas Moura	HD	MOUR-00213	1	271.21	271.21	228	77	30	8	2026-11-14 12:39:15	2026-11-14 12:39:15
294	147	268	8	22	44	Amortecedor Traseiro Cofap Premium	Único	COFA-00037	1	209.10	209.10	2079	69	16	15	2026-11-14 12:39:15	2026-11-14 12:39:15
295	147	269	7	126	253	Kit Amortecedores Continental	HD	CONT-00246	2	802.00	1604.00	4845	74	26	21	2026-11-14 12:39:15	2026-11-14 12:39:15
296	148	270	1	141	284	Coifa de Direção Mann Filter Linha Leve	Traseiro	MANN-00277	2	600.64	1201.28	3023	59	23	27	2026-11-14 12:39:15	2026-11-14 12:39:15
297	149	271	2	11	23	Coifa da Homocinética NGK HD	Original	NGK-00016	1	502.38	502.38	11721	42	37	21	2026-11-14 12:39:15	2026-11-14 12:39:15
298	149	272	5	85	175	Bomba de Direção Hidráulica Gates	Lado Esquerdo	GATE-00168	1	276.99	276.99	4123	34	38	20	2026-11-14 12:39:15	2026-11-14 12:39:15
299	149	272	5	151	304	Flexível de Freio Gates	Único	GATE-00297	1	671.46	671.46	2916	28	25	10	2026-11-14 12:39:15	2026-11-14 12:39:15
300	150	273	5	68	141	Palheta Limpador Varga	Original	VARG-00134	2	229.10	458.20	1980	63	14	16	2026-11-14 12:39:15	2026-11-14 12:39:15
301	150	274	6	129	260	Bateria 70Ah Continental	Reforçado	CONT-00253	1	862.46	862.46	14657	33	21	18	2026-11-14 12:39:15	2026-11-14 12:39:15
302	150	275	3	150	303	Amortecedor Traseiro Delphi	Único	DELP-00296	2	528.94	1057.88	3039	41	30	14	2026-11-14 12:39:15	2026-11-14 12:39:15
303	151	276	3	15	31	Pastilha de Freio Monroe	HD	MONR-00024	1	495.48	495.48	3893	28	20	14	2026-11-14 12:39:15	2026-11-14 12:39:15
304	151	277	5	59	123	Atuador de Embreagem Sachs	Original	SACH-00116	1	1404.26	1404.26	2394	30	28	30	2026-11-14 12:39:15	2026-11-14 12:39:15
305	151	278	1	112	234	Tensor da Correia Magneti Marelli	Esportivo	MAGN-00227	2	395.08	790.16	2606	28	17	16	2026-11-14 12:39:15	2026-11-14 12:39:15
306	152	279	1	1	2	Amortecedor Dianteiro Cofap	Lado Esquerdo	AMORT-COF-ESQ	2	389.90	779.80	3200	60	18	18	2026-11-14 12:39:15	2026-11-14 12:39:15
307	153	280	8	103	211	Tambor de Freio Magneti Marelli Reforçado	Único	MAGN-00204	2	38.98	77.96	5096	23	25	9	2026-11-14 12:39:15	2026-11-14 12:39:15
308	153	281	2	130	263	Radiador Continental	Lado Direito	CONT-00256	2	537.20	1074.40	3674	72	60	10	2026-11-14 12:39:15	2026-11-14 12:39:15
309	153	282	3	148	299	Capa de Volante Gates	Esportivo	GATE-00292	1	253.39	253.39	2430	66	18	9	2026-11-14 12:39:15	2026-11-14 12:39:15
310	154	283	4	113	235	Bobina de Ignição Mahle Linha Leve	Único	MAHL-00228	1	794.57	794.57	8889	28	26	18	2026-11-14 12:39:15	2026-11-14 12:39:15
311	154	284	2	197	393	Caixa de Direção Bosch Linha Leve	Reforçado	BOSC-00386	1	374.18	374.18	2207	36	29	22	2026-11-14 12:39:15	2026-11-14 12:39:15
312	155	285	5	36	72	Kit Ferramentas Magneti Marelli	HD	MAGN-00065	2	61.58	123.16	2203	33	23	10	2026-11-14 12:39:15	2026-11-14 12:39:15
313	155	286	8	72	147	Bomba de Combustível Fram	Original	FRAM-00140	1	398.74	398.74	2632	39	29	19	2026-11-14 12:39:15	2026-11-14 12:39:15
314	155	287	1	141	282	Coifa de Direção Mann Filter Linha Leve	Lado Esquerdo	MANN-00275	1	656.37	656.37	2949	38	31	22	2026-11-14 12:39:15	2026-11-14 12:39:15
315	156	288	3	35	67	Rolamento de Embreagem Bosch Linha Leve	Dianteiro	BOSC-00060	1	962.59	962.59	7951	35	35	24	2026-11-14 12:39:15	2026-11-14 12:39:15
316	156	289	2	193	385	Lâmpada Farol Denso	Único	DENS-00378	1	414.18	414.18	11712	25	19	22	2026-11-14 12:39:15	2026-11-14 12:39:15
317	157	290	8	93	193	Bomba de Direção Hidráulica Continental Série Ouro	Traseiro	CONT-00186	2	605.06	1210.12	6724	35	34	18	2026-11-14 12:39:15	2026-11-14 12:39:15
318	157	291	2	135	272	Cilindro de Roda Nakata	Lado Direito	NAKA-00265	1	599.81	599.81	5083	25	25	7	2026-11-14 12:39:15	2026-11-14 12:39:15
319	158	292	8	22	44	Amortecedor Traseiro Cofap Premium	Único	COFA-00037	2	209.10	418.20	2079	69	16	15	2026-11-14 12:39:15	2026-11-14 12:39:15
320	158	292	8	56	115	Filtro de Óleo Mann Filter Reforçado	Lado Direito	MANN-00108	2	452.64	905.28	4119	32	29	8	2026-11-14 12:39:15	2026-11-14 12:39:15
321	159	293	5	70	143	Amortecedor Traseiro Denso Premium	Original	DENS-00136	1	720.29	720.29	5997	72	20	24	2026-11-14 12:39:15	2026-11-14 12:39:15
322	159	294	1	116	239	Capa de Volante Fram	Dianteiro	FRAM-00232	2	276.05	552.10	324	78	30	16	2026-11-14 12:39:15	2026-11-14 12:39:15
323	160	295	7	111	229	Kit Freio Traseiro Moura	Traseiro	MOUR-00222	1	408.82	408.82	1178	22	27	8	2026-11-14 12:39:15	2026-11-14 12:39:15
324	160	296	1	160	320	Filtro de Óleo Valeo	Original	VALE-00313	1	47.03	47.03	2745	28	29	8	2026-11-14 12:39:15	2026-11-14 12:39:15
325	160	296	1	180	361	Kit Ferramentas Varga	Único	VARG-00354	2	182.01	364.02	415	76	16	7	2026-11-14 12:39:15	2026-11-14 12:39:15
326	161	297	2	127	256	Lonas de Freio Cofap Original	Dianteiro	COFA-00249	1	547.82	547.82	3466	22	16	5	2026-11-14 12:39:15	2026-11-14 12:39:15
327	162	298	5	134	268	Amortecedor Dianteiro Mahle	Dianteiro	MAHL-00261	2	499.85	999.70	4640	71	18	25	2026-11-14 12:39:15	2026-11-14 12:39:15
328	162	299	2	135	271	Cilindro de Roda Nakata	Original	NAKA-00264	2	599.81	1199.62	5699	26	23	11	2026-11-14 12:39:15	2026-11-14 12:39:15
329	163	300	3	95	195	Pastilha de Freio SKF	Lado Esquerdo	SKF-00188	2	94.78	189.56	6382	21	24	5	2026-11-14 12:39:15	2026-11-14 12:39:15
330	163	300	3	166	333	Barra Estabilizadora Nakata	Único	NAKA-00326	1	358.51	358.51	6891	58	22	25	2026-11-14 12:39:15	2026-11-14 12:39:15
331	163	301	7	159	318	Tambor de Freio NGK	Lado Esquerdo	NGK-00311	2	372.12	744.24	4028	24	24	12	2026-11-14 12:39:15	2026-11-14 12:39:15
332	164	302	4	164	330	Calota Fram	Lado Esquerdo	FRAM-00323	2	229.83	459.66	1258	36	12	18	2026-11-14 12:39:15	2026-11-14 12:39:15
333	165	303	4	58	121	Reservatório de Água Mann Filter	Lado Esquerdo	MANN-00114	2	598.61	1197.22	3475	68	38	14	2026-11-14 12:39:15	2026-11-14 12:39:15
334	166	304	6	96	197	Bomba d'Água Bosch	Único	BOSC-00190	2	81.84	163.68	448	40	27	12	2026-11-14 12:39:15	2026-11-14 12:39:15
335	167	305	7	6	8	Amortecedor Traseiro Magneti Marelli	Lado Direito	MAGN-00001	1	447.08	447.08	1762	43	20	18	2026-11-14 12:39:15	2026-11-14 12:39:15
336	168	306	1	1	2	Amortecedor Dianteiro Cofap	Lado Esquerdo	AMORT-COF-ESQ	1	389.90	389.90	3200	60	18	18	2026-11-14 12:39:15	2026-11-14 12:39:15
337	169	307	7	194	387	Mangueira do Radiador Denso Original	Traseiro	DENS-00380	1	817.68	817.68	3120	63	38	18	2026-11-14 12:39:15	2026-11-14 12:39:15
338	170	308	2	130	263	Radiador Continental	Lado Direito	CONT-00256	1	537.20	537.20	3674	72	60	10	2026-11-14 12:39:15	2026-11-14 12:39:15
339	171	309	3	28	56	Calota Moura	Dianteiro	MOUR-00049	1	40.17	40.17	1510	32	15	12	2026-11-14 12:39:15	2026-11-14 12:39:15
340	171	310	8	48	99	Filtro de Óleo SKF Linha Leve	Dianteiro	SKF-00092	1	128.20	128.20	3712	32	22	17	2026-11-14 12:39:15	2026-11-14 12:39:15
341	171	311	1	120	246	Filtro de Combustível Mann Filter	Único	MANN-00239	1	389.20	389.20	822	40	28	16	2026-11-14 12:39:15	2026-11-14 12:39:15
342	172	312	5	9	16	Motor de Partida SKF	Dianteiro	SKF-00009	2	730.26	1460.52	5137	23	24	15	2026-11-14 12:39:15	2026-11-14 12:39:15
343	173	313	5	43	88	Kit Embreagem Continental Reforçado	Esportivo	CONT-00081	2	99.26	198.52	6252	39	32	27	2026-11-14 12:39:15	2026-11-14 12:39:15
344	174	314	5	82	167	Eletroventilador Moura Original	Reforçado	MOUR-00160	2	380.85	761.70	3130	71	34	30	2026-11-14 12:39:15	2026-11-14 12:39:15
345	174	315	2	124	250	Palheta Limpador Varga Premium	Único	VARG-00243	1	198.20	198.20	1501	69	17	5	2026-11-14 12:39:15	2026-11-14 12:39:15
346	175	316	1	1	1	Amortecedor Dianteiro Cofap	Lado Direito	AMORT-COF-DIR	1	389.90	389.90	3200	60	18	18	2026-11-14 12:39:15	2026-11-14 12:39:15
347	175	317	4	19	40	Kit Embreagem Continental	Reforçado	CONT-00033	2	343.32	686.64	4628	42	40	25	2026-11-14 12:39:15	2026-11-14 12:39:15
348	176	318	8	72	149	Bomba de Combustível Fram	Esportivo	FRAM-00142	1	367.77	367.77	2258	28	17	20	2026-11-14 12:39:15	2026-11-14 12:39:15
349	177	319	2	11	23	Coifa da Homocinética NGK HD	Original	NGK-00016	1	502.38	502.38	11721	42	37	21	2026-11-14 12:39:15	2026-11-14 12:39:15
350	177	319	2	197	394	Caixa de Direção Bosch Linha Leve	Dianteiro	BOSC-00387	2	355.66	711.32	1413	57	35	18	2026-11-14 12:39:15	2026-11-14 12:39:15
351	178	320	1	5	7	Palheta Limpador Bosch Aerotwin	Par 24" + 18"	PALH-BOSCH-AERO	1	129.90	129.90	650	70	8	6	2026-11-14 12:39:15	2026-11-14 12:39:15
352	178	321	5	82	166	Eletroventilador Moura Original	Original	MOUR-00159	1	359.49	359.49	2208	54	59	22	2026-11-14 12:39:15	2026-11-14 12:39:15
353	178	322	7	111	230	Kit Freio Traseiro Moura	Lado Esquerdo	MOUR-00223	2	366.40	732.80	2254	29	25	11	2026-11-14 12:39:15	2026-11-14 12:39:15
354	179	323	5	36	70	Kit Ferramentas Magneti Marelli	Lado Esquerdo	MAGN-00063	2	59.21	118.42	1523	44	29	14	2026-11-14 12:39:15	2026-11-14 12:39:15
355	179	324	2	77	157	Coifa de Direção Sachs Série Ouro	Dianteiro	SACH-00150	1	421.99	421.99	7268	69	20	17	2026-11-14 12:39:15	2026-11-14 12:39:15
356	179	324	2	140	281	Palheta Limpador Monroe	Único	MONR-00274	2	188.40	376.80	557	37	14	8	2026-11-14 12:39:15	2026-11-14 12:39:15
357	180	325	6	158	317	Pivô de Suspensão Monroe	Único	MONR-00310	1	368.01	368.01	6587	51	29	22	2026-11-14 12:39:15	2026-11-14 12:39:15
358	181	326	1	118	241	Barra Estabilizadora SKF	Traseiro	SKF-00234	1	489.07	489.07	5875	80	21	24	2026-11-14 12:39:15	2026-11-14 12:39:15
359	182	327	5	97	198	Sensor de Rotação Heliar	Reforçado	HELI-00191	2	658.66	1317.32	7016	40	20	18	2026-11-14 12:39:15	2026-11-14 12:39:15
360	183	328	4	19	40	Kit Embreagem Continental	Reforçado	CONT-00033	1	343.32	343.32	4628	42	40	25	2026-11-14 12:39:15	2026-11-14 12:39:15
361	183	329	3	186	373	Radiador Heliar Premium	Esportivo	HELI-00366	1	213.47	213.47	1488	80	48	24	2026-11-14 12:39:15	2026-11-14 12:39:15
362	184	330	3	3	5	Filtro de Óleo Mann W 712/95	Único	FILT-MANN-71295	1	49.90	49.90	320	12	9	9	2026-11-14 12:39:15	2026-11-14 12:39:15
363	184	330	3	183	366	Cilindro de Roda Sachs	Lado Direito	SACH-00359	2	211.40	422.80	3018	28	20	12	2026-11-14 12:39:15	2026-11-14 12:39:15
364	184	331	5	9	16	Motor de Partida SKF	Dianteiro	SKF-00009	2	730.26	1460.52	5137	23	24	15	2026-11-14 12:39:15	2026-11-14 12:39:15
365	185	332	2	127	257	Lonas de Freio Cofap Original	Lado Direito	COFA-00250	2	506.08	1012.16	4573	32	17	7	2026-11-14 12:39:15	2026-11-14 12:39:15
366	186	333	8	13	26	Bomba de Direção Hidráulica Bosch	Lado Direito	BOSC-00019	1	122.70	122.70	1380	58	37	21	2026-11-14 12:39:15	2026-11-14 12:39:15
367	186	334	1	108	221	Kit Ferramentas Moura	Esportivo	MOUR-00214	1	271.21	271.21	2041	34	22	13	2026-11-14 12:39:15	2026-11-14 12:39:15
368	187	335	6	84	171	Antena Automotiva Delphi	Esportivo	DELP-00164	2	275.44	550.88	2098	39	21	19	2026-11-14 12:39:15	2026-11-14 12:39:15
369	188	336	3	35	67	Rolamento de Embreagem Bosch Linha Leve	Dianteiro	BOSC-00060	1	962.59	962.59	7951	35	35	24	2026-11-14 12:39:15	2026-11-14 12:39:15
370	188	337	5	43	87	Kit Embreagem Continental Reforçado	Lado Esquerdo	CONT-00080	2	105.52	211.04	6970	38	40	17	2026-11-14 12:39:15	2026-11-14 12:39:15
371	189	338	2	11	22	Coifa da Homocinética NGK HD	Reforçado	NGK-00015	2	521.89	1043.78	1112	42	33	22	2026-11-14 12:39:15	2026-11-14 12:39:15
372	189	339	7	31	60	Flexível de Freio Varga	HD	VARG-00053	1	325.81	325.81	5223	23	27	15	2026-11-14 12:39:15	2026-11-14 12:39:15
373	189	340	5	128	259	Junta do Cabeçote Denso	Original	DENS-00252	1	319.72	319.72	3963	23	28	14	2026-11-14 12:39:15	2026-11-14 12:39:15
374	190	341	4	19	39	Kit Embreagem Continental	Lado Direito	CONT-00032	2	339.92	679.84	7864	36	33	24	2026-11-14 12:39:15	2026-11-14 12:39:15
375	190	341	4	57	119	Motor de Partida Bosch	Lado Direito	BOSC-00112	2	151.11	302.22	14461	40	30	22	2026-11-14 12:39:15	2026-11-14 12:39:15
376	190	342	5	89	182	Lâmpada Farol Cofap Série Ouro	Dianteiro	COFA-00175	1	265.29	265.29	9164	29	15	21	2026-11-14 12:39:15	2026-11-14 12:39:15
377	191	343	4	19	38	Kit Embreagem Continental	Traseiro	CONT-00031	2	356.92	713.84	2288	40	26	24	2026-11-14 12:39:15	2026-11-14 12:39:15
378	191	343	4	164	329	Calota Fram	Reforçado	FRAM-00322	2	234.57	469.14	1748	31	30	11	2026-11-14 12:39:15	2026-11-14 12:39:15
379	191	344	7	175	350	Tambor de Freio Sachs	Único	SACH-00343	1	525.06	525.06	4567	25	15	6	2026-11-14 12:39:15	2026-11-14 12:39:15
380	192	345	3	47	97	Lonas de Freio Bosch Série Ouro	Reforçado	BOSC-00090	1	470.11	470.11	4426	21	15	8	2026-11-14 12:39:15	2026-11-14 12:39:15
381	192	346	2	161	322	Bateria 70Ah Varga	Lado Direito	VARG-00315	2	863.82	1727.64	2228	30	23	20	2026-11-14 12:39:15	2026-11-14 12:39:15
382	193	347	2	2	4	Kit Pastilhas de Freio Bosch	Eixo Traseiro	PAST-BOSCH-TRAS	2	189.90	379.80	1100	22	16	7	2026-11-14 12:39:15	2026-11-14 12:39:15
383	193	348	8	18	37	Válvula Termostática Continental	Dianteiro	CONT-00030	2	519.43	1038.86	1088	43	40	24	2026-11-14 12:39:15	2026-11-14 12:39:15
384	194	349	7	111	231	Kit Freio Traseiro Moura	HD	MOUR-00224	2	381.82	763.64	5303	33	30	15	2026-11-14 12:39:15	2026-11-14 12:39:15
385	194	350	1	112	234	Tensor da Correia Magneti Marelli	Esportivo	MAGN-00227	1	395.08	395.08	2606	28	17	16	2026-11-14 12:39:15	2026-11-14 12:39:15
386	195	351	2	127	257	Lonas de Freio Cofap Original	Lado Direito	COFA-00250	2	506.08	1012.16	4573	32	17	7	2026-11-14 12:39:15	2026-11-14 12:39:15
387	195	352	3	148	300	Capa de Volante Gates	Lado Esquerdo	GATE-00293	1	274.29	274.29	1008	32	16	18	2026-11-14 12:39:15	2026-11-14 12:39:15
388	196	353	8	146	295	Ventilador do Radiador Mahle	Único	MAHL-00288	1	336.44	336.44	1638	61	39	13	2026-11-14 12:39:15	2026-11-14 12:39:15
389	197	354	5	89	183	Lâmpada Farol Cofap Série Ouro	Original	COFA-00176	1	262.69	262.69	10862	34	18	19	2026-11-14 12:39:15	2026-11-14 12:39:15
390	197	355	6	158	317	Pivô de Suspensão Monroe	Único	MONR-00310	2	368.01	736.02	6587	51	29	22	2026-11-14 12:39:15	2026-11-14 12:39:15
391	198	356	8	18	36	Válvula Termostática Continental	Lado Direito	CONT-00029	2	498.23	996.46	1883	76	33	15	2026-11-14 12:39:15	2026-11-14 12:39:15
392	198	357	6	64	135	Tensor da Correia Monroe Reforçado	HD	MONR-00128	1	469.29	469.29	279	30	14	9	2026-11-14 12:39:15	2026-11-14 12:39:15
393	199	358	3	142	287	Terminal de Direção TRW	Esportivo	TRW-00280	1	657.66	657.66	6238	72	25	19	2026-11-14 12:39:15	2026-11-14 12:39:15
394	199	359	4	144	291	Filtro de Óleo Denso Original	Único	DENS-00284	2	322.95	645.90	585	23	18	24	2026-11-14 12:39:15	2026-11-14 12:39:15
395	199	360	2	149	302	Terminal Axial Varga	Único	VARG-00295	1	608.01	608.01	3316	35	31	19	2026-11-14 12:39:15	2026-11-14 12:39:15
396	200	361	6	156	314	Calota Monroe Reforçado	HD	MONR-00307	1	195.23	195.23	1382	47	22	19	2026-11-14 12:39:15	2026-11-14 12:39:15
397	201	362	3	187	374	Junta Homocinética Denso	Único	DENS-00367	1	936.52	936.52	11112	35	34	29	2026-11-14 12:40:18	2026-11-14 12:40:18
399	203	364	1	189	376	Coifa de Direção SKF	Único	SKF-00369	1	949.81	949.81	7866	69	26	18	2026-11-14 12:59:56	2026-11-14 12:59:56
400	203	365	3	183	365	Cilindro de Roda Sachs	Esportivo	SACH-00358	1	219.78	219.78	6218	20	21	7	2026-11-14 12:59:56	2026-11-14 12:59:56
401	204	366	3	187	374	Junta Homocinética Denso	Único	DENS-00367	1	936.52	936.52	11112	35	34	29	2026-11-14 13:35:45	2026-11-14 13:35:45
\.


--
-- TOC entry 5236 (class 0 OID 17022)
-- Dependencies: 229
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 5235 (class 0 OID 17007)
-- Dependencies: 228
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- TOC entry 5227 (class 0 OID 16939)
-- Dependencies: 220
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2026_10_29_000001_create_vendedores_table	1
5	2026_10_29_000002_create_modelos_veiculo_table	1
6	2026_10_29_000003_create_produtos_table	1
7	2026_10_29_000004_create_variacoes_produto_table	1
8	2026_10_29_000005_create_atributos_variacao_table	1
9	2026_10_29_000006_create_compatibilidades_produto_table	1
10	2026_10_29_000007_create_pedidos_table	1
11	2026_10_29_000008_create_envios_pedido_table	1
12	2026_10_29_000009_create_itens_pedido_table	1
13	2026_10_29_000010_create_pagamentos_table	1
14	2026_10_29_000011_add_pix_fields_to_pedidos_table	1
15	2026_11_14_000001_add_role_and_customer_fields_to_users_table	2
16	2026_11_14_000002_add_user_id_to_pedidos_table	2
\.


--
-- TOC entry 5242 (class 0 OID 17088)
-- Dependencies: 235
-- Data for Name: modelos_veiculo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.modelos_veiculo (id, brand, model, year_start, year_end, engine, created_at, updated_at) FROM stdin;
1	Volkswagen	Gol	2014	2020	1.0 12V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
2	Chevrolet	Onix	2016	2022	1.0 12V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
3	Fiat	Argo	2018	2023	1.3 8V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
4	Toyota	Corolla	2015	2021	2.0 16V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
5	Honda	Civic	2016	2021	2.0 16V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
6	Chevrolet	Cruze	2017	2023	1.4 Turbo	2026-11-14 12:39:12	2026-11-14 12:39:12
7	Hyundai	HB20	2019	2024	1.0 12V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
8	Renault	Kwid	2018	2024	1.0 12V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
9	Jeep	Renegade	2016	2023	1.8 16V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
10	Nissan	Kicks	2017	2023	1.6 16V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
11	Ford	Ka	2015	2021	1.0 12V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
12	Fiat	Toro	2017	2023	1.8 16V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
13	Volkswagen	T-Cross	2020	2024	1.0 TSI	2026-11-14 12:39:12	2026-11-14 12:39:12
14	Toyota	Yaris	2019	2023	1.5 16V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
15	Honda	HR-V	2016	2022	1.8 16V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
16	Chevrolet	S10	2016	2022	2.5 Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
17	Fiat	Strada	2015	2023	1.4 8V Flex	2026-11-14 12:39:12	2026-11-14 12:39:12
\.


--
-- TOC entry 5258 (class 0 OID 17316)
-- Dependencies: 251
-- Data for Name: pagamentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagamentos (id, order_id, seller_id, gateway, gateway_payment_id, gateway_receiver_id, amount, platform_fee, seller_amount, status, paid_at, payload, created_at, updated_at) FROM stdin;
1	1	3	sandbox	SIM-01M7DBCYDH7P65F7FSTCMA1505	recv_mann_003	590.03	54.86	535.17	paid	2026-10-26 13:33:14	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":535.17,"platform_fee":54.86,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
2	1	1	sandbox	SIM-01M7DBCYDRYSZK1830R6VXZ041	recv_cofap_001	449.22	44.92	404.30	paid	2026-10-26 14:35:14	{"payment_method":"boleto","split":{"receiver_id":"recv_cofap_001","seller_amount":404.3,"platform_fee":44.92,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
3	2	1	sandbox	SIM-01M7DBCYDZN5B2WTCBWJ8VNC8W	recv_cofap_001	1127.24	108.57	1018.67	paid	2026-10-31 18:26:14	{"payment_method":"boleto","split":{"receiver_id":"recv_cofap_001","seller_amount":1018.67,"platform_fee":108.57,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
4	2	6	sandbox	SIM-01M7DBCYE2AG5G4HV49APKGYNK	recv_oieaajmwydmf	361.28	36.13	325.15	paid	2026-10-31 18:53:14	{"payment_method":"boleto","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":325.15,"platform_fee":36.13,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
5	3	4	sandbox	SIM-01M7DBCYE8PT6SVQTKR2BBT3AY	recv_curestdgztda	427.02	36.18	390.84	paid	2026-09-08 07:32:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":390.84,"platform_fee":36.18,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
6	3	3	sandbox	SIM-01M7DBCYEBS4M3WTZ9XP674452	recv_mann_003	688.72	65.77	622.95	paid	2026-09-08 06:35:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":622.95,"platform_fee":65.77,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
7	4	2	sandbox	SIM-01M7DBCYEG029S0CQGVS8NA9W0	recv_bosch_002	189.90	18.99	170.91	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":170.91,"platform_fee":18.99,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
8	4	5	sandbox	SIM-01M7DBCYEKCKR1GENPYGRDP20Z	recv_elseufzgoyqq	2047.78	197.80	1849.98	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1849.98,"platform_fee":197.8,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
9	5	4	sandbox	SIM-01M7DBCYERP7805PP5HYYJPXHX	recv_curestdgztda	453.35	41.55	411.80	paid	2026-10-25 01:19:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":411.8,"platform_fee":41.55,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
10	5	2	sandbox	SIM-01M7DBCYEVTM9T3FPQWS5ZEQT9	recv_bosch_002	651.66	61.71	589.95	paid	2026-10-25 01:11:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":589.95,"platform_fee":61.71,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
11	6	2	sandbox	SIM-01M7DBCYF1ECNQW0RBJRKSEV80	recv_bosch_002	1241.41	119.96	1121.45	paid	2026-10-03 15:40:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":1121.45,"platform_fee":119.96,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
12	7	3	sandbox	SIM-01M7DBCYF64SBJ53M5030QDFQP	recv_mann_003	133.74	10.30	123.44	paid	2026-10-23 19:44:14	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":123.44,"platform_fee":10.3,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
13	8	2	sandbox	SIM-01M7DBCYFC8M0Z6VQFMVAP53X7	recv_bosch_002	1026.26	99.18	927.08	paid	2026-07-31 02:17:14	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":927.08,"platform_fee":99.18,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
14	8	5	sandbox	SIM-01M7DBCYFES2PRRFCE11CXBY98	recv_elseufzgoyqq	594.33	52.54	541.79	paid	2026-07-31 02:40:14	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":541.79,"platform_fee":52.54,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
15	9	4	sandbox	SIM-01M7DBCYFNP3GASRTB0816GB03	recv_curestdgztda	2482.94	239.83	2243.11	paid	2026-10-02 03:26:14	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":2243.11,"platform_fee":239.83,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
16	9	6	sandbox	SIM-01M7DBCYFQHBATECCQ05T1S02M	recv_oieaajmwydmf	205.50	18.51	186.99	paid	2026-10-02 04:49:14	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":186.99,"platform_fee":18.51,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
17	10	2	sandbox	SIM-01M7DBCYFWX2EZKAJ8SMGX35E9	recv_bosch_002	439.80	43.98	395.82	paid	2026-11-14 04:14:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":395.82,"platform_fee":43.98,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
18	10	1	sandbox	SIM-01M7DBCYFY6VZZJ13EDK8SP749	recv_cofap_001	586.66	55.56	531.10	paid	2026-11-14 04:43:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":531.1,"platform_fee":55.56,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
19	10	6	sandbox	SIM-01M7DBCYG18E6M3QR95RZX6FTG	recv_oieaajmwydmf	191.73	16.37	175.36	paid	2026-11-14 05:20:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":175.36,"platform_fee":16.37,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
20	11	1	sandbox	SIM-01M7DBCYG8G7YFC02G9QJPS2JP	recv_cofap_001	329.39	27.74	301.65	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":301.65,"platform_fee":27.74,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
21	11	6	sandbox	SIM-01M7DBCYGDVRXKXPCF5ES1WKFM	recv_oieaajmwydmf	1287.98	121.81	1166.17	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":1166.17,"platform_fee":121.81,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
22	12	3	sandbox	SIM-01M7DBCYGKRS871XESESZPYQ46	recv_mann_003	897.58	82.05	815.53	paid	2026-07-21 13:07:14	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":815.53,"platform_fee":82.05,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
23	13	5	sandbox	SIM-01M7DBCYGSD26NKD3FFRK5SFNY	recv_elseufzgoyqq	138.30	10.55	127.75	paid	2026-11-09 03:55:14	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":127.75,"platform_fee":10.55,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
24	13	2	sandbox	SIM-01M7DBCYGV1AX28884620AQCSS	recv_bosch_002	705.24	67.19	638.05	paid	2026-11-09 04:52:14	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":638.05,"platform_fee":67.19,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
25	14	8	sandbox	SIM-01M7DBCYH10081XR1AWMWX3Z8X	recv_dqtmhkykmtuu	146.44	11.82	134.62	paid	2026-10-15 16:00:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":134.62,"platform_fee":11.82,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
26	14	4	sandbox	SIM-01M7DBCYH3NWH4PG5197CQVCET	recv_curestdgztda	1273.52	119.72	1153.80	paid	2026-10-15 15:37:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":1153.8,"platform_fee":119.72,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
27	14	3	sandbox	SIM-01M7DBCYH60552Z58MH430G237	recv_mann_003	806.68	74.19	732.49	paid	2026-10-15 16:50:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":732.49,"platform_fee":74.19,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
28	15	5	sandbox	SIM-01M7DBCYHEKDD35P6PD6NVQ9FP	recv_elseufzgoyqq	306.73	27.43	279.30	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":279.3,"platform_fee":27.43,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
29	15	6	sandbox	SIM-01M7DBCYHG6TB7KKXTW7H9AH33	recv_oieaajmwydmf	1274.67	123.03	1151.64	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":1151.64,"platform_fee":123.03,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
30	16	4	sandbox	SIM-01M7DBCYHN7N24FXE84858KTG0	recv_curestdgztda	274.94	27.49	247.45	refunded	2026-10-12 03:08:14	{"payment_method":"boleto","split":{"receiver_id":"recv_curestdgztda","seller_amount":247.45,"platform_fee":27.49,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
31	17	5	sandbox	SIM-01M7DBCYHVET9VE9X5T0HG8JH7	recv_elseufzgoyqq	1033.37	103.34	930.03	paid	2026-07-17 17:14:14	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":930.03,"platform_fee":103.34,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
32	17	7	sandbox	SIM-01M7DBCYHY19TCQE10MYYXZARR	recv_oyuhvogyydlf	1372.82	131.93	1240.89	paid	2026-07-17 16:23:14	{"payment_method":"pix","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":1240.89,"platform_fee":131.93,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
33	18	8	sandbox	SIM-01M7DBCYJ2P4G06JAWNMQN9NZW	recv_dqtmhkykmtuu	996.46	99.65	896.81	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":896.81,"platform_fee":99.65,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
34	19	6	sandbox	SIM-01M7DBCYJ78RW0WSW3J95TV6WT	recv_oieaajmwydmf	378.19	34.92	343.27	paid	2026-08-28 22:06:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":343.27,"platform_fee":34.92,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
35	19	4	sandbox	SIM-01M7DBCYJ9EGY3K7T56GPMYRWC	recv_curestdgztda	725.80	72.58	653.22	paid	2026-08-28 22:13:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":653.22,"platform_fee":72.58,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
36	20	4	sandbox	SIM-01M7DBCYJFKJ1ZC23WJ3A1R9SV	recv_curestdgztda	1264.94	123.16	1141.78	paid	2026-07-21 20:32:14	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":1141.78,"platform_fee":123.16,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
37	20	5	sandbox	SIM-01M7DBCYJHDTMXFV2M95JNN96G	recv_elseufzgoyqq	351.50	32.62	318.88	paid	2026-07-21 19:05:14	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":318.88,"platform_fee":32.62,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
38	20	2	sandbox	SIM-01M7DBCYJK42F40H1P7WBC9TDA	recv_bosch_002	237.13	20.09	217.04	paid	2026-07-21 20:02:14	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":217.04,"platform_fee":20.09,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
39	21	7	sandbox	SIM-01M7DBCYJSKG4JZT87H18QASR7	recv_oyuhvogyydlf	679.68	64.49	615.19	paid	2026-09-07 15:11:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":615.19,"platform_fee":64.49,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
40	21	2	sandbox	SIM-01M7DBCYJWFM4HA8YWAQEY7KF9	recv_bosch_002	475.09	43.64	431.45	paid	2026-09-07 14:48:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":431.45,"platform_fee":43.64,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
41	21	4	sandbox	SIM-01M7DBCYJZTHABXQ6TD4NW97C4	recv_curestdgztda	255.08	23.46	231.62	paid	2026-09-07 14:07:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":231.62,"platform_fee":23.46,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
42	22	8	sandbox	SIM-01M7DBCYK5C7CVR3H6MVGXM702	recv_dqtmhkykmtuu	2285.92	228.59	2057.33	paid	2026-09-18 22:34:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":2057.33,"platform_fee":228.59,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
43	22	2	sandbox	SIM-01M7DBCYK741EQ5FSXFNVJ1A00	recv_bosch_002	2298.74	224.29	2074.45	paid	2026-09-18 22:07:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":2074.45,"platform_fee":224.29,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
44	22	3	sandbox	SIM-01M7DBCYK90TN7CFX04EMR9BP2	recv_mann_003	705.47	67.11	638.36	paid	2026-09-18 23:19:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":638.36,"platform_fee":67.11,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
45	23	6	sandbox	SIM-01M7DBCYKGCGKFCRTGTF14PF1P	recv_oieaajmwydmf	166.16	14.59	151.57	paid	2026-09-16 10:49:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":151.57,"platform_fee":14.59,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
46	24	6	sandbox	SIM-01M7DBCYKR02REY9DNHYPXS04V	recv_oieaajmwydmf	600.53	55.09	545.44	paid	2026-11-11 06:37:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":545.44,"platform_fee":55.09,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
47	24	4	sandbox	SIM-01M7DBCYKT3JV6ZHASZV45FMT6	recv_curestdgztda	725.80	72.58	653.22	paid	2026-11-11 06:47:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":653.22,"platform_fee":72.58,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
48	25	4	sandbox	SIM-01M7DBCYKZBFH0TW9QYBXT82W3	recv_curestdgztda	453.35	41.55	411.80	paid	2026-11-14 03:26:14	{"payment_method":"boleto","split":{"receiver_id":"recv_curestdgztda","seller_amount":411.8,"platform_fee":41.55,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
49	26	5	sandbox	SIM-01M7DBCYM5HH0EC7X311REZMW4	recv_elseufzgoyqq	1208.87	116.46	1092.41	paid	2026-07-31 11:28:14	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1092.41,"platform_fee":116.46,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
50	26	1	sandbox	SIM-01M7DBCYM7SV4R4R3WTJNYTA9Z	recv_cofap_001	449.22	44.92	404.30	paid	2026-07-31 11:17:14	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":404.3,"platform_fee":44.92,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
51	27	4	sandbox	SIM-01M7DBCYMDA3QXCHD45K94GAPK	recv_curestdgztda	1381.98	132.70	1249.28	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_curestdgztda","seller_amount":1249.28,"platform_fee":132.7,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
52	27	5	sandbox	SIM-01M7DBCYMFSQVZ0HWPMXS0FAP2	recv_elseufzgoyqq	777.40	75.00	702.40	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":702.4,"platform_fee":75,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
53	28	3	sandbox	SIM-01M7DBCYMMGXA3CZSHYCTVYHSR	recv_mann_003	847.24	81.49	765.75	paid	2026-11-10 06:14:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":765.75,"platform_fee":81.49,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
54	29	8	sandbox	SIM-01M7DBCYMRZA3AE8757SQ7YB18	recv_dqtmhkykmtuu	1142.96	114.30	1028.66	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":1028.66,"platform_fee":114.3,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
55	29	5	sandbox	SIM-01M7DBCYMT13XZ1DWNK17F0BE9	recv_elseufzgoyqq	1031.28	100.14	931.14	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":931.14,"platform_fee":100.14,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
56	30	2	sandbox	SIM-01M7DBCYMZERKJ1QV380AD6P49	recv_bosch_002	472.60	47.26	425.34	paid	2026-11-10 23:01:14	{"payment_method":"boleto","split":{"receiver_id":"recv_bosch_002","seller_amount":425.34,"platform_fee":47.26,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
57	30	8	sandbox	SIM-01M7DBCYN1YK3DVMGFP8DWMSHG	recv_dqtmhkykmtuu	262.85	23.23	239.62	paid	2026-11-10 22:18:14	{"payment_method":"boleto","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":239.62,"platform_fee":23.23,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
58	30	1	sandbox	SIM-01M7DBCYN3GBEMV28A37BAYP6Y	recv_cofap_001	1055.37	96.42	958.95	paid	2026-11-10 21:55:14	{"payment_method":"boleto","split":{"receiver_id":"recv_cofap_001","seller_amount":958.95,"platform_fee":96.42,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
59	31	7	sandbox	SIM-01M7DBCYN89M8ZQQWEREEJQ0JD	recv_oyuhvogyydlf	500.16	45.34	454.82	paid	2026-07-17 03:59:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":454.82,"platform_fee":45.34,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
60	31	3	sandbox	SIM-01M7DBCYNBVFK5H2VV45B06BMC	recv_mann_003	237.46	18.96	218.50	paid	2026-07-17 02:35:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":218.5,"platform_fee":18.96,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
61	32	3	sandbox	SIM-01M7DBCYNHBK4RVPKV8BE5JN0A	recv_mann_003	496.91	47.01	449.90	paid	2026-10-13 19:00:14	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":449.9,"platform_fee":47.01,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
62	32	2	sandbox	SIM-01M7DBCYNNN2Y9J11Z7P0HPZ7M	recv_bosch_002	1759.74	170.57	1589.17	paid	2026-10-13 20:38:14	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":1589.17,"platform_fee":170.57,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
63	33	1	sandbox	SIM-01M7DBCYNYYNZG5EMVZ73NH2D0	recv_cofap_001	582.44	53.57	528.87	paid	2026-09-16 22:30:14	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":528.87,"platform_fee":53.57,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
64	34	1	sandbox	SIM-01M7DBCYP5BEABBHN0FGXRMVXB	recv_cofap_001	277.88	22.56	255.32	paid	2026-07-16 22:05:14	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":255.32,"platform_fee":22.56,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
65	35	4	sandbox	SIM-01M7DBCYPC66EF0FFGQY74Y039	recv_curestdgztda	217.35	14.35	203.00	paid	2026-07-18 19:52:14	{"payment_method":"boleto","split":{"receiver_id":"recv_curestdgztda","seller_amount":203,"platform_fee":14.35,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
66	36	5	sandbox	SIM-01M7DBCYPJ6C6S6NCTNM795B4M	recv_elseufzgoyqq	280.28	24.61	255.67	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":255.67,"platform_fee":24.61,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
67	36	1	sandbox	SIM-01M7DBCYPPZGQ81XVGS2TYY65J	recv_cofap_001	1193.52	115.69	1077.83	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":1077.83,"platform_fee":115.69,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
68	37	2	sandbox	SIM-01M7DBCYPZ1GNYP219RN9C5YBV	recv_bosch_002	163.45	13.74	149.71	paid	2026-11-02 19:42:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":149.71,"platform_fee":13.74,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
69	37	8	sandbox	SIM-01M7DBCYQ21BN9F4YBQMN8T641	recv_dqtmhkykmtuu	599.84	53.56	546.28	paid	2026-11-02 20:27:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":546.28,"platform_fee":53.56,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
70	37	7	sandbox	SIM-01M7DBCYQ659W3BV2DQ0M8ETKX	recv_oyuhvogyydlf	865.13	83.04	782.09	paid	2026-11-02 19:13:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":782.09,"platform_fee":83.04,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
71	38	3	sandbox	SIM-01M7DBCYQCM8J4Y4WPB8C649Z4	recv_mann_003	867.21	82.05	785.16	paid	2026-07-23 13:13:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":785.16,"platform_fee":82.05,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
72	38	7	sandbox	SIM-01M7DBCYQF5THD153KDB76QMV0	recv_oyuhvogyydlf	335.04	33.50	301.54	paid	2026-07-23 12:42:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":301.54,"platform_fee":33.5,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
73	38	1	sandbox	SIM-01M7DBCYQJ8YM7M7X8DX1DJV9S	recv_cofap_001	585.31	55.43	529.88	paid	2026-07-23 13:07:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":529.88,"platform_fee":55.43,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
74	39	2	sandbox	SIM-01M7DBCYQT9C8EVQ7PV6SD5G0M	recv_bosch_002	808.82	74.12	734.70	paid	2026-11-13 12:40:14	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":734.7,"platform_fee":74.12,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
75	40	1	sandbox	SIM-01M7DBCYQZZC0YXZG9TBNS8619	recv_cofap_001	1025.42	97.35	928.07	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":928.07,"platform_fee":97.35,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
76	41	3	sandbox	SIM-01M7DBCYR6E1CJHGWNZMJN07AT	recv_mann_003	374.45	34.94	339.51	paid	2026-07-26 21:53:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":339.51,"platform_fee":34.94,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
77	41	5	sandbox	SIM-01M7DBCYR98190AZN2G2NCWX3W	recv_elseufzgoyqq	271.67	27.17	244.50	paid	2026-07-26 23:29:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":244.5,"platform_fee":27.17,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
78	41	8	sandbox	SIM-01M7DBCYRD8FYRNC8T9QXY5D92	recv_dqtmhkykmtuu	1251.53	121.01	1130.52	paid	2026-07-26 23:46:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":1130.52,"platform_fee":121.01,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
79	42	6	sandbox	SIM-01M7DBCYRJZE0F0R6GGN9S4YVM	recv_oieaajmwydmf	174.60	17.46	157.14	paid	2026-08-01 07:01:14	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":157.14,"platform_fee":17.46,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
80	43	3	sandbox	SIM-01M7DBCYRR0X1DHHWNKGY9E65X	recv_mann_003	493.71	47.55	446.16	paid	2026-07-21 03:02:14	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":446.16,"platform_fee":47.55,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
81	43	2	sandbox	SIM-01M7DBCYRT0BTBXZNHW83P3DS6	recv_bosch_002	162.64	16.26	146.38	paid	2026-07-21 03:46:14	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":146.38,"platform_fee":16.26,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
82	44	2	sandbox	SIM-01M7DBCYRYGRAM4HDYPJ4D2B9T	recv_bosch_002	648.96	59.98	588.98	refunded	2026-08-05 18:08:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":588.98,"platform_fee":59.98,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
83	44	4	sandbox	SIM-01M7DBCYS0FP29EA1N26SYN65G	recv_curestdgztda	413.20	37.79	375.41	refunded	2026-08-05 17:28:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":375.41,"platform_fee":37.79,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
84	45	2	sandbox	SIM-01M7DBCYS6DMPNQC8BARMVN52M	recv_bosch_002	568.65	52.19	516.46	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":516.46,"platform_fee":52.19,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
85	45	3	sandbox	SIM-01M7DBCYS94CF4QCW4J4BTJK6C	recv_mann_003	198.23	16.27	181.96	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":181.96,"platform_fee":16.27,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
86	46	2	sandbox	SIM-01M7DBCYSEAPQS4PAVG2YGG2VV	recv_bosch_002	705.24	67.19	638.05	paid	2026-11-08 16:23:14	{"payment_method":"boleto","split":{"receiver_id":"recv_bosch_002","seller_amount":638.05,"platform_fee":67.19,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
87	46	4	sandbox	SIM-01M7DBCYSGND26F4FGTJVWJSEA	recv_curestdgztda	248.79	24.88	223.91	paid	2026-11-08 15:32:14	{"payment_method":"boleto","split":{"receiver_id":"recv_curestdgztda","seller_amount":223.91,"platform_fee":24.88,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
88	47	7	sandbox	SIM-01M7DBCYSN8BNYY60FTTCZBYNM	recv_oyuhvogyydlf	429.44	38.18	391.26	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":391.26,"platform_fee":38.18,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
89	48	5	sandbox	SIM-01M7DBCYSTNATT4MGKVW96A95J	recv_elseufzgoyqq	171.06	11.84	159.22	refunded	2026-10-27 10:11:14	{"payment_method":"boleto","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":159.22,"platform_fee":11.84,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
90	49	6	sandbox	SIM-01M7DBCYSZPGKMZHBN4895J529	recv_oieaajmwydmf	1467.08	139.30	1327.78	paid	2026-11-11 21:25:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":1327.78,"platform_fee":139.3,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
91	49	8	sandbox	SIM-01M7DBCYT1VRM9W5WPH916F6DC	recv_dqtmhkykmtuu	387.13	38.71	348.42	paid	2026-11-11 20:36:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":348.42,"platform_fee":38.71,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
92	50	1	sandbox	SIM-01M7DBCYT8FD62JKCDF7N69JDH	recv_cofap_001	974.75	94.48	880.27	paid	2026-09-08 10:04:14	{"payment_method":"boleto","split":{"receiver_id":"recv_cofap_001","seller_amount":880.27,"platform_fee":94.48,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
93	51	6	sandbox	SIM-01M7DBCYTEXXQ7NXRC8MH6NG4A	recv_oieaajmwydmf	2072.21	197.12	1875.09	paid	2026-08-26 23:52:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":1875.09,"platform_fee":197.12,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
94	51	4	sandbox	SIM-01M7DBCYTGPXSMKNBTTJ12G0JY	recv_curestdgztda	436.17	37.79	398.38	paid	2026-08-26 22:37:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":398.38,"platform_fee":37.79,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
95	52	5	sandbox	SIM-01M7DBCYTN76G0A2NP76WFKC4A	recv_elseufzgoyqq	1286.33	121.58	1164.75	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1164.75,"platform_fee":121.58,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
96	52	1	sandbox	SIM-01M7DBCYTQDT9054TZS2ZY76XP	recv_cofap_001	599.33	55.21	544.12	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":544.12,"platform_fee":55.21,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
97	53	6	sandbox	SIM-01M7DBCYTWWYR40EQGE48MPWZ0	recv_oieaajmwydmf	1516.59	144.90	1371.69	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":1371.69,"platform_fee":144.9,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
98	54	5	sandbox	SIM-01M7DBCYV1NQHQ20VW5G81CQGM	recv_elseufzgoyqq	757.52	67.81	689.71	paid	2026-09-14 06:03:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":689.71,"platform_fee":67.81,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
99	55	4	sandbox	SIM-01M7DBCYV6Y77FW1SYDEN0YCVM	recv_curestdgztda	374.80	33.99	340.81	paid	2026-10-25 04:49:14	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":340.81,"platform_fee":33.99,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
100	55	3	sandbox	SIM-01M7DBCYV869ME9898QWAFRSET	recv_mann_003	105.34	8.03	97.31	paid	2026-10-25 03:31:14	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":97.31,"platform_fee":8.03,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
101	56	2	sandbox	SIM-01M7DBCYVDQPR8H8TQYBYX8K3E	recv_bosch_002	931.19	89.11	842.08	paid	2026-11-06 03:55:14	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":842.08,"platform_fee":89.11,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
102	57	2	sandbox	SIM-01M7DBCYVMGTV48D1TAS1NNTPF	recv_bosch_002	348.51	31.31	317.20	paid	2026-10-18 22:13:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":317.2,"platform_fee":31.31,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
103	58	3	sandbox	SIM-01M7DBCYVSMKMDVWWTQTC44G33	recv_mann_003	213.84	17.81	196.03	paid	2026-08-06 18:33:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":196.03,"platform_fee":17.81,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
104	58	8	sandbox	SIM-01M7DBCYVV9JFA935FEZYEQHJ7	recv_dqtmhkykmtuu	315.94	26.14	289.80	paid	2026-08-06 19:55:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":289.8,"platform_fee":26.14,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
105	58	5	sandbox	SIM-01M7DBCYVYDS849STQR11TXT5D	recv_elseufzgoyqq	567.28	50.45	516.83	paid	2026-08-06 18:47:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":516.83,"platform_fee":50.45,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
106	59	3	sandbox	SIM-01M7DBCYW47EEWF38Q5WXN1XZT	recv_mann_003	711.70	65.14	646.56	paid	2026-08-05 16:31:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":646.56,"platform_fee":65.14,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
107	60	8	sandbox	SIM-01M7DBCYW937YPTCA03WV42NVN	recv_dqtmhkykmtuu	791.05	75.48	715.57	paid	2026-09-07 16:23:14	{"payment_method":"pix","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":715.57,"platform_fee":75.48,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
108	60	2	sandbox	SIM-01M7DBCYWBJ41DNH9ZKK2YTMDJ	recv_bosch_002	477.23	42.20	435.03	paid	2026-09-07 15:43:14	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":435.03,"platform_fee":42.2,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
109	60	7	sandbox	SIM-01M7DBCYWDH3T6QE25X1TT6AX6	recv_oyuhvogyydlf	366.40	36.64	329.76	paid	2026-09-07 15:55:14	{"payment_method":"pix","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":329.76,"platform_fee":36.64,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
110	61	1	sandbox	SIM-01M7DBCYWJWKB1N7RVGQY5W2F5	recv_cofap_001	476.95	43.67	433.28	paid	2026-11-02 10:27:14	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":433.28,"platform_fee":43.67,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
111	61	6	sandbox	SIM-01M7DBCYWNRRJ0S3WZXTN4ZK9Y	recv_oieaajmwydmf	777.84	77.78	700.06	paid	2026-11-02 11:22:14	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":700.06,"platform_fee":77.78,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
112	62	3	sandbox	SIM-01M7DBCYWT5E2W52A0WEV18944	recv_mann_003	199.75	17.81	181.94	paid	2026-09-02 21:37:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":181.94,"platform_fee":17.81,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
113	62	1	sandbox	SIM-01M7DBCYWX23Z7THMGYWK1H3JZ	recv_cofap_001	1268.28	118.89	1149.39	paid	2026-09-02 20:36:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":1149.39,"platform_fee":118.89,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
114	63	3	sandbox	SIM-01M7DBCYX1J3JT16Z0D2YRC7CE	recv_mann_003	290.90	20.57	270.33	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":270.33,"platform_fee":20.57,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
115	63	4	sandbox	SIM-01M7DBCYX35C626VKNFM5JX2DF	recv_curestdgztda	784.35	70.17	714.18	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_curestdgztda","seller_amount":714.18,"platform_fee":70.17,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
116	63	5	sandbox	SIM-01M7DBCYX63NS6E03K0NAMWXVR	recv_elseufzgoyqq	525.59	46.79	478.80	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":478.8,"platform_fee":46.79,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
117	64	3	sandbox	SIM-01M7DBCYXBJZ88AGFQBM00YKNJ	recv_mann_003	284.49	25.08	259.41	paid	2026-09-04 17:14:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":259.41,"platform_fee":25.08,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
118	65	4	sandbox	SIM-01M7DBCYXHG6SD00QDZFG2VJRJ	recv_curestdgztda	1220.23	110.39	1109.84	paid	2026-08-14 00:27:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":1109.84,"platform_fee":110.39,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
119	65	5	sandbox	SIM-01M7DBCYXK09207YK8ZRPG2YQM	recv_elseufzgoyqq	1161.14	104.81	1056.33	paid	2026-08-14 00:15:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1056.33,"platform_fee":104.81,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
120	66	2	sandbox	SIM-01M7DBCYXRSZ12B8PKCD0YAC55	recv_bosch_002	153.09	12.97	140.12	paid	2026-09-18 14:28:14	{"payment_method":"boleto","split":{"receiver_id":"recv_bosch_002","seller_amount":140.12,"platform_fee":12.97,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
121	66	3	sandbox	SIM-01M7DBCYXTD87SWV8FV6GHTK7X	recv_mann_003	275.38	22.73	252.65	paid	2026-09-18 13:53:14	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":252.65,"platform_fee":22.73,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
122	67	7	sandbox	SIM-01M7DBCYXYMMZE9Y6D4SZ7RD9H	recv_oyuhvogyydlf	476.86	44.44	432.42	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":432.42,"platform_fee":44.44,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
123	67	8	sandbox	SIM-01M7DBCYY19510GTPE8ME6T7Y9	recv_dqtmhkykmtuu	1763.92	171.84	1592.08	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":1592.08,"platform_fee":171.84,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
124	67	3	sandbox	SIM-01M7DBCYY4VK1V8EXTETT5B6V1	recv_mann_003	800.00	71.70	728.30	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":728.3,"platform_fee":71.7,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
125	68	6	sandbox	SIM-01M7DBCYYA6X7H8V9NDE3EV9GW	recv_oieaajmwydmf	2730.07	258.66	2471.41	paid	2026-08-23 07:09:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":2471.41,"platform_fee":258.66,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
126	69	2	sandbox	SIM-01M7DBCYYEHFQ7W2V0GHRD1FK2	recv_bosch_002	811.02	70.32	740.70	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":740.7,"platform_fee":70.32,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
127	70	5	sandbox	SIM-01M7DBCYYK5B9DWSA32X0022PP	recv_elseufzgoyqq	807.36	71.19	736.17	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":736.17,"platform_fee":71.19,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
128	71	5	sandbox	SIM-01M7DBCYYQJN6SYE64S4APGW5J	recv_elseufzgoyqq	787.39	75.74	711.65	refunded	2026-07-22 22:58:14	{"payment_method":"boleto","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":711.65,"platform_fee":75.74,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
129	72	8	sandbox	SIM-01M7DBCYYVS8FN1HK7NR9KN35F	recv_dqtmhkykmtuu	791.05	75.48	715.57	paid	2026-09-20 02:23:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":715.57,"platform_fee":75.48,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
130	73	1	sandbox	SIM-01M7DBCYZ0JR1TYSZWMT1K2YPP	recv_cofap_001	687.16	58.67	628.49	paid	2026-09-13 02:36:14	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":628.49,"platform_fee":58.67,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
131	74	4	sandbox	SIM-01M7DBCYZ60DJ56YEXKSM90YST	recv_curestdgztda	565.28	51.50	513.78	paid	2026-09-30 19:24:14	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":513.78,"platform_fee":51.5,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
132	74	3	sandbox	SIM-01M7DBCYZ8EXFMQZ3FPYVSERVD	recv_mann_003	835.74	78.89	756.85	paid	2026-09-30 20:03:14	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":756.85,"platform_fee":78.89,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
133	75	1	sandbox	SIM-01M7DBCYZD0NRHH2XKG50TQ3E7	recv_cofap_001	509.94	48.68	461.26	refunded	2026-09-11 02:05:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":461.26,"platform_fee":48.68,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
134	75	8	sandbox	SIM-01M7DBCYZF12V74XXFKEK13WGY	recv_dqtmhkykmtuu	364.95	33.64	331.31	refunded	2026-09-11 00:41:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":331.31,"platform_fee":33.64,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
135	75	2	sandbox	SIM-01M7DBCYZJMXE53K6Q1YAZ5EGZ	recv_bosch_002	333.28	30.85	302.43	refunded	2026-09-11 00:56:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":302.43,"platform_fee":30.85,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
136	76	3	sandbox	SIM-01M7DBCYZQQE8NXBJ66BVXFYBK	recv_mann_003	1507.98	144.99	1362.99	paid	2026-07-27 03:07:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":1362.99,"platform_fee":144.99,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
137	76	1	sandbox	SIM-01M7DBCYZVD3R6VWF7YRY8J778	recv_cofap_001	1219.24	109.00	1110.24	paid	2026-07-27 05:02:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":1110.24,"platform_fee":109,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
138	77	8	sandbox	SIM-01M7DBCZ0016PPNRG600A1AQC1	recv_dqtmhkykmtuu	942.54	90.53	852.01	paid	2026-09-18 03:24:14	{"payment_method":"boleto","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":852.01,"platform_fee":90.53,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
139	77	3	sandbox	SIM-01M7DBCZ02V3XC6TR8GG8XYD4H	recv_mann_003	1362.54	131.53	1231.01	paid	2026-09-18 04:39:14	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":1231.01,"platform_fee":131.53,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
140	78	2	sandbox	SIM-01M7DBCZ07E9Y9G82XDT12WF65	recv_bosch_002	491.68	45.85	445.83	paid	2026-09-23 13:36:14	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":445.83,"platform_fee":45.85,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
141	78	1	sandbox	SIM-01M7DBCZ09VT09J198AJQ3HCK6	recv_cofap_001	909.10	90.91	818.19	paid	2026-09-23 13:49:14	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":818.19,"platform_fee":90.91,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
142	79	3	sandbox	SIM-01M7DBCZ0DV4SE8XF41D3ZFYTT	recv_mann_003	717.74	68.71	649.03	paid	2026-07-16 14:38:14	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":649.03,"platform_fee":68.71,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
143	80	1	sandbox	SIM-01M7DBCZ0J6J2XP3GPSHMTZXEV	recv_cofap_001	1110.97	107.75	1003.22	paid	2026-10-26 14:52:14	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":1003.22,"platform_fee":107.75,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
144	80	2	sandbox	SIM-01M7DBCZ0P7SJ4BDSD3BR2V43Z	recv_bosch_002	343.42	28.79	314.63	paid	2026-10-26 16:00:14	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":314.63,"platform_fee":28.79,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
145	81	4	sandbox	SIM-01M7DBCZ0VAB1YDMXN0Z26J73M	recv_curestdgztda	743.07	70.17	672.90	paid	2026-11-01 01:51:14	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":672.9,"platform_fee":70.17,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
146	82	1	sandbox	SIM-01M7DBCZ11TPWHFJNS5C20BAHV	recv_cofap_001	1990.16	189.96	1800.20	paid	2026-09-15 02:21:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":1800.2,"platform_fee":189.96,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
147	83	2	sandbox	SIM-01M7DBCZ15V7E5F10MVCG0GK01	recv_bosch_002	726.94	67.19	659.75	paid	2026-08-14 10:05:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":659.75,"platform_fee":67.19,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
148	84	7	sandbox	SIM-01M7DBCZ197H8XDZ96XHAVJQ63	recv_oyuhvogyydlf	755.35	69.87	685.48	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":685.48,"platform_fee":69.87,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
149	84	3	sandbox	SIM-01M7DBCZ1BB59T3PWBNXC8M2ET	recv_mann_003	544.39	50.16	494.23	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":494.23,"platform_fee":50.16,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
150	84	2	sandbox	SIM-01M7DBCZ1DAEGRRHX0M4HDGYMC	recv_bosch_002	459.37	40.17	419.20	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_bosch_002","seller_amount":419.2,"platform_fee":40.17,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
151	85	5	sandbox	SIM-01M7DBCZ1JVEHH8T7V810M3D3F	recv_elseufzgoyqq	592.86	52.41	540.45	paid	2026-10-13 11:28:14	{"payment_method":"boleto","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":540.45,"platform_fee":52.41,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
152	86	4	sandbox	SIM-01M7DBCZ1Q7VTQGHT5D64SJQRD	recv_curestdgztda	159.37	13.75	145.62	paid	2026-09-28 08:47:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":145.62,"platform_fee":13.75,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
153	86	5	sandbox	SIM-01M7DBCZ1TQHCPR3STRCGF3DXA	recv_elseufzgoyqq	526.16	52.62	473.54	paid	2026-09-28 09:10:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":473.54,"platform_fee":52.62,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
154	86	6	sandbox	SIM-01M7DBCZ1W1ES1EK53XR7WW9RP	recv_oieaajmwydmf	1287.98	121.81	1166.17	paid	2026-09-28 07:44:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":1166.17,"platform_fee":121.81,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
155	87	4	sandbox	SIM-01M7DBCZ2284X7AD8ADDH9TP73	recv_curestdgztda	400.12	35.69	364.43	paid	2026-10-17 18:49:14	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":364.43,"platform_fee":35.69,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
156	87	1	sandbox	SIM-01M7DBCZ23W5EAKA2NG13B38SF	recv_cofap_001	295.74	27.19	268.55	paid	2026-10-17 17:47:14	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":268.55,"platform_fee":27.19,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
157	87	3	sandbox	SIM-01M7DBCZ26FW0X33ER5BNBM98Z	recv_mann_003	936.52	93.65	842.87	paid	2026-10-17 18:12:14	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":842.87,"platform_fee":93.65,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
158	88	4	sandbox	SIM-01M7DBCZ2AWD1RKDAE033F3Z2N	recv_curestdgztda	251.39	21.73	229.66	paid	2026-11-13 10:28:14	{"payment_method":"boleto","split":{"receiver_id":"recv_curestdgztda","seller_amount":229.66,"platform_fee":21.73,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
159	88	5	sandbox	SIM-01M7DBCZ2CAEE329RVKF131K00	recv_elseufzgoyqq	528.54	46.32	482.22	paid	2026-11-13 10:40:14	{"payment_method":"boleto","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":482.22,"platform_fee":46.32,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
160	88	6	sandbox	SIM-01M7DBCZ2EFHCBNENFXTCQKSTQ	recv_oieaajmwydmf	1293.32	129.33	1163.99	paid	2026-11-13 10:33:14	{"payment_method":"boleto","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":1163.99,"platform_fee":129.33,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
161	89	5	sandbox	SIM-01M7DBCZ2MV5AK2478XEFGWZDE	recv_elseufzgoyqq	401.79	35.60	366.19	paid	2026-11-02 11:07:14	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":366.19,"platform_fee":35.6,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
162	89	2	sandbox	SIM-01M7DBCZ2P15QJFG44CHYDNZRV	recv_bosch_002	137.40	13.74	123.66	paid	2026-11-02 10:35:14	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":123.66,"platform_fee":13.74,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
163	89	6	sandbox	SIM-01M7DBCZ2RFFA381BT1C2TDSYK	recv_oieaajmwydmf	1260.45	121.81	1138.64	paid	2026-11-02 10:03:14	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":1138.64,"platform_fee":121.81,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
164	90	5	sandbox	SIM-01M7DBCZ2WGZ3P2DW2FBA57PWD	recv_elseufzgoyqq	261.70	21.10	240.60	paid	2026-10-24 20:51:14	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":240.6,"platform_fee":21.1,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
165	90	6	sandbox	SIM-01M7DBCZ2ZB6D1A7JRPA8XZSRD	recv_oieaajmwydmf	967.29	87.33	879.96	paid	2026-10-24 19:16:14	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":879.96,"platform_fee":87.33,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
166	90	7	sandbox	SIM-01M7DBCZ32MKK1Z6MY4CWAR6F2	recv_oyuhvogyydlf	410.68	38.18	372.50	paid	2026-10-24 19:05:14	{"payment_method":"pix","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":372.5,"platform_fee":38.18,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
167	91	6	sandbox	SIM-01M7DBCZ38DXQC5F8VTVWRS3F0	recv_oieaajmwydmf	703.70	65.04	638.66	refunded	2026-08-06 12:55:14	{"payment_method":"boleto","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":638.66,"platform_fee":65.04,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
168	91	8	sandbox	SIM-01M7DBCZ3A84V9HZKKTD0CVERH	recv_dqtmhkykmtuu	1312.20	131.22	1180.98	refunded	2026-08-06 14:42:14	{"payment_method":"boleto","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":1180.98,"platform_fee":131.22,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
169	92	5	sandbox	SIM-01M7DBCZ3F3SQ4D0RJ8E294YKW	recv_elseufzgoyqq	1052.32	105.23	947.09	paid	2026-10-04 11:37:14	{"payment_method":"boleto","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":947.09,"platform_fee":105.23,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
170	92	1	sandbox	SIM-01M7DBCZ3H8TSFT7C3KTVMCFCA	recv_cofap_001	1432.48	135.78	1296.70	paid	2026-10-04 11:55:14	{"payment_method":"boleto","split":{"receiver_id":"recv_cofap_001","seller_amount":1296.7,"platform_fee":135.78,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
171	93	1	sandbox	SIM-01M7DBCZ3PT0A4ER1YD8KP20MP	recv_cofap_001	974.75	94.48	880.27	paid	2026-11-05 22:53:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":880.27,"platform_fee":94.48,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
172	93	5	sandbox	SIM-01M7DBCZ3SDY91Y4ARTKE3KE4J	recv_elseufzgoyqq	1716.79	164.48	1552.31	paid	2026-11-05 23:55:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1552.31,"platform_fee":164.48,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
173	93	3	sandbox	SIM-01M7DBCZ3V0H9PDJ6PNHVNQEXR	recv_mann_003	1047.79	100.84	946.95	paid	2026-11-05 22:47:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":946.95,"platform_fee":100.84,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
174	94	2	sandbox	SIM-01M7DBCZ409YXZ7YD6JA8N69CE	recv_bosch_002	311.99	27.48	284.51	paid	2026-09-15 22:45:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":284.51,"platform_fee":27.48,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
175	94	3	sandbox	SIM-01M7DBCZ42WQ2H81TZA3N51NB6	recv_mann_003	675.25	65.50	609.75	paid	2026-09-15 22:38:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":609.75,"platform_fee":65.5,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
176	95	5	sandbox	SIM-01M7DBCZ48DDJ53K479GM5TH1C	recv_elseufzgoyqq	1946.75	187.91	1758.84	refunded	2026-08-11 12:42:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1758.84,"platform_fee":187.91,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
177	96	8	sandbox	SIM-01M7DBCZ4ESWX4K6PR0TAFW9A9	recv_dqtmhkykmtuu	331.48	30.51	300.97	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":300.97,"platform_fee":30.51,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
178	97	5	sandbox	SIM-01M7DBCZ4K7E0SZ4150TMDZYE2	recv_elseufzgoyqq	1465.25	141.73	1323.52	paid	2026-08-05 20:05:14	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1323.52,"platform_fee":141.73,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
179	97	6	sandbox	SIM-01M7DBCZ4PV7QDTAJ9YGEF0YJ3	recv_oieaajmwydmf	2665.93	259.95	2405.98	paid	2026-08-05 19:28:14	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":2405.98,"platform_fee":259.95,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
180	98	4	sandbox	SIM-01M7DBCZ4TYM1B0PTAAR3W2123	recv_curestdgztda	397.52	34.33	363.19	paid	2026-08-27 11:59:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":363.19,"platform_fee":34.33,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
181	98	3	sandbox	SIM-01M7DBCZ4WQ9E9TZP84PWYT12J	recv_mann_003	2086.57	202.14	1884.43	paid	2026-08-27 12:31:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":1884.43,"platform_fee":202.14,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
182	98	7	sandbox	SIM-01M7DBCZ4ZRDNBWPMS5ATDD4NE	recv_oyuhvogyydlf	1685.76	160.40	1525.36	paid	2026-08-27 11:42:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":1525.36,"platform_fee":160.4,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
183	99	2	sandbox	SIM-01M7DBCZ54JVYNEZ7GAX45N72P	recv_bosch_002	987.81	98.78	889.03	paid	2026-10-16 02:46:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":889.03,"platform_fee":98.78,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
184	99	4	sandbox	SIM-01M7DBCZ57P84E25D7X7GRM2RW	recv_curestdgztda	401.33	36.18	365.15	paid	2026-10-16 01:29:14	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":365.15,"platform_fee":36.18,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
185	100	3	sandbox	SIM-01M7DBCZ5C9CQQY5XC6YW6Q2EV	recv_mann_003	773.33	73.47	699.86	paid	2026-08-08 20:33:14	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":699.86,"platform_fee":73.47,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
186	100	1	sandbox	SIM-01M7DBCZ5EN75NDQDZ8X63STZC	recv_cofap_001	271.21	27.12	244.09	paid	2026-08-08 20:00:14	{"payment_method":"boleto","split":{"receiver_id":"recv_cofap_001","seller_amount":244.09,"platform_fee":27.12,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
187	100	6	sandbox	SIM-01M7DBCZ5JDT0MC5SXVD83FSBS	recv_oieaajmwydmf	1396.98	137.02	1259.96	paid	2026-08-08 21:13:14	{"payment_method":"boleto","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":1259.96,"platform_fee":137.02,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
188	101	2	sandbox	SIM-01M7DBCZ5QMC1C7M8H32CV94NW	recv_bosch_002	550.23	52.19	498.04	paid	2026-10-04 23:33:14	{"payment_method":"boleto","split":{"receiver_id":"recv_bosch_002","seller_amount":498.04,"platform_fee":52.19,"platform_fee_percent":10}}	2026-11-14 12:39:14	2026-11-14 12:39:14
189	101	5	sandbox	SIM-01M7DBCZ5TB5316WZYQ069V9BZ	recv_elseufzgoyqq	1380.45	131.24	1249.21	paid	2026-10-05 00:11:14	{"payment_method":"boleto","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1249.21,"platform_fee":131.24,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
190	102	5	sandbox	SIM-01M7DBCZ5Y3CNV6XAFWD698SAZ	recv_elseufzgoyqq	1104.94	110.49	994.45	paid	2026-09-27 00:01:15	{"payment_method":"boleto","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":994.45,"platform_fee":110.49,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
191	102	3	sandbox	SIM-01M7DBCZ60X58FQFV99BQ4AW4E	recv_mann_003	1032.25	100.84	931.41	paid	2026-09-26 23:34:15	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":931.41,"platform_fee":100.84,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
192	103	1	sandbox	SIM-01M7DBCZ64C8NGK9Y5G34R6MCA	recv_cofap_001	586.66	55.56	531.10	paid	2026-07-21 15:53:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":531.1,"platform_fee":55.56,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
193	103	6	sandbox	SIM-01M7DBCZ6612YGJFMWZMKJG4V9	recv_oieaajmwydmf	166.16	14.59	151.57	paid	2026-07-21 16:11:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":151.57,"platform_fee":14.59,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
194	104	5	sandbox	SIM-01M7DBCZ6BPZQC1QHBHBGX5BY0	recv_elseufzgoyqq	303.51	27.70	275.81	paid	2026-09-21 13:01:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":275.81,"platform_fee":27.7,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
195	104	3	sandbox	SIM-01M7DBCZ6C7DG66T2HV0QYC58K	recv_mann_003	2070.97	201.67	1869.30	paid	2026-09-21 12:34:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":1869.3,"platform_fee":201.67,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
196	105	3	sandbox	SIM-01M7DBCZ6HKDDX3FGX23QES7WV	recv_mann_003	761.44	72.49	688.95	paid	2026-09-03 02:55:15	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":688.95,"platform_fee":72.49,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
197	105	5	sandbox	SIM-01M7DBCZ6JD2TD8919QKWXT2GR	recv_elseufzgoyqq	807.36	71.19	736.17	paid	2026-09-03 02:15:15	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":736.17,"platform_fee":71.19,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
198	105	4	sandbox	SIM-01M7DBCZ6M7GHZ53FD4TY30EK3	recv_curestdgztda	410.59	36.29	374.30	paid	2026-09-03 03:21:15	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":374.3,"platform_fee":36.29,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
199	106	3	sandbox	SIM-01M7DBCZ6WWBY19A29FT1NSBK5	recv_mann_003	346.27	20.57	325.70	paid	2026-10-09 20:58:15	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":325.7,"platform_fee":20.57,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
200	106	6	sandbox	SIM-01M7DBCZ6YWCKA52WKKYJANJSA	recv_oieaajmwydmf	573.14	57.31	515.83	paid	2026-10-09 20:02:15	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":515.83,"platform_fee":57.31,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
201	107	5	sandbox	SIM-01M7DBCZ731P4XF5VSYEV68WKC	recv_elseufzgoyqq	1353.64	131.24	1222.40	paid	2026-07-19 22:39:15	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1222.4,"platform_fee":131.24,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
202	107	1	sandbox	SIM-01M7DBCZ75CBAW12RWETQDQVHA	recv_cofap_001	1930.27	189.27	1741.00	paid	2026-07-19 23:24:15	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":1741,"platform_fee":189.27,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
203	107	4	sandbox	SIM-01M7DBCZ77BA1JE114MB6D3PN2	recv_curestdgztda	639.92	61.58	578.34	paid	2026-07-20 00:08:15	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":578.34,"platform_fee":61.58,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
204	108	2	sandbox	SIM-01M7DBCZ7C5Y37DD0ZK12Z531J	recv_bosch_002	1165.02	113.28	1051.74	paid	2026-10-17 13:52:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":1051.74,"platform_fee":113.28,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
205	109	2	sandbox	SIM-01M7DBCZ7HDMMJ1XVCWRBNA98T	recv_bosch_002	414.03	39.30	374.73	paid	2026-08-08 02:17:15	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":374.73,"platform_fee":39.3,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
206	109	1	sandbox	SIM-01M7DBCZ7KCS2TMP5RCVSDE64E	recv_cofap_001	451.15	41.96	409.19	paid	2026-08-08 03:23:15	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":409.19,"platform_fee":41.96,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
207	110	3	sandbox	SIM-01M7DBCZ7RDMA1GNZ4DMJBWANJ	recv_mann_003	521.92	41.08	480.84	paid	2026-11-03 06:29:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":480.84,"platform_fee":41.08,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
208	111	4	sandbox	SIM-01M7DBCZ7X6W6JQKCFQNXVQQW0	recv_curestdgztda	535.95	49.76	486.19	paid	2026-09-13 10:58:15	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":486.19,"platform_fee":49.76,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
209	112	5	sandbox	SIM-01M7DBCZ82G98B8GH6N118EVR1	recv_elseufzgoyqq	303.23	26.53	276.70	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":276.7,"platform_fee":26.53,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
210	112	2	sandbox	SIM-01M7DBCZ84A7PRNGRVSJEVR3C1	recv_bosch_002	1129.83	109.56	1020.27	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_bosch_002","seller_amount":1020.27,"platform_fee":109.56,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
211	113	5	sandbox	SIM-01M7DBCZ89SAK5697FNHTRHF90	recv_elseufzgoyqq	309.03	29.15	279.88	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":279.88,"platform_fee":29.15,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
212	114	5	sandbox	SIM-01M7DBCZ8FH1HHXR6SYW65JRYT	recv_elseufzgoyqq	1540.86	154.09	1386.77	paid	2026-10-17 22:06:15	{"payment_method":"boleto","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1386.77,"platform_fee":154.09,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
213	115	1	sandbox	SIM-01M7DBCZ8MH6ZCXBVN8G9NYB6Q	recv_cofap_001	837.51	83.75	753.76	paid	2026-09-30 02:31:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":753.76,"platform_fee":83.75,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
214	116	4	sandbox	SIM-01M7DBCZ8S9VTM37NERBXFZ3XA	recv_curestdgztda	856.10	79.46	776.64	paid	2026-10-03 07:00:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":776.64,"platform_fee":79.46,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
215	117	3	sandbox	SIM-01M7DBCZ8Z22VHM9H6SW16Y070	recv_mann_003	1117.59	107.13	1010.46	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":1010.46,"platform_fee":107.13,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
216	117	7	sandbox	SIM-01M7DBCZ901BCYR2WVB070CWTS	recv_oyuhvogyydlf	373.96	34.93	339.03	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":339.03,"platform_fee":34.93,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
217	118	6	sandbox	SIM-01M7DBCZ941P6JWVQEBC7203EE	recv_oieaajmwydmf	167.25	13.23	154.02	paid	2026-08-14 18:16:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":154.02,"platform_fee":13.23,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
218	119	1	sandbox	SIM-01M7DBCZ9919F8Y2X4A72QVRYB	recv_cofap_001	289.46	26.79	262.67	paid	2026-11-04 22:32:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":262.67,"platform_fee":26.79,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
219	119	8	sandbox	SIM-01M7DBCZ9CGG948G9MS426YDJP	recv_dqtmhkykmtuu	1568.27	149.15	1419.12	paid	2026-11-04 20:43:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":1419.12,"platform_fee":149.15,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
220	120	2	sandbox	SIM-01M7DBCZ9HBGQFMB5KTNVJ5A0A	recv_bosch_002	834.44	80.42	754.02	paid	2026-11-07 01:34:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":754.02,"platform_fee":80.42,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
221	120	1	sandbox	SIM-01M7DBCZ9MRYAW8Q3H2392D5EA	recv_cofap_001	765.57	73.16	692.41	paid	2026-11-07 01:07:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":692.41,"platform_fee":73.16,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
222	121	3	sandbox	SIM-01M7DBCZ9SY3YQTAW7MKVHH11B	recv_mann_003	539.17	51.05	488.12	paid	2026-08-08 04:04:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":488.12,"platform_fee":51.05,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
223	121	4	sandbox	SIM-01M7DBCZ9VVK9MYW2EKHX9VS86	recv_curestdgztda	743.07	70.17	672.90	paid	2026-08-08 02:17:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":672.9,"platform_fee":70.17,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
224	121	6	sandbox	SIM-01M7DBCZ9XCVR7Y84C22WDE8MP	recv_oieaajmwydmf	298.80	26.43	272.37	paid	2026-08-08 02:52:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":272.37,"platform_fee":26.43,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
225	122	5	sandbox	SIM-01M7DBCZA152Q154VR87RXJHYY	recv_elseufzgoyqq	169.77	12.32	157.45	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":157.45,"platform_fee":12.32,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
226	123	2	sandbox	SIM-01M7DBCZA7X8KMEZBHS97Q92RG	recv_bosch_002	198.60	16.21	182.39	refunded	2026-10-21 17:55:15	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":182.39,"platform_fee":16.21,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
227	123	7	sandbox	SIM-01M7DBCZA99APHAS6R0D75SXFB	recv_oyuhvogyydlf	440.02	41.52	398.50	refunded	2026-10-21 18:06:15	{"payment_method":"pix","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":398.5,"platform_fee":41.52,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
228	124	3	sandbox	SIM-01M7DBCZAE98FW3C2DXQBK7TWB	recv_mann_003	514.33	47.01	467.32	paid	2026-07-26 06:06:15	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":467.32,"platform_fee":47.01,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
229	125	2	sandbox	SIM-01M7DBCZAJK0CNPRWTET7QGTYZ	recv_bosch_002	550.23	52.19	498.04	paid	2026-09-25 06:53:15	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":498.04,"platform_fee":52.19,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
230	126	3	sandbox	SIM-01M7DBCZAQV3P7XG2K80TWSE6P	recv_mann_003	1640.98	164.10	1476.88	paid	2026-10-02 18:10:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":1476.88,"platform_fee":164.1,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
231	126	8	sandbox	SIM-01M7DBCZASS42WRPFZW67RACZZ	recv_dqtmhkykmtuu	749.32	71.56	677.76	paid	2026-10-02 17:14:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":677.76,"platform_fee":71.56,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
232	127	3	sandbox	SIM-01M7DBCZB00AFNRMG0632YJ45M	recv_mann_003	2769.51	271.03	2498.48	paid	2026-08-16 15:33:15	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":2498.48,"platform_fee":271.03,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
233	127	2	sandbox	SIM-01M7DBCZB2P4Y0XREZXBBRJ5QW	recv_bosch_002	459.37	40.17	419.20	paid	2026-08-16 15:54:15	{"payment_method":"boleto","split":{"receiver_id":"recv_bosch_002","seller_amount":419.2,"platform_fee":40.17,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
234	128	4	sandbox	SIM-01M7DBCZB7Y3X28E5XAFDDV67X	recv_curestdgztda	474.45	42.41	432.04	paid	2026-09-27 19:05:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":432.04,"platform_fee":42.41,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
235	128	8	sandbox	SIM-01M7DBCZB9M7TWYZQEKKJPATG2	recv_dqtmhkykmtuu	393.05	36.25	356.80	paid	2026-09-27 19:41:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":356.8,"platform_fee":36.25,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
236	129	8	sandbox	SIM-01M7DBCZBDZTDFYQC20R6P8Y8Q	recv_dqtmhkykmtuu	794.85	77.43	717.42	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":717.42,"platform_fee":77.43,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
237	130	7	sandbox	SIM-01M7DBCZBKJSJFNEBXCQYYCB3R	recv_oyuhvogyydlf	1230.58	123.06	1107.52	paid	2026-08-20 02:39:15	{"payment_method":"pix","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":1107.52,"platform_fee":123.06,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
238	130	1	sandbox	SIM-01M7DBCZBNR544B09871N5BD0N	recv_cofap_001	277.88	22.56	255.32	paid	2026-08-20 03:42:15	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":255.32,"platform_fee":22.56,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
239	130	4	sandbox	SIM-01M7DBCZBQCKVS3HYRPZY7YSE7	recv_curestdgztda	212.38	18.91	193.47	paid	2026-08-20 03:15:15	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":193.47,"platform_fee":18.91,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
240	131	2	sandbox	SIM-01M7DBCZBXPSFD9679SBYKQ4G9	recv_bosch_002	593.94	53.15	540.79	paid	2026-08-04 18:47:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":540.79,"platform_fee":53.15,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
241	132	6	sandbox	SIM-01M7DBCZC2213FMKS8PYNFAC5Z	recv_oieaajmwydmf	1836.75	176.97	1659.78	paid	2026-09-26 14:17:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":1659.78,"platform_fee":176.97,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
242	133	5	sandbox	SIM-01M7DBCZC6KAXNWXT1JX5R4BEK	recv_elseufzgoyqq	1688.43	164.48	1523.95	paid	2026-09-02 09:47:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1523.95,"platform_fee":164.48,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
243	134	3	sandbox	SIM-01M7DBCZCC5F70MBM0WR1KRAPS	recv_mann_003	1538.13	146.40	1391.73	paid	2026-07-19 07:06:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":1391.73,"platform_fee":146.4,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
244	134	8	sandbox	SIM-01M7DBCZCF2CP4Y9E6V5WC1PV2	recv_dqtmhkykmtuu	776.47	74.58	701.89	paid	2026-07-19 07:15:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":701.89,"platform_fee":74.58,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
245	135	4	sandbox	SIM-01M7DBCZCM5PQBEW7J5PD6B16J	recv_curestdgztda	829.45	72.36	757.09	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":757.09,"platform_fee":72.36,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
246	135	7	sandbox	SIM-01M7DBCZCPPM0PJ4N86PH78TKF	recv_oyuhvogyydlf	410.68	38.18	372.50	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":372.5,"platform_fee":38.18,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
247	135	6	sandbox	SIM-01M7DBCZCRRB7B56R4XAJWFH98	recv_oieaajmwydmf	1299.74	129.97	1169.77	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":1169.77,"platform_fee":129.97,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
248	136	5	sandbox	SIM-01M7DBCZCYDMNXYK10B556C3E9	recv_elseufzgoyqq	304.18	28.09	276.09	paid	2026-09-24 18:20:15	{"payment_method":"boleto","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":276.09,"platform_fee":28.09,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
249	137	5	sandbox	SIM-01M7DBCZD3GZ0K83GJ2Y801TCW	recv_elseufzgoyqq	593.46	56.17	537.29	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":537.29,"platform_fee":56.17,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
250	137	8	sandbox	SIM-01M7DBCZD6R46W9S5NYV6Y63HC	recv_dqtmhkykmtuu	477.87	44.70	433.17	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":433.17,"platform_fee":44.7,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
251	138	3	sandbox	SIM-01M7DBCZDC2KSEGXG3NDAMAF2B	recv_mann_003	452.73	37.93	414.80	paid	2026-08-08 12:27:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":414.8,"platform_fee":37.93,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
252	138	6	sandbox	SIM-01M7DBCZDD28EZTT2X7D2G9GPT	recv_oieaajmwydmf	550.88	55.09	495.79	paid	2026-08-08 13:06:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":495.79,"platform_fee":55.09,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
253	139	5	sandbox	SIM-01M7DBCZDJQ4WAPF1GJG4CJMNB	recv_elseufzgoyqq	1113.76	108.83	1004.93	paid	2026-10-15 14:28:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1004.93,"platform_fee":108.83,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
254	139	8	sandbox	SIM-01M7DBCZDM8D2Z3F7HGABNE64S	recv_dqtmhkykmtuu	975.06	94.48	880.58	paid	2026-10-15 14:41:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":880.58,"platform_fee":94.48,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
255	139	2	sandbox	SIM-01M7DBCZDPKX02D5VBD9W4ZY05	recv_bosch_002	628.16	59.98	568.18	paid	2026-10-15 15:30:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":568.18,"platform_fee":59.98,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
256	140	4	sandbox	SIM-01M7DBCZDXM5H0PN1GZ4XVHD7B	recv_curestdgztda	1459.05	141.04	1318.01	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":1318.01,"platform_fee":141.04,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
257	140	6	sandbox	SIM-01M7DBCZDYT88JTE9PT8JFQC1R	recv_oieaajmwydmf	1230.28	123.03	1107.25	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":1107.25,"platform_fee":123.03,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
258	141	3	sandbox	SIM-01M7DBCZE3Q3EGPPY9BER8N7E7	recv_mann_003	530.45	48.90	481.55	paid	2026-09-20 01:59:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":481.55,"platform_fee":48.9,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
259	141	6	sandbox	SIM-01M7DBCZE5BZXYH5PX1CYZMQHB	recv_oieaajmwydmf	307.01	28.66	278.35	paid	2026-09-20 01:52:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":278.35,"platform_fee":28.66,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
260	142	4	sandbox	SIM-01M7DBCZEANJCBCJ98065RH7SH	recv_curestdgztda	1150.26	115.03	1035.23	paid	2026-10-12 11:12:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":1035.23,"platform_fee":115.03,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
261	142	2	sandbox	SIM-01M7DBCZEDB6VBY5J1DB23TVZ2	recv_bosch_002	1054.29	102.30	951.99	paid	2026-10-12 11:27:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":951.99,"platform_fee":102.3,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
262	143	2	sandbox	SIM-01M7DBCZEJC7BZCQEEGSZF888M	recv_bosch_002	1051.55	101.22	950.33	refunded	2026-09-25 19:31:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":950.33,"platform_fee":101.22,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
263	144	4	sandbox	SIM-01M7DBCZEQYWQGZ9XH70F31M7N	recv_curestdgztda	389.90	35.94	353.96	refunded	2026-09-25 20:44:15	{"payment_method":"boleto","split":{"receiver_id":"recv_curestdgztda","seller_amount":353.96,"platform_fee":35.94,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
264	145	3	sandbox	SIM-01M7DBCZEXTYJEBZ7T2TDE6T41	recv_mann_003	761.44	72.49	688.95	paid	2026-10-06 00:25:15	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":688.95,"platform_fee":72.49,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
265	145	2	sandbox	SIM-01M7DBCZEZJVTNB9XVCDQ66SCE	recv_bosch_002	1067.50	103.28	964.22	paid	2026-10-05 23:28:15	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":964.22,"platform_fee":103.28,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
266	145	8	sandbox	SIM-01M7DBCZF2JRJZABYB4HCSM9BK	recv_dqtmhkykmtuu	348.60	30.51	318.09	paid	2026-10-05 23:35:15	{"payment_method":"pix","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":318.09,"platform_fee":30.51,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
267	146	1	sandbox	SIM-01M7DBCZF823PAR27ZQGK187GZ	recv_cofap_001	310.22	27.12	283.10	paid	2026-10-07 20:31:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":283.1,"platform_fee":27.12,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
268	147	8	sandbox	SIM-01M7DBCZFFV0S323P812PSETFF	recv_dqtmhkykmtuu	231.99	20.91	211.08	paid	2026-10-12 13:21:15	{"payment_method":"boleto","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":211.08,"platform_fee":20.91,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
269	147	7	sandbox	SIM-01M7DBCZFJXV2VKT50GSVC1JXP	recv_oyuhvogyydlf	1604.00	160.40	1443.60	paid	2026-10-12 14:06:15	{"payment_method":"boleto","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":1443.6,"platform_fee":160.4,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
270	148	1	sandbox	SIM-01M7DBCZFRG84RXPHGN8NEWJBN	recv_cofap_001	1247.88	120.13	1127.75	paid	2026-10-09 12:36:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":1127.75,"platform_fee":120.13,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
271	149	2	sandbox	SIM-01M7DBCZFZD6EDMHCV9V6J553S	recv_bosch_002	546.32	50.24	496.08	paid	2026-10-18 14:51:15	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":496.08,"platform_fee":50.24,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
272	149	5	sandbox	SIM-01M7DBCZG2FCVN4Z8FJNSSFCRR	recv_elseufzgoyqq	1005.99	94.85	911.14	paid	2026-10-18 15:14:15	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":911.14,"platform_fee":94.85,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
273	150	5	sandbox	SIM-01M7DBCZG9PG43PXTSEAEB0MWF	recv_elseufzgoyqq	458.20	45.82	412.38	paid	2026-10-12 15:22:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":412.38,"platform_fee":45.82,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
274	150	6	sandbox	SIM-01M7DBCZGCF1EMQTMZR254PB2J	recv_oieaajmwydmf	913.30	86.25	827.05	paid	2026-10-12 15:39:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":827.05,"platform_fee":86.25,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
275	150	3	sandbox	SIM-01M7DBCZGFN852ZJKEZ76SW25K	recv_mann_003	1110.98	105.79	1005.19	paid	2026-10-12 15:56:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":1005.19,"platform_fee":105.79,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
276	151	3	sandbox	SIM-01M7DBCZGP1D5AX5WGPVCP3VGC	recv_mann_003	521.03	49.55	471.48	paid	2026-07-26 12:56:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":471.48,"platform_fee":49.55,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
277	151	5	sandbox	SIM-01M7DBCZGSWYM941GSBT615N3V	recv_elseufzgoyqq	1430.53	140.43	1290.10	paid	2026-07-26 14:38:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1290.1,"platform_fee":140.43,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
278	151	1	sandbox	SIM-01M7DBCZGWFGGVJ0GNWZ3K3GZB	recv_cofap_001	820.31	79.02	741.29	paid	2026-07-26 13:42:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":741.29,"platform_fee":79.02,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
279	152	1	sandbox	SIM-01M7DBCZH392TPG3TWW7FJREQ0	recv_cofap_001	779.80	77.98	701.82	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":701.82,"platform_fee":77.98,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
280	153	8	sandbox	SIM-01M7DBCZHCXZMB3E2G8W2BSN5S	recv_dqtmhkykmtuu	119.81	7.80	112.01	paid	2026-08-16 07:45:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":112.01,"platform_fee":7.8,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
281	153	2	sandbox	SIM-01M7DBCZHGD7TPJJBTZF7F6AM5	recv_bosch_002	1126.14	107.44	1018.70	paid	2026-08-16 07:58:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":1018.7,"platform_fee":107.44,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
282	153	3	sandbox	SIM-01M7DBCZHK9NAF9NJZYCYXN1QW	recv_mann_003	275.50	25.34	250.16	paid	2026-08-16 07:11:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":250.16,"platform_fee":25.34,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
283	154	4	sandbox	SIM-01M7DBCZHV65SDH1CRKJTX20JA	recv_curestdgztda	831.86	79.46	752.40	paid	2026-07-27 13:28:15	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":752.4,"platform_fee":79.46,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
284	154	2	sandbox	SIM-01M7DBCZHYF0WDEKM3X970NWFV	recv_bosch_002	416.09	37.42	378.67	paid	2026-07-27 13:11:15	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":378.67,"platform_fee":37.42,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
285	155	5	sandbox	SIM-01M7DBCZJ60D1RT54YHJ2EYEBF	recv_elseufzgoyqq	169.77	12.32	157.45	paid	2026-11-01 19:27:15	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":157.45,"platform_fee":12.32,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
286	155	8	sandbox	SIM-01M7DBCZJ9DWWP9Y1VCRGGP57H	recv_dqtmhkykmtuu	423.56	39.87	383.69	paid	2026-11-01 19:57:15	{"payment_method":"pix","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":383.69,"platform_fee":39.87,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
287	155	1	sandbox	SIM-01M7DBCZJC9M54A7PXW47GCFJR	recv_cofap_001	682.92	65.64	617.28	paid	2026-11-01 19:43:15	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":617.28,"platform_fee":65.64,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
288	156	3	sandbox	SIM-01M7DBCZJMMMZ6VYRJ11PG3NTN	recv_mann_003	1020.47	96.26	924.21	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":924.21,"platform_fee":96.26,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
289	156	2	sandbox	SIM-01M7DBCZJSNVDCCQYKM73RR348	recv_bosch_002	458.10	41.42	416.68	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":416.68,"platform_fee":41.42,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
290	157	8	sandbox	SIM-01M7DBCZJZ0R862SDXAYXZKBCV	recv_dqtmhkykmtuu	1259.62	121.01	1138.61	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":1138.61,"platform_fee":121.01,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
291	157	2	sandbox	SIM-01M7DBCZK3FSTB32M1DNJKTYK9	recv_bosch_002	628.16	59.98	568.18	pending	\N	{"payment_method":"boleto","split":{"receiver_id":"recv_bosch_002","seller_amount":568.18,"platform_fee":59.98,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
292	158	8	sandbox	SIM-01M7DBCZKF4ES6TB3RZ8BSF5MD	recv_dqtmhkykmtuu	1411.31	132.35	1278.96	paid	2026-10-08 07:11:15	{"payment_method":"boleto","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":1278.96,"platform_fee":132.35,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
293	159	5	sandbox	SIM-01M7DBCZKPSG14JCQ684BV4V0T	recv_elseufzgoyqq	750.78	72.03	678.75	paid	2026-10-08 05:18:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":678.75,"platform_fee":72.03,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
294	159	1	sandbox	SIM-01M7DBCZKS53SSA37J8S87D89D	recv_cofap_001	599.33	55.21	544.12	paid	2026-10-08 05:46:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":544.12,"platform_fee":55.21,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
295	160	7	sandbox	SIM-01M7DBCZKZTW6YM805J59B6GGR	recv_oyuhvogyydlf	440.45	40.88	399.57	paid	2026-09-14 02:24:15	{"payment_method":"boleto","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":399.57,"platform_fee":40.88,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
296	160	1	sandbox	SIM-01M7DBCZM3P35QMKECDT1D0DD9	recv_cofap_001	443.57	41.11	402.46	paid	2026-09-14 02:18:15	{"payment_method":"boleto","split":{"receiver_id":"recv_cofap_001","seller_amount":402.46,"platform_fee":41.11,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
297	161	2	sandbox	SIM-01M7DBCZM91M2CFB44BAN3BJF3	recv_bosch_002	547.82	54.78	493.04	refunded	2026-10-01 19:39:15	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":493.04,"platform_fee":54.78,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
298	162	5	sandbox	SIM-01M7DBCZME5B94A5TXB6Q8WX5D	recv_elseufzgoyqq	1070.53	99.97	970.56	paid	2026-08-04 16:30:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":970.56,"platform_fee":99.97,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
299	162	2	sandbox	SIM-01M7DBCZMGV8HVEHZ8Q3KRBAPY	recv_bosch_002	1244.31	119.96	1124.35	paid	2026-08-04 16:43:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":1124.35,"platform_fee":119.96,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
300	163	3	sandbox	SIM-01M7DBCZMQGQ8QMC1JXR6EWPVJ	recv_mann_003	548.07	54.81	493.26	paid	2026-09-24 12:00:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":493.26,"platform_fee":54.81,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
301	163	7	sandbox	SIM-01M7DBCZMT7TJ028H6E8K5R6DS	recv_oyuhvogyydlf	781.07	74.42	706.65	paid	2026-09-24 11:29:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":706.65,"platform_fee":74.42,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
302	164	4	sandbox	SIM-01M7DBCZMZ7YFSDNGRCDWAXKT4	recv_curestdgztda	483.65	45.97	437.68	paid	2026-07-27 11:18:15	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":437.68,"platform_fee":45.97,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
303	165	4	sandbox	SIM-01M7DBCZN5HMT5CDEXHEN5V45E	recv_curestdgztda	1273.52	119.72	1153.80	paid	2026-10-22 23:41:15	{"payment_method":"boleto","split":{"receiver_id":"recv_curestdgztda","seller_amount":1153.8,"platform_fee":119.72,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
304	166	6	sandbox	SIM-01M7DBCZNANFXAHN9154DT8745	recv_oieaajmwydmf	191.73	16.37	175.36	paid	2026-08-08 07:46:15	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":175.36,"platform_fee":16.37,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
305	167	7	sandbox	SIM-01M7DBCZNG68AR67GP6Z899B44	recv_oyuhvogyydlf	484.14	44.71	439.43	paid	2026-07-30 04:02:15	{"payment_method":"boleto","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":439.43,"platform_fee":44.71,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
306	168	1	sandbox	SIM-01M7DBCZNPN8BEX5T5X3SNKK6A	recv_cofap_001	413.91	38.99	374.92	paid	2026-09-27 19:12:15	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":374.92,"platform_fee":38.99,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
307	169	7	sandbox	SIM-01M7DBCZNWK9D0WH7JY5F0XXNJ	recv_oyuhvogyydlf	850.96	81.77	769.19	paid	2026-10-12 16:21:15	{"payment_method":"pix","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":769.19,"platform_fee":81.77,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
308	170	2	sandbox	SIM-01M7DBCZP2951T3PMDBE0TGZBF	recv_bosch_002	592.18	53.72	538.46	paid	2026-09-22 06:16:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":538.46,"platform_fee":53.72,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
309	171	3	sandbox	SIM-01M7DBCZP8J6R4ZWS0NJZMBD1R	recv_mann_003	60.12	4.02	56.10	paid	2026-10-20 00:02:15	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":56.1,"platform_fee":4.02,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
310	171	8	sandbox	SIM-01M7DBCZPAYKP1Y6KYGMZEJP7B	recv_dqtmhkykmtuu	153.32	12.82	140.50	paid	2026-10-20 00:47:15	{"payment_method":"pix","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":140.5,"platform_fee":12.82,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
311	171	1	sandbox	SIM-01M7DBCZPDNAB37G0RWT52HYC6	recv_cofap_001	412.62	38.92	373.70	paid	2026-10-20 01:28:15	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":373.7,"platform_fee":38.92,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
312	172	5	sandbox	SIM-01M7DBCZPMMMD5NS3QBRJDBRW3	recv_elseufzgoyqq	1529.89	146.05	1383.84	paid	2026-09-05 09:50:15	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1383.84,"platform_fee":146.05,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
313	173	5	sandbox	SIM-01M7DBCZPTXXFVDRHARJ6VVTTY	recv_elseufzgoyqq	245.80	19.85	225.95	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":225.95,"platform_fee":19.85,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
314	174	5	sandbox	SIM-01M7DBCZQ019PS0REKJH0CCHVF	recv_elseufzgoyqq	884.84	76.17	808.67	paid	2026-09-16 07:46:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":808.67,"platform_fee":76.17,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
315	174	2	sandbox	SIM-01M7DBCZQ47MHVC7SK0MARNGDF	recv_bosch_002	231.08	19.82	211.26	paid	2026-09-16 06:39:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":211.26,"platform_fee":19.82,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
316	175	1	sandbox	SIM-01M7DBCZQB0XDT9NVZGZ5TFQS6	recv_cofap_001	413.91	38.99	374.92	paid	2026-08-21 23:02:15	{"payment_method":"boleto","split":{"receiver_id":"recv_cofap_001","seller_amount":374.92,"platform_fee":38.99,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
317	175	4	sandbox	SIM-01M7DBCZQEVCAC0VJC0QBFBWDP	recv_curestdgztda	770.46	68.66	701.80	paid	2026-08-21 23:42:15	{"payment_method":"boleto","split":{"receiver_id":"recv_curestdgztda","seller_amount":701.8,"platform_fee":68.66,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
318	176	8	sandbox	SIM-01M7DBCZQNRQ9HCWJ6GMZAD220	recv_dqtmhkykmtuu	389.48	36.78	352.70	paid	2026-09-20 12:37:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":352.7,"platform_fee":36.78,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
319	177	2	sandbox	SIM-01M7DBCZQVRVAQYYAJ89DXJCRD	recv_bosch_002	1337.57	121.37	1216.20	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":1216.2,"platform_fee":121.37,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
320	178	1	sandbox	SIM-01M7DBCZR2VBDD8Y3K8VGT5GVZ	recv_cofap_001	159.48	12.99	146.49	paid	2026-09-03 00:25:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_cofap_001","seller_amount":146.49,"platform_fee":12.99,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
321	178	5	sandbox	SIM-01M7DBCZR52CZDBX6R6F2PRX40	recv_elseufzgoyqq	431.84	35.95	395.89	paid	2026-09-03 01:19:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":395.89,"platform_fee":35.95,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
322	178	7	sandbox	SIM-01M7DBCZR753CE76HRB0BZADQ3	recv_oyuhvogyydlf	761.29	73.28	688.01	paid	2026-09-03 01:49:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":688.01,"platform_fee":73.28,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
323	179	5	sandbox	SIM-01M7DBCZREJQSY91MBY90GBZ9H	recv_elseufzgoyqq	150.32	11.84	138.48	paid	2026-10-10 16:05:15	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":138.48,"platform_fee":11.84,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
324	179	2	sandbox	SIM-01M7DBCZRJ33WKVFRBQZ47XK0C	recv_bosch_002	838.52	79.88	758.64	paid	2026-10-10 14:39:15	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":758.64,"platform_fee":79.88,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
325	180	6	sandbox	SIM-01M7DBCZRR893205NT3QEDFZYJ	recv_oieaajmwydmf	420.61	36.80	383.81	paid	2026-09-05 20:00:15	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":383.81,"platform_fee":36.8,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
326	181	1	sandbox	SIM-01M7DBCZRYDKK7YA1PTT7727TS	recv_cofap_001	521.26	48.91	472.35	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":472.35,"platform_fee":48.91,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
327	182	5	sandbox	SIM-01M7DBCZS4QY4EPGRXT526RGHG	recv_elseufzgoyqq	1401.27	131.73	1269.54	paid	2026-10-20 15:39:15	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1269.54,"platform_fee":131.73,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
328	183	4	sandbox	SIM-01M7DBCZSAVG11YZC6KQRXZ3K5	recv_curestdgztda	397.52	34.33	363.19	paid	2026-08-13 01:52:15	{"payment_method":"boleto","split":{"receiver_id":"recv_curestdgztda","seller_amount":363.19,"platform_fee":34.33,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
329	183	3	sandbox	SIM-01M7DBCZSDKJQ3PX4Z9DRXM1CE	recv_mann_003	265.97	21.35	244.62	paid	2026-08-13 03:36:15	{"payment_method":"boleto","split":{"receiver_id":"recv_mann_003","seller_amount":244.62,"platform_fee":21.35,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
330	184	3	sandbox	SIM-01M7DBCZSKD4NBV05MJ49Z0N6J	recv_mann_003	529.36	47.27	482.09	paid	2026-07-24 02:38:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":482.09,"platform_fee":47.27,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
331	184	5	sandbox	SIM-01M7DBCZSPXC8Y90RDEMS0KAZA	recv_elseufzgoyqq	1460.52	146.05	1314.47	paid	2026-07-24 02:37:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":1314.47,"platform_fee":146.05,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
332	185	2	sandbox	SIM-01M7DBCZSVBJWVAT7V7R45QNHZ	recv_bosch_002	1051.55	101.22	950.33	refunded	2026-09-09 06:51:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":950.33,"platform_fee":101.22,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
333	186	8	sandbox	SIM-01M7DBCZT1MWNCRYSDW9C1K9TR	recv_dqtmhkykmtuu	156.75	12.27	144.48	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":144.48,"platform_fee":12.27,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
334	186	1	sandbox	SIM-01M7DBCZT4HYF1409FCP66961K	recv_cofap_001	292.41	27.12	265.29	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":265.29,"platform_fee":27.12,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
335	187	6	sandbox	SIM-01M7DBCZT9Y0C1THE80RPR9FHV	recv_oieaajmwydmf	600.53	55.09	545.44	paid	2026-09-09 13:11:15	{"payment_method":"boleto","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":545.44,"platform_fee":55.09,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
336	188	3	sandbox	SIM-01M7DBCZTF6DNAAFQD00V71BT7	recv_mann_003	997.67	96.26	901.41	paid	2026-09-29 14:15:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":901.41,"platform_fee":96.26,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
337	188	5	sandbox	SIM-01M7DBCZTHG85XQ6KV87Y2M84A	recv_elseufzgoyqq	261.70	21.10	240.60	paid	2026-09-29 13:30:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":240.6,"platform_fee":21.1,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
338	189	2	sandbox	SIM-01M7DBCZTQRVYG752XXQKDM8DM	recv_bosch_002	1112.73	104.38	1008.35	paid	2026-09-17 07:05:15	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":1008.35,"platform_fee":104.38,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
339	189	7	sandbox	SIM-01M7DBCZTS5VZYGC8QHMSQ6WET	recv_oyuhvogyydlf	373.12	32.58	340.54	paid	2026-09-17 06:47:15	{"payment_method":"pix","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":340.54,"platform_fee":32.58,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
340	189	5	sandbox	SIM-01M7DBCZTW3GTD5HXJ92R15F74	recv_elseufzgoyqq	345.43	31.97	313.46	paid	2026-09-17 06:53:15	{"payment_method":"pix","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":313.46,"platform_fee":31.97,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
341	190	4	sandbox	SIM-01M7DBCZV3X72QP2HADZE8G24A	recv_curestdgztda	1189.68	98.21	1091.47	paid	2026-08-26 13:22:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":1091.47,"platform_fee":98.21,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
342	190	5	sandbox	SIM-01M7DBCZV6T1NKCEM7HGG5Y59T	recv_elseufzgoyqq	303.23	26.53	276.70	paid	2026-08-26 14:42:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":276.7,"platform_fee":26.53,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
343	191	4	sandbox	SIM-01M7DBCZVCVESEFNA4WB92508A	recv_curestdgztda	1231.65	118.30	1113.35	paid	2026-08-01 10:46:15	{"payment_method":"pix","split":{"receiver_id":"recv_curestdgztda","seller_amount":1113.35,"platform_fee":118.3,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
344	191	7	sandbox	SIM-01M7DBCZVFJK0497X6W67Z4THG	recv_oyuhvogyydlf	569.82	52.51	517.31	paid	2026-08-01 11:07:15	{"payment_method":"pix","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":517.31,"platform_fee":52.51,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
345	192	3	sandbox	SIM-01M7DBCZVM364GZS6CRMSDGCWE	recv_mann_003	496.91	47.01	449.90	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":449.9,"platform_fee":47.01,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
346	192	2	sandbox	SIM-01M7DBCZVPVQZ9HD9M6FV3NS9J	recv_bosch_002	1775.01	172.76	1602.25	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":1602.25,"platform_fee":172.76,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
347	193	2	sandbox	SIM-01M7DBCZVVBQAQSBH1QQ8TV26X	recv_bosch_002	417.87	37.98	379.89	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":379.89,"platform_fee":37.98,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
348	193	8	sandbox	SIM-01M7DBCZVX8QPT8AYXMGENSTFN	recv_dqtmhkykmtuu	1121.76	103.89	1017.87	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":1017.87,"platform_fee":103.89,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
349	194	7	sandbox	SIM-01M7DBCZW3QZ90Z1CDGWJJSRAG	recv_oyuhvogyydlf	806.46	76.36	730.10	paid	2026-10-24 12:09:15	{"payment_method":"pix","split":{"receiver_id":"recv_oyuhvogyydlf","seller_amount":730.1,"platform_fee":76.36,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
350	194	1	sandbox	SIM-01M7DBCZW54F8K3VEB9S0QESD9	recv_cofap_001	417.60	39.51	378.09	paid	2026-10-24 13:19:15	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":378.09,"platform_fee":39.51,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
351	195	2	sandbox	SIM-01M7DBCZWAK81P0B9QSQTKBDTK	recv_bosch_002	1051.55	101.22	950.33	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_bosch_002","seller_amount":950.33,"platform_fee":101.22,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
352	195	3	sandbox	SIM-01M7DBCZWCYNPDSD1T9XGE8S3W	recv_mann_003	294.30	27.43	266.87	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":266.87,"platform_fee":27.43,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
353	196	8	sandbox	SIM-01M7DBCZWK2B7JCHJ56EXDJ0ZQ	recv_dqtmhkykmtuu	383.48	33.64	349.84	paid	2026-07-18 21:37:15	{"payment_method":"boleto","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":349.84,"platform_fee":33.64,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
354	197	5	sandbox	SIM-01M7DBCZWRJJYGMG1YGDHQMT22	recv_elseufzgoyqq	331.87	26.27	305.60	paid	2026-10-06 21:17:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_elseufzgoyqq","seller_amount":305.6,"platform_fee":26.27,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
355	197	6	sandbox	SIM-01M7DBCZWT20BK5VR0F18Y81PW	recv_oieaajmwydmf	784.88	73.60	711.28	paid	2026-10-06 22:28:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":711.28,"platform_fee":73.6,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
356	198	8	sandbox	SIM-01M7DBCZWZ546CBX4P2WDN5C5J	recv_dqtmhkykmtuu	1074.62	99.65	974.97	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_dqtmhkykmtuu","seller_amount":974.97,"platform_fee":99.65,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
357	198	6	sandbox	SIM-01M7DBCZX1CTSH0FJ2CGGCSRVQ	recv_oieaajmwydmf	469.29	46.93	422.36	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":422.36,"platform_fee":46.93,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
358	199	3	sandbox	SIM-01M7DBCZX6XCNZCPH4ZSMVWYWB	recv_mann_003	708.91	65.77	643.14	paid	2026-08-25 20:00:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_mann_003","seller_amount":643.14,"platform_fee":65.77,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
359	199	4	sandbox	SIM-01M7DBCZX9W32ABMKD0MMCT96Y	recv_curestdgztda	671.58	64.59	606.99	paid	2026-08-25 20:10:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_curestdgztda","seller_amount":606.99,"platform_fee":64.59,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
360	199	2	sandbox	SIM-01M7DBCZXDCZ3TTT2KGWWC8KPN	recv_bosch_002	648.39	60.80	587.59	paid	2026-08-25 19:51:15	{"payment_method":"credit_card","split":{"receiver_id":"recv_bosch_002","seller_amount":587.59,"platform_fee":60.8,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
361	200	6	sandbox	SIM-01M7DBCZXJGXK5XWYMDEHH7489	recv_oieaajmwydmf	235.00	19.52	215.48	pending	\N	{"payment_method":"credit_card","split":{"receiver_id":"recv_oieaajmwydmf","seller_amount":215.48,"platform_fee":19.52,"platform_fee_percent":10}}	2026-11-14 12:39:15	2026-11-14 12:39:15
362	201	3	sandbox	SIM-01M7DBEXD35GE3ATBWCP52G4XK	recv_mann_003	979.03	93.65	885.38	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":885.38,"platform_fee":93.65,"platform_fee_percent":10}}	2026-11-14 12:40:18	2026-11-14 12:40:18
364	203	1	sandbox	SIM-01M7DCJV852NR9SGPRKB9ST46R	recv_cofap_001	984.70	94.98	889.72	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_cofap_001","seller_amount":889.72,"platform_fee":94.98,"platform_fee_percent":10}}	2026-11-14 12:59:56	2026-11-14 12:59:56
365	203	3	sandbox	SIM-01M7DCJV8GVQQ6TKWWHWYFM782	recv_mann_003	250.79	21.98	228.81	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":228.81,"platform_fee":21.98,"platform_fee_percent":10}}	2026-11-14 12:59:56	2026-11-14 12:59:56
366	204	3	sandbox	SIM-01M7DEME9WJGZ2DNYR7YH096AW	recv_mann_003	979.03	93.65	885.38	pending	\N	{"payment_method":"pix","split":{"receiver_id":"recv_mann_003","seller_amount":885.38,"platform_fee":93.65,"platform_fee_percent":10}}	2026-11-14 13:35:45	2026-11-14 13:35:45
\.


--
-- TOC entry 5230 (class 0 OID 16963)
-- Dependencies: 223
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 5252 (class 0 OID 17200)
-- Dependencies: 245
-- Data for Name: pedidos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedidos (id, number, customer_name, customer_email, customer_document, customer_phone, shipping_zip_code, shipping_street, shipping_number, shipping_complement, shipping_neighborhood, shipping_city, shipping_state, subtotal, shipping_total, discount_total, total, status, payment_status, payment_method, notes, placed_at, created_at, updated_at, pix_payload, pix_expires_at, user_id) FROM stdin;
1	ORD-20261026-VJJPDK	Tomás Meireles Jr.	thales16@example.org	06885132390	(01) 97302-1000	70040900	SQS 308	38	\N	Asa Sul	Brasília	DF	997.80	41.45	0.00	1039.25	processing	paid	boleto	\N	2026-10-26 12:54:14	2026-10-26 12:54:14	2026-10-26 12:54:14	\N	\N	\N
4	ORD-20260825-1HZSLV	Srta. Carol Burgos Velasques Filho	rodrigues.andressa@example.com	36745599864	(10) 96731-4178	80420000	Rua Comendador Araújo	3102	\N	Centro	Curitiba	PR	2167.92	69.76	0.00	2237.68	pending	pending	pix	\N	2026-08-25 07:39:14	2026-08-25 07:39:14	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+551999385679452040000530398654072237.685802BR5909AUTOSTOCK6009SAO PAULO62210517ORD202608251HZSLV63040477	2026-11-14 13:20:02	\N
2	ORD-20261031-KOINFI	Dr. Léia Santana	tatiane.espinoza@example.net	29120635400	(08) 95240-0425	40015010	Avenida da França	2055	\N	Comércio	Salvador	BA	1446.98	41.54	0.00	1488.52	processing	paid	boleto	\N	2026-10-31 18:25:14	2026-10-31 18:25:14	2026-10-31 18:25:14	\N	\N	\N
11	ORD-20260902-D3QAXX	Leandro Estêvão de Souza Sobrinho	cristiana13@example.com	75130427483	(02) 90543-9830	88010400	Rua Felipe Schmidt	1894	\N	Centro	Florianópolis	SC	1495.47	121.90	0.00	1617.37	pending	pending	pix	\N	2026-09-02 08:19:14	2026-09-02 08:19:14	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+551999385679452040000530398654071617.375802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260902D3QAXX6304C0D5	2026-11-14 13:20:02	\N
3	ORD-20260908-ZTNLEQ	Priscila Luísa Vieira Sobrinho	wesley.aguiar@example.com	13682138200	(45) 98206-7338	74003010	Avenida Anhanguera	119	\N	Setor Central	Goiânia	GO	1019.47	96.27	0.00	1115.74	processing	paid	credit_card	\N	2026-09-08 05:40:14	2026-09-08 05:40:14	2026-09-08 05:40:14	\N	\N	\N
5	ORD-20261025-M0PL2B	Denis Pedro Maldonado	regiane.fernandes@example.com	20122858999	(77) 94329-1510	40015010	Avenida da França	1006	\N	Comércio	Salvador	BA	1032.58	72.43	0.00	1105.01	paid	paid	credit_card	\N	2026-10-25 00:37:14	2026-10-25 00:37:14	2026-10-25 00:37:14	\N	\N	\N
6	ORD-20261003-VOKOQ2	Rafaela Alma Batista	enzo08@example.com	53969341159	(82) 93215-4270	01310100	Avenida Paulista	2723	\N	Bela Vista	São Paulo	SP	1199.62	41.79	0.00	1241.41	processing	paid	credit_card	\N	2026-10-03 14:33:14	2026-10-03 14:33:14	2026-10-03 14:33:14	\N	\N	\N
7	ORD-20261023-3WLDXF	Sra. Raysa Batista Lozano	rios.jose@example.net	30216471621	(91) 94059-4754	13010111	Rua Barão de Jaguara	3153	\N	Centro	Campinas	SP	103.00	30.74	0.00	133.74	shipped	paid	boleto	\N	2026-10-23 18:14:14	2026-10-23 18:14:14	2026-10-23 18:14:14	\N	\N	\N
8	ORD-20260731-FFDUZ6	Srta. Danielle Perez Franco	roberta47@example.net	51400707900	(44) 97852-5939	70040900	SQS 308	2729	\N	Asa Sul	Brasília	DF	1517.22	103.37	0.00	1620.59	delivered	paid	pix	\N	2026-07-31 01:06:14	2026-07-31 01:06:14	2026-07-31 01:06:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071620.595802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260731FFDUZ6630493C4	2026-07-31 01:36:14	\N
9	ORD-20261002-LA3PML	Carlos Salgado Oliveira Sobrinho	renata.davila@example.net	07621859709	(48) 97461-1689	50030230	Rua da Aurora	20	\N	Boa Vista	Recife	PE	2583.40	105.04	0.00	2688.44	shipped	paid	pix	\N	2026-10-02 03:07:14	2026-10-02 03:07:14	2026-10-02 03:07:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654072688.445802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261002LA3PML6304E368	2026-10-02 03:37:14	\N
10	ORD-20261114-JVEPJA	Fabrício Bonilha de Arruda Jr.	danilo.dacruz@example.org	29163249170	(12) 94996-9060	88010400	Rua Felipe Schmidt	2756	\N	Centro	Florianópolis	SC	1159.07	59.12	0.00	1218.19	processing	paid	credit_card	\N	2026-11-14 03:41:14	2026-11-14 03:41:14	2026-11-14 03:41:14	\N	\N	\N
12	ORD-20260721-JPVFMJ	Otávio Kevin Lutero	sepulveda.tainara@example.org	68347789932	(51) 97168-8489	60060180	Rua Floriano Peixoto	2106	Apto 241	Centro	Fortaleza	CE	820.49	77.09	0.00	897.58	paid	paid	pix	\N	2026-07-21 12:43:14	2026-07-21 12:43:14	2026-07-21 12:43:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406897.585802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260721JPVFMJ630499CB	2026-07-21 13:13:14	\N
13	ORD-20261109-9ASWLO	Dr. Sofia Rocha Assunção Jr.	flores.alonso@example.org	69962795931	(04) 94146-8165	13010111	Rua Barão de Jaguara	805	\N	Centro	Campinas	SP	777.37	66.17	0.00	843.54	processing	paid	pix	\N	2026-11-09 03:42:14	2026-11-09 03:42:14	2026-11-09 03:42:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406843.545802BR5909AUTOSTOCK6009SAO PAULO62210517ORD202611099ASWLO63047722	2026-11-09 04:12:14	\N
14	ORD-20261015-V39ZAT	Alan Paes Bittencourt Neto	antonella25@example.org	54537732601	(48) 99990-0590	40015010	Avenida da França	265	Apto 149	Comércio	Salvador	BA	2057.24	169.40	0.00	2226.64	paid	paid	credit_card	\N	2026-10-15 14:57:14	2026-10-15 14:57:14	2026-10-15 14:57:14	\N	\N	\N
15	ORD-20260718-TOURZM	Luis Queirós Rico Jr.	kevin.valencia@example.com	02035485746	(96) 97619-7338	90010150	Rua dos Andradas	2735	\N	Centro Histórico	Porto Alegre	RS	1504.61	76.79	0.00	1581.40	pending	pending	credit_card	\N	2026-07-18 07:46:14	2026-07-18 07:46:14	2026-07-18 07:46:14	\N	\N	\N
16	ORD-20261012-UKG40L	Matheus Correia Delvalle Filho	giovane46@example.org	96383145673	(29) 90295-5754	90010150	Rua dos Andradas	3055	Apto 652	Centro Histórico	Porto Alegre	RS	274.94	0.00	0.00	274.94	cancelled	refunded	boleto	\N	2026-10-12 02:46:14	2026-10-12 02:46:14	2026-10-12 02:46:14	\N	\N	\N
17	ORD-20260717-W7PL0O	Rafaela Ayla Ramires	garcia.ariana@example.com	63744163687	(40) 90542-3092	01310100	Avenida Paulista	294	\N	Bela Vista	São Paulo	SP	2352.65	53.54	0.00	2406.19	delivered	paid	pix	\N	2026-07-17 16:03:14	2026-07-17 16:03:14	2026-07-17 16:03:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654072406.195802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260717W7PL0O63042BB3	2026-07-17 16:33:14	\N
18	ORD-20260809-KNKJJQ	Srta. Késia Lúcia Faro	aline63@example.com	31322352453	(97) 96223-3669	20040020	Avenida Rio Branco	569	Apto 73	Centro	Rio de Janeiro	RJ	996.46	0.00	0.00	996.46	pending	pending	credit_card	\N	2026-08-09 23:55:14	2026-08-09 23:55:14	2026-08-09 23:55:14	\N	\N	\N
19	ORD-20260828-LLBFIF	Adriele Vila Salgado Sobrinho	alicia36@example.net	04245014148	(13) 91313-0582	40015010	Avenida da França	2332	\N	Comércio	Salvador	BA	1075.00	28.99	0.00	1103.99	paid	paid	credit_card	\N	2026-08-28 20:35:14	2026-08-28 20:35:14	2026-08-28 20:35:14	\N	\N	\N
20	ORD-20260721-T9FUEX	Martinho Benites Neto	elutero@example.com	94971487395	(22) 94647-7758	80420000	Rua Comendador Araújo	1636	\N	Centro	Curitiba	PR	1758.62	94.95	0.00	1853.57	processing	paid	pix	\N	2026-07-21 18:46:14	2026-07-21 18:46:14	2026-07-21 18:46:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071853.575802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260721T9FUEX630430C4	2026-07-21 19:16:14	\N
21	ORD-20260907-U35W9F	Sergio Paes Rocha Filho	mila27@example.com	26992241621	(36) 99057-8728	80420000	Rua Comendador Araújo	2197	\N	Centro	Curitiba	PR	1315.84	94.01	0.00	1409.85	paid	paid	credit_card	\N	2026-09-07 13:45:14	2026-09-07 13:45:14	2026-09-07 13:45:14	\N	\N	\N
22	ORD-20260918-NEEAOY	Richard Valência Mendes	emanuel79@example.com	66097783108	(15) 92585-5936	30130010	Avenida Afonso Pena	1593	Apto 957	Centro	Belo Horizonte	MG	5199.90	90.23	0.00	5290.13	delivered	paid	credit_card	\N	2026-09-18 21:54:14	2026-09-18 21:54:14	2026-09-18 21:54:14	\N	\N	\N
23	ORD-20260916-NX4H5B	Sra. Mariah Barreto	cristiana72@example.com	98068003975	(95) 91232-5455	20040020	Avenida Rio Branco	843	\N	Centro	Rio de Janeiro	RJ	145.88	20.28	0.00	166.16	processing	paid	credit_card	\N	2026-09-16 10:28:14	2026-09-16 10:28:14	2026-09-16 10:28:14	\N	\N	\N
24	ORD-20261111-5GKYXJ	Thomas Brito Rivera Sobrinho	amaral.sandro@example.net	58268616814	(52) 96195-4260	20040020	Avenida Rio Branco	2623	Apto 959	Centro	Rio de Janeiro	RJ	1276.68	49.65	0.00	1326.33	shipped	paid	credit_card	\N	2026-11-11 05:43:14	2026-11-11 05:43:14	2026-11-11 05:43:14	\N	\N	\N
36	ORD-20260916-D5MHQB	Josué Roque	llutero@example.com	90667726543	(96) 92906-1005	20040020	Avenida Rio Branco	2895	Apto 33	Centro	Rio de Janeiro	RJ	1402.92	70.88	0.00	1473.80	pending	pending	pix	\N	2026-09-16 11:09:14	2026-09-16 11:09:14	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+551999385679452040000530398654071473.805802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260916D5MHQB63047879	2026-11-14 13:20:02	\N
25	ORD-20261114-RZW5EV	Evandro Nelson Marin	ilira@example.com	64038843521	(81) 97968-2558	74003010	Avenida Anhanguera	385	Apto 63	Setor Central	Goiânia	GO	415.50	37.85	0.00	453.35	shipped	paid	boleto	\N	2026-11-14 02:21:14	2026-11-14 02:21:14	2026-11-14 02:21:14	\N	\N	\N
45	ORD-20260831-FRUTUA	Dr. Sérgio Valente Rodrigues	nvega@example.net	76393849070	(95) 91963-8239	40015010	Avenida da França	2346	\N	Comércio	Salvador	BA	684.55	82.33	0.00	766.88	pending	pending	pix	\N	2026-08-31 00:03:14	2026-08-31 00:03:14	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+55199938567945204000053039865406766.885802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260831FRUTUA63046DC2	2026-11-14 13:20:02	\N
26	ORD-20260731-UHQGHH	Bruno Barreto Sepúlveda	enzo.galhardo@example.com	67634841196	(34) 99259-5129	01310100	Avenida Paulista	1086	\N	Bela Vista	São Paulo	SP	1613.79	44.30	0.00	1658.09	processing	paid	pix	\N	2026-07-31 09:29:14	2026-07-31 09:29:14	2026-07-31 09:29:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071658.095802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260731UHQGHH6304FA99	2026-07-31 09:59:14	\N
27	ORD-20260729-JND8AL	Renan Hugo Verdara Jr.	achaves@example.org	45751575970	(98) 99101-0203	60060180	Rua Floriano Peixoto	146	\N	Centro	Fortaleza	CE	2076.99	82.39	0.00	2159.38	pending	pending	boleto	\N	2026-07-29 16:26:14	2026-07-29 16:26:14	2026-07-29 16:26:14	\N	\N	\N
28	ORD-20261110-7SHW5M	Lorenzo Giovane Cordeiro	yesteves@example.net	29585000636	(61) 93206-4649	88010400	Rua Felipe Schmidt	773	\N	Centro	Florianópolis	SC	814.90	32.34	0.00	847.24	processing	paid	credit_card	\N	2026-11-10 05:38:14	2026-11-10 05:38:14	2026-11-10 05:38:14	\N	\N	\N
29	ORD-20260924-FC9USH	Joaquin Soto	prado.luiza@example.org	18788267865	(97) 91918-3896	01310100	Avenida Paulista	1098	\N	Bela Vista	São Paulo	SP	2144.40	29.84	0.00	2174.24	pending	pending	credit_card	\N	2026-09-24 17:56:14	2026-09-24 17:56:14	2026-09-24 17:56:14	\N	\N	\N
30	ORD-20261110-AEJFT0	Dr. Leonardo Yuri Maldonado	leon.dante@example.net	28544435602	(63) 91110-2461	13010111	Rua Barão de Jaguara	1181	\N	Centro	Campinas	SP	1669.05	121.77	0.00	1790.82	paid	paid	boleto	\N	2026-11-10 21:30:14	2026-11-10 21:30:14	2026-11-10 21:30:14	\N	\N	\N
31	ORD-20260717-WUFCAL	Dr. Murilo Noel de Freitas Jr.	cervantes.daniel@example.com	15787239733	(73) 99785-8901	40015010	Avenida da França	2351	Apto 978	Comércio	Salvador	BA	642.94	94.68	0.00	737.62	paid	paid	credit_card	\N	2026-07-17 02:03:14	2026-07-17 02:03:14	2026-07-17 02:03:14	\N	\N	\N
32	ORD-20261013-UL1KHC	Viviane Valência Lutero Neto	hcarvalho@example.net	71163504700	(23) 99074-1573	74003010	Avenida Anhanguera	542	Apto 702	Setor Central	Goiânia	GO	2175.81	80.84	0.00	2256.65	delivered	paid	pix	\N	2026-10-13 18:38:14	2026-10-13 18:38:14	2026-10-13 18:38:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654072256.655802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261013UL1KHC6304DBF9	2026-10-13 19:08:14	\N
33	ORD-20260916-800X9H	Elaine Ferreira Cruz	roberto.meireles@example.net	30040728668	(90) 95140-6563	90010150	Rua dos Andradas	1910	\N	Centro Histórico	Porto Alegre	RS	535.70	46.74	0.00	582.44	paid	paid	pix	\N	2026-09-16 21:02:14	2026-09-16 21:02:14	2026-09-16 21:02:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406582.445802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260916800X9H6304FE0F	2026-09-16 21:32:14	\N
34	ORD-20260716-CEZFQ2	Filipe Carvalho Sobrinho	serrano.emilly@example.com	85617913816	(63) 93862-2491	90010150	Rua dos Andradas	806	\N	Centro Histórico	Porto Alegre	RS	225.57	52.31	0.00	277.88	delivered	paid	pix	\N	2026-07-16 21:56:14	2026-07-16 21:56:14	2026-07-16 21:56:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406277.885802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260716CEZFQ26304094B	2026-07-16 22:26:14	\N
35	ORD-20260718-VWXHSE	Lucio George Burgos Sobrinho	flor.darosa@example.org	72536599612	(66) 99589-7173	90010150	Rua dos Andradas	3018	Apto 480	Centro Histórico	Porto Alegre	RS	143.48	73.87	0.00	217.35	processing	paid	boleto	\N	2026-07-18 19:31:14	2026-07-18 19:31:14	2026-07-18 19:31:14	\N	\N	\N
37	ORD-20261102-PBZW7V	Valéria Mendonça Gusmão	mari54@example.com	51847833772	(37) 92596-7775	01310100	Avenida Paulista	2291	Apto 654	Bela Vista	São Paulo	SP	1503.40	125.02	0.00	1628.42	shipped	paid	credit_card	\N	2026-11-02 19:01:14	2026-11-02 19:01:14	2026-11-02 19:01:14	\N	\N	\N
38	ORD-20260723-SCDP0W	Dr. Allison Sophie Deverso	acervantes@example.org	15819969260	(30) 95518-9567	74003010	Avenida Anhanguera	483	\N	Setor Central	Goiânia	GO	1709.81	77.75	0.00	1787.56	processing	paid	credit_card	\N	2026-07-23 11:24:14	2026-07-23 11:24:14	2026-07-23 11:24:14	\N	\N	\N
39	ORD-20261113-4BLTF7	Hosana Zambrano Sobrinho	gian52@example.net	87001255718	(78) 96648-7344	80420000	Rua Comendador Araújo	1796	Apto 92	Centro	Curitiba	PR	741.22	67.60	0.00	808.82	paid	paid	pix	\N	2026-11-13 11:21:14	2026-11-13 11:21:14	2026-11-13 11:21:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406808.825802BR5909AUTOSTOCK6009SAO PAULO62210517ORD202611134BLTF76304E33E	2026-11-13 11:51:14	\N
40	ORD-20260915-VL5MAZ	David Lourenço	emily.assuncao@example.net	39548392534	(41) 98707-2932	01310100	Avenida Paulista	2388	\N	Bela Vista	São Paulo	SP	973.54	51.88	0.00	1025.42	pending	pending	credit_card	\N	2026-09-15 21:22:14	2026-09-15 21:22:14	2026-09-15 21:22:14	\N	\N	\N
41	ORD-20260726-KIHCTS	Juliane Ingrid Torres	stephanie17@example.com	31261062930	(23) 90464-9790	13010111	Rua Barão de Jaguara	1447	Apto 765	Centro	Campinas	SP	1831.21	66.44	0.00	1897.65	processing	paid	credit_card	\N	2026-07-26 21:48:14	2026-07-26 21:48:14	2026-07-26 21:48:14	\N	\N	\N
42	ORD-20260801-FQ3OHU	Marcelo Montenegro Vale Filho	ndomingues@example.org	21678978205	(86) 92022-2539	88010400	Rua Felipe Schmidt	2832	\N	Centro	Florianópolis	SC	174.60	0.00	0.00	174.60	shipped	paid	pix	\N	2026-08-01 05:31:14	2026-08-01 05:31:14	2026-08-01 05:31:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406174.605802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260801FQ3OHU630496C5	2026-08-01 06:01:14	\N
43	ORD-20260721-TEHRKA	Dr. Cristóvão Paulo Sandoval	toledo.emily@example.net	54084276847	(70) 95883-6103	80420000	Rua Comendador Araújo	1957	\N	Centro	Curitiba	PR	638.10	18.25	0.00	656.35	processing	paid	pix	\N	2026-07-21 02:31:14	2026-07-21 02:31:14	2026-07-21 02:31:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406656.355802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260721TEHRKA6304FF3F	2026-07-21 03:01:14	\N
44	ORD-20260805-GEDF4E	Sr. Otávio Godói Estrada Filho	fabricio.saraiva@example.org	58403084714	(15) 98332-7648	01310100	Avenida Paulista	1632	Apto 973	Bela Vista	São Paulo	SP	977.67	84.49	0.00	1062.16	cancelled	refunded	credit_card	\N	2026-08-05 16:47:14	2026-08-05 16:47:14	2026-08-05 16:47:14	\N	\N	\N
46	ORD-20261108-NMWBH5	Sra. Sandra Fonseca	urias.eduardo@example.org	12368380175	(01) 91535-7446	88010400	Rua Felipe Schmidt	92	\N	Centro	Florianópolis	SC	920.64	33.39	0.00	954.03	paid	paid	boleto	\N	2026-11-08 14:52:14	2026-11-08 14:52:14	2026-11-08 14:52:14	\N	\N	\N
47	ORD-20261016-TWHTHL	Aparecida Torres	santacruz.gean@example.org	00517899060	(70) 94120-5881	30130010	Avenida Afonso Pena	2276	\N	Centro	Belo Horizonte	MG	381.82	47.62	0.00	429.44	pending	pending	boleto	\N	2026-10-16 00:44:14	2026-10-16 00:44:14	2026-10-16 00:44:14	\N	\N	\N
48	ORD-20261027-I75TXM	Willian Lira Ramos	tabreu@example.org	86759633784	(33) 98238-3801	13010111	Rua Barão de Jaguara	150	Apto 225	Centro	Campinas	SP	118.42	52.64	0.00	171.06	cancelled	refunded	boleto	\N	2026-10-27 09:03:14	2026-10-27 09:03:14	2026-10-27 09:03:14	\N	\N	\N
49	ORD-20261111-M7BX6O	Sr. Sérgio Toledo Torres	hferreira@example.com	48867169386	(18) 97757-7773	90010150	Rua dos Andradas	1360	\N	Centro Histórico	Porto Alegre	RS	1780.16	74.05	0.00	1854.21	processing	paid	credit_card	\N	2026-11-11 19:44:14	2026-11-11 19:44:14	2026-11-11 19:44:14	\N	\N	\N
50	ORD-20260908-U99HZT	Luan Vega Ramires Neto	marin.jeronimo@example.org	36530817778	(67) 92117-6058	13010111	Rua Barão de Jaguara	1518	\N	Centro	Campinas	SP	944.76	29.99	0.00	974.75	shipped	paid	boleto	\N	2026-09-08 08:30:14	2026-09-08 08:30:14	2026-09-08 08:30:14	\N	\N	\N
51	ORD-20260826-EQSIIZ	Srta. Danielle Zambrano Neto	hbenites@example.net	32411357133	(18) 96070-8096	80420000	Rua Comendador Araújo	1911	Apto 693	Centro	Curitiba	PR	2349.02	159.36	0.00	2508.38	delivered	paid	credit_card	\N	2026-08-26 22:07:14	2026-08-26 22:07:14	2026-08-26 22:07:14	\N	\N	\N
52	ORD-20260827-9F5ATG	Lara Laiane Paes	henrique39@example.com	88932934630	(79) 93530-9750	50030230	Rua da Aurora	3148	Apto 215	Boa Vista	Recife	PE	1767.86	117.80	0.00	1885.66	pending	pending	credit_card	\N	2026-08-27 17:24:14	2026-08-27 17:24:14	2026-08-27 17:24:14	\N	\N	\N
53	ORD-20261030-NYR3DH	Guilherme Dante Aranda	gbranco@example.com	80308986490	(03) 93937-8977	90010150	Rua dos Andradas	3036	Apto 232	Centro Histórico	Porto Alegre	RS	1448.96	67.63	0.00	1516.59	pending	pending	credit_card	\N	2026-10-30 00:13:14	2026-10-30 00:13:14	2026-10-30 00:13:14	\N	\N	\N
54	ORD-20260914-HGA2BI	Srta. Cristina Rayane Padilha	jaqueline44@example.com	67799174196	(42) 99603-2341	88010400	Rua Felipe Schmidt	35	Apto 368	Centro	Florianópolis	SC	678.14	79.38	0.00	757.52	paid	paid	credit_card	\N	2026-09-14 05:03:14	2026-09-14 05:03:14	2026-09-14 05:03:14	\N	\N	\N
55	ORD-20261025-GACYEP	Juan Perez Reis Jr.	henrique76@example.net	06239570001	(63) 94781-5420	80420000	Rua Comendador Araújo	1461	\N	Centro	Curitiba	PR	420.26	59.88	0.00	480.14	shipped	paid	pix	\N	2026-10-25 02:56:14	2026-10-25 02:56:14	2026-10-25 02:56:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406480.145802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261025GACYEP63044CC8	2026-10-25 03:26:14	\N
56	ORD-20261106-JDLH2Y	Dr. Franciele Maísa Santiago Neto	manuela.branco@example.org	98740991865	(14) 99553-5956	74003010	Avenida Anhanguera	1543	\N	Setor Central	Goiânia	GO	891.09	40.10	0.00	931.19	delivered	paid	pix	\N	2026-11-06 02:40:14	2026-11-06 02:40:14	2026-11-06 02:40:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406931.195802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261106JDLH2Y630485BB	2026-11-06 03:10:14	\N
57	ORD-20261018-RPNW3C	Dr. Mirela Manoela Amaral	dferminiano@example.com	16802676397	(65) 90920-3217	60060180	Rua Floriano Peixoto	2541	\N	Centro	Fortaleza	CE	313.12	35.39	0.00	348.51	delivered	paid	credit_card	\N	2026-10-18 20:24:14	2026-10-18 20:24:14	2026-10-18 20:24:14	\N	\N	\N
58	ORD-20260806-2ZPG39	Stephany Lourenço Jr.	queiros.valeria@example.com	58238910838	(95) 96211-3183	40015010	Avenida da França	1872	\N	Comércio	Salvador	BA	943.97	153.09	0.00	1097.06	shipped	paid	credit_card	\N	2026-08-06 18:06:14	2026-08-06 18:06:14	2026-08-06 18:06:14	\N	\N	\N
59	ORD-20260805-ANDODG	Tatiane Suelen Paes Sobrinho	ysales@example.org	02923826183	(49) 93515-3988	74003010	Avenida Anhanguera	2863	\N	Setor Central	Goiânia	GO	651.44	60.26	0.00	711.70	processing	paid	credit_card	\N	2026-08-05 15:37:14	2026-08-05 15:37:14	2026-08-05 15:37:14	\N	\N	\N
60	ORD-20260907-FI7XD2	Robson Balestero Neto	rebeca.avila@example.com	50883557509	(14) 97092-0161	60060180	Rua Floriano Peixoto	1631	\N	Centro	Fortaleza	CE	1543.19	91.49	0.00	1634.68	processing	paid	pix	\N	2026-09-07 14:29:14	2026-09-07 14:29:14	2026-09-07 14:29:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071634.685802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260907FI7XD263040B32	2026-09-07 14:59:14	\N
61	ORD-20261102-1UEC1I	Srta. Verônica Pâmela Santiago Sobrinho	milene.benez@example.net	20351443029	(65) 91785-2638	60060180	Rua Floriano Peixoto	28	\N	Centro	Fortaleza	CE	1214.50	40.29	0.00	1254.79	paid	paid	pix	\N	2026-11-02 09:40:14	2026-11-02 09:40:14	2026-11-02 09:40:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071254.795802BR5909AUTOSTOCK6009SAO PAULO62210517ORD202611021UEC1I6304E9EB	2026-11-02 10:10:14	\N
62	ORD-20260902-31DAOI	Sr. Murilo Paulo Fontes	qbranco@example.com	64242154844	(06) 93063-9749	40015010	Avenida da França	215	Apto 805	Comércio	Salvador	BA	1366.97	101.06	0.00	1468.03	delivered	paid	credit_card	\N	2026-09-02 20:12:14	2026-09-02 20:12:14	2026-09-02 20:12:14	\N	\N	\N
63	ORD-20260731-MC3FDO	Sra. Luana Feliciano	everton.cruz@example.org	70043442900	(69) 96158-8455	01310100	Avenida Paulista	2260	\N	Bela Vista	São Paulo	SP	1375.34	225.50	0.00	1600.84	pending	pending	boleto	\N	2026-07-31 12:56:14	2026-07-31 12:56:14	2026-07-31 12:56:14	\N	\N	\N
64	ORD-20260904-SHXPCZ	Srta. Fernanda da Silva Sobrinho	ugrego@example.net	40790716984	(49) 97296-1795	50030230	Rua da Aurora	2345	\N	Boa Vista	Recife	PE	250.78	33.71	0.00	284.49	paid	paid	credit_card	\N	2026-09-04 16:24:14	2026-09-04 16:24:14	2026-09-04 16:24:14	\N	\N	\N
65	ORD-20260813-3QCSVQ	Sr. Fabrício Casanova Jr.	martinho56@example.org	97518293056	(47) 95100-8381	30130010	Avenida Afonso Pena	3020	\N	Centro	Belo Horizonte	MG	2152.02	229.35	0.00	2381.37	processing	paid	credit_card	\N	2026-08-13 23:51:14	2026-08-13 23:51:14	2026-08-13 23:51:14	\N	\N	\N
66	ORD-20260918-THXVXK	Raissa Padilha Martines	medina.isis@example.net	09081085328	(07) 97248-3531	74003010	Avenida Anhanguera	520	\N	Setor Central	Goiânia	GO	356.97	71.50	0.00	428.47	processing	paid	boleto	\N	2026-09-18 13:27:14	2026-09-18 13:27:14	2026-09-18 13:27:14	\N	\N	\N
67	ORD-20260818-UU5WBI	Sra. Bia Caldeira	arruda.thales@example.org	38224707679	(42) 96020-2972	13010111	Rua Barão de Jaguara	1604	\N	Centro	Campinas	SP	2879.82	160.96	0.00	3040.78	pending	pending	boleto	\N	2026-08-18 19:25:14	2026-08-18 19:25:14	2026-08-18 19:25:14	\N	\N	\N
68	ORD-20260823-EADZSE	Mia Carmona Neto	monica.jimenes@example.org	86269852315	(58) 97995-4619	20040020	Avenida Rio Branco	1534	\N	Centro	Rio de Janeiro	RJ	2586.64	143.43	0.00	2730.07	processing	paid	credit_card	\N	2026-08-23 05:55:14	2026-08-23 05:55:14	2026-08-23 05:55:14	\N	\N	\N
69	ORD-20260818-QTAKOF	Srta. Simone Valdez Aragão	qamaral@example.com	20709960182	(55) 94004-9291	88010400	Rua Felipe Schmidt	980	\N	Centro	Florianópolis	SC	703.23	107.79	0.00	811.02	pending	pending	credit_card	\N	2026-08-18 17:35:14	2026-08-18 17:35:14	2026-08-18 17:35:14	\N	\N	\N
70	ORD-20260716-BYN5XS	Joana Gabrielle Bonilha	cgoncalves@example.org	31763976823	(69) 91805-7010	40015010	Avenida da França	885	\N	Comércio	Salvador	BA	711.86	95.50	0.00	807.36	pending	pending	credit_card	\N	2026-07-16 19:22:14	2026-07-16 19:22:14	2026-07-16 19:22:14	\N	\N	\N
71	ORD-20260722-KJBKQF	Sr. Marcos Serra Jimenes	aragao.flavio@example.org	38637716059	(73) 99859-0841	40015010	Avenida da França	1649	Apto 77	Comércio	Salvador	BA	757.42	29.97	0.00	787.39	cancelled	refunded	boleto	\N	2026-07-22 21:36:14	2026-07-22 21:36:14	2026-07-22 21:36:14	\N	\N	\N
201	ORD-20261114-R3BYZM	João da Silva	joao.teste@example.com		11999999999	13455759	Praça da Sé	100	Apto 10	Sé	São Paulo	SP	936.52	42.51	0.00	979.03	pending	pending	pix	\N	2026-11-14 12:40:18	2026-11-14 12:40:18	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+55199938567945204000053039865406979.035802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261114R3BYZM63045BFE	2026-11-14 13:20:02	\N
72	ORD-20260920-CSYZHZ	Wilson de Freitas Rosa Sobrinho	torres.jean@example.net	31884217702	(87) 91347-4191	13010111	Rua Barão de Jaguara	853	\N	Centro	Campinas	SP	754.80	36.25	0.00	791.05	paid	paid	credit_card	\N	2026-09-20 00:28:14	2026-09-20 00:28:14	2026-09-20 00:28:14	\N	\N	\N
73	ORD-20260913-VIJ61T	Srta. Mel Paes Filho	rdearruda@example.org	35815977306	(25) 99341-8652	80420000	Rua Comendador Araújo	429	\N	Centro	Curitiba	PR	586.74	100.42	0.00	687.16	processing	paid	pix	\N	2026-09-13 02:30:14	2026-09-13 02:30:14	2026-09-13 02:30:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406687.165802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260913VIJ61T63045506	2026-09-13 03:00:14	\N
74	ORD-20260930-SHABMH	Dr. Abgail Emilly Delgado Neto	heloisa.assuncao@example.org	62498644660	(50) 91170-9414	60060180	Rua Floriano Peixoto	1622	\N	Centro	Fortaleza	CE	1303.93	97.09	0.00	1401.02	processing	paid	pix	\N	2026-09-30 18:30:14	2026-09-30 18:30:14	2026-09-30 18:30:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071401.025802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260930SHABMH63047FB1	2026-09-30 19:00:14	\N
75	ORD-20260911-P9OHXJ	Luiza Raysa Corona Sobrinho	jfonseca@example.org	99341485606	(43) 93270-7169	88010400	Rua Felipe Schmidt	2755	\N	Centro	Florianópolis	SC	1131.75	76.42	0.00	1208.17	cancelled	refunded	credit_card	\N	2026-09-11 00:07:14	2026-09-11 00:07:14	2026-09-11 00:07:14	\N	\N	\N
76	ORD-20260727-HRXFP0	Sr. Marco Cervantes Casanova	fidalgo.joaquim@example.net	66237290540	(50) 99138-1224	70040900	SQS 308	959	\N	Asa Sul	Brasília	DF	2539.87	187.35	0.00	2727.22	delivered	paid	credit_card	\N	2026-07-27 03:03:14	2026-07-27 03:03:14	2026-07-27 03:03:14	\N	\N	\N
77	ORD-20260918-IYJRL2	Emerson Serna Cervantes	paes.luciano@example.com	60630449147	(07) 93858-0457	88010400	Rua Felipe Schmidt	1414	\N	Centro	Florianópolis	SC	2220.60	84.48	0.00	2305.08	delivered	paid	boleto	\N	2026-09-18 02:53:14	2026-09-18 02:53:14	2026-09-18 02:53:14	\N	\N	\N
78	ORD-20260923-PYVMQH	Dr. Otávio Camilo Corona	dacruz.liz@example.com	98036508583	(62) 95789-0810	30130010	Avenida Afonso Pena	1015	\N	Centro	Belo Horizonte	MG	1367.59	33.19	0.00	1400.78	paid	paid	pix	\N	2026-09-23 13:17:14	2026-09-23 13:17:14	2026-09-23 13:17:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071400.785802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260923PYVMQH63047672	2026-09-23 13:47:14	\N
79	ORD-20260716-ENCSQG	Josefina Caldeira Filho	psantos@example.org	40164994963	(51) 99070-4629	50030230	Rua da Aurora	496	\N	Boa Vista	Recife	PE	687.08	30.66	0.00	717.74	processing	paid	pix	\N	2026-07-16 14:22:14	2026-07-16 14:22:14	2026-07-16 14:22:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406717.745802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260716ENCSQG63046B32	2026-07-16 14:52:14	\N
80	ORD-20261026-Y8CTVF	Dr. Isadora Amélia Estrada Jr.	nicolas.valente@example.com	02580706763	(46) 93840-7433	40015010	Avenida da França	2875	Apto 63	Comércio	Salvador	BA	1365.40	88.99	0.00	1454.39	paid	paid	pix	\N	2026-10-26 14:33:14	2026-10-26 14:33:14	2026-10-26 14:33:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071454.395802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261026Y8CTVF63043A7B	2026-10-26 15:03:14	\N
81	ORD-20261101-BVQSNW	Sr. Erik Horácio Deverso Filho	tiago29@example.com	21474170250	(11) 96381-5017	74003010	Avenida Anhanguera	2828	\N	Setor Central	Goiânia	GO	701.68	41.39	0.00	743.07	delivered	paid	pix	\N	2026-11-01 00:55:14	2026-11-01 00:55:14	2026-11-01 00:55:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406743.075802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261101BVQSNW6304D17B	2026-11-01 01:25:14	\N
82	ORD-20260915-YL2EFI	Dirce Malena Santos Jr.	jean27@example.org	04434539930	(39) 93616-0034	20040020	Avenida Rio Branco	3097	\N	Centro	Rio de Janeiro	RJ	1899.62	90.54	0.00	1990.16	shipped	paid	credit_card	\N	2026-09-15 02:06:14	2026-09-15 02:06:14	2026-09-15 02:06:14	\N	\N	\N
83	ORD-20260814-E3B2CC	Rodrigo Teobaldo Escobar	muchoa@example.com	17969734243	(09) 94450-5563	20040020	Avenida Rio Branco	2987	\N	Centro	Rio de Janeiro	RJ	671.85	55.09	0.00	726.94	shipped	paid	credit_card	\N	2026-08-14 08:50:14	2026-08-14 08:50:14	2026-08-14 08:50:14	\N	\N	\N
84	ORD-20261103-AAYODZ	Srta. Betina de Freitas da Rosa Sobrinho	tamoio.carol@example.org	81671976703	(33) 90521-9327	50030230	Rua da Aurora	135	\N	Boa Vista	Recife	PE	1601.92	157.19	0.00	1759.11	pending	pending	boleto	\N	2026-11-03 03:44:14	2026-11-03 03:44:14	2026-11-03 03:44:14	\N	\N	\N
85	ORD-20261013-KMB8VB	Dr. Nicole Madalena Bonilha	raissa.rocha@example.com	57824345386	(62) 95147-9251	80420000	Rua Comendador Araújo	441	Apto 844	Centro	Curitiba	PR	524.05	68.81	0.00	592.86	paid	paid	boleto	\N	2026-10-13 11:02:14	2026-10-13 11:02:14	2026-10-13 11:02:14	\N	\N	\N
86	ORD-20260928-RTNL14	Sra. Violeta Mascarenhas Marin Neto	balcantara@example.org	52959549511	(89) 93123-6668	74003010	Avenida Anhanguera	3133	\N	Setor Central	Goiânia	GO	1881.73	91.78	0.00	1973.51	paid	paid	credit_card	\N	2026-09-28 07:18:14	2026-09-28 07:18:14	2026-09-28 07:18:14	\N	\N	\N
87	ORD-20261017-ZG7VTB	Luzia Valentin	ferreira.tais@example.net	08545993986	(40) 92250-5920	50030230	Rua da Aurora	1316	Apto 309	Boa Vista	Recife	PE	1565.31	67.07	0.00	1632.38	processing	paid	pix	\N	2026-10-17 17:17:14	2026-10-17 17:17:14	2026-10-17 17:17:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071632.385802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261017ZG7VTB6304578D	2026-10-17 17:47:14	\N
88	ORD-20261113-WQDSAX	Cecília Ariane Leon	julieta84@example.net	17269591717	(72) 98663-6498	80420000	Rua Comendador Araújo	2016	\N	Centro	Curitiba	PR	1973.78	99.47	0.00	2073.25	paid	paid	boleto	\N	2026-11-13 10:02:14	2026-11-13 10:02:14	2026-11-13 10:02:14	\N	\N	\N
89	ORD-20261102-5T8QUK	Marcos Santana Jr.	maria.franco@example.com	90187751420	(37) 98882-9517	30130010	Avenida Afonso Pena	1970	\N	Centro	Belo Horizonte	MG	1711.47	88.17	0.00	1799.64	shipped	paid	pix	\N	2026-11-02 09:10:14	2026-11-02 09:10:14	2026-11-02 09:10:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071799.645802BR5909AUTOSTOCK6009SAO PAULO62210517ORD202611025T8QUK63042CEF	2026-11-02 09:40:14	\N
90	ORD-20261024-DASVKA	Milene Lozano	domingues.gilberto@example.net	14972608765	(05) 99270-7266	60060180	Rua Floriano Peixoto	377	\N	Centro	Fortaleza	CE	1466.20	173.47	0.00	1639.67	processing	paid	pix	\N	2026-10-24 18:51:14	2026-10-24 18:51:14	2026-10-24 18:51:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071639.675802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261024DASVKA6304D316	2026-10-24 19:21:14	\N
91	ORD-20260806-ZJPQ8T	Gabrielly Verdugo	tamoio.christian@example.org	78318109864	(30) 96002-9587	30130010	Avenida Afonso Pena	1865	\N	Centro	Belo Horizonte	MG	1962.64	53.26	0.00	2015.90	cancelled	refunded	boleto	\N	2026-08-06 12:52:14	2026-08-06 12:52:14	2026-08-06 12:52:14	\N	\N	\N
92	ORD-20261004-DQPHZW	Cristina Benites Beltrão Sobrinho	davi.paes@example.net	64304424033	(06) 99162-8005	13010111	Rua Barão de Jaguara	3089	\N	Centro	Campinas	SP	2410.14	74.66	0.00	2484.80	processing	paid	boleto	\N	2026-10-04 10:06:14	2026-10-04 10:06:14	2026-10-04 10:06:14	\N	\N	\N
93	ORD-20261105-GMKKVG	Eloah Toledo	ileon@example.com	38400040554	(07) 92591-2025	90010150	Rua dos Andradas	346	\N	Centro Histórico	Porto Alegre	RS	3597.91	141.42	0.00	3739.33	delivered	paid	credit_card	\N	2026-11-05 22:21:14	2026-11-05 22:21:14	2026-11-05 22:21:14	\N	\N	\N
94	ORD-20260915-8BKLF2	Sérgio Marcelo Flores Jr.	breno92@example.net	29308558861	(49) 92559-8520	80420000	Rua Comendador Araújo	900	Apto 154	Centro	Curitiba	PR	929.77	57.47	0.00	987.24	delivered	paid	credit_card	\N	2026-09-15 22:19:14	2026-09-15 22:19:14	2026-09-15 22:19:14	\N	\N	\N
96	ORD-20260815-VHLBUF	Sr. Martinho Paz	antonio71@example.com	82802833901	(32) 96267-1696	50030230	Rua da Aurora	712	\N	Boa Vista	Recife	PE	305.14	26.34	0.00	331.48	pending	pending	pix	\N	2026-08-15 06:53:14	2026-08-15 06:53:14	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+55199938567945204000053039865406331.485802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260815VHLBUF63041B62	2026-11-14 13:20:02	\N
95	ORD-20260811-CJSC1Y	Luan Enzo Galhardo	andressa54@example.net	62744631787	(54) 97863-9602	30130010	Avenida Afonso Pena	1382	\N	Centro	Belo Horizonte	MG	1879.06	67.69	0.00	1946.75	cancelled	refunded	credit_card	\N	2026-08-11 12:34:14	2026-08-11 12:34:14	2026-08-11 12:34:14	\N	\N	\N
113	ORD-20260821-KITHIX	Sr. Roberto Torres Furtado	bittencourt.alan@example.org	93506092073	(89) 96930-6365	40015010	Avenida da França	305	\N	Comércio	Salvador	BA	291.47	17.56	0.00	309.03	pending	pending	pix	\N	2026-08-21 02:19:15	2026-08-21 02:19:15	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+55199938567945204000053039865406309.035802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260821KITHIX6304BFCC	2026-11-14 13:20:02	\N
203	ORD-20261114-GRYZ9E	VINICIUS DA COSTA SIRINO SIRINO	vdcsirino@gmail.com		19993856794	13455759	Rua Maria Tereza Guardiano Ribeiro	863	casa	Jardim Dona Regina	Santa Bárbara D'Oeste/SP	SP	1169.59	65.90	0.00	1235.49	pending	pending	pix	Traga bem embalado	2026-11-14 12:59:56	2026-11-14 12:59:56	2026-11-14 12:59:56	00020126360014br.gov.bcb.pix0114+551999385679452040000530398654071235.495802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261114GRYZ9E63041156	2026-11-14 13:29:56	\N
97	ORD-20260805-OHF3VP	Dr. Luna Solano Martines Sobrinho	adriele.dasilva@example.com	43763345108	(34) 96553-8988	60060180	Rua Floriano Peixoto	1317	Apto 954	Centro	Fortaleza	CE	4016.82	114.36	0.00	4131.18	paid	paid	pix	\N	2026-08-05 18:05:14	2026-08-05 18:05:14	2026-08-05 18:05:14	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654074131.185802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260805OHF3VP6304A0C7	2026-08-05 18:35:14	\N
98	ORD-20260827-UVA9EV	Eloah Queirós Matos	guerra.valeria@example.org	28031108579	(89) 93440-0150	50030230	Rua da Aurora	2434	Apto 447	Boa Vista	Recife	PE	3968.76	201.09	0.00	4169.85	paid	paid	credit_card	\N	2026-08-27 11:18:14	2026-08-27 11:18:14	2026-08-27 11:18:14	\N	\N	\N
99	ORD-20261016-G48G0O	Sr. Lucio Lovato Sobrinho	ucorona@example.org	86296458657	(94) 98096-7387	60060180	Rua Floriano Peixoto	1392	\N	Centro	Fortaleza	CE	1349.62	39.52	0.00	1389.14	delivered	paid	credit_card	\N	2026-10-16 01:14:14	2026-10-16 01:14:14	2026-10-16 01:14:14	\N	\N	\N
100	ORD-20260808-CH3LY2	Dr. Vinícius Pena Esteves Neto	marques.italo@example.org	29860924384	(87) 98111-2168	90010150	Rua dos Andradas	2107	Apto 414	Centro Histórico	Porto Alegre	RS	2376.10	65.42	0.00	2441.52	shipped	paid	boleto	\N	2026-08-08 19:28:14	2026-08-08 19:28:14	2026-08-08 19:28:14	\N	\N	\N
101	ORD-20261004-4I8PRL	Dr. Wilson Otávio Ferraz Sobrinho	anita.verdara@example.net	12978822880	(40) 99148-0079	74003010	Avenida Anhanguera	75	\N	Setor Central	Goiânia	GO	1834.28	96.40	0.00	1930.68	shipped	paid	boleto	\N	2026-10-04 22:38:14	2026-10-04 22:38:14	2026-10-04 22:38:14	\N	\N	\N
102	ORD-20260926-8J3Y9M	Srta. Yohanna Godói	haranda@example.net	79937027713	(96) 92843-3381	88010400	Rua Felipe Schmidt	2410	Apto 535	Centro	Florianópolis	SC	2113.29	23.90	0.00	2137.19	paid	paid	boleto	\N	2026-09-26 22:31:15	2026-09-26 22:31:15	2026-09-26 22:31:15	\N	\N	\N
103	ORD-20260721-K5N4TF	Moisés Tamoio	denise62@example.org	65007929123	(13) 97154-8122	70040900	SQS 308	1316	Apto 291	Asa Sul	Brasília	DF	701.47	51.35	0.00	752.82	processing	paid	credit_card	\N	2026-07-21 14:25:15	2026-07-21 14:25:15	2026-07-21 14:25:15	\N	\N	\N
104	ORD-20260921-8E5HRQ	Emília Agatha Valdez	tainara.beltrao@example.org	58704202619	(62) 99281-1452	50030230	Rua da Aurora	1846	Apto 105	Boa Vista	Recife	PE	2293.69	80.79	0.00	2374.48	paid	paid	credit_card	\N	2026-09-21 11:20:15	2026-09-21 11:20:15	2026-09-21 11:20:15	\N	\N	\N
105	ORD-20260903-LSDEIX	Ricardo Leal Camacho Jr.	natal.bezerra@example.org	34951040387	(95) 92771-1572	50030230	Rua da Aurora	1310	Apto 987	Boa Vista	Recife	PE	1799.69	179.70	0.00	1979.39	paid	paid	pix	\N	2026-09-03 01:27:15	2026-09-03 01:27:15	2026-09-03 01:27:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071979.395802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260903LSDEIX63046D7B	2026-09-03 01:57:15	\N
106	ORD-20261009-2YUVGS	Sra. Alana Giovanna Teles	romero.tiago@example.com	96553418365	(50) 98128-1065	74003010	Avenida Anhanguera	1475	\N	Setor Central	Goiânia	GO	778.86	140.55	0.00	919.41	paid	paid	pix	\N	2026-10-09 19:41:15	2026-10-09 19:41:15	2026-10-09 19:41:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406919.415802BR5909AUTOSTOCK6009SAO PAULO62210517ORD202610092YUVGS63042CDB	2026-10-09 20:11:15	\N
107	ORD-20260719-WOUXFG	Luan Máximo Mendonça Jr.	jorge.delgado@example.com	57771400841	(52) 90252-6720	90010150	Rua dos Andradas	2241	Apto 167	Centro Histórico	Porto Alegre	RS	3820.90	102.93	0.00	3923.83	paid	paid	pix	\N	2026-07-19 22:19:15	2026-07-19 22:19:15	2026-07-19 22:19:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654073923.835802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260719WOUXFG6304CF26	2026-07-19 22:49:15	\N
108	ORD-20261017-SHIQCB	Gabriel Ítalo Vieira Jr.	delgado.agatha@example.org	11838506624	(87) 98128-2691	40015010	Avenida da França	2395	\N	Comércio	Salvador	BA	1132.78	32.24	0.00	1165.02	paid	paid	credit_card	\N	2026-10-17 12:23:15	2026-10-17 12:23:15	2026-10-17 12:23:15	\N	\N	\N
109	ORD-20260808-ZIBBQM	Sr. Renato Quintana Pontes Neto	maicon.rivera@example.net	55369220093	(58) 97907-8747	50030230	Rua da Aurora	2439	\N	Boa Vista	Recife	PE	812.52	52.66	0.00	865.18	paid	paid	pix	\N	2026-08-08 01:36:15	2026-08-08 01:36:15	2026-08-08 01:36:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406865.185802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260808ZIBBQM6304A97C	2026-08-08 02:06:15	\N
110	ORD-20261103-K9CWFA	Dr. Teobaldo Aragão Dias	leal.ziraldo@example.com	68925436698	(66) 93357-8254	60060180	Rua Floriano Peixoto	2308	\N	Centro	Fortaleza	CE	410.84	111.08	0.00	521.92	paid	paid	credit_card	\N	2026-11-03 05:03:15	2026-11-03 05:03:15	2026-11-03 05:03:15	\N	\N	\N
111	ORD-20260913-JUUIZC	Thiago Romero Rodrigues	lmaldonado@example.org	70841367469	(80) 95347-0330	80420000	Rua Comendador Araújo	2634	Apto 467	Centro	Curitiba	PR	497.58	38.37	0.00	535.95	paid	paid	pix	\N	2026-09-13 09:53:15	2026-09-13 09:53:15	2026-09-13 09:53:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406535.955802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260913JUUIZC63049CEB	2026-09-13 10:23:15	\N
112	ORD-20261108-JZONSA	Bella Quintana	tamara.delgado@example.net	66349445392	(76) 98122-5899	90010150	Rua dos Andradas	1168	\N	Centro Histórico	Porto Alegre	RS	1360.93	72.13	0.00	1433.06	pending	pending	boleto	\N	2026-11-08 05:44:15	2026-11-08 05:44:15	2026-11-08 05:44:15	\N	\N	\N
114	ORD-20261017-WKZ6SV	Srta. Sophie Jimenes	delatorre.henrique@example.com	92602934720	(73) 98641-6415	60060180	Rua Floriano Peixoto	2013	\N	Centro	Fortaleza	CE	1540.86	0.00	0.00	1540.86	shipped	paid	boleto	\N	2026-10-17 21:08:15	2026-10-17 21:08:15	2026-10-17 21:08:15	\N	\N	\N
115	ORD-20260930-7VIAZL	Mauro Mauro Domingues	marina.pena@example.org	10125263058	(05) 93078-9774	90010150	Rua dos Andradas	127	Apto 593	Centro Histórico	Porto Alegre	RS	837.51	0.00	0.00	837.51	delivered	paid	credit_card	\N	2026-09-30 01:20:15	2026-09-30 01:20:15	2026-09-30 01:20:15	\N	\N	\N
116	ORD-20261003-0HSTMV	Gabrielle Sales Jr.	avila.giovanna@example.com	70314538364	(85) 97509-1026	50030230	Rua da Aurora	146	\N	Boa Vista	Recife	PE	794.57	61.53	0.00	856.10	paid	paid	credit_card	\N	2026-10-03 06:36:15	2026-10-03 06:36:15	2026-10-03 06:36:15	\N	\N	\N
117	ORD-20260917-CML8RX	Sr. Sergio Rezende Jr.	cesar.ferminiano@example.com	15320248008	(71) 97998-9825	90010150	Rua dos Andradas	2235	\N	Centro Histórico	Porto Alegre	RS	1420.63	70.92	0.00	1491.55	pending	pending	boleto	\N	2026-09-17 21:09:15	2026-09-17 21:09:15	2026-09-17 21:09:15	\N	\N	\N
135	ORD-20261109-N64DFR	Mia Neves Sobrinho	aparecida74@example.org	81252017340	(95) 95944-7869	50030230	Rua da Aurora	267	\N	Boa Vista	Recife	PE	2405.18	134.69	0.00	2539.87	pending	pending	pix	\N	2026-11-09 02:30:15	2026-11-09 02:30:15	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+551999385679452040000530398654072539.875802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261109N64DFR630458D4	2026-11-14 13:20:02	\N
118	ORD-20260814-B00OPG	Sophia Malena Fonseca Sobrinho	valencia.benedito@example.net	72717955887	(40) 95866-1201	70040900	SQS 308	1427	\N	Asa Sul	Brasília	DF	132.25	35.00	0.00	167.25	processing	paid	credit_card	\N	2026-08-14 17:34:15	2026-08-14 17:34:15	2026-08-14 17:34:15	\N	\N	\N
137	ORD-20260824-MC0UMD	Sra. Cecília Alma Serna	deverso.deivid@example.org	97155855740	(85) 95420-1309	30130010	Avenida Afonso Pena	1049	Apto 975	Centro	Belo Horizonte	MG	1008.71	62.62	0.00	1071.33	pending	pending	pix	\N	2026-08-24 22:17:15	2026-08-24 22:17:15	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+551999385679452040000530398654071071.335802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260824MC0UMD63042456	2026-11-14 13:20:02	\N
119	ORD-20261104-RLNXXX	Nelson Martinho Zaragoça Sobrinho	thales.rangel@example.net	58327522957	(00) 99611-4904	50030230	Rua da Aurora	3190	\N	Boa Vista	Recife	PE	1759.35	98.38	0.00	1857.73	paid	paid	credit_card	\N	2026-11-04 20:35:15	2026-11-04 20:35:15	2026-11-04 20:35:15	\N	\N	\N
140	ORD-20260829-EFCRXM	Inácio Martines Caldeira Sobrinho	juliane96@example.org	15626979514	(23) 97167-4984	90010150	Rua dos Andradas	792	Apto 660	Centro Histórico	Porto Alegre	RS	2640.65	48.68	0.00	2689.33	pending	pending	pix	\N	2026-08-29 08:21:15	2026-08-29 08:21:15	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+551999385679452040000530398654072689.335802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260829EFCRXM6304DE81	2026-11-14 13:20:02	\N
120	ORD-20261107-ZCNJD7	Sr. Ícaro Giovane Corona Sobrinho	fgil@example.org	56051612459	(28) 92994-5252	80420000	Rua Comendador Araújo	2896	Apto 872	Centro	Curitiba	PR	1535.71	64.30	0.00	1600.01	paid	paid	credit_card	\N	2026-11-07 00:57:15	2026-11-07 00:57:15	2026-11-07 00:57:15	\N	\N	\N
204	ORD-20261114-SGISCS	Cliente de Teste	cliente@autostock.test	12345678901	(19) 99999-0000	13455759	Rua das Peças	100	casa	Centro	Santa Bárbara D'Oeste	SP	936.52	42.51	0.00	979.03	pending	pending	pix	\N	2026-11-14 13:35:45	2026-11-14 13:35:45	2026-11-14 13:35:45	00020126360014br.gov.bcb.pix0114+55199938567945204000053039865406979.035802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261114SGISCS6304BFFA	2026-11-14 14:05:45	3
121	ORD-20260808-KIEJQ3	Dr. Robson das Neves Espinoza	evandro60@example.org	58180346587	(82) 99141-5673	80420000	Rua Comendador Araújo	736	\N	Centro	Curitiba	PR	1476.48	104.56	0.00	1581.04	processing	paid	credit_card	\N	2026-08-08 02:10:15	2026-08-08 02:10:15	2026-08-08 02:10:15	\N	\N	\N
122	ORD-20261023-CEI4DB	Joaquin Gil das Dores	bittencourt.isabelly@example.net	00054470978	(49) 92989-8553	80420000	Rua Comendador Araújo	517	Apto 845	Centro	Curitiba	PR	123.16	46.61	0.00	169.77	pending	pending	credit_card	\N	2026-10-23 09:04:15	2026-10-23 09:04:15	2026-10-23 09:04:15	\N	\N	\N
123	ORD-20261021-IFAEOX	Dr. Vicente Reinaldo Cruz Sobrinho	elias30@example.com	53652866347	(87) 91564-5907	88010400	Rua Felipe Schmidt	2791	\N	Centro	Florianópolis	SC	577.32	61.30	0.00	638.62	cancelled	refunded	pix	\N	2026-10-21 16:12:15	2026-10-21 16:12:15	2026-10-21 16:12:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406638.625802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261021IFAEOX6304C024	2026-10-21 16:42:15	\N
124	ORD-20260726-W9PDHW	Dr. Paulo Abreu	antonieta.franco@example.org	82864989689	(41) 95332-0361	74003010	Avenida Anhanguera	1796	\N	Setor Central	Goiânia	GO	470.11	44.22	0.00	514.33	delivered	paid	boleto	\N	2026-07-26 05:17:15	2026-07-26 05:17:15	2026-07-26 05:17:15	\N	\N	\N
125	ORD-20260925-SCSFRI	Sra. Simone Késia Galindo	gabrielle42@example.org	07110462714	(62) 97106-6177	20040020	Avenida Rio Branco	1148	\N	Centro	Rio de Janeiro	RJ	521.89	28.34	0.00	550.23	processing	paid	pix	\N	2026-09-25 06:49:15	2026-09-25 06:49:15	2026-09-25 06:49:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406550.235802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260925SCSFRI63040390	2026-09-25 07:19:15	\N
126	ORD-20261002-1OUP3W	Srta. Gabrielly Dirce Vila	tpaz@example.net	23776279788	(42) 93896-0450	13010111	Rua Barão de Jaguara	2754	Apto 349	Centro	Campinas	SP	2356.60	33.70	0.00	2390.30	paid	paid	credit_card	\N	2026-10-02 16:37:15	2026-10-02 16:37:15	2026-10-02 16:37:15	\N	\N	\N
127	ORD-20260816-IUGHJD	Srta. Dayane Rico Sobrinho	sergio.assuncao@example.com	33716404691	(97) 94025-9180	60060180	Rua Floriano Peixoto	905	Apto 391	Centro	Fortaleza	CE	3112.02	116.86	0.00	3228.88	shipped	paid	boleto	\N	2026-08-16 14:42:15	2026-08-16 14:42:15	2026-08-16 14:42:15	\N	\N	\N
128	ORD-20260927-BZY4W0	Sra. Emília Pacheco	bromero@example.org	88278037507	(59) 92058-6474	20040020	Avenida Rio Branco	2298	\N	Centro	Rio de Janeiro	RJ	786.56	80.94	0.00	867.50	delivered	paid	credit_card	\N	2026-09-27 18:58:15	2026-09-27 18:58:15	2026-09-27 18:58:15	\N	\N	\N
129	ORD-20261103-GQRRNC	Victor Augusto Maia Filho	kesia.quintana@example.org	54697790766	(59) 99265-1144	90010150	Rua dos Andradas	3107	Apto 808	Centro Histórico	Porto Alegre	RS	774.26	20.59	0.00	794.85	pending	pending	boleto	\N	2026-11-03 19:08:15	2026-11-03 19:08:15	2026-11-03 19:08:15	\N	\N	\N
130	ORD-20260820-K9CFP3	José Madeira Matos	karruda@example.net	60975575740	(70) 94775-3387	40015010	Avenida da França	462	Apto 549	Comércio	Salvador	BA	1645.23	75.61	0.00	1720.84	paid	paid	pix	\N	2026-08-20 01:54:15	2026-08-20 01:54:15	2026-08-20 01:54:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071720.845802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260820K9CFP363040000	2026-08-20 02:24:15	\N
131	ORD-20260804-DZ9EUK	Sr. Dante Neves Molina	luan38@example.org	43775515828	(06) 98631-2145	01310100	Avenida Paulista	1441	\N	Bela Vista	São Paulo	SP	531.54	62.40	0.00	593.94	processing	paid	credit_card	\N	2026-08-04 18:29:15	2026-08-04 18:29:15	2026-08-04 18:29:15	\N	\N	\N
132	ORD-20260926-Z5NJ7R	Márcia Fabiana Deverso	caldeira.rodrigo@example.net	34409759167	(10) 91151-9446	30130010	Avenida Afonso Pena	443	Apto 977	Centro	Belo Horizonte	MG	1769.68	67.07	0.00	1836.75	processing	paid	credit_card	\N	2026-09-26 13:24:15	2026-09-26 13:24:15	2026-09-26 13:24:15	\N	\N	\N
133	ORD-20260902-LEQTHB	Adriel João Aranda Filho	isales@example.net	31063520002	(31) 94519-1791	50030230	Rua da Aurora	376	\N	Boa Vista	Recife	PE	1644.80	43.63	0.00	1688.43	delivered	paid	credit_card	\N	2026-09-02 08:16:15	2026-09-02 08:16:15	2026-09-02 08:16:15	\N	\N	\N
134	ORD-20260719-HCPFUA	Aaron Walter Urias Neto	aline.rosa@example.com	00263434877	(89) 93096-4589	90010150	Rua dos Andradas	290	\N	Centro Histórico	Porto Alegre	RS	2209.75	104.85	0.00	2314.60	delivered	paid	credit_card	\N	2026-07-19 05:30:15	2026-07-19 05:30:15	2026-07-19 05:30:15	\N	\N	\N
136	ORD-20260924-HWKOD6	Sra. Mia Estrada Filho	marin.danilo@example.com	68518543410	(33) 91061-5996	70040900	SQS 308	1846	Apto 925	Asa Sul	Brasília	DF	280.87	23.31	0.00	304.18	shipped	paid	boleto	\N	2026-09-24 18:02:15	2026-09-24 18:02:15	2026-09-24 18:02:15	\N	\N	\N
138	ORD-20260808-NI9SS7	Victor Vitor Bittencourt	gescobar@example.com	35952900976	(22) 98506-0413	70040900	SQS 308	2680	\N	Asa Sul	Brasília	DF	930.16	73.45	0.00	1003.61	processing	paid	credit_card	\N	2026-08-08 12:05:15	2026-08-08 12:05:15	2026-08-08 12:05:15	\N	\N	\N
139	ORD-20261015-W2LG42	Sra. Irene Ferreira	darosa.augusto@example.com	66466135080	(34) 96450-7124	74003010	Avenida Anhanguera	836	\N	Setor Central	Goiânia	GO	2632.89	84.09	0.00	2716.98	paid	paid	credit_card	\N	2026-10-15 13:59:15	2026-10-15 13:59:15	2026-10-15 13:59:15	\N	\N	\N
141	ORD-20260920-5S8CVB	Sr. Francisco Alonso Caldeira Jr.	mbonilha@example.com	20064709060	(26) 90587-9923	70040900	SQS 308	249	\N	Asa Sul	Brasília	DF	775.57	61.89	0.00	837.46	delivered	paid	credit_card	\N	2026-09-20 00:25:15	2026-09-20 00:25:15	2026-09-20 00:25:15	\N	\N	\N
142	ORD-20261012-JJFJGN	Srta. Joyce Sueli Arruda	luisa.bezerra@example.com	22527464327	(26) 94426-7661	74003010	Avenida Anhanguera	796	Apto 175	Setor Central	Goiânia	GO	2173.21	31.34	0.00	2204.55	shipped	paid	credit_card	\N	2026-10-12 09:41:15	2026-10-12 09:41:15	2026-10-12 09:41:15	\N	\N	\N
143	ORD-20260925-U217F0	Daniel Alcantara Santacruz Jr.	bsaito@example.org	27377415649	(79) 94413-7433	20040020	Avenida Rio Branco	1868	\N	Centro	Rio de Janeiro	RJ	1012.16	39.39	0.00	1051.55	cancelled	refunded	credit_card	\N	2026-09-25 19:20:15	2026-09-25 19:20:15	2026-09-25 19:20:15	\N	\N	\N
144	ORD-20260925-LJJLB9	Maximiano Michael Zaragoça	natan.benites@example.org	34753567672	(28) 93724-1755	80420000	Rua Comendador Araújo	3176	Apto 176	Centro	Curitiba	PR	359.38	30.52	0.00	389.90	cancelled	refunded	boleto	\N	2026-09-25 19:02:15	2026-09-25 19:02:15	2026-09-25 19:02:15	\N	\N	\N
145	ORD-20261005-QEUV1W	Sarah Medina Galhardo	analu49@example.net	65166956796	(54) 93490-2949	13010111	Rua Barão de Jaguara	1400	Apto 146	Centro	Campinas	SP	2062.82	114.72	0.00	2177.54	shipped	paid	pix	\N	2026-10-05 23:26:15	2026-10-05 23:26:15	2026-10-05 23:26:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654072177.545802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261005QEUV1W63040D9A	2026-10-05 23:56:15	\N
146	ORD-20261007-SXJOQU	Louise Balestero Vila Neto	salas.antonieta@example.net	79836582819	(11) 91795-1180	20040020	Avenida Rio Branco	1704	\N	Centro	Rio de Janeiro	RJ	271.21	39.01	0.00	310.22	processing	paid	credit_card	\N	2026-10-07 20:17:15	2026-10-07 20:17:15	2026-10-07 20:17:15	\N	\N	\N
147	ORD-20261012-XRLH4I	Sr. Christopher Montenegro Sobrinho	marin.david@example.com	67265388631	(98) 95082-7770	88010400	Rua Felipe Schmidt	27	Apto 80	Centro	Florianópolis	SC	1813.10	22.89	0.00	1835.99	processing	paid	boleto	\N	2026-10-12 12:13:15	2026-10-12 12:13:15	2026-10-12 12:13:15	\N	\N	\N
148	ORD-20261009-L8ACQ7	Sr. Renan Ramos Correia Neto	jacomo52@example.com	61971648175	(80) 93009-0935	30130010	Avenida Afonso Pena	3020	Apto 482	Centro	Belo Horizonte	MG	1201.28	46.60	0.00	1247.88	processing	paid	credit_card	\N	2026-10-09 11:15:15	2026-10-09 11:15:15	2026-10-09 11:15:15	\N	\N	\N
149	ORD-20261018-8VPMRA	Dr. Gisele Valentin Azevedo	serra.victor@example.com	11435032950	(88) 90480-2954	60060180	Rua Floriano Peixoto	1876	\N	Centro	Fortaleza	CE	1450.83	101.48	0.00	1552.31	shipped	paid	pix	\N	2026-10-18 13:24:15	2026-10-18 13:24:15	2026-10-18 13:24:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071552.315802BR5909AUTOSTOCK6009SAO PAULO62210517ORD202610188VPMRA6304B0DD	2026-10-18 13:54:15	\N
150	ORD-20261012-LXTJDP	Sr. Caio Rodrigues	rosa.mirella@example.com	30725482001	(22) 98371-6154	01310100	Avenida Paulista	2813	\N	Bela Vista	São Paulo	SP	2378.54	103.94	0.00	2482.48	paid	paid	credit_card	\N	2026-10-12 14:56:15	2026-10-12 14:56:15	2026-10-12 14:56:15	\N	\N	\N
151	ORD-20260726-5TIOWO	Gian Martines Sobrinho	mirela92@example.org	78583928169	(14) 95365-2196	88010400	Rua Felipe Schmidt	2170	\N	Centro	Florianópolis	SC	2689.90	81.97	0.00	2771.87	paid	paid	credit_card	\N	2026-07-26 12:44:15	2026-07-26 12:44:15	2026-07-26 12:44:15	\N	\N	\N
152	ORD-20261104-YHCHBE	Sr. Roberto Emílio Saraiva	george.meireles@example.org	62560522853	(52) 91580-5000	30130010	Avenida Afonso Pena	1375	\N	Centro	Belo Horizonte	MG	779.80	0.00	0.00	779.80	pending	pending	credit_card	\N	2026-11-04 15:20:15	2026-11-04 15:20:15	2026-11-04 15:20:15	\N	\N	\N
153	ORD-20260816-G9TL9X	Gabrielly Noemi Leal Neto	tcaldeira@example.net	48863800693	(35) 95024-6174	80420000	Rua Comendador Araújo	741	\N	Centro	Curitiba	PR	1405.75	115.70	0.00	1521.45	paid	paid	credit_card	\N	2026-08-16 06:07:15	2026-08-16 06:07:15	2026-08-16 06:07:15	\N	\N	\N
154	ORD-20260727-RISG0Z	Sra. Júlia Sheila Rangel Neto	miranda96@example.net	19734766147	(43) 90076-1031	88010400	Rua Felipe Schmidt	1866	\N	Centro	Florianópolis	SC	1168.75	79.20	0.00	1247.95	processing	paid	pix	\N	2026-07-27 12:54:15	2026-07-27 12:54:15	2026-07-27 12:54:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071247.955802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260727RISG0Z63047ED2	2026-07-27 13:24:15	\N
155	ORD-20261101-BGJDKM	Alan Madeira Faria	marcia86@example.net	34601850070	(37) 92128-7686	30130010	Avenida Afonso Pena	1680	\N	Centro	Belo Horizonte	MG	1178.27	97.98	0.00	1276.25	delivered	paid	pix	\N	2026-11-01 18:14:15	2026-11-01 18:14:15	2026-11-01 18:14:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071276.255802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261101BGJDKM6304C55E	2026-11-01 18:44:15	\N
156	ORD-20261009-18OYMF	Dr. Robson Gael Benez	bittencourt.cristovao@example.org	98150720308	(54) 96484-3832	80420000	Rua Comendador Araújo	3074	Apto 688	Centro	Curitiba	PR	1376.77	101.80	0.00	1478.57	pending	pending	credit_card	\N	2026-10-09 05:08:15	2026-10-09 05:08:15	2026-10-09 05:08:15	\N	\N	\N
157	ORD-20260914-WW1HH8	Samara Dayane Rico	gisela25@example.org	43678732348	(06) 94534-6359	80420000	Rua Comendador Araújo	1229	\N	Centro	Curitiba	PR	1809.93	77.85	0.00	1887.78	pending	pending	boleto	\N	2026-09-14 10:55:15	2026-09-14 10:55:15	2026-09-14 10:55:15	\N	\N	\N
158	ORD-20261008-PFBPPJ	Heloísa Gonçalves Aranda	ivan.serrano@example.net	43669542140	(09) 94343-6783	70040900	SQS 308	2937	\N	Asa Sul	Brasília	DF	1323.48	87.83	0.00	1411.31	shipped	paid	boleto	\N	2026-10-08 05:53:15	2026-10-08 05:53:15	2026-10-08 05:53:15	\N	\N	\N
159	ORD-20261008-XOXINH	Alice Santos Cortês	velasques.dayane@example.org	44344004523	(03) 91441-9089	30130010	Avenida Afonso Pena	1356	\N	Centro	Belo Horizonte	MG	1272.39	77.72	0.00	1350.11	delivered	paid	credit_card	\N	2026-10-08 04:26:15	2026-10-08 04:26:15	2026-10-08 04:26:15	\N	\N	\N
160	ORD-20260914-GSMER3	Sra. Fernanda Bittencourt Filho	davi60@example.org	90980734410	(66) 95420-7996	90010150	Rua dos Andradas	622	Apto 993	Centro Histórico	Porto Alegre	RS	819.87	64.15	0.00	884.02	paid	paid	boleto	\N	2026-09-14 02:17:15	2026-09-14 02:17:15	2026-09-14 02:17:15	\N	\N	\N
161	ORD-20261001-RU9RAW	Sra. Lavínia Graziela Ramires Jr.	renan.deverso@example.com	77676198771	(92) 95743-5725	60060180	Rua Floriano Peixoto	2195	\N	Centro	Fortaleza	CE	547.82	0.00	0.00	547.82	cancelled	refunded	pix	\N	2026-10-01 19:35:15	2026-10-01 19:35:15	2026-10-01 19:35:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406547.825802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261001RU9RAW630406DA	2026-10-01 20:05:15	\N
162	ORD-20260804-DRLKN6	Dr. Valéria Saito	soares.viviane@example.com	44416801980	(75) 90406-7732	90010150	Rua dos Andradas	1716	\N	Centro Histórico	Porto Alegre	RS	2199.32	115.52	0.00	2314.84	processing	paid	credit_card	\N	2026-08-04 15:13:15	2026-08-04 15:13:15	2026-08-04 15:13:15	\N	\N	\N
163	ORD-20260924-GBD5VB	Jaqueline Ferminiano Leon Filho	alessandro.gusmao@example.org	05276113874	(85) 95157-1940	13010111	Rua Barão de Jaguara	1110	Apto 628	Centro	Campinas	SP	1292.31	36.83	0.00	1329.14	paid	paid	credit_card	\N	2026-09-24 11:24:15	2026-09-24 11:24:15	2026-09-24 11:24:15	\N	\N	\N
164	ORD-20260727-VEXK71	Lorena Rezende Pedrosa Jr.	dante71@example.org	11064677100	(25) 92718-3063	88010400	Rua Felipe Schmidt	1034	Apto 139	Centro	Florianópolis	SC	459.66	23.99	0.00	483.65	paid	paid	pix	\N	2026-07-27 09:31:15	2026-07-27 09:31:15	2026-07-27 09:31:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406483.655802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260727VEXK7163047201	2026-07-27 10:01:15	\N
165	ORD-20261022-WI1TIE	Sra. Gabriela Queirós Carrara	maisa.serra@example.org	24433837504	(95) 92473-2377	60060180	Rua Floriano Peixoto	2442	Apto 842	Centro	Fortaleza	CE	1197.22	76.30	0.00	1273.52	processing	paid	boleto	\N	2026-10-22 21:42:15	2026-10-22 21:42:15	2026-10-22 21:42:15	\N	\N	\N
177	ORD-20261101-UFN3XG	Marisa Salgado	stella.dasilva@example.org	79554107269	(84) 98001-0251	70040900	SQS 308	605	Apto 120	Asa Sul	Brasília	DF	1213.70	123.87	0.00	1337.57	pending	pending	pix	\N	2026-11-01 20:28:15	2026-11-01 20:28:15	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+551999385679452040000530398654071337.575802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261101UFN3XG630430D9	2026-11-14 13:20:02	\N
166	ORD-20260808-RXOD8G	Srta. Rosana Batista	angelica.darosa@example.com	67468675520	(15) 98758-2957	40015010	Avenida da França	3172	\N	Comércio	Salvador	BA	163.68	28.05	0.00	191.73	shipped	paid	pix	\N	2026-08-08 06:54:15	2026-08-08 06:54:15	2026-08-08 06:54:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406191.735802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260808RXOD8G630412B3	2026-08-08 07:24:15	\N
181	ORD-20261018-GBVMKC	Henrique Lira	rmontenegro@example.com	55382290091	(74) 90449-2024	90010150	Rua dos Andradas	3046	\N	Centro Histórico	Porto Alegre	RS	489.07	32.19	0.00	521.26	pending	pending	pix	\N	2026-10-18 10:01:15	2026-10-18 10:01:15	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+55199938567945204000053039865406521.265802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261018GBVMKC63047C8E	2026-11-14 13:20:02	\N
167	ORD-20260730-MRKV0I	Dr. Walter Simon Soares	zmarin@example.net	91809765650	(45) 95642-0326	60060180	Rua Floriano Peixoto	310	Apto 394	Centro	Fortaleza	CE	447.08	37.06	0.00	484.14	shipped	paid	boleto	\N	2026-07-30 03:09:15	2026-07-30 03:09:15	2026-07-30 03:09:15	\N	\N	\N
186	ORD-20260805-ZZPO61	Mila Luzia Meireles Sobrinho	rangel.elias@example.net	53027319248	(43) 93319-4454	13010111	Rua Barão de Jaguara	790	Apto 31	Centro	Campinas	SP	393.91	55.25	0.00	449.16	pending	pending	pix	\N	2026-08-05 16:14:15	2026-08-05 16:14:15	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+55199938567945204000053039865406449.165802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260805ZZPO6163049CCA	2026-11-14 13:20:02	\N
168	ORD-20260927-J6372N	Bernardo Toledo Sales	wagner36@example.net	00253888433	(11) 98633-0791	01310100	Avenida Paulista	1801	\N	Bela Vista	São Paulo	SP	389.90	24.01	0.00	413.91	delivered	paid	pix	\N	2026-09-27 17:44:15	2026-09-27 17:44:15	2026-09-27 17:44:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406413.915802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260927J6372N6304A644	2026-09-27 18:14:15	\N
169	ORD-20261012-ZINXOK	Dr. Pablo Teles Sobrinho	sabrina.matias@example.com	00687834422	(06) 94150-2737	60060180	Rua Floriano Peixoto	2224	\N	Centro	Fortaleza	CE	817.68	33.28	0.00	850.96	shipped	paid	pix	\N	2026-10-12 15:49:15	2026-10-12 15:49:15	2026-10-12 15:49:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406850.965802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261012ZINXOK63047C5A	2026-10-12 16:19:15	\N
170	ORD-20260922-POK7UX	Fábio Rezende Neto	campos.isabelly@example.com	40974556050	(53) 99048-2681	88010400	Rua Felipe Schmidt	1935	Apto 443	Centro	Florianópolis	SC	537.20	54.98	0.00	592.18	shipped	paid	credit_card	\N	2026-09-22 06:08:15	2026-09-22 06:08:15	2026-09-22 06:08:15	\N	\N	\N
171	ORD-20261019-DKQWQX	Dr. Allan Gabriel Leon Jr.	campos.rebeca@example.net	39089264400	(06) 93330-9675	01310100	Avenida Paulista	2069	Apto 740	Bela Vista	São Paulo	SP	557.57	68.49	0.00	626.06	delivered	paid	pix	\N	2026-10-19 23:46:15	2026-10-19 23:46:15	2026-10-19 23:46:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406626.065802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261019DKQWQX63046C80	2026-10-20 00:16:15	\N
172	ORD-20260905-SVKIQL	Isis Leon Santana Filho	msantana@example.net	93317195665	(05) 95066-5198	13010111	Rua Barão de Jaguara	2124	Apto 684	Centro	Campinas	SP	1460.52	69.37	0.00	1529.89	shipped	paid	pix	\N	2026-09-05 08:09:15	2026-09-05 08:09:15	2026-09-05 08:09:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071529.895802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260905SVKIQL63041611	2026-09-05 08:39:15	\N
173	ORD-20260726-KVIS2V	Sra. Fabiana Vasques Campos Neto	cristina58@example.org	36998081499	(16) 95058-0511	60060180	Rua Floriano Peixoto	3175	\N	Centro	Fortaleza	CE	198.52	47.28	0.00	245.80	pending	pending	credit_card	\N	2026-07-26 03:29:15	2026-07-26 03:29:15	2026-07-26 03:29:15	\N	\N	\N
174	ORD-20260916-QEHFR5	Nicole Gonçalves da Silva	ldelatorre@example.net	27920537983	(03) 99952-2396	80420000	Rua Comendador Araújo	3186	\N	Centro	Curitiba	PR	959.90	156.02	0.00	1115.92	delivered	paid	credit_card	\N	2026-09-16 06:00:15	2026-09-16 06:00:15	2026-09-16 06:00:15	\N	\N	\N
175	ORD-20260821-ZPUYMW	Dr. Mel Sandoval Matias	hernani.brito@example.org	50395487960	(01) 97633-5925	20040020	Avenida Rio Branco	431	\N	Centro	Rio de Janeiro	RJ	1076.54	107.83	0.00	1184.37	delivered	paid	boleto	\N	2026-08-21 21:52:15	2026-08-21 21:52:15	2026-08-21 21:52:15	\N	\N	\N
176	ORD-20260920-4SXJDQ	Cristina Feliciano Madeira	bteles@example.net	13360799240	(59) 94006-7581	50030230	Rua da Aurora	107	Apto 29	Boa Vista	Recife	PE	367.77	21.71	0.00	389.48	processing	paid	credit_card	\N	2026-09-20 11:23:15	2026-09-20 11:23:15	2026-09-20 11:23:15	\N	\N	\N
178	ORD-20260903-X833HF	Sr. Ivan Amaral	ymendes@example.com	53821494450	(20) 97300-5216	88010400	Rua Felipe Schmidt	2477	\N	Centro	Florianópolis	SC	1222.19	130.42	0.00	1352.61	delivered	paid	credit_card	\N	2026-09-03 00:09:15	2026-09-03 00:09:15	2026-09-03 00:09:15	\N	\N	\N
179	ORD-20261010-56KMLB	Dr. Eduardo Delgado	icampos@example.net	76948236073	(42) 97692-7852	01310100	Avenida Paulista	1692	\N	Bela Vista	São Paulo	SP	917.21	71.63	0.00	988.84	delivered	paid	pix	\N	2026-10-10 14:12:15	2026-10-10 14:12:15	2026-10-10 14:12:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406988.845802BR5909AUTOSTOCK6009SAO PAULO62210517ORD2026101056KMLB6304BFB1	2026-10-10 14:42:15	\N
180	ORD-20260905-CNMRPC	Verônica Sara Reis	mpaz@example.com	61027000908	(95) 97878-0433	40015010	Avenida da França	2487	\N	Comércio	Salvador	BA	368.01	52.60	0.00	420.61	processing	paid	pix	\N	2026-09-05 18:12:15	2026-09-05 18:12:15	2026-09-05 18:12:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test5204000053039865406420.615802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260905CNMRPC63040ED5	2026-09-05 18:42:15	\N
182	ORD-20261020-KPGGWA	Srta. Fernanda Malu Marques	bonilha.marco@example.org	17744897757	(76) 90846-2514	30130010	Avenida Afonso Pena	1317	Apto 402	Centro	Belo Horizonte	MG	1317.32	83.95	0.00	1401.27	shipped	paid	pix	\N	2026-10-20 15:21:15	2026-10-20 15:21:15	2026-10-20 15:21:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071401.275802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261020KPGGWA630483A3	2026-10-20 15:51:15	\N
183	ORD-20260813-FS8Q7L	Isaac Dias Sepúlveda Sobrinho	joaquim.domingues@example.com	58355965965	(94) 93163-0654	40015010	Avenida da França	3110	Apto 705	Comércio	Salvador	BA	556.79	106.70	0.00	663.49	processing	paid	boleto	\N	2026-08-13 01:39:15	2026-08-13 01:39:15	2026-08-13 01:39:15	\N	\N	\N
184	ORD-20260724-9NP1VF	Micaela Aragão Filho	cdefreitas@example.net	99507639594	(22) 97524-5011	01310100	Avenida Paulista	1149	Apto 25	Bela Vista	São Paulo	SP	1933.22	56.66	0.00	1989.88	delivered	paid	credit_card	\N	2026-07-24 00:46:15	2026-07-24 00:46:15	2026-07-24 00:46:15	\N	\N	\N
185	ORD-20260909-JAJRKB	Gabriel Ramires Cordeiro Sobrinho	grego.kesia@example.net	13459461713	(44) 93737-0787	13010111	Rua Barão de Jaguara	2284	Apto 732	Centro	Campinas	SP	1012.16	39.39	0.00	1051.55	cancelled	refunded	credit_card	\N	2026-09-09 06:24:15	2026-09-09 06:24:15	2026-09-09 06:24:15	\N	\N	\N
193	ORD-20261112-3FEXIW	Hortência Vila	ferreira.bianca@example.net	25092520540	(67) 95288-8798	80420000	Rua Comendador Araújo	461	Apto 16	Centro	Curitiba	PR	1418.66	120.97	0.00	1539.63	pending	pending	pix	\N	2026-11-12 16:32:15	2026-11-12 16:32:15	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+551999385679452040000530398654071539.635802BR5909AUTOSTOCK6009SAO PAULO62210517ORD202611123FEXIW63044E8F	2026-11-14 13:20:02	\N
187	ORD-20260909-TKMPBE	George Demian Santos	stephanie.colaco@example.net	35782308125	(78) 98652-0569	01310100	Avenida Paulista	1860	\N	Bela Vista	São Paulo	SP	550.88	49.65	0.00	600.53	processing	paid	boleto	\N	2026-09-09 11:25:15	2026-09-09 11:25:15	2026-09-09 11:25:15	\N	\N	\N
195	ORD-20261109-FLD3MY	Igor Montenegro de Souza	everdara@example.org	00163088403	(52) 97894-5965	74003010	Avenida Anhanguera	1713	Apto 389	Setor Central	Goiânia	GO	1286.45	59.40	0.00	1345.85	pending	pending	pix	\N	2026-11-09 06:27:15	2026-11-09 06:27:15	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+551999385679452040000530398654071345.855802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261109FLD3MY63046953	2026-11-14 13:20:02	\N
188	ORD-20260929-IM71DW	Franciele Grego	mendes.alessandro@example.net	65361925160	(77) 95234-4571	01310100	Avenida Paulista	2579	\N	Bela Vista	São Paulo	SP	1173.63	85.74	0.00	1259.37	paid	paid	credit_card	\N	2026-09-29 12:52:15	2026-09-29 12:52:15	2026-09-29 12:52:15	\N	\N	\N
198	ORD-20261007-WFHCTF	Srta. Viviane Duarte Mendonça Filho	patricia.lira@example.com	35024200683	(68) 96073-8397	20040020	Avenida Rio Branco	3023	\N	Centro	Rio de Janeiro	RJ	1465.75	78.16	0.00	1543.91	pending	pending	pix	\N	2026-10-07 09:03:15	2026-10-07 09:03:15	2026-11-14 12:50:02	00020126360014br.gov.bcb.pix0114+551999385679452040000530398654071543.915802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261007WFHCTF63045784	2026-11-14 13:20:02	\N
189	ORD-20260917-XQKASP	Daiana Matias Azevedo Jr.	heitor.cervantes@example.net	08533786573	(58) 91436-4477	60060180	Rua Floriano Peixoto	1312	\N	Centro	Fortaleza	CE	1689.31	141.97	0.00	1831.28	shipped	paid	pix	\N	2026-09-17 06:12:15	2026-09-17 06:12:15	2026-09-17 06:12:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071831.285802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260917XQKASP6304EFEC	2026-09-17 06:42:15	\N
190	ORD-20260826-KNTQYS	Dr. Franco Matos	tessalia.molina@example.org	53353168702	(31) 94594-5760	40015010	Avenida da França	1338	\N	Comércio	Salvador	BA	1247.35	245.56	0.00	1492.91	delivered	paid	credit_card	\N	2026-08-26 13:07:15	2026-08-26 13:07:15	2026-08-26 13:07:15	\N	\N	\N
191	ORD-20260801-AOLX05	Srta. Giovanna Padrão Sales Filho	kmaldonado@example.net	74590810786	(36) 94455-2897	30130010	Avenida Afonso Pena	497	\N	Centro	Belo Horizonte	MG	1708.04	93.43	0.00	1801.47	delivered	paid	pix	\N	2026-08-01 09:32:15	2026-08-01 09:32:15	2026-08-01 09:32:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071801.475802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20260801AOLX05630499DC	2026-08-01 10:02:15	\N
192	ORD-20260819-6LG8PG	Pérola Saraiva	alexa.carvalho@example.com	35134810800	(41) 98374-8816	60060180	Rua Floriano Peixoto	1415	Apto 965	Centro	Fortaleza	CE	2197.75	74.17	0.00	2271.92	pending	pending	credit_card	\N	2026-08-19 17:52:15	2026-08-19 17:52:15	2026-08-19 17:52:15	\N	\N	\N
194	ORD-20261024-XNYCIQ	Ruth Laiane Brito Jr.	camilo13@example.org	46960813204	(33) 97049-3288	74003010	Avenida Anhanguera	2823	\N	Setor Central	Goiânia	GO	1158.72	65.34	0.00	1224.06	shipped	paid	pix	\N	2026-10-24 11:51:15	2026-10-24 11:51:15	2026-10-24 11:51:15	00020126470014br.gov.bcb.pix0125pagamentos@autostock.test52040000530398654071224.065802BR5909AUTOSTOCK6009SAO PAULO62210517ORD20261024XNYCIQ630411DE	2026-10-24 12:21:15	\N
196	ORD-20260718-GQKWWQ	Artur Lourenço	suzana.salas@example.org	46097994800	(97) 90541-0080	20040020	Avenida Rio Branco	1842	Apto 327	Centro	Rio de Janeiro	RJ	336.44	47.04	0.00	383.48	delivered	paid	boleto	\N	2026-07-18 21:11:15	2026-07-18 21:11:15	2026-07-18 21:11:15	\N	\N	\N
197	ORD-20261006-9QN4IB	Dr. Jéssica Isadora Franco Neto	wespinoza@example.org	37610573183	(33) 96303-8627	13010111	Rua Barão de Jaguara	2656	Apto 22	Centro	Campinas	SP	998.71	118.04	0.00	1116.75	shipped	paid	credit_card	\N	2026-10-06 20:33:15	2026-10-06 20:33:15	2026-10-06 20:33:15	\N	\N	\N
199	ORD-20260825-WI7RFY	Bella Rivera Urias	juliane86@example.com	02581007613	(43) 92103-4585	88010400	Rua Felipe Schmidt	1152	Apto 599	Centro	Florianópolis	SC	1911.57	117.31	0.00	2028.88	shipped	paid	credit_card	\N	2026-08-25 19:32:15	2026-08-25 19:32:15	2026-08-25 19:32:15	\N	\N	\N
200	ORD-20260719-1ID7FL	Maximiano Martinho Aguiar Filho	rafaela14@example.net	94473339238	(82) 90304-0459	70040900	SQS 308	1617	\N	Asa Sul	Brasília	DF	195.23	39.77	0.00	235.00	pending	pending	credit_card	\N	2026-07-19 14:50:15	2026-07-19 14:50:15	2026-07-19 14:50:15	\N	\N	\N
\.


--
-- TOC entry 5244 (class 0 OID 17104)
-- Dependencies: 237
-- Data for Name: produtos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produtos (id, seller_id, name, slug, brand, category, description, image_url, active, created_at, updated_at, deleted_at) FROM stdin;
2	2	Kit Pastilhas de Freio Bosch	kit-pastilhas-de-freio-bosch	Bosch	Freios	Jogo de pastilhas cerâmicas com alta performance e baixo ruído. Acompanha sensores quando aplicável.	/images/products/pastilha-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
3	3	Filtro de Óleo Mann W 712/95	filtro-de-oleo-mann-w-71295	Mann Filter	Motor	Filtro de óleo com válvula anti-retorno e mídia filtrante de alta eficiência.	/images/products/filtro-oleo-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
4	2	Bateria Moura M60AD 60Ah	bateria-moura-m60ad-60ah	Moura	Elétrica	Bateria automotiva 60Ah, livre de manutenção, com 18 meses de garantia.	/images/products/bateria-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
5	1	Palheta Limpador Bosch Aerotwin	palheta-limpador-bosch-aerotwin	Bosch	Acessórios	Par de palhetas aerodinâmicas com encaixe universal e excelente visibilidade.	/images/products/palheta-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
7	8	Tambor de Freio SKF	tambor-de-freio-skf	SKF	Freios	Tambor de Freio SKF, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/tambor-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
8	2	Filtro de Combustível Mahle	filtro-de-combustivel-mahle	Mahle	Motor	Filtro de Combustível Mahle, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/filtro-combustivel-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
9	5	Motor de Partida SKF	motor-de-partida-skf	SKF	Elétrica	Motor de Partida SKF, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/motor-partida-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
10	4	Ventilador do Radiador Continental HD	ventilador-do-radiador-continental-hd	Continental	Arrefecimento	Ventilador do Radiador Continental, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/ventilador-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
11	2	Coifa da Homocinética NGK HD	coifa-da-homocinetica-ngk-hd	NGK	Transmissão	Coifa da Homocinética NGK, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/coifa-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
12	4	Protetor de Carter Valeo	protetor-de-carter-valeo	Valeo	Acessórios	Protetor de Carter Valeo, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/protetor-carter-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
13	8	Bomba de Direção Hidráulica Bosch	bomba-de-direcao-hidraulica-bosch	Bosch	Direção	Bomba de Direção Hidráulica Bosch, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bomba-direcao-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
14	1	Pivô de Suspensão Varga	pivo-de-suspensao-varga	Varga	Suspensão	Pivô de Suspensão Varga, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/pivo-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
15	3	Pastilha de Freio Monroe	pastilha-de-freio-monroe	Monroe	Freios	Pastilha de Freio Monroe, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/pastilha-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
17	3	Bateria 70Ah SKF Original	bateria-70ah-skf-original	SKF	Elétrica	Bateria 70Ah SKF, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bateria-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
18	8	Válvula Termostática Continental	valvula-termostatica-continental	Continental	Arrefecimento	Válvula Termostática Continental, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/valvula-termostatica-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
19	4	Kit Embreagem Continental	kit-embreagem-continental	Continental	Transmissão	Kit Embreagem Continental, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/embreagem-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
20	4	Calota Continental	calota-continental	Continental	Acessórios	Calota Continental, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/calota-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
21	3	Terminal Axial Denso	terminal-axial-denso	Denso	Direção	Terminal Axial Denso, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/terminal-direcao-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
22	8	Amortecedor Traseiro Cofap Premium	amortecedor-traseiro-cofap-premium	Cofap	Suspensão	Amortecedor Traseiro Cofap, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/amortecedor-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
23	4	Lonas de Freio Gates	lonas-de-freio-gates	Gates	Freios	Lonas de Freio Gates, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/lona-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
24	2	Kit Correia Dentada Nakata	kit-correia-dentada-nakata	Nakata	Motor	Kit Correia Dentada Nakata, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/correia-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
27	5	Coifa da Homocinética Mann Filter HD	coifa-da-homocinetica-mann-filter-hd	Mann Filter	Transmissão	Coifa da Homocinética Mann Filter, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/coifa-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
28	3	Calota Moura	calota-moura	Moura	Acessórios	Calota Moura, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/calota-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
29	2	Bomba de Direção Hidráulica Magneti Marelli	bomba-de-direcao-hidraulica-magneti-marelli	Magneti Marelli	Direção	Bomba de Direção Hidráulica Magneti Marelli, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bomba-direcao-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
30	8	Kit Amortecedores Mahle Reforçado	kit-amortecedores-mahle-reforcado	Mahle	Suspensão	Kit Amortecedores Mahle, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/amortecedor-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
31	7	Flexível de Freio Varga	flexivel-de-freio-varga	Varga	Freios	Flexível de Freio Varga, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/flexivel-freio-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
32	7	Correia Dentada Heliar	correia-dentada-heliar	Heliar	Motor	Correia Dentada Heliar, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/correia-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
33	6	Lâmpada Farol Cofap	lampada-farol-cofap	Cofap	Elétrica	Lâmpada Farol Cofap, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/lampada-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
35	3	Rolamento de Embreagem Bosch Linha Leve	rolamento-de-embreagem-bosch-linha-leve	Bosch	Transmissão	Rolamento de Embreagem Bosch, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/embreagem-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
36	5	Kit Ferramentas Magneti Marelli	kit-ferramentas-magneti-marelli	Magneti Marelli	Acessórios	Kit Ferramentas Magneti Marelli, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/ferramentas-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
37	3	Bomba de Direção Hidráulica Delphi	bomba-de-direcao-hidraulica-delphi	Delphi	Direção	Bomba de Direção Hidráulica Delphi, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bomba-direcao-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
38	5	Barra Estabilizadora Fram	barra-estabilizadora-fram	Fram	Suspensão	Barra Estabilizadora Fram, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/barra-estabilizadora-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
39	3	Cilindro de Roda Fram	cilindro-de-roda-fram	Fram	Freios	Cilindro de Roda Fram, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/cilindro-roda-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
40	8	Filtro de Óleo Bosch	filtro-de-oleo-bosch	Bosch	Motor	Filtro de Óleo Bosch, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/filtro-oleo-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
41	1	Sensor de Rotação Mahle HD	sensor-de-rotacao-mahle-hd	Mahle	Elétrica	Sensor de Rotação Mahle, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/sensor-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
42	3	Radiador Valeo	radiador-valeo	Valeo	Arrefecimento	Radiador Valeo, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/radiador-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
44	3	Palheta Limpador Magneti Marelli	palheta-limpador-magneti-marelli	Magneti Marelli	Acessórios	Palheta Limpador Magneti Marelli, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/palheta-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
45	4	Caixa de Direção NGK	caixa-de-direcao-ngk	NGK	Direção	Caixa de Direção NGK, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/caixa-direcao-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
46	3	Mola Helicoidal Nakata	mola-helicoidal-nakata	Nakata	Suspensão	Mola Helicoidal Nakata, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/mola-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
47	3	Lonas de Freio Bosch Série Ouro	lonas-de-freio-bosch-serie-ouro	Bosch	Freios	Lonas de Freio Bosch, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/lona-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
48	8	Filtro de Óleo SKF Linha Leve	filtro-de-oleo-skf-linha-leve	SKF	Motor	Filtro de Óleo SKF, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/filtro-oleo-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
50	5	Eletroventilador Magneti Marelli Original	eletroventilador-magneti-marelli-original	Magneti Marelli	Arrefecimento	Eletroventilador Magneti Marelli, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/ventilador-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
51	2	Coifa da Homocinética Cofap Premium	coifa-da-homocinetica-cofap-premium	Cofap	Transmissão	Coifa da Homocinética Cofap, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/coifa-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
52	7	Kit Ferramentas Delphi Linha Leve	kit-ferramentas-delphi-linha-leve	Delphi	Acessórios	Kit Ferramentas Delphi, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/ferramentas-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
53	6	Terminal Axial Cofap	terminal-axial-cofap	Cofap	Direção	Terminal Axial Cofap, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/terminal-direcao-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
55	3	Flexível de Freio Monroe Série Ouro	flexivel-de-freio-monroe-serie-ouro	Monroe	Freios	Flexível de Freio Monroe, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/flexivel-freio-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
56	8	Filtro de Óleo Mann Filter Reforçado	filtro-de-oleo-mann-filter-reforcado	Mann Filter	Motor	Filtro de Óleo Mann Filter, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/filtro-oleo-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
57	4	Motor de Partida Bosch	motor-de-partida-bosch	Bosch	Elétrica	Motor de Partida Bosch, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/motor-partida-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
58	4	Reservatório de Água Mann Filter	reservatorio-de-agua-mann-filter	Mann Filter	Arrefecimento	Reservatório de Água Mann Filter, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/reservatorio-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
59	5	Atuador de Embreagem Sachs	atuador-de-embreagem-sachs	Sachs	Transmissão	Atuador de Embreagem Sachs, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/embreagem-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
60	7	Tapete Automotivo Mann Filter	tapete-automotivo-mann-filter	Mann Filter	Acessórios	Tapete Automotivo Mann Filter, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/tapete-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
61	8	Terminal Axial Mahle	terminal-axial-mahle	Mahle	Direção	Terminal Axial Mahle, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/terminal-direcao-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
62	2	Mola Helicoidal Heliar	mola-helicoidal-heliar	Heliar	Suspensão	Mola Helicoidal Heliar, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/mola-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
63	1	Cilindro de Roda Heliar Reforçado	cilindro-de-roda-heliar-reforcado	Heliar	Freios	Cilindro de Roda Heliar, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/cilindro-roda-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
65	4	Sensor de Rotação Moura	sensor-de-rotacao-moura	Moura	Elétrica	Sensor de Rotação Moura, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/sensor-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
66	3	Reservatório de Água TRW	reservatorio-de-agua-trw	TRW	Arrefecimento	Reservatório de Água TRW, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/reservatorio-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
67	8	Coifa da Homocinética Mahle Reforçado	coifa-da-homocinetica-mahle-reforcado	Mahle	Transmissão	Coifa da Homocinética Mahle, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/coifa-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
68	5	Palheta Limpador Varga	palheta-limpador-varga	Varga	Acessórios	Palheta Limpador Varga, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/palheta-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
69	6	Coifa de Direção Mahle	coifa-de-direcao-mahle	Mahle	Direção	Coifa de Direção Mahle, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/coifa-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
70	5	Amortecedor Traseiro Denso Premium	amortecedor-traseiro-denso-premium	Denso	Suspensão	Amortecedor Traseiro Denso, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/amortecedor-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
71	3	Cilindro de Roda Valeo	cilindro-de-roda-valeo	Valeo	Freios	Cilindro de Roda Valeo, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/cilindro-roda-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
73	2	Lâmpada Farol Mahle	lampada-farol-mahle	Mahle	Elétrica	Lâmpada Farol Mahle, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/lampada-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
74	3	Radiador Delphi Reforçado	radiador-delphi-reforcado	Delphi	Arrefecimento	Radiador Delphi, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/radiador-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
75	2	Coifa da Homocinética Fram Série Ouro	coifa-da-homocinetica-fram-serie-ouro	Fram	Transmissão	Coifa da Homocinética Fram, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/coifa-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
76	6	Calota NGK	calota-ngk	NGK	Acessórios	Calota NGK, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/calota-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
77	2	Coifa de Direção Sachs Série Ouro	coifa-de-direcao-sachs-serie-ouro	Sachs	Direção	Coifa de Direção Sachs, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/coifa-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
78	3	Terminal de Direção Sachs	terminal-de-direcao-sachs	Sachs	Suspensão	Terminal de Direção Sachs, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/terminal-direcao-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
80	5	Filtro de Ar Magneti Marelli Série Ouro	filtro-de-ar-magneti-marelli-serie-ouro	Magneti Marelli	Motor	Filtro de Ar Magneti Marelli, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/filtro-ar-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
81	3	Bobina de Ignição Valeo Linha Leve	bobina-de-ignicao-valeo-linha-leve	Valeo	Elétrica	Bobina de Ignição Valeo, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bobina-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
82	5	Eletroventilador Moura Original	eletroventilador-moura-original	Moura	Arrefecimento	Eletroventilador Moura, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/ventilador-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
83	6	Junta Homocinética Gates Reforçado	junta-homocinetica-gates-reforcado	Gates	Transmissão	Junta Homocinética Gates, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/homocinetica-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
84	6	Antena Automotiva Delphi	antena-automotiva-delphi	Delphi	Acessórios	Antena Automotiva Delphi, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/antena-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
85	5	Bomba de Direção Hidráulica Gates	bomba-de-direcao-hidraulica-gates	Gates	Direção	Bomba de Direção Hidráulica Gates, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bomba-direcao-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
86	5	Amortecedor Traseiro Gates	amortecedor-traseiro-gates	Gates	Suspensão	Amortecedor Traseiro Gates, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/amortecedor-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
87	8	Kit Freio Traseiro Delphi	kit-freio-traseiro-delphi	Delphi	Freios	Kit Freio Traseiro Delphi, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/kit-freio-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
88	2	Junta do Cabeçote Heliar	junta-do-cabecote-heliar	Heliar	Motor	Junta do Cabeçote Heliar, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/junta-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
90	8	Mangueira do Radiador Fram	mangueira-do-radiador-fram	Fram	Arrefecimento	Mangueira do Radiador Fram, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/mangueira-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
91	7	Kit Embreagem Sachs	kit-embreagem-sachs	Sachs	Transmissão	Kit Embreagem Sachs, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/embreagem-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
92	4	Antena Automotiva Monroe	antena-automotiva-monroe	Monroe	Acessórios	Antena Automotiva Monroe, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/antena-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
93	8	Bomba de Direção Hidráulica Continental Série Ouro	bomba-de-direcao-hidraulica-continental-serie-ouro	Continental	Direção	Bomba de Direção Hidráulica Continental, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bomba-direcao-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
94	7	Amortecedor Dianteiro NGK	amortecedor-dianteiro-ngk	NGK	Suspensão	Amortecedor Dianteiro NGK, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/amortecedor-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
97	5	Sensor de Rotação Heliar	sensor-de-rotacao-heliar	Heliar	Elétrica	Sensor de Rotação Heliar, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/sensor-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
98	8	Mangueira do Radiador Denso	mangueira-do-radiador-denso	Denso	Arrefecimento	Mangueira do Radiador Denso, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/mangueira-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
99	8	Junta Homocinética SKF Série Ouro	junta-homocinetica-skf-serie-ouro	SKF	Transmissão	Junta Homocinética SKF, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/homocinetica-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
100	6	Protetor de Carter Mahle	protetor-de-carter-mahle	Mahle	Acessórios	Protetor de Carter Mahle, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/protetor-carter-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
101	2	Caixa de Direção Denso	caixa-de-direcao-denso	Denso	Direção	Caixa de Direção Denso, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/caixa-direcao-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
102	3	Barra Estabilizadora Fram Premium	barra-estabilizadora-fram-premium	Fram	Suspensão	Barra Estabilizadora Fram, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/barra-estabilizadora-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
104	5	Junta do Cabeçote Valeo Premium	junta-do-cabecote-valeo-premium	Valeo	Motor	Junta do Cabeçote Valeo, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/junta-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
105	1	Motor de Partida Magneti Marelli	motor-de-partida-magneti-marelli	Magneti Marelli	Elétrica	Motor de Partida Magneti Marelli, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/motor-partida-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
106	2	Radiador NGK	radiador-ngk	NGK	Arrefecimento	Radiador NGK, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/radiador-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
107	5	Junta Homocinética Magneti Marelli	junta-homocinetica-magneti-marelli	Magneti Marelli	Transmissão	Junta Homocinética Magneti Marelli, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/homocinetica-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
108	1	Kit Ferramentas Moura	kit-ferramentas-moura	Moura	Acessórios	Kit Ferramentas Moura, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/ferramentas-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
109	8	Terminal Axial NGK Premium	terminal-axial-ngk-premium	NGK	Direção	Terminal Axial NGK, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/terminal-direcao-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
110	4	Terminal de Direção Nakata	terminal-de-direcao-nakata	Nakata	Suspensão	Terminal de Direção Nakata, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/terminal-direcao-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
111	7	Kit Freio Traseiro Moura	kit-freio-traseiro-moura	Moura	Freios	Kit Freio Traseiro Moura, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/kit-freio-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
112	1	Tensor da Correia Magneti Marelli	tensor-da-correia-magneti-marelli	Magneti Marelli	Motor	Tensor da Correia Magneti Marelli, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/tensor-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
113	4	Bobina de Ignição Mahle Linha Leve	bobina-de-ignicao-mahle-linha-leve	Mahle	Elétrica	Bobina de Ignição Mahle, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bobina-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
114	5	Radiador Mann Filter	radiador-mann-filter	Mann Filter	Arrefecimento	Radiador Mann Filter, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/radiador-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
116	1	Capa de Volante Fram	capa-de-volante-fram	Fram	Acessórios	Capa de Volante Fram, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/capa-volante-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
117	1	Coifa de Direção Sachs	coifa-de-direcao-sachs	Sachs	Direção	Coifa de Direção Sachs, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/coifa-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
118	1	Barra Estabilizadora SKF	barra-estabilizadora-skf	SKF	Suspensão	Barra Estabilizadora SKF, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/barra-estabilizadora-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
120	1	Filtro de Combustível Mann Filter	filtro-de-combustivel-mann-filter	Mann Filter	Motor	Filtro de Combustível Mann Filter, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/filtro-combustivel-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
121	4	Bateria 70Ah NGK	bateria-70ah-ngk	NGK	Elétrica	Bateria 70Ah NGK, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bateria-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
122	2	Reservatório de Água SKF	reservatorio-de-agua-skf	SKF	Arrefecimento	Reservatório de Água SKF, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/reservatorio-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
123	7	Atuador de Embreagem TRW	atuador-de-embreagem-trw	TRW	Transmissão	Atuador de Embreagem TRW, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/embreagem-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
124	2	Palheta Limpador Varga Premium	palheta-limpador-varga-premium	Varga	Acessórios	Palheta Limpador Varga, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/palheta-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
126	7	Kit Amortecedores Continental	kit-amortecedores-continental	Continental	Suspensão	Kit Amortecedores Continental, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/amortecedor-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
127	2	Lonas de Freio Cofap Original	lonas-de-freio-cofap-original	Cofap	Freios	Lonas de Freio Cofap, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/lona-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
128	5	Junta do Cabeçote Denso	junta-do-cabecote-denso	Denso	Motor	Junta do Cabeçote Denso, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/junta-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
129	6	Bateria 70Ah Continental	bateria-70ah-continental	Continental	Elétrica	Bateria 70Ah Continental, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bateria-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
130	2	Radiador Continental	radiador-continental	Continental	Arrefecimento	Radiador Continental, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/radiador-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
131	4	Junta Homocinética Magneti Marelli Série Ouro	junta-homocinetica-magneti-marelli-serie-ouro	Magneti Marelli	Transmissão	Junta Homocinética Magneti Marelli, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/homocinetica-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
132	4	Calota Nakata	calota-nakata	Nakata	Acessórios	Calota Nakata, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/calota-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
133	2	Terminal Axial Monroe	terminal-axial-monroe	Monroe	Direção	Terminal Axial Monroe, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/terminal-direcao-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
134	5	Amortecedor Dianteiro Mahle	amortecedor-dianteiro-mahle	Mahle	Suspensão	Amortecedor Dianteiro Mahle, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/amortecedor-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
135	2	Cilindro de Roda Nakata	cilindro-de-roda-nakata	Nakata	Freios	Cilindro de Roda Nakata, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/cilindro-roda-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
136	2	Vela de Ignição Heliar HD	vela-de-ignicao-heliar-hd	Heliar	Motor	Vela de Ignição Heliar, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/vela-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
138	1	Mangueira do Radiador Mann Filter	mangueira-do-radiador-mann-filter	Mann Filter	Arrefecimento	Mangueira do Radiador Mann Filter, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/mangueira-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
139	5	Junta Homocinética Bosch Linha Leve	junta-homocinetica-bosch-linha-leve	Bosch	Transmissão	Junta Homocinética Bosch, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/homocinetica-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
140	2	Palheta Limpador Monroe	palheta-limpador-monroe	Monroe	Acessórios	Palheta Limpador Monroe, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/palheta-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
141	1	Coifa de Direção Mann Filter Linha Leve	coifa-de-direcao-mann-filter-linha-leve	Mann Filter	Direção	Coifa de Direção Mann Filter, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/coifa-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
143	5	Fluido de Freio SKF	fluido-de-freio-skf	SKF	Freios	Fluido de Freio SKF, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/fluido-freio-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
144	4	Filtro de Óleo Denso Original	filtro-de-oleo-denso-original	Denso	Motor	Filtro de Óleo Denso, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/filtro-oleo-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
145	1	Sensor de Oxigênio Cofap	sensor-de-oxigenio-cofap	Cofap	Elétrica	Sensor de Oxigênio Cofap, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/sensor-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
147	1	Atuador de Embreagem Moura	atuador-de-embreagem-moura	Moura	Transmissão	Atuador de Embreagem Moura, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/embreagem-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
148	3	Capa de Volante Gates	capa-de-volante-gates	Gates	Acessórios	Capa de Volante Gates, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/capa-volante-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
149	2	Terminal Axial Varga	terminal-axial-varga	Varga	Direção	Terminal Axial Varga, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/terminal-direcao-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
150	3	Amortecedor Traseiro Delphi	amortecedor-traseiro-delphi	Delphi	Suspensão	Amortecedor Traseiro Delphi, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/amortecedor-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
151	5	Flexível de Freio Gates	flexivel-de-freio-gates	Gates	Freios	Flexível de Freio Gates, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/flexivel-freio-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
152	2	Bomba de Combustível Sachs	bomba-de-combustivel-sachs	Sachs	Motor	Bomba de Combustível Sachs, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bomba-combustivel-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
153	6	Lâmpada Farol SKF	lampada-farol-skf	SKF	Elétrica	Lâmpada Farol SKF, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/lampada-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
154	6	Válvula Termostática SKF	valvula-termostatica-skf	SKF	Arrefecimento	Válvula Termostática SKF, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/valvula-termostatica-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
155	5	Junta Homocinética Sachs HD	junta-homocinetica-sachs-hd	Sachs	Transmissão	Junta Homocinética Sachs, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/homocinetica-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
156	6	Calota Monroe Reforçado	calota-monroe-reforcado	Monroe	Acessórios	Calota Monroe, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/calota-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
158	6	Pivô de Suspensão Monroe	pivo-de-suspensao-monroe	Monroe	Suspensão	Pivô de Suspensão Monroe, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/pivo-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
159	7	Tambor de Freio NGK	tambor-de-freio-ngk	NGK	Freios	Tambor de Freio NGK, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/tambor-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
160	1	Filtro de Óleo Valeo	filtro-de-oleo-valeo	Valeo	Motor	Filtro de Óleo Valeo, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/filtro-oleo-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
161	2	Bateria 70Ah Varga	bateria-70ah-varga	Varga	Elétrica	Bateria 70Ah Varga, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bateria-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
162	1	Mangueira do Radiador SKF HD	mangueira-do-radiador-skf-hd	SKF	Arrefecimento	Mangueira do Radiador SKF, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/mangueira-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
163	2	Rolamento de Embreagem Continental	rolamento-de-embreagem-continental	Continental	Transmissão	Rolamento de Embreagem Continental, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/embreagem-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
164	4	Calota Fram	calota-fram	Fram	Acessórios	Calota Fram, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/calota-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
165	3	Terminal Axial Cofap Original	terminal-axial-cofap-original	Cofap	Direção	Terminal Axial Cofap, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/terminal-direcao-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
167	8	Cilindro de Roda Heliar	cilindro-de-roda-heliar	Heliar	Freios	Cilindro de Roda Heliar, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/cilindro-roda-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
169	6	Alternador NGK Reforçado	alternador-ngk-reforcado	NGK	Elétrica	Alternador NGK, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/alternador-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
170	2	Eletroventilador Nakata	eletroventilador-nakata	Nakata	Arrefecimento	Eletroventilador Nakata, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/ventilador-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
171	6	Junta Homocinética Monroe	junta-homocinetica-monroe	Monroe	Transmissão	Junta Homocinética Monroe, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/homocinetica-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
172	3	Palheta Limpador Bosch	palheta-limpador-bosch	Bosch	Acessórios	Palheta Limpador Bosch, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/palheta-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
173	7	Coifa de Direção Heliar	coifa-de-direcao-heliar	Heliar	Direção	Coifa de Direção Heliar, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/coifa-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
174	2	Kit Amortecedores Valeo	kit-amortecedores-valeo	Valeo	Suspensão	Kit Amortecedores Valeo, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/amortecedor-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
175	7	Tambor de Freio Sachs	tambor-de-freio-sachs	Sachs	Freios	Tambor de Freio Sachs, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/tambor-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
176	5	Filtro de Ar Cofap	filtro-de-ar-cofap	Cofap	Motor	Filtro de Ar Cofap, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/filtro-ar-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
177	3	Bateria 70Ah Bosch	bateria-70ah-bosch	Bosch	Elétrica	Bateria 70Ah Bosch, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bateria-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
178	8	Reservatório de Água Cofap	reservatorio-de-agua-cofap	Cofap	Arrefecimento	Reservatório de Água Cofap, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/reservatorio-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
180	1	Kit Ferramentas Varga	kit-ferramentas-varga	Varga	Acessórios	Kit Ferramentas Varga, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/ferramentas-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
181	3	Bomba de Direção Hidráulica Mahle Linha Leve	bomba-de-direcao-hidraulica-mahle-linha-leve	Mahle	Direção	Bomba de Direção Hidráulica Mahle, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bomba-direcao-2.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
182	6	Coxim do Motor Gates Premium	coxim-do-motor-gates-premium	Gates	Suspensão	Coxim do Motor Gates, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/coxim-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
183	3	Cilindro de Roda Sachs	cilindro-de-roda-sachs	Sachs	Freios	Cilindro de Roda Sachs, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/cilindro-roda-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
184	8	Kit Correia Dentada SKF Original	kit-correia-dentada-skf-original	SKF	Motor	Kit Correia Dentada SKF, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/correia-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
185	2	Alternador SKF	alternador-skf	SKF	Elétrica	Alternador SKF, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/alternador-2.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
186	3	Radiador Heliar Premium	radiador-heliar-premium	Heliar	Arrefecimento	Radiador Heliar, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/radiador-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
187	3	Junta Homocinética Denso	junta-homocinetica-denso	Denso	Transmissão	Junta Homocinética Denso, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/homocinetica-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
188	5	Antena Automotiva Heliar HD	antena-automotiva-heliar-hd	Heliar	Acessórios	Antena Automotiva Heliar, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/antena-2.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
189	1	Coifa de Direção SKF	coifa-de-direcao-skf	SKF	Direção	Coifa de Direção SKF, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/coifa-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
1	1	Amortecedor Dianteiro Cofap	amortecedor-dianteiro-cofap	Cofap	Suspensão	Amortecedor dianteiro a gás, alta durabilidade e conforto para uso urbano. Vendido por unidade.	/images/products/amortecedor-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
6	7	Amortecedor Traseiro Magneti Marelli	amortecedor-traseiro-magneti-marelli	Magneti Marelli	Suspensão	Amortecedor Traseiro Magneti Marelli, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/amortecedor-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
16	6	Filtro de Ar Delphi	filtro-de-ar-delphi	Delphi	Motor	Filtro de Ar Delphi, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/filtro-ar-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
25	4	Alternador Heliar HD	alternador-heliar-hd	Heliar	Elétrica	Alternador Heliar, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/alternador-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
26	2	Reservatório de Água Gates HD	reservatorio-de-agua-gates-hd	Gates	Arrefecimento	Reservatório de Água Gates, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/reservatorio-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
34	6	Eletroventilador Fram	eletroventilador-fram	Fram	Arrefecimento	Eletroventilador Fram, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/ventilador-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
43	5	Kit Embreagem Continental Reforçado	kit-embreagem-continental-reforcado	Continental	Transmissão	Kit Embreagem Continental, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/embreagem-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
49	4	Bobina de Ignição Fram	bobina-de-ignicao-fram	Fram	Elétrica	Bobina de Ignição Fram, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bobina-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
54	1	Amortecedor Traseiro NGK	amortecedor-traseiro-ngk	NGK	Suspensão	Amortecedor Traseiro NGK, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/amortecedor-1.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
64	6	Tensor da Correia Monroe Reforçado	tensor-da-correia-monroe-reforcado	Monroe	Motor	Tensor da Correia Monroe, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/tensor-2.jpg	t	2026-11-14 12:39:12	2026-11-14 12:39:15	\N
72	8	Bomba de Combustível Fram	bomba-de-combustivel-fram	Fram	Motor	Bomba de Combustível Fram, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bomba-combustivel-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
79	3	Lonas de Freio Denso Série Ouro	lonas-de-freio-denso-serie-ouro	Denso	Freios	Lonas de Freio Denso, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/lona-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
191	1	Fluido de Freio Fram	fluido-de-freio-fram	Fram	Freios	Fluido de Freio Fram, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/fluido-freio-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
193	2	Lâmpada Farol Denso	lampada-farol-denso	Denso	Elétrica	Lâmpada Farol Denso, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/lampada-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
194	7	Mangueira do Radiador Denso Original	mangueira-do-radiador-denso-original	Denso	Arrefecimento	Mangueira do Radiador Denso, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/mangueira-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
195	6	Kit Embreagem Denso	kit-embreagem-denso	Denso	Transmissão	Kit Embreagem Denso, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/embreagem-2.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
196	1	Palheta Limpador Heliar	palheta-limpador-heliar	Heliar	Acessórios	Palheta Limpador Heliar, categoria Acessórios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/palheta-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
197	2	Caixa de Direção Bosch Linha Leve	caixa-de-direcao-bosch-linha-leve	Bosch	Direção	Caixa de Direção Bosch, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/caixa-direcao-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
198	6	Bucha da Bandeja Varga Série Ouro	bucha-da-bandeja-varga-serie-ouro	Varga	Suspensão	Bucha da Bandeja Varga, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bucha-2.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
199	4	Tambor de Freio Gates Reforçado	tambor-de-freio-gates-reforcado	Gates	Freios	Tambor de Freio Gates, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/tambor-2.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
200	4	Kit Correia Dentada Cofap	kit-correia-dentada-cofap	Cofap	Motor	Kit Correia Dentada Cofap, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/correia-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
89	5	Lâmpada Farol Cofap Série Ouro	lampada-farol-cofap-serie-ouro	Cofap	Elétrica	Lâmpada Farol Cofap, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/lampada-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
95	3	Pastilha de Freio SKF	pastilha-de-freio-skf	SKF	Freios	Pastilha de Freio SKF, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/pastilha-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
96	6	Bomba d'Água Bosch	bomba-dagua-bosch	Bosch	Motor	Bomba d'Água Bosch, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bomba-agua-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
103	8	Tambor de Freio Magneti Marelli Reforçado	tambor-de-freio-magneti-marelli-reforcado	Magneti Marelli	Freios	Tambor de Freio Magneti Marelli, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/tambor-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
115	5	Kit Embreagem Gates	kit-embreagem-gates	Gates	Transmissão	Kit Embreagem Gates, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/embreagem-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
119	3	Kit Freio Traseiro Monroe	kit-freio-traseiro-monroe	Monroe	Freios	Kit Freio Traseiro Monroe, categoria Freios. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/kit-freio-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
125	1	Bomba de Direção Hidráulica Denso Linha Leve	bomba-de-direcao-hidraulica-denso-linha-leve	Denso	Direção	Bomba de Direção Hidráulica Denso, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/bomba-direcao-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
137	1	Sensor de Rotação Bosch Reforçado	sensor-de-rotacao-bosch-reforcado	Bosch	Elétrica	Sensor de Rotação Bosch, categoria Elétrica. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/sensor-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
142	3	Terminal de Direção TRW	terminal-de-direcao-trw	TRW	Suspensão	Terminal de Direção TRW, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/terminal-direcao-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
146	8	Ventilador do Radiador Mahle	ventilador-do-radiador-mahle	Mahle	Arrefecimento	Ventilador do Radiador Mahle, categoria Arrefecimento. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/ventilador-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
157	6	Caixa de Direção Continental	caixa-de-direcao-continental	Continental	Direção	Caixa de Direção Continental, categoria Direção. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/caixa-direcao-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
166	3	Barra Estabilizadora Nakata	barra-estabilizadora-nakata	Nakata	Suspensão	Barra Estabilizadora Nakata, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/barra-estabilizadora-1.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
168	8	Filtro de Óleo Magneti Marelli Série Ouro	filtro-de-oleo-magneti-marelli-serie-ouro	Magneti Marelli	Motor	Filtro de Óleo Magneti Marelli, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/filtro-oleo-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
179	1	Junta Homocinética Nakata Série Ouro	junta-homocinetica-nakata-serie-ouro	Nakata	Transmissão	Junta Homocinética Nakata, categoria Transmissão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/homocinetica-2.jpg	t	2026-11-14 12:39:13	2026-11-14 12:39:15	\N
190	4	Barra Estabilizadora Valeo	barra-estabilizadora-valeo	Valeo	Suspensão	Barra Estabilizadora Valeo, categoria Suspensão. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/barra-estabilizadora-2.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
192	2	Tensor da Correia Cofap Série Ouro	tensor-da-correia-cofap-serie-ouro	Cofap	Motor	Tensor da Correia Cofap, categoria Motor. Peça de reposição com procedência garantida, ideal para manutenção preventiva e corretiva. Consulte a compatibilidade com o seu veículo.	/images/products/tensor-1.jpg	t	2026-11-14 12:39:14	2026-11-14 12:39:15	\N
\.


--
-- TOC entry 5231 (class 0 OID 16972)
-- Dependencies: 224
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
TftpWDjBd3OfjIPdrCRbmBkmgSoNcz1nGO0AcpyE	1	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36	YTo2OntzOjY6Il90b2tlbiI7czo0MDoiMjdIUEtSblJBVzBwZkVlRUQ1UXlhZVhOUWhTeG1CUlpmTzRpR3NrTSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/cHJldmlldz0xIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjY0OiJmYWU0NmNmYmU4ZTg4ODkwOTZmYzZlZmJhYTY4MGRmNTczZWMwNjEyZGYzOGQ4MzdhYzg1NmU0ODViZjg3YTYxIjtzOjE5OiJhZG1pbl9wcmV2aWV3X3N0b3JlIjtiOjE7fQ==	1794791404
mW9QW05jSj6NKaBJpoVuYh6ZB96izFom0DpTGso5	\N	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36	YToyOntzOjY6Il90b2tlbiI7czo0MDoiODhxMkpUNEppdHc0aFFRaDRTblBjVjRHTzVKNFFXM09wTDFVTXZVSyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1794791248
\.


--
-- TOC entry 5229 (class 0 OID 16949)
-- Dependencies: 222
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, role, document, phone, zip_code, address_street, address_number, address_complement, address_neighborhood, address_city, address_state) FROM stdin;
3	Cliente de Teste	cliente@autostock.test	\N	$2y$12$h77dkt2KX4Bp4BOtf0KScOWcy1mGNfwqh.PkquDtLObnodzoScjO2	\N	2026-11-14 13:33:22	2026-11-14 13:33:22	cliente	12345678901	(19) 99999-0000	13450000	Rua das Peças	100	\N	Centro	Santa Bárbara D'Oeste	SP
1	Administrador AutoStock	admin@autostock.test	\N	$2y$12$yvnJstPrlKZM3FILiDap.O4B0hBLZAYonamVFBap5jSsGHqi5TGuq	fNJ0520ZbezEm9DUdXPhbN8Gd75Cs4cbA0N3FheDd0XksgTKyKLWEMPNyZP3	2026-11-14 12:39:12	2026-11-14 12:39:12	admin	\N	\N	\N	\N	\N	\N	\N	\N	\N
4	Yasmin Magalhaes Pessoa	Yasminmagalhaes124@gmail.com	\N	$2y$12$yH9gX7dWWm07CMzWy9UyL.2s5j8ZY6l3qw2GxV7EbGT7KBtY/RNwO	\N	2026-11-15 22:06:01	2026-11-15 22:06:01	cliente	51166199584	199938567965	\N	\N	\N	\N	\N	\N	\N
\.


--
-- TOC entry 5246 (class 0 OID 17130)
-- Dependencies: 239
-- Data for Name: variacoes_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.variacoes_produto (id, product_id, sku, name, price, compare_at_price, stock, weight_grams, length_cm, width_cm, height_cm, active, created_at, updated_at, deleted_at) FROM stdin;
2	1	AMORT-COF-ESQ	Lado Esquerdo	389.90	449.90	8	3200	60	18	18	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
3	2	PAST-BOSCH-DIANT	Eixo Dianteiro	219.90	\N	20	1400	25	18	8	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
4	2	PAST-BOSCH-TRAS	Eixo Traseiro	189.90	\N	15	1100	22	16	7	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
5	3	FILT-MANN-71295	Único	49.90	59.90	50	320	12	9	9	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
6	4	BAT-MOURA-60	60Ah	549.90	629.90	6	14500	30	20	22	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
7	5	PALH-BOSCH-AERO	Par 24" + 18"	129.90	\N	30	650	70	8	6	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
8	6	MAGN-00001	Lado Direito	447.08	\N	23	1762	43	20	18	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
9	6	MAGN-00002	Esportivo	413.02	470.84	32	6687	78	28	24	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
10	7	SKF-00003	Reforçado	450.46	\N	55	4417	21	30	14	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
11	7	SKF-00004	Original	436.67	\N	46	6095	30	17	8	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
12	7	SKF-00005	HD	455.05	\N	2	2822	20	23	5	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
13	8	MAHL-00006	Traseiro	402.08	498.58	37	2269	39	27	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
14	8	MAHL-00007	Dianteiro	356.56	\N	63	1314	39	15	10	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
15	8	MAHL-00008	Lado Direito	390.70	496.19	30	2984	36	26	11	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
16	9	SKF-00009	Dianteiro	730.26	\N	54	5137	23	24	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
17	9	SKF-00010	Traseiro	796.65	\N	78	7459	29	27	23	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
18	9	SKF-00011	Esportivo	789.27	891.88	66	10954	38	28	23	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
19	10	CONT-00012	Original	682.10	757.13	1	1273	76	60	23	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
20	10	CONT-00013	Traseiro	675.42	783.49	38	4548	49	44	29	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
21	11	NGK-00014	Traseiro	458.49	\N	0	7146	30	30	27	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
22	11	NGK-00015	Reforçado	521.89	\N	46	1112	42	33	22	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
23	11	NGK-00016	Original	502.38	577.74	35	11721	42	37	21	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
24	12	VALE-00017	Original	217.28	267.25	38	1819	65	19	6	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
25	12	VALE-00018	Esportivo	237.23	275.19	14	1105	33	28	10	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
26	13	BOSC-00019	Lado Direito	122.70	\N	80	1380	58	37	21	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
27	13	BOSC-00020	Reforçado	118.15	\N	0	5058	40	27	21	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
28	14	VARG-00021	Dianteiro	538.75	\N	79	3137	53	25	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
29	14	VARG-00022	Esportivo	555.59	688.93	35	6242	69	17	14	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
30	15	MONR-00023	Dianteiro	510.49	556.43	59	5227	21	20	10	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
31	15	MONR-00024	HD	495.48	\N	39	3893	28	20	14	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
32	15	MONR-00025	Lado Direito	475.46	\N	0	787	27	20	7	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
33	16	DELP-00026	Único	325.22	\N	54	1359	36	30	17	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
34	17	SKF-00027	Único	102.86	\N	46	14315	20	19	28	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
35	18	CONT-00028	Original	503.53	\N	32	1692	40	40	18	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
36	18	CONT-00029	Lado Direito	498.23	\N	5	1883	76	33	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
37	18	CONT-00030	Dianteiro	519.43	\N	47	1088	43	40	24	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
38	19	CONT-00031	Traseiro	356.92	\N	61	2288	40	26	24	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
39	19	CONT-00032	Lado Direito	339.92	424.90	22	7864	36	33	24	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
40	19	CONT-00033	Reforçado	343.32	374.22	67	4628	42	40	25	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
41	20	CONT-00034	Único	137.47	159.47	0	383	39	24	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
42	21	DENS-00035	Dianteiro	902.44	1055.85	32	1141	50	23	21	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
43	21	DENS-00036	Lado Direito	885.57	\N	73	6935	65	37	26	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
44	22	COFA-00037	Único	209.10	\N	46	2079	69	16	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
45	23	GATE-00038	HD	248.12	297.74	72	1705	32	23	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
46	23	GATE-00039	Esportivo	266.21	287.51	68	995	32	21	8	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
47	23	GATE-00040	Traseiro	266.21	\N	15	3128	29	25	8	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
48	24	NAKA-00041	Lado Direito	353.46	\N	0	2009	22	29	9	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
49	24	NAKA-00042	Esportivo	346.39	\N	72	3246	29	11	19	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
50	25	HELI-00043	Único	809.36	938.86	0	10462	39	20	30	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
51	26	GATE-00044	Único	745.06	871.72	69	4447	52	35	17	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
52	27	MANN-00045	Lado Direito	1088.28	\N	41	3862	36	32	18	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
53	27	MANN-00046	Reforçado	1152.93	\N	68	8325	40	25	20	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
54	28	MOUR-00047	Traseiro	40.17	\N	78	1672	41	12	7	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
55	28	MOUR-00048	Lado Esquerdo	40.99	\N	37	1349	72	20	8	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
56	28	MOUR-00049	Dianteiro	40.17	44.19	19	1510	32	15	12	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
57	29	MAGN-00050	Único	741.22	\N	67	3058	70	32	28	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
58	30	MAHL-00051	Único	754.80	928.40	1	8447	44	18	17	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
59	31	VARG-00052	Esportivo	349.33	426.18	14	3502	23	23	14	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
60	31	VARG-00053	HD	325.81	351.87	75	5223	23	27	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
61	31	VARG-00054	Original	322.45	406.29	77	494	29	28	5	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
62	32	HELI-00055	Único	337.87	429.09	53	886	30	20	23	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
63	33	COFA-00056	Lado Esquerdo	280.65	308.72	0	9000	20	18	19	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
64	33	COFA-00057	Reforçado	294.54	350.50	0	12021	37	22	26	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
65	34	FRAM-00058	Esportivo	816.78	\N	0	3625	74	45	13	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
66	34	FRAM-00059	Lado Esquerdo	884.84	999.87	20	1772	40	33	22	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
67	35	BOSC-00060	Dianteiro	962.59	\N	52	7951	35	35	24	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
68	35	BOSC-00061	Traseiro	1010.72	1101.68	50	2894	45	36	17	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
69	35	BOSC-00062	Esportivo	1010.72	1283.61	76	10031	41	40	25	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
70	36	MAGN-00063	Lado Esquerdo	59.21	\N	71	1523	44	29	14	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
71	36	MAGN-00064	Esportivo	62.76	71.55	39	330	71	23	6	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
72	36	MAGN-00065	HD	61.58	78.82	25	2203	33	23	10	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
73	37	DELP-00066	Traseiro	484.11	542.20	4	5140	33	27	26	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
74	37	DELP-00067	Lado Esquerdo	489.00	\N	59	3580	44	23	22	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
75	38	FRAM-00068	Lado Direito	231.59	273.28	9	1805	77	20	18	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
76	38	FRAM-00069	Traseiro	234.00	259.74	57	3493	68	17	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
77	38	FRAM-00070	Reforçado	246.06	\N	33	7585	49	27	19	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
78	39	FRAM-00071	Lado Esquerdo	113.73	\N	14	5739	22	29	9	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
79	39	FRAM-00072	Original	103.00	124.63	6	563	30	19	10	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
80	40	BOSC-00073	Esportivo	374.04	\N	17	461	15	21	18	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
81	40	BOSC-00074	HD	377.60	\N	20	4175	22	29	25	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
82	40	BOSC-00075	Traseiro	345.54	442.29	23	2993	33	17	22	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
83	41	MAHL-00076	Único	1137.39	1285.25	73	10917	22	29	26	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
84	42	VALE-00077	Esportivo	788.93	\N	71	1809	50	47	13	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
85	42	VALE-00078	HD	820.49	\N	0	1570	79	49	20	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
86	42	VALE-00079	Lado Direito	820.49	1017.41	0	3453	50	39	29	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
87	43	CONT-00080	Lado Esquerdo	105.52	\N	17	6970	38	40	17	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
88	43	CONT-00081	Esportivo	99.26	113.16	61	6252	39	32	27	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
89	44	MAGN-00082	Esportivo	162.66	\N	0	2194	32	27	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
90	44	MAGN-00083	Dianteiro	171.22	\N	53	1554	45	24	6	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
91	44	MAGN-00084	Original	178.07	215.46	43	2036	77	25	7	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
92	45	NGK-00085	Reforçado	350.84	\N	4	6212	51	31	26	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
93	45	NGK-00086	Traseiro	361.81	\N	75	4312	68	31	28	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
94	45	NGK-00087	Lado Esquerdo	350.84	\N	45	4446	42	34	21	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
95	46	NAKA-00088	Reforçado	684.28	\N	0	5439	78	26	17	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
96	46	NAKA-00089	HD	724.93	\N	4	8557	74	16	16	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
97	47	BOSC-00090	Reforçado	470.11	\N	33	4426	21	15	8	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
98	47	BOSC-00091	Lado Direito	474.90	550.88	66	2447	20	18	8	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
99	48	SKF-00092	Dianteiro	128.20	153.84	12	3712	32	22	17	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
100	48	SKF-00093	Traseiro	130.72	143.79	38	3220	39	11	8	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
101	49	FRAM-00094	Único	572.08	617.85	78	4666	28	26	21	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
102	50	MAGN-00095	Traseiro	524.05	\N	26	3132	73	59	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
103	50	MAGN-00096	Lado Direito	504.46	580.13	12	4832	76	56	13	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
104	50	MAGN-00097	Reforçado	470.18	526.60	20	4277	88	38	23	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
105	51	COFA-00098	Dianteiro	437.26	\N	0	3369	45	35	18	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
106	51	COFA-00099	Lado Direito	472.60	\N	6	7806	49	27	24	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
107	51	COFA-00100	Reforçado	437.26	520.34	22	6096	34	39	16	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
108	52	DELP-00101	Dianteiro	222.21	\N	44	751	64	29	10	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
109	52	DELP-00102	HD	226.69	\N	11	2223	33	12	5	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
110	53	COFA-00103	Único	721.27	\N	29	3336	40	40	25	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
111	54	NGK-00104	HD	274.62	\N	71	4505	54	21	12	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
112	54	NGK-00105	Esportivo	277.37	\N	0	5498	70	24	23	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
113	54	NGK-00106	Dianteiro	271.87	301.78	52	1723	53	15	24	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
114	55	MONR-00107	Único	407.45	\N	0	3073	22	25	13	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
115	56	MANN-00108	Lado Direito	452.64	\N	14	4119	32	29	8	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
116	56	MANN-00109	Esportivo	448.33	\N	39	1327	39	10	22	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
117	57	BOSC-00110	Reforçado	143.48	\N	21	12071	32	28	18	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
118	57	BOSC-00111	Lado Esquerdo	145.01	184.16	58	14453	33	24	21	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
119	57	BOSC-00112	Lado Direito	151.11	\N	53	14461	40	30	22	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
120	58	MANN-00113	HD	575.13	\N	60	1848	47	34	28	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
121	58	MANN-00114	Lado Esquerdo	598.61	712.35	0	3475	68	38	14	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
122	59	SACH-00115	Lado Direito	1351.76	\N	26	1771	48	30	25	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
123	59	SACH-00116	Original	1404.26	1516.60	50	2394	30	28	30	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
124	59	SACH-00117	Dianteiro	1312.39	1561.74	12	10573	50	31	30	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
125	60	MANN-00118	Único	113.61	136.33	9	233	80	24	11	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
126	61	MAHL-00119	HD	859.19	1039.62	62	5880	35	33	20	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
127	61	MAHL-00120	Dianteiro	843.28	952.91	0	3291	33	36	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
128	62	HELI-00121	Esportivo	678.31	773.27	26	4020	70	16	23	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
129	62	HELI-00122	Traseiro	691.23	\N	22	6759	43	30	20	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
130	62	HELI-00123	Reforçado	671.85	\N	32	5155	68	29	22	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
131	63	HELI-00124	Dianteiro	633.65	735.03	61	6361	27	22	8	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
132	63	HELI-00125	Lado Esquerdo	691.25	850.24	69	2022	31	21	6	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
133	63	HELI-00126	Reforçado	684.85	\N	75	1456	22	18	14	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
134	64	MONR-00127	Lado Esquerdo	424.59	484.03	51	1587	27	26	13	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
135	64	MONR-00128	HD	469.29	\N	72	279	30	14	9	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
136	65	MOUR-00129	Único	1199.16	\N	10	14195	35	23	16	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
137	66	TRW-00130	Reforçado	734.74	918.43	60	3751	71	38	21	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
138	66	TRW-00131	Esportivo	741.87	934.76	1	3407	41	57	25	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
139	67	MAHL-00132	Único	1142.96	1382.98	39	4994	47	38	23	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
140	68	VARG-00133	Traseiro	233.97	\N	73	1891	50	29	15	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
141	68	VARG-00134	Original	229.10	\N	29	1980	63	14	16	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
142	69	MAHL-00135	Único	436.67	\N	37	8307	35	31	30	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
143	70	DENS-00136	Original	720.29	828.33	23	5997	72	20	24	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
144	70	DENS-00137	Esportivo	757.42	886.18	77	5776	67	18	25	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
145	70	DENS-00138	Dianteiro	750.00	922.50	62	2870	65	24	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
146	71	VALE-00139	Único	174.71	\N	30	1517	25	15	9	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
147	72	FRAM-00140	Original	398.74	458.55	0	2632	39	29	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
148	72	FRAM-00141	Traseiro	387.13	437.46	40	572	24	12	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
149	72	FRAM-00142	Esportivo	367.77	\N	8	2258	28	17	20	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
150	73	MAHL-00143	HD	138.13	\N	18	9243	27	28	24	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
151	73	MAHL-00144	Lado Esquerdo	143.95	169.86	14	8005	30	25	24	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
152	74	DELP-00145	Único	834.95	\N	14	4996	63	42	12	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
153	75	FRAM-00146	Reforçado	991.84	\N	7	7668	38	31	30	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
154	75	FRAM-00147	Lado Direito	1032.75	\N	32	7810	48	30	21	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
155	76	NGK-00148	Esportivo	185.08	212.84	0	764	30	18	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
156	76	NGK-00149	Dianteiro	174.60	200.79	40	2359	34	11	8	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
157	77	SACH-00150	Dianteiro	421.99	\N	38	7268	69	20	17	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
158	77	SACH-00151	Lado Esquerdo	393.03	491.29	55	6736	51	40	17	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
159	78	SACH-00152	Esportivo	688.35	867.32	19	7490	43	23	25	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
160	78	SACH-00153	Lado Esquerdo	701.72	\N	67	8879	52	22	21	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
161	79	DENS-00154	Lado Esquerdo	570.37	684.44	72	1498	26	27	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
162	79	DENS-00155	Esportivo	542.95	640.68	23	3394	22	17	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
163	80	MAGN-00156	Original	291.47	\N	63	281	27	11	10	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
164	80	MAGN-00157	Esportivo	291.47	\N	50	1370	21	26	9	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
165	81	VALE-00158	Único	189.64	\N	54	11819	27	28	24	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
166	82	MOUR-00159	Original	359.49	442.17	5	2208	54	59	22	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
167	82	MOUR-00160	Reforçado	380.85	\N	9	3130	71	34	30	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
168	82	MOUR-00161	Lado Esquerdo	355.93	\N	27	2393	55	32	29	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
169	83	GATE-00162	Único	243.50	\N	35	10839	38	27	22	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
170	84	DELP-00163	Traseiro	264.31	327.74	3	1916	43	16	10	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
171	84	DELP-00164	Esportivo	275.44	\N	3	2098	39	21	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
172	84	DELP-00165	HD	286.57	338.15	14	1256	43	15	16	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
173	85	GATE-00166	Traseiro	271.67	317.85	69	5343	34	40	20	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
174	85	GATE-00167	HD	274.33	\N	0	3387	46	37	24	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
175	85	GATE-00168	Lado Esquerdo	276.99	321.31	28	4123	34	38	20	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
176	86	GATE-00169	Único	355.97	384.45	0	1804	77	29	13	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
177	87	DELP-00170	Traseiro	242.16	\N	73	3846	34	25	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
178	87	DELP-00171	Esportivo	259.46	295.78	49	932	27	28	6	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
179	87	DELP-00172	Lado Esquerdo	232.27	\N	36	6036	27	16	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
180	88	HELI-00173	HD	129.69	\N	37	2979	28	22	22	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
181	88	HELI-00174	Reforçado	137.40	171.75	18	4105	31	13	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
182	89	COFA-00175	Dianteiro	265.29	\N	17	9164	29	15	21	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
183	89	COFA-00176	Original	262.69	\N	1	10862	34	18	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
184	90	FRAM-00177	Lado Direito	249.42	\N	20	5822	75	38	12	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
185	90	FRAM-00178	Dianteiro	267.80	\N	17	3183	51	58	20	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
186	91	SACH-00179	Lado Direito	1113.38	1380.59	24	2014	37	26	20	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
187	91	SACH-00180	Reforçado	1230.58	\N	71	4568	44	37	24	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
188	92	MONR-00181	Lado Esquerdo	220.61	251.50	31	1502	66	14	6	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
189	92	MONR-00182	Lado Direito	212.04	\N	4	2478	72	28	8	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
190	92	MONR-00183	Traseiro	207.75	234.76	40	729	67	20	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
191	93	CONT-00184	Esportivo	617.41	\N	0	3070	36	26	25	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
192	93	CONT-00185	Lado Direito	605.06	\N	4	3321	44	31	22	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
193	93	CONT-00186	Traseiro	605.06	707.92	38	6724	35	34	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
194	94	NGK-00187	Único	406.28	\N	62	5090	66	29	21	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
195	95	SKF-00188	Lado Esquerdo	94.78	\N	42	6382	21	24	5	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
196	95	SKF-00189	Dianteiro	93.79	\N	6	4080	34	27	10	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
197	96	BOSC-00190	Único	81.84	\N	52	448	40	27	12	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
198	97	HELI-00191	Reforçado	658.66	750.87	62	7016	40	20	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
199	97	HELI-00192	Lado Esquerdo	686.10	775.29	72	7149	30	24	15	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
200	98	DENS-00193	Único	788.86	867.75	30	2548	89	58	29	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
201	99	SKF-00194	Lado Esquerdo	944.80	1181.00	53	5898	47	33	21	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
202	99	SKF-00195	Dianteiro	935.80	\N	57	6340	35	25	16	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
203	100	MAHL-00196	Esportivo	145.88	176.51	0	644	38	29	9	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
204	100	MAHL-00197	Lado Direito	145.88	169.22	17	2008	36	19	7	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
205	100	MAHL-00198	Dianteiro	132.25	\N	63	2048	54	15	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
206	101	DENS-00199	Reforçado	1121.45	\N	42	5910	69	27	26	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
207	101	DENS-00200	Lado Esquerdo	1121.45	\N	54	7529	49	37	20	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
208	101	DENS-00201	Dianteiro	1132.78	\N	16	6741	45	33	25	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
209	102	FRAM-00202	Traseiro	668.08	\N	39	8551	43	19	25	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
210	102	FRAM-00203	Lado Esquerdo	668.08	\N	68	7218	46	23	21	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
211	103	MAGN-00204	Único	38.98	49.11	29	5096	23	25	9	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
212	104	VALE-00205	HD	479.79	\N	40	1842	17	28	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
213	104	VALE-00206	Traseiro	452.63	556.73	60	358	17	19	17	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
214	105	MAGN-00207	Lado Direito	946.35	1192.40	36	1288	39	28	23	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
215	105	MAGN-00208	Dianteiro	881.40	1066.49	73	7262	26	18	22	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
216	106	NGK-00209	Esportivo	265.77	316.27	30	4952	65	46	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
217	106	NGK-00210	Original	284.37	318.49	15	1076	66	32	10	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
218	106	NGK-00211	Reforçado	252.48	297.93	66	5957	62	33	22	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
219	107	MAGN-00212	Único	1338.67	1512.70	43	9516	43	37	27	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
220	108	MOUR-00213	HD	271.21	325.45	45	228	77	30	8	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
221	108	MOUR-00214	Esportivo	271.21	314.60	0	2041	34	22	13	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
222	108	MOUR-00215	Lado Esquerdo	301.97	\N	27	2207	52	17	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
223	109	NGK-00216	Dianteiro	1051.03	1187.66	56	4628	50	39	27	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
224	109	NGK-00217	Esportivo	1137.72	\N	42	8236	46	36	21	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
225	109	NGK-00218	Lado Esquerdo	1051.03	\N	77	7775	48	31	26	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
226	110	NAKA-00219	Reforçado	615.81	763.60	0	2422	74	19	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
227	110	NAKA-00220	Original	615.81	\N	67	7397	74	16	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
228	110	NAKA-00221	HD	634.10	710.19	59	8055	61	20	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
229	111	MOUR-00222	Traseiro	408.82	\N	76	1178	22	27	8	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
230	111	MOUR-00223	Lado Esquerdo	366.40	\N	0	2254	29	25	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
231	111	MOUR-00224	HD	381.82	\N	21	5303	33	30	15	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
232	112	MAGN-00225	Reforçado	415.87	\N	16	1522	17	13	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
233	112	MAGN-00226	Dianteiro	436.66	484.69	50	3411	32	26	12	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
234	112	MAGN-00227	Esportivo	395.08	\N	7	2606	28	17	16	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
235	113	MAHL-00228	Único	794.57	\N	77	8889	28	26	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
236	114	MANN-00229	Único	607.88	668.67	15	5292	44	48	12	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
237	115	GATE-00230	Único	212.60	\N	57	10293	40	30	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
238	116	FRAM-00231	HD	267.85	291.96	0	2219	62	17	5	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
239	116	FRAM-00232	Dianteiro	276.05	\N	68	324	78	30	16	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
240	117	SACH-00233	Único	655.50	\N	0	6243	68	33	16	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
241	118	SKF-00234	Traseiro	489.07	\N	17	5875	80	21	24	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
242	118	SKF-00235	Esportivo	493.82	\N	0	8293	72	27	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
243	119	MONR-00236	Dianteiro	629.29	\N	48	6387	33	26	7	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
244	119	MONR-00237	HD	654.97	\N	36	826	30	30	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
245	119	MONR-00238	Lado Esquerdo	687.08	790.14	10	928	20	25	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
246	120	MANN-00239	Único	389.20	443.69	27	822	40	28	16	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
247	121	NGK-00240	Único	390.84	\N	40	2488	24	18	15	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
248	122	SKF-00241	Único	162.12	194.54	47	5786	89	36	16	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
249	123	TRW-00242	Único	167.52	184.27	19	4115	31	34	24	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
250	124	VARG-00243	Único	198.20	\N	68	1501	69	17	5	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
251	125	DENS-00244	Lado Esquerdo	234.69	\N	12	7623	40	22	28	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
252	125	DENS-00245	Reforçado	225.57	266.17	38	1170	48	37	22	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
253	126	CONT-00246	HD	802.00	986.46	27	4845	74	26	21	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
254	126	CONT-00247	Lado Direito	887.32	1073.66	45	7725	59	23	25	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
255	127	COFA-00248	Traseiro	516.51	\N	24	3144	35	23	13	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
256	127	COFA-00249	Dianteiro	547.82	668.34	66	3466	22	16	5	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
257	127	COFA-00250	Lado Direito	506.08	\N	6	4573	32	17	7	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
258	128	DENS-00251	HD	280.87	\N	40	684	35	28	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
259	128	DENS-00252	Original	319.72	\N	1	3963	23	28	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
260	129	CONT-00253	Reforçado	862.46	983.20	1	14657	33	21	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
261	129	CONT-00254	Traseiro	828.97	\N	77	9159	24	15	16	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
262	130	CONT-00255	Lado Esquerdo	526.97	\N	49	5538	73	53	16	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
263	130	CONT-00256	Lado Direito	537.20	682.24	65	3674	72	60	10	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
264	131	MAGN-00257	Único	744.13	907.84	72	1336	32	28	27	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
265	132	NAKA-00258	Original	179.69	\N	51	2338	79	12	17	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
266	132	NAKA-00259	Dianteiro	187.03	\N	12	2402	33	20	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
267	133	MONR-00260	Único	230.62	279.05	9	1973	33	20	30	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
268	134	MAHL-00261	Dianteiro	499.85	\N	76	4640	71	18	25	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
269	134	MAHL-00262	Esportivo	552.47	\N	12	7672	79	28	23	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
270	134	MAHL-00263	Lado Esquerdo	526.16	\N	67	4389	51	23	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
271	135	NAKA-00264	Original	599.81	725.77	35	5699	26	23	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
272	135	NAKA-00265	Lado Direito	599.81	\N	55	5083	25	25	7	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
273	136	HELI-00266	Esportivo	162.64	\N	78	300	21	27	13	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
274	136	HELI-00267	Dianteiro	156.56	\N	0	2049	35	29	22	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
275	137	BOSC-00268	Dianteiro	432.27	\N	7	7851	39	28	30	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
276	137	BOSC-00269	HD	454.55	536.37	24	11779	39	28	26	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
277	137	BOSC-00270	Esportivo	472.38	547.96	22	2573	31	19	23	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
278	138	MANN-00271	Esportivo	482.09	602.61	53	2309	81	55	21	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
279	138	MANN-00272	Original	486.77	\N	27	2142	40	36	12	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
280	139	BOSC-00273	Único	822.40	953.98	61	5475	47	32	16	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
281	140	MONR-00274	Único	188.40	218.54	47	557	37	14	8	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
282	141	MANN-00275	Lado Esquerdo	656.37	827.03	65	2949	38	31	22	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
283	141	MANN-00276	Esportivo	594.45	719.28	56	6427	48	34	17	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
284	141	MANN-00277	Traseiro	600.64	756.81	70	3023	59	23	27	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
285	142	TRW-00278	Original	650.95	813.69	22	5570	55	25	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
286	142	TRW-00279	Dianteiro	671.08	\N	2	7657	62	30	12	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
287	142	TRW-00280	Esportivo	657.66	723.43	0	6238	72	25	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
288	143	SKF-00281	Original	326.15	\N	72	6311	33	23	7	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
289	143	SKF-00282	HD	339.07	\N	52	6428	20	27	6	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
290	143	SKF-00283	Lado Direito	326.15	\N	34	3809	31	30	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
291	144	DENS-00284	Único	322.95	384.31	49	585	23	18	24	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
292	145	COFA-00285	Lado Esquerdo	554.28	659.59	19	6227	35	24	29	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
293	145	COFA-00286	Traseiro	542.85	656.85	0	5030	36	20	20	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
294	145	COFA-00287	Esportivo	548.56	603.42	46	3365	39	25	28	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
295	146	MAHL-00288	Único	336.44	397.00	7	1638	61	39	13	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
296	147	MOUR-00289	Reforçado	290.28	339.63	45	1638	42	26	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
297	147	MOUR-00290	Dianteiro	293.37	331.51	36	9140	40	37	26	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
298	147	MOUR-00291	Original	305.72	333.23	29	1404	45	29	24	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
299	148	GATE-00292	Esportivo	253.39	278.73	39	2430	66	18	9	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
300	148	GATE-00293	Lado Esquerdo	274.29	\N	79	1008	32	16	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
301	148	GATE-00294	Dianteiro	250.78	293.41	52	1140	70	21	7	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
302	149	VARG-00295	Único	608.01	717.45	17	3316	35	31	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
303	150	DELP-00296	Único	528.94	\N	38	3039	41	30	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
304	151	GATE-00297	Único	671.46	\N	77	2916	28	25	10	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
305	152	SACH-00298	Reforçado	389.00	455.13	18	560	25	27	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
306	152	SACH-00299	Esportivo	392.97	503.00	0	1981	18	26	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
307	152	SACH-00300	Dianteiro	373.12	\N	38	2402	30	25	17	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
308	153	SKF-00301	Dianteiro	1370.15	1479.76	77	4438	38	24	29	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
309	153	SKF-00302	Original	1293.32	\N	48	14688	26	21	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
310	154	SKF-00303	Traseiro	459.24	\N	35	579	68	57	24	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
311	154	SKF-00304	Lado Direito	454.45	\N	57	5418	89	38	17	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
312	155	SACH-00305	Único	1001.44	\N	16	5721	39	27	26	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
313	156	MONR-00306	Dianteiro	180.64	214.96	4	1776	75	14	9	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
314	156	MONR-00307	HD	195.23	214.75	8	1382	47	22	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
315	157	CONT-00308	Esportivo	429.86	502.94	41	5124	58	25	25	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
316	157	CONT-00309	HD	388.92	423.92	12	6727	45	36	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
317	158	MONR-00310	Único	368.01	\N	49	6587	51	29	22	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
318	159	NGK-00311	Lado Esquerdo	372.12	\N	31	4028	24	24	12	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
319	159	NGK-00312	Dianteiro	415.20	\N	0	3581	31	28	7	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
320	160	VALE-00313	Original	47.03	54.55	0	2745	28	29	8	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
321	160	VALE-00314	Dianteiro	51.83	\N	0	2556	25	17	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
322	161	VARG-00315	Lado Direito	863.82	\N	35	2228	30	23	20	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
323	161	VARG-00316	HD	863.82	\N	18	5687	30	29	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
324	161	VARG-00317	Lado Esquerdo	891.09	1087.13	38	10083	37	27	27	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
325	162	SKF-00318	Lado Esquerdo	738.51	\N	25	1027	62	49	24	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
326	162	SKF-00319	Reforçado	731.55	914.44	39	1138	76	37	16	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
327	163	CONT-00320	Único	436.37	\N	76	9496	31	27	28	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
328	164	FRAM-00321	Dianteiro	248.79	303.52	0	1183	71	23	16	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
329	164	FRAM-00322	Reforçado	234.57	276.79	39	1748	31	30	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
330	164	FRAM-00323	Lado Esquerdo	229.83	275.80	25	1258	36	12	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
331	165	COFA-00324	Dianteiro	922.73	1134.96	46	7527	64	33	26	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
332	165	COFA-00325	Lado Esquerdo	1008.35	\N	43	2008	44	29	15	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
333	166	NAKA-00326	Único	358.51	\N	8	6891	58	22	25	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
334	167	HELI-00327	Original	141.83	\N	6	895	26	25	12	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
335	167	HELI-00328	HD	150.34	\N	8	3323	27	23	13	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
336	167	HELI-00329	Lado Esquerdo	138.99	\N	3	572	21	15	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
337	168	MAGN-00330	Dianteiro	181.24	\N	47	1284	22	24	23	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
338	168	MAGN-00331	HD	181.24	213.86	35	2695	34	17	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
339	169	NGK-00332	Lado Esquerdo	1218.10	\N	0	3910	23	24	17	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
340	169	NGK-00333	Esportivo	1218.10	\N	36	11043	38	17	20	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
341	169	NGK-00334	Dianteiro	1230.28	1451.73	0	4469	34	15	29	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
342	170	NAKA-00335	Único	84.03	93.27	56	1760	83	40	11	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
343	171	MONR-00336	Único	724.48	\N	25	10580	39	40	28	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
344	172	BOSC-00337	Esportivo	117.23	\N	55	488	74	16	13	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
345	172	BOSC-00338	Lado Direito	113.64	\N	52	1553	78	13	7	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
346	172	BOSC-00339	Dianteiro	113.64	\N	67	2393	41	18	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
347	173	HELI-00340	Esportivo	659.64	\N	38	1312	43	24	18	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
348	173	HELI-00341	Original	659.64	\N	52	4699	68	37	20	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
349	174	VALE-00342	Único	758.65	849.69	1	8944	46	22	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
350	175	SACH-00343	Único	525.06	661.58	29	4567	25	15	6	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
351	176	COFA-00344	Reforçado	438.73	\N	21	646	31	13	19	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
352	176	COFA-00345	Dianteiro	417.64	522.05	28	1923	22	23	14	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
353	176	COFA-00346	Lado Direito	417.64	\N	70	1068	39	19	12	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
354	177	BOSC-00347	Único	269.35	309.75	70	14416	38	29	15	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
355	178	COFA-00348	Esportivo	715.62	844.43	71	848	80	46	12	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
356	178	COFA-00349	Lado Esquerdo	753.28	926.53	37	5948	84	51	13	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
357	178	COFA-00350	Lado Direito	745.75	\N	30	3172	85	43	10	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
358	179	NAKA-00351	HD	449.22	\N	0	9704	35	33	30	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
359	179	NAKA-00352	Lado Direito	419.55	469.90	70	6466	36	34	17	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
360	179	NAKA-00353	Esportivo	411.08	\N	57	11427	38	40	29	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
361	180	VARG-00354	Único	182.01	212.95	6	415	76	16	7	t	2026-11-14 12:39:13	2026-11-14 12:39:13	\N
362	181	MAHL-00355	Único	546.25	\N	31	3198	63	31	27	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
363	182	GATE-00356	Traseiro	279.34	\N	7	1903	72	27	18	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
364	182	GATE-00357	HD	273.58	\N	23	8293	65	26	24	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
366	183	SACH-00359	Lado Direito	211.40	\N	20	3018	28	20	12	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
367	184	SKF-00360	Lado Direito	149.63	\N	23	2060	17	12	10	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
368	184	SKF-00361	HD	149.63	\N	63	609	15	12	11	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
369	184	SKF-00362	Lado Esquerdo	152.57	\N	1	1796	32	12	9	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
370	185	SKF-00363	Lado Esquerdo	200.85	241.02	14	8461	24	19	21	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
371	185	SKF-00364	Dianteiro	202.84	\N	32	1319	30	15	16	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
372	186	HELI-00365	Original	205.42	\N	77	512	83	40	19	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
373	186	HELI-00366	Esportivo	213.47	\N	1	1488	80	48	24	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
375	188	HELI-00368	Único	204.77	247.77	21	2197	68	21	7	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
377	190	VALE-00370	Reforçado	362.90	\N	80	5321	53	15	19	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
378	190	VALE-00371	Lado Esquerdo	377.86	457.21	64	8058	51	26	14	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
379	190	VALE-00372	Lado Direito	374.12	\N	13	8269	53	22	23	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
380	191	FRAM-00373	Lado Esquerdo	613.14	686.72	37	1470	34	16	5	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
381	191	FRAM-00374	Reforçado	578.43	665.19	0	920	24	17	11	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
382	192	COFA-00375	Original	344.64	\N	66	1425	31	20	10	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
383	192	COFA-00376	Reforçado	308.54	351.74	70	3549	31	11	22	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
384	192	COFA-00377	Esportivo	321.67	357.05	5	2866	30	22	11	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
385	193	DENS-00378	Único	414.18	505.30	31	11712	25	19	22	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
386	194	DENS-00379	Lado Direito	800.82	977.00	26	5483	88	42	23	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
387	194	DENS-00380	Traseiro	817.68	\N	43	3120	63	38	18	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
388	195	DENS-00381	Lado Esquerdo	1326.54	\N	18	3062	38	32	25	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
389	195	DENS-00382	Dianteiro	1299.74	\N	23	2397	40	34	21	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
390	196	HELI-00383	Traseiro	293.89	337.97	30	431	56	30	6	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
391	196	HELI-00384	Dianteiro	272.12	\N	54	619	47	24	5	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
392	196	HELI-00385	Lado Direito	258.51	315.38	55	1943	73	11	8	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
393	197	BOSC-00386	Reforçado	374.18	\N	64	2207	36	29	22	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
394	197	BOSC-00387	Dianteiro	355.66	\N	18	1413	57	35	18	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
395	197	BOSC-00388	Traseiro	363.07	\N	3	4216	41	33	17	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
396	198	VARG-00389	Único	691.16	\N	67	2774	56	18	21	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
397	199	GATE-00390	Único	469.26	563.11	48	4483	22	23	15	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
398	200	COFA-00391	Lado Esquerdo	94.54	\N	43	794	27	17	15	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
399	200	COFA-00392	Dianteiro	88.98	113.00	19	3535	32	23	20	t	2026-11-14 12:39:14	2026-11-14 12:39:14	\N
1	1	AMORT-COF-DIR	Lado Direito	389.90	449.90	11	3200	60	18	18	t	2026-11-14 12:39:12	2026-11-14 12:41:10	\N
376	189	SKF-00369	Único	949.81	\N	54	7866	69	26	18	t	2026-11-14 12:39:14	2026-11-14 12:59:56	\N
365	183	SACH-00358	Esportivo	219.78	\N	36	6218	20	21	7	t	2026-11-14 12:39:14	2026-11-14 12:59:56	\N
374	187	DENS-00367	Único	936.52	\N	36	11112	35	34	29	t	2026-11-14 12:39:14	2026-11-14 13:35:45	\N
\.


--
-- TOC entry 5240 (class 0 OID 17056)
-- Dependencies: 233
-- Data for Name: vendedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendedores (id, legal_name, trade_name, document, email, phone, zip_code, address_street, address_number, address_complement, address_neighborhood, address_city, address_state, gateway_receiver_id, active, created_at, updated_at, deleted_at) FROM stdin;
1	Cofap Autopeças Ltda	Cofap Center	12345678000190	vendas@cofapcenter.test	(11) 98888-1000	01310100	Avenida Paulista	1000	\N	Bela Vista	São Paulo	SP	recv_cofap_001	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
2	Bosch Parts Distribuidora Ltda	Bosch Parts	98765432000110	vendas@boschparts.test	(41) 97777-2000	80420000	Rua Comendador Araújo	500	\N	Centro	Curitiba	PR	recv_bosch_002	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
3	Mann Filter Brasil Ltda	Mann Filter Store	11222333000144	vendas@mannstore.test	(31) 96666-3000	30130010	Avenida Afonso Pena	800	\N	Centro	Belo Horizonte	MG	recv_mann_003	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
4	Grego e Pereira e Filhos Ltda	Gonçalves-Salgado	29.845.558/5329-83	mia58@example.org	(11) 92615-9540	45706706	Avenida Lilian	49	\N	d'Oeste	Porto Jorge	SP	recv_curestdgztda	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
5	Jimenes e Alves e Associados Ltda	Amaral e Filhos	31.378.801/8006-60	miguel.pontes@example.net	(11) 97134-8103	10842268	Av. Ziraldo	7	\N	d'Oeste	Wilson d'Oeste	PR	recv_elseufzgoyqq	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
6	Oliveira e Vila Ltda	Marin Comercial Ltda.	61.189.822/5744-90	jaqueline.medina@example.org	(11) 92078-7950	29375998	Av. Amaral	7316	\N	d'Oeste	São Graziela do Leste	PR	recv_oieaajmwydmf	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
7	Gomes e Filhos Ltda	Rosa e Filhos	82.631.027/1513-70	mascarenhas.renata@example.com	(11) 98542-6123	97182757	R. Ícaro	3	\N	do Sul	Eric do Leste	MG	recv_oyuhvogyydlf	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
8	Vega Comercial Ltda. Ltda	Tamoio Comercial Ltda.	40.343.783/7783-94	renata12@example.com	(11) 95199-2020	45094176	Travessa Stefany Alves	5305	\N	do Norte	Porto Jonas d'Oeste	RS	recv_dqtmhkykmtuu	t	2026-11-14 12:39:12	2026-11-14 12:39:12	\N
\.


--
-- TOC entry 5278 (class 0 OID 0)
-- Dependencies: 240
-- Name: atributos_variacao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.atributos_variacao_id_seq', 1196, true);


--
-- TOC entry 5279 (class 0 OID 0)
-- Dependencies: 242
-- Name: compatibilidades_produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.compatibilidades_produto_id_seq', 536, true);


--
-- TOC entry 5280 (class 0 OID 0)
-- Dependencies: 246
-- Name: envios_pedido_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.envios_pedido_id_seq', 366, true);


--
-- TOC entry 5281 (class 0 OID 0)
-- Dependencies: 230
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 5282 (class 0 OID 0)
-- Dependencies: 248
-- Name: itens_pedido_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.itens_pedido_id_seq', 401, true);


--
-- TOC entry 5283 (class 0 OID 0)
-- Dependencies: 227
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 5284 (class 0 OID 0)
-- Dependencies: 219
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 16, true);


--
-- TOC entry 5285 (class 0 OID 0)
-- Dependencies: 234
-- Name: modelos_veiculo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.modelos_veiculo_id_seq', 17, true);


--
-- TOC entry 5286 (class 0 OID 0)
-- Dependencies: 250
-- Name: pagamentos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagamentos_id_seq', 366, true);


--
-- TOC entry 5287 (class 0 OID 0)
-- Dependencies: 244
-- Name: pedidos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedidos_id_seq', 204, true);


--
-- TOC entry 5288 (class 0 OID 0)
-- Dependencies: 236
-- Name: produtos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produtos_id_seq', 200, true);


--
-- TOC entry 5289 (class 0 OID 0)
-- Dependencies: 221
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- TOC entry 5290 (class 0 OID 0)
-- Dependencies: 238
-- Name: variacoes_produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.variacoes_produto_id_seq', 399, true);


--
-- TOC entry 5291 (class 0 OID 0)
-- Dependencies: 232
-- Name: vendedores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendedores_id_seq', 8, true);


--
-- TOC entry 5031 (class 2606 OID 17168)
-- Name: atributos_variacao atributos_variacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atributos_variacao
    ADD CONSTRAINT atributos_variacao_pkey PRIMARY KEY (id);


--
-- TOC entry 5033 (class 2606 OID 17175)
-- Name: atributos_variacao atributos_variacao_product_variant_id_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atributos_variacao
    ADD CONSTRAINT atributos_variacao_product_variant_id_name_unique UNIQUE (product_variant_id, name);


--
-- TOC entry 4988 (class 2606 OID 17004)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 4985 (class 2606 OID 16993)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 5035 (class 2606 OID 17185)
-- Name: compatibilidades_produto compatibilidades_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compatibilidades_produto
    ADD CONSTRAINT compatibilidades_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 5037 (class 2606 OID 17197)
-- Name: compatibilidades_produto compatibilidades_produto_product_id_vehicle_model_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compatibilidades_produto
    ADD CONSTRAINT compatibilidades_produto_product_id_vehicle_model_id_unique UNIQUE (product_id, vehicle_model_id);


--
-- TOC entry 5050 (class 2606 OID 17263)
-- Name: envios_pedido envios_pedido_order_id_seller_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.envios_pedido
    ADD CONSTRAINT envios_pedido_order_id_seller_id_unique UNIQUE (order_id, seller_id);


--
-- TOC entry 5052 (class 2606 OID 17251)
-- Name: envios_pedido envios_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.envios_pedido
    ADD CONSTRAINT envios_pedido_pkey PRIMARY KEY (id);


--
-- TOC entry 4995 (class 2606 OID 17052)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4997 (class 2606 OID 17054)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 5057 (class 2606 OID 17287)
-- Name: itens_pedido itens_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT itens_pedido_pkey PRIMARY KEY (id);


--
-- TOC entry 4993 (class 2606 OID 17035)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 4990 (class 2606 OID 17020)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 4971 (class 2606 OID 16947)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 5012 (class 2606 OID 17098)
-- Name: modelos_veiculo modelos_veiculo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modelos_veiculo
    ADD CONSTRAINT modelos_veiculo_pkey PRIMARY KEY (id);


--
-- TOC entry 5014 (class 2606 OID 17102)
-- Name: modelos_veiculo modelos_veiculo_unique_spec; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modelos_veiculo
    ADD CONSTRAINT modelos_veiculo_unique_spec UNIQUE (brand, model, year_start, year_end, engine);


--
-- TOC entry 5062 (class 2606 OID 17334)
-- Name: pagamentos pagamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamentos
    ADD CONSTRAINT pagamentos_pkey PRIMARY KEY (id);


--
-- TOC entry 4978 (class 2606 OID 16971)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 5042 (class 2606 OID 17231)
-- Name: pedidos pedidos_number_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_number_unique UNIQUE (number);


--
-- TOC entry 5045 (class 2606 OID 17227)
-- Name: pedidos pedidos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (id);


--
-- TOC entry 5020 (class 2606 OID 17117)
-- Name: produtos produtos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos
    ADD CONSTRAINT produtos_pkey PRIMARY KEY (id);


--
-- TOC entry 5023 (class 2606 OID 17128)
-- Name: produtos produtos_slug_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos
    ADD CONSTRAINT produtos_slug_unique UNIQUE (slug);


--
-- TOC entry 4981 (class 2606 OID 16981)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4973 (class 2606 OID 16962)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 4975 (class 2606 OID 16960)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5025 (class 2606 OID 17148)
-- Name: variacoes_produto variacoes_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variacoes_produto
    ADD CONSTRAINT variacoes_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 5029 (class 2606 OID 17157)
-- Name: variacoes_produto variacoes_produto_sku_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variacoes_produto
    ADD CONSTRAINT variacoes_produto_sku_unique UNIQUE (sku);


--
-- TOC entry 5003 (class 2606 OID 17080)
-- Name: vendedores vendedores_document_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedores
    ADD CONSTRAINT vendedores_document_unique UNIQUE (document);


--
-- TOC entry 5005 (class 2606 OID 17082)
-- Name: vendedores vendedores_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedores
    ADD CONSTRAINT vendedores_email_unique UNIQUE (email);


--
-- TOC entry 5008 (class 2606 OID 17076)
-- Name: vendedores vendedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedores
    ADD CONSTRAINT vendedores_pkey PRIMARY KEY (id);


--
-- TOC entry 4983 (class 1259 OID 16994)
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- TOC entry 4986 (class 1259 OID 17005)
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- TOC entry 5038 (class 1259 OID 17198)
-- Name: compatibilidades_produto_vehicle_model_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX compatibilidades_produto_vehicle_model_id_index ON public.compatibilidades_produto USING btree (vehicle_model_id);


--
-- TOC entry 5053 (class 1259 OID 17265)
-- Name: envios_pedido_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX envios_pedido_status_index ON public.envios_pedido USING btree (status);


--
-- TOC entry 5054 (class 1259 OID 17264)
-- Name: envios_pedido_tracking_code_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX envios_pedido_tracking_code_index ON public.envios_pedido USING btree (tracking_code);


--
-- TOC entry 5055 (class 1259 OID 17313)
-- Name: itens_pedido_order_id_seller_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX itens_pedido_order_id_seller_id_index ON public.itens_pedido USING btree (order_id, seller_id);


--
-- TOC entry 5058 (class 1259 OID 17314)
-- Name: itens_pedido_product_variant_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX itens_pedido_product_variant_id_index ON public.itens_pedido USING btree (product_variant_id);


--
-- TOC entry 4991 (class 1259 OID 17021)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 5010 (class 1259 OID 17099)
-- Name: modelos_veiculo_brand_model_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX modelos_veiculo_brand_model_index ON public.modelos_veiculo USING btree (brand, model);


--
-- TOC entry 5015 (class 1259 OID 17100)
-- Name: modelos_veiculo_year_start_year_end_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX modelos_veiculo_year_start_year_end_index ON public.modelos_veiculo USING btree (year_start, year_end);


--
-- TOC entry 5059 (class 1259 OID 17346)
-- Name: pagamentos_gateway_payment_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pagamentos_gateway_payment_id_index ON public.pagamentos USING btree (gateway_payment_id);


--
-- TOC entry 5060 (class 1259 OID 17345)
-- Name: pagamentos_order_id_seller_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pagamentos_order_id_seller_id_index ON public.pagamentos USING btree (order_id, seller_id);


--
-- TOC entry 5063 (class 1259 OID 17347)
-- Name: pagamentos_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pagamentos_status_index ON public.pagamentos USING btree (status);


--
-- TOC entry 5039 (class 1259 OID 17229)
-- Name: pedidos_created_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pedidos_created_at_index ON public.pedidos USING btree (created_at);


--
-- TOC entry 5040 (class 1259 OID 17228)
-- Name: pedidos_customer_email_created_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pedidos_customer_email_created_at_index ON public.pedidos USING btree (customer_email, created_at);


--
-- TOC entry 5043 (class 1259 OID 17233)
-- Name: pedidos_payment_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pedidos_payment_status_index ON public.pedidos USING btree (payment_status);


--
-- TOC entry 5046 (class 1259 OID 17234)
-- Name: pedidos_placed_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pedidos_placed_at_index ON public.pedidos USING btree (placed_at);


--
-- TOC entry 5047 (class 1259 OID 17232)
-- Name: pedidos_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pedidos_status_index ON public.pedidos USING btree (status);


--
-- TOC entry 5048 (class 1259 OID 17363)
-- Name: pedidos_user_id_created_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pedidos_user_id_created_at_index ON public.pedidos USING btree (user_id, created_at);


--
-- TOC entry 5016 (class 1259 OID 17124)
-- Name: produtos_brand_active_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX produtos_brand_active_index ON public.produtos USING btree (brand, active);


--
-- TOC entry 5017 (class 1259 OID 17125)
-- Name: produtos_category_active_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX produtos_category_active_index ON public.produtos USING btree (category, active);


--
-- TOC entry 5018 (class 1259 OID 17126)
-- Name: produtos_name_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX produtos_name_index ON public.produtos USING btree (name);


--
-- TOC entry 5021 (class 1259 OID 17123)
-- Name: produtos_seller_id_active_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX produtos_seller_id_active_index ON public.produtos USING btree (seller_id, active);


--
-- TOC entry 4979 (class 1259 OID 16983)
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- TOC entry 4982 (class 1259 OID 16982)
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- TOC entry 4976 (class 1259 OID 17357)
-- Name: users_role_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_role_index ON public.users USING btree (role);


--
-- TOC entry 5026 (class 1259 OID 17155)
-- Name: variacoes_produto_price_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX variacoes_produto_price_index ON public.variacoes_produto USING btree (price);


--
-- TOC entry 5027 (class 1259 OID 17154)
-- Name: variacoes_produto_product_id_active_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX variacoes_produto_product_id_active_index ON public.variacoes_produto USING btree (product_id, active);


--
-- TOC entry 4998 (class 1259 OID 17077)
-- Name: vendedores_active_address_state_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vendedores_active_address_state_index ON public.vendedores USING btree (active, address_state);


--
-- TOC entry 4999 (class 1259 OID 17086)
-- Name: vendedores_active_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vendedores_active_index ON public.vendedores USING btree (active);


--
-- TOC entry 5000 (class 1259 OID 17078)
-- Name: vendedores_address_city_address_state_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vendedores_address_city_address_state_index ON public.vendedores USING btree (address_city, address_state);


--
-- TOC entry 5001 (class 1259 OID 17084)
-- Name: vendedores_address_state_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vendedores_address_state_index ON public.vendedores USING btree (address_state);


--
-- TOC entry 5006 (class 1259 OID 17085)
-- Name: vendedores_gateway_receiver_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vendedores_gateway_receiver_id_index ON public.vendedores USING btree (gateway_receiver_id);


--
-- TOC entry 5009 (class 1259 OID 17083)
-- Name: vendedores_zip_code_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX vendedores_zip_code_index ON public.vendedores USING btree (zip_code);


--
-- TOC entry 5066 (class 2606 OID 17169)
-- Name: atributos_variacao atributos_variacao_product_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atributos_variacao
    ADD CONSTRAINT atributos_variacao_product_variant_id_foreign FOREIGN KEY (product_variant_id) REFERENCES public.variacoes_produto(id) ON DELETE CASCADE;


--
-- TOC entry 5067 (class 2606 OID 17186)
-- Name: compatibilidades_produto compatibilidades_produto_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compatibilidades_produto
    ADD CONSTRAINT compatibilidades_produto_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.produtos(id) ON DELETE CASCADE;


--
-- TOC entry 5068 (class 2606 OID 17191)
-- Name: compatibilidades_produto compatibilidades_produto_vehicle_model_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compatibilidades_produto
    ADD CONSTRAINT compatibilidades_produto_vehicle_model_id_foreign FOREIGN KEY (vehicle_model_id) REFERENCES public.modelos_veiculo(id) ON DELETE CASCADE;


--
-- TOC entry 5070 (class 2606 OID 17252)
-- Name: envios_pedido envios_pedido_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.envios_pedido
    ADD CONSTRAINT envios_pedido_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.pedidos(id) ON DELETE CASCADE;


--
-- TOC entry 5071 (class 2606 OID 17257)
-- Name: envios_pedido envios_pedido_seller_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.envios_pedido
    ADD CONSTRAINT envios_pedido_seller_id_foreign FOREIGN KEY (seller_id) REFERENCES public.vendedores(id) ON DELETE RESTRICT;


--
-- TOC entry 5072 (class 2606 OID 17288)
-- Name: itens_pedido itens_pedido_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT itens_pedido_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.pedidos(id) ON DELETE CASCADE;


--
-- TOC entry 5073 (class 2606 OID 17293)
-- Name: itens_pedido itens_pedido_order_shipment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT itens_pedido_order_shipment_id_foreign FOREIGN KEY (order_shipment_id) REFERENCES public.envios_pedido(id) ON DELETE SET NULL;


--
-- TOC entry 5074 (class 2606 OID 17303)
-- Name: itens_pedido itens_pedido_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT itens_pedido_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.produtos(id) ON DELETE RESTRICT;


--
-- TOC entry 5075 (class 2606 OID 17308)
-- Name: itens_pedido itens_pedido_product_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT itens_pedido_product_variant_id_foreign FOREIGN KEY (product_variant_id) REFERENCES public.variacoes_produto(id) ON DELETE RESTRICT;


--
-- TOC entry 5076 (class 2606 OID 17298)
-- Name: itens_pedido itens_pedido_seller_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT itens_pedido_seller_id_foreign FOREIGN KEY (seller_id) REFERENCES public.vendedores(id) ON DELETE RESTRICT;


--
-- TOC entry 5077 (class 2606 OID 17335)
-- Name: pagamentos pagamentos_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamentos
    ADD CONSTRAINT pagamentos_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.pedidos(id) ON DELETE CASCADE;


--
-- TOC entry 5078 (class 2606 OID 17340)
-- Name: pagamentos pagamentos_seller_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamentos
    ADD CONSTRAINT pagamentos_seller_id_foreign FOREIGN KEY (seller_id) REFERENCES public.vendedores(id) ON DELETE RESTRICT;


--
-- TOC entry 5069 (class 2606 OID 17358)
-- Name: pedidos pedidos_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- TOC entry 5064 (class 2606 OID 17118)
-- Name: produtos produtos_seller_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos
    ADD CONSTRAINT produtos_seller_id_foreign FOREIGN KEY (seller_id) REFERENCES public.vendedores(id) ON DELETE CASCADE;


--
-- TOC entry 5065 (class 2606 OID 17149)
-- Name: variacoes_produto variacoes_produto_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.variacoes_produto
    ADD CONSTRAINT variacoes_produto_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.produtos(id) ON DELETE CASCADE;


-- Completed on 2026-11-15 22:29:06

--
-- PostgreSQL database dump complete
--

\unrestrict OKhBOFkF0EfkdUkGJLaf6PyLdSgUPoR6rXRTBHXiY0bUXGb3MmB9MKiL9Udp7ES

