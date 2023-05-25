
--1.Cuantos costes básicos hay.
SELECT COUNT(A.COSTEBASICO)
FROM ASIGNATURA a;
--2.Para cada titulación mostrar el número de asignaturas que hay junto con el nombre de la titulación.
SELECT T.NOMBRE ,COUNT(A.IDASIGNATURA)
FROM TITULACION t ,ASIGNATURA a 
WHERE T.IDTITULACION =A.IDTITULACION 
GROUP BY T.NOMBRE;
--3.Para cada titulación mostrar el nombre de la titulación junto con el precio total de todas sus asignaturas.
SELECT T.NOMBRE ,SUM(A.COSTEBASICO)
FROM TITULACION t ,ASIGNATURA a 
WHERE T.IDTITULACION =A.IDTITULACION 
GROUP BY T.NOMBRE;
--4.Cual sería el coste global de cursar la titulación de Matemáticas si el coste de cada asignatura fuera incrementado en un 7%. 
SELECT AVG((A.COSTEBASICO *0.07) + A.COSTEBASICO) AS COSTE_GLOBAL
FROM TITULACION t ,ASIGNATURA a 
WHERE T.IDTITULACION =A.IDTITULACION
AND T.NOMBRE LIKE 'Matematicas';
--5.Cuantos alumnos hay matriculados en cada asignatura, junto al id de la asignatura. 
SELECT AA.IDASIGNATURA ,COUNT(AA.IDALUMNO)
FROM ALUMNO_ASIGNATURA aa 
GROUP BY AA.IDASIGNATURA;
--6.Igual que el anterior pero mostrando el nombre de la asignatura.
SELECT A.NOMBRE ,COUNT(AA.IDALUMNO)
FROM ALUMNO_ASIGNATURA aa ,ASIGNATURA a 
WHERE AA.IDASIGNATURA = A.IDASIGNATURA 
GROUP BY A.NOMBRE;
--7.Mostrar para cada alumno, el nombre del alumno junto con lo que tendría que pagar por el total de todas las asignaturas en las que está matriculada. Recuerda que el precio de la matrícula tiene un incremento de un 10% por cada año en el que esté matriculado. 
SELECT P.NOMBRE,SUM(AA.COSTEBASICO),(AA.COSTEBASICO*ASIG.NUMEROMATRICULA)*0.1 AS PRECIO
FROM PERSONA P,ASIGNATURA AA,ALUMNO AL ,ALUMNO_ASIGNATURA ASIG
WHERE P.DNI=AL.DNI
AND AL.IDALUMNO=ASIG.IDALUMNO
AND ASIG.IDASIGNATURA=AA.IDASIGNATURA
GROUP BY P.NOMBRE,AA.COSTEBASICO,ASIG.NUMEROMATRICULA;
--8.Coste medio de las asignaturas de cada titulación, para aquellas titulaciones en el que el coste total de la 1ª matrícula sea mayor que 60 euros. 
SELECT AVG(A.COSTEBASICO)
FROM TITULACION t ,ASIGNATURA a ,ALUMNO_ASIGNATURA aa 
WHERE T.IDTITULACION = A.IDTITULACION 
AND A.IDASIGNATURA = AA.IDASIGNATURA
AND AA.NUMEROMATRICULA =1
GROUP BY T.NOMBRE 
HAVING SUM(A.COSTEBASICO)>60;
--9.Nombre de las titulaciones que tengan más de tres alumnos.
SELECT T.NOMBRE
FROM TITULACION t ,ASIGNATURA a ,ALUMNO_ASIGNATURA aa 
WHERE T.IDTITULACION = A.IDTITULACION 
AND A.IDASIGNATURA = AA.IDASIGNATURA
GROUP BY T.NOMBRE
HAVING COUNT(AA.IDALUMNO)>3;
--10.Nombre de cada ciudad junto con el número de personas que viven en ella.
SELECT P.CIUDAD ,COUNT(P.NOMBRE)
FROM PERSONA p 
GROUP BY P.CIUDAD;
--11.Nombre de cada profesor junto con el número de asignaturas que imparte.
SELECT P.NOMBRE , COUNT(A.IDASIGNATURA)
FROM PERSONA p ,PROFESOR p2 ,ASIGNATURA a 
WHERE P.DNI = P2.DNI 
AND P2.IDPROFESOR  = A.IDPROFESOR 
GROUP BY P.NOMBRE;
--12.Nombre de cada profesor junto con el número de alumnos que tiene, para aquellos profesores que tengan dos o más de 2 alumnos.
SELECT P.NOMBRE , COUNT(AA.IDALUMNO)
FROM PERSONA p ,PROFESOR p2 ,ASIGNATURA a ,ALUMNO_ASIGNATURA aa 
WHERE P.DNI = P2.DNI 
AND P2.IDPROFESOR  = A.IDPROFESOR 
AND A.IDASIGNATURA = AA.IDASIGNATURA 
GROUP BY P.NOMBRE
HAVING COUNT(AA.IDALUMNO)>2;
--13.Obtener el máximo de las sumas de los costesbásicos de cada cuatrimestre
SELECT MAX(SUM(A.COSTEBASICO))
FROM ASIGNATURA a 
GROUP BY A.CUATRIMESTRE;
--14.Suma del coste de las asignaturas
SELECT SUM(A.COSTEBASICO)
FROM ASIGNATURA a;
--15.¿Cuántas asignaturas hay?
SELECT COUNT(A.IDASIGNATURA)
FROM ASIGNATURA a;
--16.Coste de la asignatura más cara y de la más barata
SELECT MAX(A.COSTEBASICO),MIN(A.COSTEBASICO)
FROM ASIGNATURA a;
--17.¿Cuántas posibilidades de créditos de asignatura hay?
SELECT VARIANCE(A.CREDITOS)
FROM ASIGNATURA a;
--18.¿Cuántos cursos hay?
SELECT COUNT(A.CURSO)
FROM ASIGNATURA a;
--19.¿Cuántas ciudades hau?
SELECT COUNT(P.CIUDAD)
FROM PERSONA p;
--20.Nombre y número de horas de todas las asignaturas.
SELECT A.NOMBRE , A.CREDITOS * 10 AS NUM_HORA
FROM ASIGNATURA a;
--21.Mostrar las asignaturas que no pertenecen a ninguna titulación.
SELECT A.NOMBRE
FROM ASIGNATURA a
WHERE A.IDTITULACION IS NULL;
--22.Listado del nombre completo de las personas, sus teléfonos y sus direcciones, llamando a la columna del nombre "NombreCompleto" y a la de direcciones "Direccion".
SELECT P.NOMBRE ||' '||P.APELLIDO AS NOMBRE_COMPLETOS,P.TELEFONO ,P.DIRECCIONCALLE ||' '||P.DIRECCIONNUM AS DIRECCION
FROM PERSONA p;
--23.Cual es el día siguiente al día en que nacieron las personas de la B.D.
SELECT SUM(EXTRACT(DAY FROM P.FECHA_NACIMIENTO+1)) AS DIA_NACIMIENTO
FROM PERSONA p
GROUP BY P.DNI;
--24.Años de las personas de la Base de Datos, esta consulta tiene que valor para cualquier momento
SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT( YEAR FROM P.FECHA_NACIMIENTO) AS AÑOS
FROM PERSONA p;
--25.Listado de personas mayores de 25 años ordenadas por apellidos y nombre, esta consulta tiene que valor para cualquier momento
SELECT P.NOMBRE ,P.APELLIDO
FROM PERSONA p
GROUP BY P.NOMBRE ,P.APELLIDO
HAVING SUM(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM P.FECHA_NACIMIENTO))>25
ORDER BY APELLIDO,NOMBRE;
--26.Nombres completos de los profesores que además son alumnos
SELECT P.NOMBRE ||' '||P.APELLIDO AS NOMBRE_COMPLETO
FROM PERSONA p,PROFESOR p2,ALUMNO a
WHERE A.DNI =P.DNI
AND P2.DNI=P.DNI;
--27.Suma de los créditos de las asignaturas de la titulación de Matemáticas
SELECT SUM(A.CREDITOS)
FROM ASIGNATURA a,TITULACION t
WHERE T.IDTITULACION=A.IDTITULACION
AND T.NOMBRE LIKE 'Matematicas';
--28.Número de asignaturas de la titulación de Matemáticas
SELECT COUNT(A.IDASIGNATURA)
FROM ASIGNATURA a,TITULACION t
WHERE T.IDTITULACION=A.IDTITULACION
AND T.NOMBRE LIKE 'Matematicas';
--29.¿Cuánto paga cada alumno por su matrícula?
SELECT SUM(A.COSTEBASICO) AS PRECIO
FROM ASIGNATURA a ,ALUMNO_ASIGNATURA aa
WHERE A.IDASIGNATURA=AA.IDASIGNATURA
GROUP BY AA.IDALUMNO;
--30.¿Cuántos alumnos hay matriculados en cada asignatura?
SELECT COUNT(AA.IDALUMNO)
FROM ALUMNO_ASIGNATURA aa
GROUP BY AA.IDASIGNATURA; 