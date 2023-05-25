CREATE TABLE EMPLE(
	EMP_NO INTEGER(4),
	APELLIDO VARCHAR(20),
	OFICIO VARCHAR(20),
	DIR INTEGER(4),
	FECHA_ALT DATE,
	SALARIO INTEGER(8),
	COMISION INTEGER(6),
	DEPT_NO INTEGER(2),
	CONSTRAINT PK_EMPLE PRIMARY KEY(EMP_NO)
);
CREATE TABLE DEPART(
	DEPT_NO INTEGER(2),
	DNOMBRE VARCHAR(15),
	LOC VARCHAR(15),
	CONSTRAINT PK_DEPART PRIMARY KEY(DEPT_NO)
);

ALTER TABLE EMPLE ADD CONSTRAINT FK2_EMPLE FOREIGN KEY(DEPT_NO)REFERENCES DEPART(DEPT_NO);

INSERT INTO DEPART
VALUES(10,'CONTABILIDAD','SEVILLA');
INSERT INTO DEPART
VALUES(20,'INVESTIGACION','MADRID');
INSERT INTO DEPART
VALUES(30,'VENTAS','BARCELONA');
INSERT INTO DEPART
VALUES(40,'PRODUCCION','BILBAO');

INSERT INTO EMPLE
VALUES(7369,'SANCHEZ','EMPLEADO',7902,('1980-12-17'),104000,NULL,20);
INSERT INTO EMPLE
VALUES(7499,'ARROYO','VENDEDOR',7698,('1980-02-20'),208000,39000,30);
INSERT INTO EMPLE
VALUES(7521,'SALA','VENDEDOR',7698,('1981-02-22'),162500,162500,30);
INSERT INTO EMPLE
VALUES(7566,'JIMENEZ','DIRECTOR',7839,('1981-04-02'),386750,NULL,20);
INSERT INTO EMPLE
VALUES(7654,'MARTIN','VENDEDOR',7698,('1981-09-29'),162500,182000,30);
INSERT INTO EMPLE
VALUES(7698,'NEGRO','DIRECTOR',7839,('1981-05-01'),370500,NULL,30);
INSERT INTO EMPLE
VALUES(7788,'GIL','ANALISTA',7566,('1981-11-09'),390000,NULL,20);
INSERT INTO EMPLE
VALUES(7839,'REY','PRESIDENTE',NULL,('1981-11-17'),650000,NULL,10);
INSERT INTO EMPLE
VALUES(7844,'TOVAR','VENDEDOR',7698,('1981-09-08'),195000,0,30);
INSERT INTO EMPLE
VALUES(7876,'ALONSO','EMPLEADO',7788,('1981-09-23'),143000,NULL,20);
INSERT INTO EMPLE
VALUES(7900,'JIMENO','EMPLEADO',7698,('1981-12-03'),1235000,NULL,30);
INSERT INTO EMPLE
VALUES(7902,'FERNANDEZ','ANALISTA',7566,('1981-12-03'),390000,NULL,20);
INSERT INTO EMPLE
VALUES(7934,'MUÑOZ','EMPLEADO',NULL,('1982-01-23'),169000,NULL,10);

ALTER TABLE EMPLE ADD CONSTRAINT FK_EMPLE FOREIGN KEY(DIR) REFERENCES EMPLE(EMP_NO);

