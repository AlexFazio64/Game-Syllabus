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
CREATE TABLE public."ListaGiochi" (
 "emailUtente" character varying(255)[],
 "idGioco" character varying(255)[]
);
ALTER TABLE public."ListaGiochi" OWNER TO postgres;
CREATE TABLE public."Profilo" (
 username character varying(50)[] NOT NULL,
 descrizione character varying(255)[],
 email character varying(255)[] NOT NULL,
 immagine bytea[],
 password character varying(20)[] NOT NULL
);
ALTER TABLE public."Profilo" OWNER TO postgres;
CREATE TABLE public."Recensione" (
 id integer NOT NULL,
 valutazione integer NOT NULL,
 testo character varying(255)[] NOT NULL,
 "idGioco" character varying(255)[] NOT NULL,
 "scrittaDa" character varying(255)[] NOT NULL
);
ALTER TABLE public."Recensione" OWNER TO postgres;
CREATE SEQUENCE public."Recensione_id_seq"
 AS integer
 START WITH 1
 INCREMENT BY 1
 NO MINVALUE
 NO MAXVALUE
 CACHE 1;
 ALTER TABLE public."Recensione_id_seq" OWNER TO postgres;
ALTER SEQUENCE public."Recensione_id_seq" OWNED BY public."Recensione".id;
ALTER TABLE ONLY public."Recensione" ALTER COLUMN id SET DEFAULT nextval('public."Recensione_id_seq"'::regclass);
SELECT pg_catalog.setval('public."Recensione_id_seq"', 2, true);
ALTER TABLE ONLY public."Profilo"
 ADD CONSTRAINT "Profilo_pkey" PRIMARY KEY (email);
ALTER TABLE ONLY public."Recensione"
 ADD CONSTRAINT "Recensione_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."ListaGiochi"
 ADD CONSTRAINT "ListaGiochi_emailUtente_fkey" FOREIGN KEY ("emailUtente") REFERENCES public."Profilo"(email) ON UPDATE
CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public."Recensione"
 ADD CONSTRAINT "Recensione_emailProfilo_fkey" FOREIGN KEY ("scrittaDa") REFERENCES public."Profilo"(email);
