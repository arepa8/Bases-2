/*

Andres Hernandez
Samuel Rodriguez
Estrategias usadas en la traducción del esquema
La relación "otorga" presente entre las entidades "Deporte" y "Medalla" al ser 1:1 presentaba dos posibles opciones de traducción:
Definir colecciones REF en ambas tablas.
Definir una colección REF en una tabla y la otra definirla como un método.
Se optó por la segunda opción siendo la tabla "Deporte" el método y "Medalla" la de REF, 
esto se debe a que "Deporte" posee otra relación que se especificará más adelante que también una involucra que una tabla sea método y otra no, 
por ende es conveniente que la tabla con más relaciones sea el método.
Cabe destacar que la tabla deporte al tener un atributo  multievaluado se optó por usar la estructura VARRAY

La relación "compite" presente entre "Deporte" y "Competidor" al ser M:N presentaba tres opciones:
Una fuera un método y la otra fuera una tabla anidada.
Se creaba una tercera tabla que tuviera colecciones REF a las dos tablas.
Crear una tabla anidada para cada una.
Como ya la tabla deporte era un método por la relación 1:1, para mantener coherencia y expresividad se optó por la opción uno siendo competidor una tabla anidada.
La relación "entrena" presente entre "Entrenador" y "Deportista" al ser 1:N sus opciones son muy similares a las de M:N. 
Se consideró como opción más acertada que la tabla entrenador fuera un método y deportista sea una colección REF.

*/




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

	INSERT INTO medalla VALUES (medalla_t(1,'Beijing',SELECT REF(d) FROM deporte d WHERE d.nombre='Natacion'))
	INSERT INTO medalla VALUES (medalla_t(1,'Londres',SELECT REF(d) FROM deporte d WHERE d.nombre='Atletismo'))
	INSERT INTO medalla VALUES (medalla_t(1,'Rio',SELECT REF(d) FROM deporte d WHERE d.nombre='Ciclismo'))

	INSERT INTO competidor_t VALUES (entrenador_t(0991283,'Luis',60,20,'venezolano'))
	INSERT INTO comprtidor_t VALUES (deportista_t(1010192,'Samuel','Venezuela',22,1.80,SELECT REF(e) FROM competidor e WHERE e.nombre='Luis')))
	INSERT INTO comprtidor_t VALUES (deportista_t(1010353,'Andres','Venezuela',23,1.82,SELECT REF(e) FROM competidor e WHERE e.nombre='Luis'))

END;
/