-- 1 Mostrar el apellido, oficio y número de departamento de cada empleado.
SELECT E.APELLIDO ,E.OFICIO ,E.DEPT_NO
FROM EMPLE E;
-- 2 Mostrar el número, nombre y localización de cada departamento.
SELECT D.DEPT_NO ,D.DNOMBRE ,D.LOC
FROM DEPART D;
-- 3 Mostrar todos los datos de todos los empleados.
SELECT * 
FROM EMPLE E;
-- 4 Datos de los empleados ordenados por apellidos.
SELECT *
FROM EMPLE E
ORDER BY E.APELLIDO;
-- 5 Datos de los empleados ordenados por número de departamento
-- descendentemente.
SELECT *
FROM EMPLE E
ORDER BY E.DEPT_NO DESC;
-- 6 Datos de los empleados ordenados por número de departamento
-- descendentemente y dentro de cada departamento ordenados por apellido
-- ascendentemente.
SELECT *
FROM EMPLE E
ORDER BY E.DEPT_NO DESC,E.APELLIDO ASC;
-- 8 Mostrar los datos de los empleados cuyo salario sea mayor que 2000000.
SELECT *
FROM EMPLE E
WHERE E.SALARIO>2000000;
-- 9 Mostrar los datos de los empleados cuyo oficio sea ʻANALISTAʼ.
SELECT *
FROM EMPLE E
WHERE UPPER(E.OFICIO) LIKE ('ANALISTA');
-- 10 Seleccionar el apellido y oficio de los empleados del departamento número 20.
SELECT E.APELLIDO ,E.OFICIO 
FROM EMPLE E 
WHERE E.DEPT_NO =20;
-- 11 Mostrar todos los datos de los empleados ordenados por apellido.
SELECT *
FROM EMPLE E
ORDER BY E.APELLIDO;
-- 12 Seleccionar los empleados cuyo oficio sea ʻVENDEDORʼ. Mostrar los datos
-- ordenados por apellido.
SELECT *
FROM EMPLE E
WHERE UPPER(E.OFICIO) LIKE ('VENDEDOR')
ORDER BY E.APELLIDO;
-- 13 Mostrar los empleados cuyo departamento sea 10 y cuyo oficio sea
-- ʻANALISTAʼ. Ordenar el resultado por apellido.
SELECT *
FROM EMPLE E
WHERE UPPER(E.OFICIO) LIKE ('VENDEDOR') 
AND E.DEPT_NO =10
ORDER BY E.APELLIDO;
-- 14 Mostrar los empleados que tengan un salario mayor que 200000 o que
-- pertenezcan al departamento número 20.
SELECT *
FROM EMPLE E
WHERE E.SALARIO>200000 OR E.DEPT_NO=20;
-- 15 Ordenar los empleados por oficio, y dentro de oficio por nombre.
SELECT *
FROM EMPLE E ,DEPART D
ORDER BY E.OFICIO ,D.DNOMBRE;
-- 16 Seleccionar de la tabla EMPLE los empleados cuyo apellido empiece por ʻAʼ.
SELECT * 
FROM EMPLE E 
WHERE E.APELLIDO LIKE ('A%');
-- 17 Seleccionar de la tabla EMPLE los empleados cuyo apellido termine por ʻZʼ.
SELECT * 
FROM EMPLE E 
WHERE E.APELLIDO LIKE ('%Z');
-- 18 Seleccionar de la tabla EMPLE aquellas filas cuyo APELLIDO empiece por
-- ʻAʼ y el OFICIO tenga una ʻEʼ en cualquier posición.
SELECT * 
FROM EMPLE E 
WHERE E.APELLIDO LIKE ('A%')
AND E.OFICIO LIKE ('%E%');
-- 19 Seleccionar los empleados cuyo salario esté entre 100000 y 200000. Utilizar
-- el operador BETWEEN.
SELECT * 
FROM EMPLE E 
WHERE E.SALARIO BETWEEN 100000 AND 200000;
-- 20 Obtener los empleados cuyo oficio sea ʻVENDEDORʼ y tengan una comisión
-- superior a 100000.
SELECT *
FROM EMPLE E
WHERE UPPER(E.OFICIO) LIKE ('VENDEDOR') 
AND E.COMISION >100000;
-- 21 Seleccionar los datos de los empleados ordenados por número de

