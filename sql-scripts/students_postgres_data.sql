--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.3

-- Started on 2025-06-18 18:40:27

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
-- TOC entry 221 (class 1259 OID 65590)
-- Name: students; Type: TABLE; Schema: certify; Owner: postgres
--

CREATE TABLE certify.students (
    id character varying(64) NOT NULL,
    roll_number integer NOT NULL,
    student_name character varying(128) NOT NULL,
    course_name character varying(256) NOT NULL,
    course_division_name character varying(256),
    course_duration character varying(128),
    result character varying(128),
    gender character varying(64),
    date_of_birth date,
    start_date date,
    completion_date date,
    face text
);


ALTER TABLE certify.students OWNER TO postgres;

--
-- TOC entry 3201 (class 2606 OID 65596)
-- Name: students students_pkey; Type: CONSTRAINT; Schema: certify; Owner: postgres
--

ALTER TABLE ONLY certify.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- TOC entry 3350 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE students; Type: ACL; Schema: certify; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,UPDATE ON TABLE certify.students TO certifyuser;
GRANT SELECT ON TABLE certify.students TO readuser;


-- Completed on 2025-06-18 18:40:31

--
-- PostgreSQL database dump complete
--

