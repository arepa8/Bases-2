CREATE TYPE distancia AS VARRAY(50) OF INTEGER
/
CREATE TABLE deporte (
	nombre		VARCHAR(40),
	record		CHAR(8),
	distancia	distancia_table
);