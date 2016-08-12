CREATE OR REPLACE TYPE deporte_t
/
CREATE OR REPLACE TYPE medalla_t
/
CREATE OR REPLACE TYPE competidor_t
/
CREATE OR REPLACE TYPE entrenador_t
/
CREATE OR REPLACE TYPE distancia_t
/
CREATE OR REPLACE TYPE distancia_table
/
CREATE OR REPLACE TYPE deportista_t
/
CREATE OR REPLACE TYPE deportistas_t --#Para relacion unos a muchos



--####     DEPORTE     ####

--CREATE OR REPLACE distancia_t AS OBJECT(distancia INT);
--CREATE OR REPLACE distancia_table AS TABLE OF distancia_t;	--#Atributo multivaluado distancia

--CREATE OR REPLACE TYPE deporte_t AS OBJECT(
--	nombre VARCHAR(40),
--	record CHAR(8),
--	distancia distancia_table
--),
--MEMBER FUNCTION GET medalla RETURN medalla_t,
--MEMBER FUNCTION GET competidor RETURN competidor_t;/

--CREATE TABLE deporte AS TABLE OF deporte_t (PRIMARY KEY (nombre));
--CREATE OR REPLACE TYPE sport AS TABLE OF deporte_t;




--####     MEDALLA     ####

--CREATE OR REPLACE TYPE medalla_t AS OBJECT(
--	id INT,
--	olimpiada VARCHAR(20),
--	otorga REF deporte_t SCOPE IS deporte);/

--CREATE TABLE medalla AS TABLE OF medalla_t (PRIMARY KEY (id));




--####     COMPETIDOR     ####

--CREATE OR REPLACE TYPE competidor_t AS OBJECT(
--	carnet INT,
--	nombre VARCHAR(40) NOT FINAL),
--	compite sport
--	NESTED TABLE compite STORE AS sport_store;);

--CREATE TABLE competidor AS TABLE OF competidor_t (PRIMARY KEY (carnet))

--## REVISAR EL NESTED TABLE


--####     DEPORTISTA     ####

--CREATE OR REPLACE TYPE deportista_t UNDER competidor_t (
--	pais VARCHAR(20),
--	edad int,
--	estatura NUMBER(3,2),
--	entrena REF entrenador 
--	);/

--CREATE TYPE deportistas AS TABLE OF deportista_t;




--####     ENTRENADOR     ####

--CREATE OR REPLACE TYPE entrenador_t UNDER competidor_t(
--	edad INT,
--	años_experiencia INT 
--	nacionalidad VARCHAR(20)
--	),
--MEMBER FUNCTION GET deportistas_col return deportistas;/
--BEGIN
--END;
/

