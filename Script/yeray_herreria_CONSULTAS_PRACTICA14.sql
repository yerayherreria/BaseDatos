--1. Nombre de los trabajadores cuya tarifa este entre 10 y 12 euros.
SELECT T.NOMBRE
FROM TRABAJADOR t 
WHERE T.TARIFA BETWEEN 10 AND 12;

--2. ¿Cuáles son los oficios de los trabajadores asignados al edificio 435?
SELECT T.OFICIO
FROM TRABAJADOR t ,ASIGNACION a
WHERE T.ID_T = A.ID_T 
AND A.ID_E = 435;

--3. Indicar el nombre del trabajador y el de su supervisor.
SELECT T.NOMBRE, T2.NOMBRE
FROM TRABAJADOR t, TRABAJADOR t2
WHERE T.ID_SUPV = T2.ID_T;

--4. Nombre de los trabajadores asignados a oficinas.
SELECT DISTINCT T.NOMBRE
FROM TRABAJADOR t ,ASIGNACION a ,EDIFICIO e 
WHERE A.ID_T = T.ID_T
AND A.ID_E = E.ID_E;

--5. ¿Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor?
SELECT T.NOMBRE
FROM TRABAJADOR t, TRABAJADOR t2
WHERE T.ID_SUPV = T2.ID_T
AND T.TARIFA > T2.TARIFA;

--6. ¿Cuál es el número total de días que se han dedicado a fontanería en el edificio 312?
SELECT A.NUM_DIAS 
FROM ASIGNACION a ,TRABAJADOR t 
WHERE A.ID_T = T.ID_T 
AND T.OFICIO LIKE 'FONTANERO'
AND A.ID_E = 312;

--7. ¿Cuántos tipos de oficios diferentes hay?
SELECT DISTINCT T.OFICIO
FROM TRABAJADOR t;

--8. Para cada supervisor, ¿Cuál es la tarifa por hora más alta que se paga a un trabajador
--que informa a esesupervisor?
SELECT max(T.TARIFA)
FROM TRABAJADOR t 
GROUP BY T.ID_SUPV;

--9. Para cada supervisor que supervisa a más de un trabajador, ¿cuál es la tarifa más alta
--que se para a un trabajador que informa a ese supervisor?
SELECT max(T.TARIFA)
FROM TRABAJADOR t 
GROUP BY T.ID_SUPV
HAVING COUNT(T.ID_T)>1;

--10. Para cada tipo de edificio, ¿Cuál es el nivel de calidad medio de los edificios con
--categoría 1? Considérense sólo aquellos tipos de edificios que tienen un nivel de calidad
--máximo no mayor que 3.
SELECT AVG(E.NIVEL_CALIDAD)
FROM EDIFICIO e
WHERE E.NIVEL_CALIDAD=1
GROUP BY E.TIPO;

--11. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio?
SELECT T.NOMBRE
FROM TRABAJADOR t
WHERE T.TARIFA < (SELECT AVG(T2.TARIFA) FROM TRABAJADOR t2);

--12. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los
--trabajadores que tienen su mismo oficio?
SELECT T.NOMBRE
FROM TRABAJADOR t
WHERE T.TARIFA < (SELECT AVG(T2.TARIFA) FROM TRABAJADOR t2 WHERE T2.OFICIO = t.OFICIO);

--13. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los
--trabajadores que dependen del mismo supervisor que él?
SELECT T.NOMBRE
FROM TRABAJADOR t
WHERE T.TARIFA < (SELECT AVG(T2.TARIFA) FROM TRABAJADOR t2,TRABAJADOR t3  WHERE T2.ID_SUPV = T3.ID_T);

--14. Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que
--empezaron a trabajar enél.
SELECT T.NOMBRE ,A.FECHA_INICIO
FROM TRABAJADOR t ,ASIGNACION a 
WHERE T.ID_T = A.ID_T 
AND T.OFICIO LIKE 'ELECTRICISTA'
AND A.ID_E = 435;

--15. ¿Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de
--los 12 euros?
SELECT T.NOMBRE
FROM TRABAJADOR t
WHERE 12 < (SELECT AVG(T2.TARIFA) FROM TRABAJADOR t2,TRABAJADOR t3  WHERE T2.ID_SUPV = T3.ID_T);
