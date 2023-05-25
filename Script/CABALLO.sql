alter session set "_oracle_script"=true;
create user CABALLO identified by CABALLO;
GRANT CONNECT, RESOURCE, DBA TO CABALLO;

CREATE TABLE CABALLOS(
	CODCABALLO VARCHAR2(4),
	NOMBRE VARCHAR2(20) NOT NULL,
	PESO NUMBER(3),
	FECHANACIMIENTO DATE,
	PROPIETARIO VARCHAR2(25),
	NACIONALIDAD VARCHAR2(20),
	CONSTRAINT PK_CODCABALLO PRIMARY KEY (CODCABALLO),
	CONSTRAINT CHK_NACIONALIDAD CHECK (UPPER(NACIONALIDAD)=NACIONALIDAD),
	CONSTRAINT CHK_FECHANACIMINETO CHECK (EXTRACT(YEAR FROM FECHANACIMIENTO)>2000)
);
ALTER TABLE CABALLOS ADD CONSTRAINT CHK_PESO CHECK ((PESO>240) AND (PESO<300));
CREATE TABLE CARRERAS(
	CODCARRERA VARCHAR2(4),
	FECHAYHORA DATE,
	IMPORTEPREMIO NUMBER(6),
	APUESTALIMITE NUMBER(5,2),
	CONSTRAINT PK_COD_CARRERA PRIMARY KEY (CODCARRERA),
	CONSTRAINT CHK_APUESTA CHECK (APUESTALIMITE<20000),
	CONSTRAINT CHK_FECHAYHORA CHECK (TO_CHAR(FECHAYHORA)>TO_CHAR('09:00','HH:MM')AND TO_CHAR(FECHAYHORA)<TO_CHAR('14:30','HH:MM'))
);
CREATE TABLE PARTICIPACIONES(
	CODCABALLO VARCHAR2(4),
	CODCARRERA VARCHAR2(4),
	DORSAL NUMBER(2) NOT NULL,
	JOCKEY VARCHAR2(10) NOT NULL,
	POSICIONFINAL NUMBER(2),
	CONSTRAINT PK_PARTICIPACIONES PRIMARY KEY (CODCABALLO,CODCARRERA),
	CONSTRAINT CHK_POSICION CHECK (POSICIONFINAL>0),
	CONSTRAINT FK_CODIGOCABALLO FOREIGN KEY (CODCABALLO) REFERENCES CABALLOS(CODCABALLO),
	CONSTRAINT FK_CODCARRERA FOREIGN KEY (CODCARRERA) REFERENCES CARRERAS(CODCARRERA)
);
CREATE TABLE APUESTAS(
	DNICLIENTE VARCHAR2(10),
	CODCABALLO VARCHAR2(4),
	CODCARRERA VARCHAR2(4),
	IMPORTE NUMBER(6) DEFAULT 300 NOT NULL,
	TANTOPORUNO NUMBER(4,2),
	CONSTRAINT PK_APUESTAS PRIMARY KEY (DNICLIENTE,CODCABALLO,CODCARRERA),
	CONSTRAINT CHK_TANTOPORUNO CHECK (TANTOPORUNO>1),
	CONSTRAINT FK2_CODIGOCABALLO FOREIGN KEY (CODCABALLO) REFERENCES CABALLOS(CODCABALLO),
	CONSTRAINT FK2_CODCARRERA FOREIGN KEY (CODCARRERA) REFERENCES CARRERAS(CODCARRERA)
);
CREATE TABLE CLIENTES(
	DNI VARCHAR2(10),
	NOMBRE VARCHAR(20),
	NACIONALIDAD VARCHAR2(20),
	CONSTRAINT PK_DNI PRIMARY KEY (DNI),
	CONSTRAINT CHK_DNI CHECK (DNI=('[0-9]{8}[A-Z]')),
	CONSTRAINT CHK2_NACIONALIDAD CHECK (UPPER(NACIONALIDAD)=NACIONALIDAD)
);
ALTER TABLE APUESTAS ADD CONSTRAINT FK2_DNI FOREIGN KEY (DNICLIENTE) REFERENCES CLIENTES(DNI);

--2. Inserta el registro o registros necesarios para guardar la siguiente información:     
--El cliente escocés realiza una apuesta al caballo más pesado de la primera carrera que se corra en el verano de 2009 por un importe de 2000 euros. En ese momento ese caballo en esa carrera se paga 30 a 1.
--Si es necesario algún dato invéntatelo, pero sólo los datos que sean estrictamente necesaria.

