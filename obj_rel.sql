CREATE TYPE distancia_t 
/
CREATE TYPE distancia_table
/
CREATE TYPE deporte_t 
/
CREATE TYPE disciplina
/
CREATE TYPE medalla_t 
/
CREATE TYPE competidor_t
/
CREATE TYPE entrenador_t
/
CREATE TYPE deportista_t
/
CREATE TYPE deportista_table
/

CREATE TYPE distancia_t AS OBJECT
           (course_no  NUMBER,
            title      VARCHAR2(64),
            credits    NUMBER);
/
CREATE TYPE distancia_table AS TABLE OF distancia_t;
/

-- create deporte table
CREATE TABLE deporte (
	nombre		VARCHAR(40),
	record		CHAR(8),
	distancia	distancia_table,
	MEMBER FUNCTION get_medalla RETURN INT,
	MEMBER FUNCTION get_competidor RETURN VARCHAR
	);
/