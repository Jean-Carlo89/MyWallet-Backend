--
-- PostgreSQL database dump
--

-- Dumped from database version 12.7 (Ubuntu 12.7-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.7 (Ubuntu 12.7-0ubuntu0.20.04.1)

\c mywallet;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    "userId" integer,
    token text
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    value integer,
    description text,
    type text,
    date text,
    "userId" integer
);


--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text,
    email text,
    password text
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sessions VALUES (16, 19, '7cbb4ed2-bf76-4069-9390-f4446845b050');
INSERT INTO public.sessions VALUES (17, 20, '08e4fc30-c4d3-419a-a66e-10fc894c658d');
INSERT INTO public.sessions VALUES (18, 21, 'e50eb08f-797b-4fc6-80ff-bd56b688c378');
INSERT INTO public.sessions VALUES (19, 22, '2d94d015-3b7b-4ccd-8781-4337f93805ad');
INSERT INTO public.sessions VALUES (20, 23, 'c0fb75ae-409b-4986-8f1d-f7fa0e2f571d');
INSERT INTO public.sessions VALUES (21, 23, '01765252-a392-48a0-9d0c-95f2a3162aa7');
INSERT INTO public.sessions VALUES (22, 24, '89616654-315d-4b83-9b1e-73ad72a4801f');


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.transactions VALUES (2, 14540, 'segundo depósito', 'deposit', '2021/06/24', 1);
INSERT INTO public.transactions VALUES (3, 4540, 'primeira retirada', 'withdraw', '2021/06/24', 1);
INSERT INTO public.transactions VALUES (4, 6700, 'primeiro dep teste2', 'deposit', '2021/06/24', 2);
INSERT INTO public.transactions VALUES (5, 700, 'primeira retirada teste2', 'withdraw', '2021/06/24', 2);
INSERT INTO public.transactions VALUES (6, 7000, 'testar o negativo', 'withdraw', '2021/06/24', 2);
INSERT INTO public.transactions VALUES (7, 2000, 'testar o positivo', 'deposit', '2021/06/24', 2);
INSERT INTO public.transactions VALUES (8, 100, 'teste de apagar', 'deposit', '2021/06/24', 2);
INSERT INTO public.transactions VALUES (9, 100, 'carnval', 'withdraw', '2021/06/25', 2);
INSERT INTO public.transactions VALUES (10, 700, 'carnaval 2', 'withdraw', '2021/06/25', 2);
INSERT INTO public.transactions VALUES (11, 400, 'salario 2', 'deposit', '2021/06/25', 2);
INSERT INTO public.transactions VALUES (12, 100, 'last test', 'deposit', '2021/06/25', 2);
INSERT INTO public.transactions VALUES (13, 200, 'last teste saida', 'withdraw', '2021/06/25', 2);
INSERT INTO public.transactions VALUES (14, 300, 'salario', 'deposit', '2021/08/10', 20);
INSERT INTO public.transactions VALUES (15, 3000, 'colegio', 'withdraw', '2021/08/10', 20);
INSERT INTO public.transactions VALUES (16, 300000, 'salário', 'deposit', '2021/08/10', 22);
INSERT INTO public.transactions VALUES (17, 120000, 'despesa-colégio', 'withdraw', '2021/08/10', 22);
INSERT INTO public.transactions VALUES (18, 300000, 'salário', 'deposit', '2021/08/10', 23);
INSERT INTO public.transactions VALUES (19, 120000, 'despesa-colégio', 'withdraw', '2021/08/10', 23);
INSERT INTO public.transactions VALUES (20, 3400, 'mesada', 'deposit', '2021/08/11', 24);
INSERT INTO public.transactions VALUES (21, 1256, 'despesa-lanche', 'withdraw', '2021/08/11', 24);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES (1, 'Teste', 'teste@gmail.com', '$2b$12$7z2iZlRDUtGTgFpkPScFf.di4m01r2Ovyc7TCMfuyikW/AeR0ypaG');
INSERT INTO public.users VALUES (2, 'jteste2', 'jteste2@gmail.com', '$2b$12$8m8Yu6H4WQVMqY.M0a6NEu9MMZc6IM5tWZ225ZYbJ9QhSK1FE/WBq');
INSERT INTO public.users VALUES (3, 'Jean', 'jeancarlomo@hotmail.com', '$2b$12$4vCICd1DtKgja8GP9MJwhuKwgIhKr1cWlCCR8RzASYxRKe2zWsj/2');
INSERT INTO public.users VALUES (19, 'jean', '12345@gmail.com', '$2b$12$KRaMcKSJ1f5oq4pfqaoNHe/5CDyRzPX.P8tt7oi1EQYRSGWpGlp8C');
INSERT INTO public.users VALUES (20, 'Jean Carlo', 'jteste34@gmail.com', '$2b$12$EXHGWZB2vhQ6S6RUEZms9er1TTK0mBwEQuonyVFjjNZcNBtSC6ZM.');
INSERT INTO public.users VALUES (21, 'test1', 'test@gmail.com', '$2b$12$5IBlISfnRlWbaZwO1ZroOelaKwsoh.0ruBFz7q350//PDjSwN7AuW');
INSERT INTO public.users VALUES (22, 'Pedro Farias', 'pedrof@gmail.com', '$2b$12$MOwRK/nJi4WU7rkE5MOup.fj9jZmcGLcxeAiKASpACLv4iDEBZHcK');
INSERT INTO public.users VALUES (23, 'Jorge Gabriel', 'jorge@gmail.com', '$2b$12$f3wl.2z1Mb6sY.i0E1DiV.YrpQeznSL/PCCC.MAWAJ2nrTttqpEku');
INSERT INTO public.users VALUES (24, 'Jean ', 'jteste89@gmail.com', '$2b$12$Umk1WQ7zzeHp6uD5U5vtUeaqS.wTtWjrunMP6p1mo4rKVqE33PjtK');


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sessions_id_seq', 22, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.transactions_id_seq', 21, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 27, true);


--
-- PostgreSQL database dump complete
--

