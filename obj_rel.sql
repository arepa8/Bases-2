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

DBMS_OUTPUT.PUT_LINE('Distancia')
CREATE OR REPLACE TYPE distancia AS VARRAY(5) OF INTEGER
/
DBMS_OUTPUT.PUT_LINE('Deporte')
CREATE TABLE deporte (
	nombre		VARCHAR(40),
	record		CHAR(8),
	distancia	distancia
);
DBMS_OUTPUT.PUT_LINE('medalla_t')
CREATE OR REPLACE TYPE medalla_t AS OBJECT (
	id			INT,
	olimpiada	VARCHAR(20),
	otorga REF 	deporte_t);
/
DBMS_OUTPUT.PUT_LINE('medalla')
CREATE TABLE medalla OF medalla_t;

DBMS_OUTPUT.PUT_LINE('Deporte_t')
CREATE OR REPLACE TYPE deporte_t AS OBJECT (
	MEMBER FUNCTION get_medalla RETURN medalla_t
	MEMBER FUNCTION get_competidor RETURN competidor_t
);
/

DBMS_OUTPUT.PUT_LINE('Disciplina')
CREATE OR REPLACE TYPE disciplina AS TABLE OF REF deporte_t
/

DBMS_OUTPUT.PUT_LINE('competidor_t')
CREATE OR REPLACE TYPE competidor_t AS OBJECT (
	carnet	INT,
	nombre	VARCHAR(40),
	compite	disciplina) NOT FINAL;
/

DBMS_OUTPUT.PUT_LINE('entrenador_t')
CREATE OR REPLACE TYPE entrenador_t UNDER competidor_t (
	edad				INT,
	tiempo_experiencia	INT,
	nacionalidad		VARCHAR(20),
	MEMBER FUNCTION get_deportistas RETURN deportista_table);
/

DBMS_OUTPUT.PUT_LINE('deportista_t')
CREATE OR REPLACE TYPE deportista_t UNDER competidor_t (
	pais 		VARCHAR(20),
	edad 		INT,
	estatura 	NUMBER(3,2),
	entrena REF entrenador_t);
/

DBMS_OUTPUT.PUT_LINE('deportista_table')
CREATE OR REPLACE TYPE deportista_table AS TABLE OF REF deportista_t
/

DBMS_OUTPUT.PUT_LINE('competidor')
CREATE TABLE competidor OF competidor_t
	NESTED TABLE compite STORE AS compite_nt;