-- departamento, y dentro de cada departamento ordenados por apellido.
SELECT *
FROM EMPLE E
ORDER BY E.DEPT_NO ,E.APELLIDO;
-- 22 Número y apellidos de los empleados cuyo apellido termine por ʻZʼ y tengan
-- un salario superior a 300000.
SELECT *
FROM EMPLE E
WHERE E.APELLIDO LIKE ('%Z')
AND E.COMISION >300000;
-- 23. Datos de los departamentos cuya localización empiece por ʻBʼ.
SELECT *
FROM DEPART D
WHERE D.LOC LIKE ('B%');
-- 24. Datos de los empleados cuyo oficio sea ʻEMPLEADOʼ, tengan un salario
-- superior a 100000 y pertenezcan al departamento número 10.
SELECT *
FROM EMPLE E
WHERE UPPER(E.OFICIO) LIKE ('EMPLEADO')
AND E.SALARIO>100000
AND E.DEPT_NO=10;
-- 25. Mostrar los apellidos de los empleados que no tengan comisión.
SELECT E.APELLIDO 
FROM EMPLE E
WHERE E.COMISION IS NULL;
-- 26. Mostrar los apellidos de los empleados que no tengan comisión y cuyo
-- apellido empiece por ʻJʼ.
SELECT E.APELLIDO 
FROM EMPLE E
WHERE E.COMISION IS NULL
AND E.APELLIDO LIKE ('J%');
-- 27. Mostrar los apellidos de los empleados cuyo oficio sea ʻVENDEDORʼ,
-- ʻANALISTAʼ o ʻEMPLEADOʼ.
SELECT E.APELLIDO 
FROM EMPLE E
WHERE UPPER(E.OFICIO) IN ('VENDEDOR','ANALISTA','EMPLEADO');
-- 28. Mostrar los apellidos de los empleados cuyo oficio no sea ni ʻANALISTAʼ ni
-- ʻEMPLEADOʼ, y además tengan un salario mayor de 200000.
SELECT E.APELLIDO 
FROM EMPLE E
WHERE UPPER(E.OFICIO) NOT IN ('ANALISTA','EMPLEADO')
AND E.SALARIO > 200000;
-- 29 Seleccionar de la tabla EMPLE los empleados cuyo salario esté entre
-- 2000000 y 3000000 (utilizar BETWEEN).
SELECT * 
FROM EMPLE E 
WHERE E.SALARIO BETWEEN 2000000 AND 3000000;
-- 30 Seleccionar el apellido, salario y número de departamento de los empleados
-- cuyo salario sea mayor que 200000 en los departamentos 10 ó 30.
SELECT E.APELLIDO ,E.SALARIO ,DEPT_NO 
FROM EMPLE E
WHERE E.SALARIO > 200000
AND (E.DEPT_NO = 10 OR E.DEPT_NO = 30);
-- 31. Mostrar el apellido y número de los empleados cuyo salario no esté entre
-- 100000 y 200000 (utilizar BETWEEN).
SELECT E.APELLIDO ,E.DIR 
FROM EMPLE E 
WHERE E.SALARIO NOT BETWEEN 100000 AND 200000;
-- 32.Obtener el apellidos de todos los empleados en minúscula.
SELECT LOWER(E.APELLIDO) 
FROM EMPLE E; 
-- 33.En una consulta concatena el apellido de cada empleado con su oficio.
SELECT CONCAT(E.APELLIDO,E.OFICIO) 
FROM EMPLE E;
-- 34. Mostrar el apellido y la longitud del apellido (función LENGTH) de todos
-- los empleados, ordenados por la longitud de los apellidos de los
-- empleados descendentemente.
SELECT E.APELLIDO ,LENGTH(E.APELLIDO)
FROM EMPLE E 
ORDER BY LENGTH(E.APELLIDO) DESC;
-- 35.Obtener el año de contratación de todos los empleados (función YEAR).
SELECT YEAR(E.FECHA_ALT)
FROM EMPLE E;
-- 36. Mostrar los datos de los empleados que hayan sido contratados en el
-- año 1992.
SELECT *
FROM EMPLE E
WHERE YEAR(E.FECHA_ALT)=1992;
-- 37. Mostrar los datos de los empleados que hayan sido contratados en el
-- mes de febrero de cualquier año (función MONTHNAME).
SELECT *
FROM EMPLE E
WHERE MONTHNAME(E.FECHA_ALT)='febrero';
-- 38. Para cada empleado mostrar el apellido y el mayor valor del salario y la
-- comisión que tienen.
SELECT E.APELLIDO ,E.COMISION  
FROM EMPLE E;
-- 39. Mostrar los datos de los empleados cuyo apellido empiece por 'A' y
-- hayan sido contratados en el año 1990.
SELECT * 
FROM EMPLE E 
WHERE E.APELLIDO LIKE ('A%') 
AND YEAR(E.FECHA_ALT)=1990;
-- 40. Mostrar los datos de los empleados del departamento 10 que no tengan
-- comisión.
SELECT *
FROM EMPLE E
WHERE E.COMISION IS NULL 
AND E.DEPT_NO=10;
