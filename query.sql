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

SET default_table_access_method = heap;

--
-- Name: recensione; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recensione (
    id integer NOT NULL,
    valutazione integer NOT NULL,
    testo character varying(255) NOT NULL,
    "idGioco" character varying(255) NOT NULL,
    "scrittaDa" character varying(320) NOT NULL
);


--
-- Name: Recensione_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Recensione_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Recensione_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Recensione_id_seq" OWNED BY public.recensione.id;


--
-- Name: listagiochi; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.listagiochi (
    "emailUtente" character varying(320) NOT NULL,
    "idGioco" character varying(255) NOT NULL
);


--
-- Name: profilo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profilo (
    email character varying(320) NOT NULL,
    password character varying(64) NOT NULL,
    username character varying(25) NOT NULL,
    descrizione character varying(255),
    immagine bytea
);


--
-- Name: recensione id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recensione ALTER COLUMN id SET DEFAULT nextval('public."Recensione_id_seq"'::regclass);


--
-- Name: profilo Profilo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profilo
    ADD CONSTRAINT "Profilo_pkey" PRIMARY KEY (email);


--
-- Name: recensione Recensione_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recensione
    ADD CONSTRAINT "Recensione_pkey" PRIMARY KEY (id);


--
-- Name: listagiochi email-gioco; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listagiochi
    ADD CONSTRAINT "email-gioco" PRIMARY KEY ("emailUtente", "idGioco");


--
-- Name: profilo username; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profilo
    ADD CONSTRAINT username UNIQUE (username);


--
-- Name: fki_emailFK; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fki_emailFK" ON public.listagiochi USING btree ("emailUtente");


--
-- Name: fki_profiloFK; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fki_profiloFK" ON public.recensione USING btree ("scrittaDa");


--
-- Name: listagiochi emailFK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.listagiochi
    ADD CONSTRAINT "emailFK" FOREIGN KEY ("emailUtente") REFERENCES public.profilo(email) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: recensione profiloFK; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recensione
    ADD CONSTRAINT "profiloFK" FOREIGN KEY ("scrittaDa") REFERENCES public.profilo(email) ON UPDATE CASCADE ON DELETE CASCADE;
