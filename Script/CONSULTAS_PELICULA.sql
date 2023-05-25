--1. Obtén las diferentes ciudades donde hay cines
SELECT DISTINCT C.CIUDAD_CINE
FROM CINE c;
--2. Obtener las películas con un presupuesto mayor de 2000 o cuya duración 
--sea superior a 100.
SELECT P.TITULO_P
FROM PELICULA p 
WHERE P.PRESUPUESTO > 2000 
AND P.DURACION > 100;
--3. Obtener las películas cuyo título (da igual el original o el español) 
--contenga la cadena la sin importar que esté en mayúsculas o minúsculas.
SELECT P.CIP
FROM PELICULA p 
WHERE UPPER(P.TITULO_P) LIKE '%LA%';
--4. Obtener el nombre y la nacionalidad de los personajes que sean hombres 
--ordenado por nacionalidad y nombre.
SELECT P.NOMBRE_PERSONA ,P.NACIONALIDAD_PERSONA 
FROM PERSONAJE p 
WHERE P.SEXO_PERSONA LIKE 'H';
--5. Obtener las películas estrenadas en el mes de septiembre.
SELECT P.CIP
FROM PROYECCION p 
WHERE EXTRACT(MONTH FROM(P.FECHA_ESTRENO))=09;
--6. Obtener las diferentes tareas que ha desempeñado alguna persona alguna vez.
SELECT DISTINCT T.TAREA,T.NOMBRE_PERSONA 
FROM TRABAJO t;
--7. Obtener el numero de sala y el aforo de todas las salas de los cines que 
--terminen en vocal.
SELECT S.SALA ,S.AFORO
FROM SALA s 
WHERE S.CINE LIKE '%a' OR  S.CINE LIKE '%e' OR  S.CINE LIKE '%i' OR  S.CINE LIKE '%o' OR  S.CINE LIKE '%u';
--8. Obtener las distintas ciudades que tienen cines con alguna sala 
--con aforo superior a 100 ordenadas por el nombre de la ciudad de la z a la a.
SELECT DISTINCT C.CIUDAD_CINE
FROM CINE c ,SALA s 
WHERE S.AFORO >100 
ORDER BY C.CIUDAD_CINE DESC;
--9. Obtener los títulos (ambos) y la nacionalidad de las películas que hayan 
--obtenido una recaudación en alguna sala 10000 mayor que su presupuesto ordenadas 
--de mayor a menor beneficio.
SELECT P.TITULO_P ,P.TITULO_S ,P.NACIONALIDAD 
FROM PELICULA p ,PROYECCION p2 
WHERE P.CIP = P2.CIP 
AND P2.RECAUDACION >10000
ORDER BY P2.RECAUDACION DESC;
--10. Obtener el nombre de los actores hombres que participen en la película Viaje 
--al centro de la tierra.
SELECT T.NOMBRE_PERSONA 
FROM PELICULA p ,TRABAJO t
WHERE P.TITULO_P LIKE 'Viaje al centro de la tierra'
AND P.CIP = T.CIP;
--11. Obtener el nombre del cine y el número de películas diferentes estrenadas 
--por cada cine ordenadas por el número de películas ordenadas de mayor a menor.
SELECT DISTINCT P.CINE ,COUNT(P.CIP) AS NUMERO_PELICULAS
FROM PROYECCION p
GROUP BY P.CINE
ORDER BY COUNT(P.CIP) DESC;
--12. Obtener el nombre y nacionalidad de las personas que hayan trabajado en 
--alguna película de diferente nacionalidad a la suya.
SELECT P.NOMBRE_PERSONA  ,P.NACIONALIDAD_PERSONA
FROM PERSONAJE p ,TRABAJO t ,PELICULA p2 
WHERE P.NOMBRE_PERSONA =T.NOMBRE_PERSONA 
AND T.CIP =P2.CIP
AND P.NACIONALIDAD_PERSONA != P2.NACIONALIDAD;
--13. Obtener por cada cine, el nombre, las salas y el nombre de la película.
SELECT P.CINE ,P.SALA , P2.TITULO_P
FROM PROYECCION p ,PELICULA p2 
WHERE P.CIP = P2.CIP;
--14. Obtener la recaudación total de cada cine ordenada de mayor a menor recaudación 
--total.
SELECT SUM(P.RECAUDACION)
FROM PROYECCION p 
GROUP BY (P.CIP);
--15. Obtener aquellas personas que hayan realizado una tarea cuyo sexo sea diferente 
--al suyo, teniendo en cuenta que para productor y director no hay un sexo definido.
SELECT T.NOMBRE_PERSONA 
FROM TRABAJO t ,TAREA t2 ,PERSONAJE p 
WHERE T.TAREA = T2.TAREA 
AND P.NOMBRE_PERSONA = T.NOMBRE_PERSONA 
AND P.SEXO_PERSONA != T2.SEXO_TAREA;
--16. Obtener el título, al año de producción, el presupuesto y la recaudación total 
--de las películas que han sido proyectadas en algún cine de la ciudad de Córdoba.
SELECT P.TITULO_P ,P.ANO_PRODUCCION ,P.PRESUPUESTO ,(P2.RECAUDACION)  
FROM PELICULA p ,PROYECCION p2 ,SALA s ,CINE c
WHERE P.CIP =P2.CIP 
AND S.CINE = P2.CINE 
AND S.SALA = P2.SALA
AND S.CINE = C.CINE 
AND C.CIUDAD_CINE LIKE 'Cordoba';
--17. Obtener el título de las películas cuya recaudación por espectador (con 2 
--decimales) sea mayor de 700.
SELECT P.TITULO_P  
FROM PELICULA p ,PROYECCION p2 
WHERE P.CIP =P2.CIP 
AND P2.RECAUDACION > 700;
--18. Obtener el nombre de los actores que han participado en más de 2 películas.
SELECT T.NOMBRE_PERSONA
FROM TRABAJO t
GROUP BY (T.NOMBRE_PERSONA)
HAVING COUNT(T.CIP)>2;