--3. Inscribe a 2 caballos  en la carrera cuyo código es C6. La carrera aún no se ha celebrado. Invéntate los jockeys y los dorsales y los caballos.
INSERT INTO CABALLOS (CODCABALLO,NOMBRE,PESO,FECHANACIMIENTO,PROPIETARIO,NACIONALIDAD)
VALUES ('1','COFRADE',246,TO_DATE('12/04/2018','DD/MM/YYYY'),'JUANITO PEREZ SÁEZ','ESPAÑOLA');
INSERT INTO CABALLOS (CODCABALLO,NOMBRE,PESO,FECHANACIMIENTO,PROPIETARIO,NACIONALIDAD)
VALUES ('2','MANDARINO',290,TO_DATE('03/12/2019','DD/MM/YYYY'),'TAMARA FALCAO GUTIERREZ','ESPAÑOLA');
SELECT *FROM CABALLOS
INSERT INTO CARRERAS (CODCARRERA,FECHAYHORA,IMPORTEPREMIO,APUESTALIMITE)
VALUES ('C6',NULL,200,30);

INSERT INTO PARTICIPACIONES (CODCABALLO,CODCARRERA,DORSAL,JOCKEY)
VALUES ('1','C6',34,'BENITEZ');
INSERT INTO PARTICIPACIONES (CODCABALLO,CODCARRERA,DORSAL,JOCKEY)
VALUES ('2','C6',13,'ESCUDERO');

--4. Inserta dos carreras con los datos que creas necesario.
INSERT INTO CARRERAS (CODCARRERA,FECHAYHORA,IMPORTEPREMIO,APUESTALIMITE)
VALUES ('C3',NULL,800,10);
INSERT INTO CARRERAS (CODCARRERA,FECHAYHORA,IMPORTEPREMIO,APUESTALIMITE)
VALUES ('C7',NULL,400,600);
--INSERT INTO CARRERAS (CODCARRERA,FECHAYHORA,IMPORTEPREMIO,APUESTALIMITE)
--VALUES ('C8',TO_DATE('01-03-2011 10:01','DD-MM-YYYY HH:MI'),400,600);
SELECT * FROM CARRERAS;
--5. Quita el campo propietario de la tabla caballos
ALTER TABLE CABALLOS DROP COLUMN PROPIETARIO;
--6. Añadir las siguientes restricciones a las tablas:
   --• En la Tabla Participaciones los nombres de los jockeys tienen siempre las iniciales en mayúsculas.
ALTER TABLE PARTICIPACIONES ADD CONSTRAINT CHK_JOCKEY CHECK (REGEXP_LIKE(JOCKEY,'^[A-Z]'));
   --• La temporada de carreras transcurre del 10 de Marzo al 10 de Noviembre.
   --• La nacionalidad de los caballos sólo puede ser Española, Británica o Árabe.
      --Si los datos que has introducidos no cumplen las restricciones haz los cambios necesarios para ellos.
ALTER TABLE CABALLOS ADD CONSTRAINT CHK1_NACIONALIDAD CHECK ((NACIONALIDAD='ESPAÑOLA') OR (NACIONALIDAD='BRITANICA') OR (NACIONALIDAD='ARABE'));
--6. Borra las carreras en las que no hay caballos inscritos.
DELETE FROM CARRERAS 
WHERE NOT EXISTS (SELECT * FROM PARTICIPACIONES);
--7. Añade un campo llamado código en el campo clientes, que no permita valores nulos ni repetidos
 ALTER TABLE CLIENTES ADD CODIGO VARCHAR(4) NOT NULL;
--8. Nos hemos equivocado y el código C6 de la carrera en realidad es C66.
INSERT INTO CARRERAS (CODCARRERA,FECHAYHORA,IMPORTEPREMIO,APUESTALIMITE)
VALUES ('C66',NULL,200,30);

UPDATE PARTICIPACIONES  
SET CODCARRERA='C66'
WHERE CODCARRERA='C6';

DELETE FROM CARRERAS
WHERE CODCARRERA='C6';
--PREGUNTAR A MARTA
--9. Añade un campo llamado premio a la tabla apuestas.
 ALTER TABLE APUESTAS ADD PREMIO VARCHAR(10);
--10. Borra todas las tablas y datos con el número menor de instrucciones posibles.
DROP USER CABALLO CASCADE;