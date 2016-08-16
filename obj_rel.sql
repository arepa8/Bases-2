
CREATE OR REPLACE TYPE medalla_t
/
CREATE OR REPLACE TYPE deporte_t
/
CREATE OR REPLACE TYPE disciplina_t
/
CREATE OR REPLACE TYPE competidor_t
/




CREATE TYPE distancias AS VARRAY(5) OF INTEGER;
/
CREATE TABLE deporte (
	nombre		VARCHAR(40),
	record		CHAR(8),
	distancia 	distancias
);



CREATE OR REPLACE TYPE medalla_t AS OBJECT (
	id			INT,
	olimpiada	VARCHAR(20),
	otorga REF 	deporte_t);
/
CREATE TABLE medalla OF medalla_t;


CREATE OR REPLACE TYPE deporte_t AS OBJECT (
	nombre		VARCHAR(40),
	MEMBER FUNCTION get_medalla RETURN medalla_t,
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


CREATE  TYPE entrenador_t UNDER competidor_t (
	edad				INT,
	tiempo_experiencia	INT,
	nacionalidad		VARCHAR(20),
	MEMBER FUNCTION get_deportistas RETURN deportista_table);
/


CREATE  TYPE deportista_t UNDER competidor_t (
	pais 		VARCHAR(20),
	edad 		INT,
	estatura 	NUMBER(3,2),
	entrena REF entrenador_t);
/


CREATE TYPE deportista_table AS TABLE OF deportista_t
/


CREATE TABLE competidor OF competidor_t
	NESTED TABLE compite STORE AS compite_nt;

BEGIN
	INSERT INTO deporte (nombre, record, distancia) VALUES ('Natacion','10.08s',distancias(100,200,400,800))
	INSERT INTO deporte (nombre, record, distancia) VALUES ('Atletismo','9.54s',distancias(100,200,400,800,1500))
	INSERT INTO deporte (nombre, record, distancia) VALUES ('Ciclismo','10.08s',distancias(10000,20000,40000,80000))

	INSERT INTO medalla (id,olimpiada,otorga) VALUES (1,'Beijing',SELECT REF(d) FROM deporte d WHERE d.nombre='Natacion')
	INSERT INTO medalla (id,olimpiada,otorga) VALUES (1,'Londres',SELECT REF(d) FROM deporte d WHERE d.nombre='Atletismo')
	INSERT INTO medalla (id,olimpiada,otorga) VALUES (1,'Rio',SELECT REF(d) FROM deporte d WHERE d.nombre='Ciclismo')
END;
/

