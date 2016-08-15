--
--	Universidad Simon Bolivar
--	Paradigmas de Modelado de Bases de Datos
--
--	Proyecto 1: Traducción a Objeto Relacional
--
--
--	Autores:	Samuel Rodriguez
--				Andres Hernandez
--
--	DBMS: Sql*plus, oracle			
--	Fecha: 15/8/2016
--


--	Creacion de los objetos

CREATE OR REPLACE TYPE distancia_t AS OBJECT (
	distancia	INT);
/

CREATE OR REPLACE TYPE distancia_table AS TABLE OF distancia_t
/

CREATE OR REPLACE TYPE deporte_t AS OBJECT (
	nombre		VARCHAR(40),
	record		CHAR(8),
	distancia	distancia_table),
	MAP MEMBER FUNCTION get_medalla RETURN medalla_t,
	MAP MEMBER FUNCTION get_competidor RETURN competidor_t;
/

CREATE OR REPLACE TYPE disciplina AS TABLE OF deporte_t
/

CREATE OR REPLACE TYPE medalla_t AS OBJECT (
	id			INT,
	olimpiada	VARCHAR(20),
	otorga REF 	deporte_t);
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
	MEMBER FUNCTION get_deportistas return deportistas;);
/
CREATE OR REPLACE TYPE deportista_t UNDER competidor_t (
	pais 		VARCHAR(20),
	edad 		INT,
	estatura 	NUMBER(3,2),
	entrena REF entrenador_t);
/
CREATE OR REPLACE TYPE deportista_table AS TABLE OF deportista_t --#Para relacion unos a muchos
/

--	Creacion de las tablas

CREATE TABLE deporte OF deporte_t;
CREATE TABLE medalla OF medalla_t;
CREATE TABLE competidor OF competidor_t
	NESTED TABLE compite STORE AS compite_tab;
CREATE TABLE deportista OF deportista_t;
CREATE TABLE entrenador OF entrenador_t;


--	Inserciones

--DECLARE

--comp1 deportista_t := competidor_t(1010353,'Andres Hernandez',disciplina(deporte_t('Atletismo','9.54s',distancia_table(distancia_t(100)))))

--BEGIN

	-- Tabla Deporte
	--INSERT INTO disciplina VALUES (deporte_t('Atletismo','9.54s',distancia_table(distancia_t(100))));
	--INSERT INTO disciplina VALUES (deporte_t('Natacion','18.04s',distancia_table(distancia_t(100))));
	--INSERT INTO disciplina VALUES (deporte_t('Ciclismo','20m',distancia_table(distancia_t(10000))));

	-- Tabla Medalla
	--INSERT INTO medalla VALUES (medalla_t(1, 'Beijing 2008',));
	--INSERT INTO medalla VALUES (medalla_t(2, 'Londres 2012',));
	--INSERT INTO medalla VALUES (medalla_t(3, 'Rio 2016',));

	-- Tabla Deportista
	--INSERT INTO deportista VALUES (deportista_t('Venezuela',23,1.80,));
	--INSERT INTO deportista VALUES (deportista_t('Estados Unidos',32,1.75,));
	--INSERT INTO deportista VALUES (deportista_t('Colombia',23,1.60,));

	-- Tabla Entrenador
	--INSERT INTO entrenador VALUES (entrenador_t(60, 30, 'venezolano', ));
	--INSERT INTO entrenador VALUES (entrenador_t(60, 30, 'venezolano', ));
	--INSERT INTO entrenador VALUES (entrenador_t(60, 30, 'venezolano', ));

--END;
--/

















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


