CREATE OR REPLACE TYPE distancia
/
CREATE OR REPLACE TYPE medalla_t
/
CREATE OR REPLACE TYPE deporte_t
/
CREATE OR REPLACE TYPE disciplina_t
/
CREATE OR REPLACE TYPE competidor_t
/
CREATE OR REPLACE TYPE entrenador_t
/
CREATE OR REPLACE TYPE deportista_t
/
CREATE OR REPLACE TYPE deportista_table
/


CREATE OR REPLACE TYPE distancia AS VARRAY(5) OF INTEGER
/
CREATE TABLE deporte (
	nombre		VARCHAR(40),
	record		CHAR(8),
	distancia	distancia
);

CREATE OR REPLACE TYPE medalla_t AS OBJECT (
	id			INT,
	olimpiada	VARCHAR(20),
	otorga REF 	deporte_t);
/
CREATE TABLE medalla OF medalla_t;


CREATE OR REPLACE TYPE deporte_t AS OBJECT (
	MEMBER FUNCTION get_medalla RETURN medalla_t
	MEMBER FUNCTION get_competidor RETURN competidor_t
);
/


CREATE OR REPLACE TYPE disciplina AS TABLE OF REF deporte_t
/


CREATE OR REPLACE TYPE competidor_t AS OBJECT (
	carnet	INT,
	nombre	VARCHAR(40),
	compite	disciplina) NOT FINAL;
/


CREATE OR REPLACE TYPE entrenador_t UNDER competidor_t (
	edad				INT,
	tiempo_experiencia	INT,
	nacionalidad		VARCHAR(20),
	MEMBER FUNCTION get_deportistas RETURN deportista_table);
/


CREATE OR REPLACE TYPE deportista_t UNDER competidor_t (
	pais 		VARCHAR(20),
	edad 		INT,
	estatura 	NUMBER(3,2),
	entrena REF entrenador_t);
/


CREATE OR REPLACE TYPE deportista_table AS TABLE OF REF deportista_t
/


CREATE TABLE competidor OF competidor_t
	NESTED TABLE compite STORE AS compite_nt;


