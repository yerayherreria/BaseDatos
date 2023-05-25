-- 1 Averigua el DNI de todos los clientes.
SELECT c.DNI 
FROM CLIENTE c;
-- 2 Consulta todos los datos de todos los programas.
SELECT * FROM PROGRAMA p;
-- 3 Obtén un listado con los nombres de todos los programas.
SELECT p.NOMBRE
FROM PROGRAMA p;
-- 4 Genera una lista con todos los comercios.
SELECT * FROM COMERCIO c;
-- 5 Genera una lista de las ciudades con establecimientos donde se venden
-- programas, sin que aparezcan valores duplicados (utiliza DISTINCT).
SELECT DISTINCT c.NOMBRE 
FROM COMERCIO c ,DISTRIBUYE d 
WHERE c.CIF = d.CIF;
-- 6 Obtén una lista con los nombres de programas, sin que aparezcan valores
-- duplicados (utiliza DISTINCT).
SELECT DISTINCT p.NOMBRE
FROM PROGRAMA p;
-- 7 Obtén el DNI más 4 de todos los clientes.
SELECT c.DNI + 4 AS DNI
FROM CLIENTE c;
-- 8 Haz un listado con los códigos de los programas multiplicados por 7.
SELECT p.CODIGO * 7 AS CODIGO 
FROM PROGRAMA p;
-- 9 ¿Cuáles son los programas cuyo código es inferior o igual a 10?
SELECT p.NOMBRE  
FROM PROGRAMA p
WHERE p.CODIGO <= 10;
-- 10 ¿Cuál es el programa cuyo código es 11?
SELECT p.NOMBRE  
FROM PROGRAMA p
WHERE p.CODIGO = 11;
-- 11 ¿Qué fabricantes son de Estados Unidos?
SELECT f.NOMBRE 
FROM FABRICANTE f
WHERE f.PAIS LIKE 'Estados Unidos';
-- 12 ¿Cuáles son los fabricantes no españoles? Utilizar el operador IN.
SELECT f.NOMBRE 
FROM FABRICANTE f
WHERE f.PAIS NOT IN ('Español');
-- 13 Obtén un listado con los códigos de las distintas versiones de Windows.
SELECT p.VERSION2 
FROM PROGRAMA p 
WHERE p.NOMBRE LIKE 'Windows';
-- 14 ¿En qué ciudades comercializa programas El Corte Inglés?
SELECT c.CIUDAD
FROM COMERCIO c 
WHERE c.NOMBRE LIKE 'El Corte Ingles';
-- 15 ¿Qué otros comercios hay, además de El Corte Inglés? Utilizar el operador
-- IN.
SELECT c.NOMBRE
FROM COMERCIO c 
WHERE c.NOMBRE NOT IN ('El Corte Ingles');
-- 16 Genera una lista con los códigos de las distintas versiones de Windows y
-- Access. Utilizar el operador IN.
SELECT DISTINCT p.VERSION2 
FROM PROGRAMA p 
WHERE p.NOMBRE IN ('Windows','Access');
-- 17 Obtén un listado que incluya los nombres de los clientes de edades
-- comprendidas entre 10 y 25 y de los mayores de 50 años. Da una solución con
-- BETWEEN y otra sin BETWEEN.
SELECT c.NOMBRE
FROM CLIENTE c 
WHERE (c.EDAD BETWEEN 10 AND 25)
OR c.EDAD > 50;
-- 18 Saca un listado con los comercios de Sevilla y Madrid. No se admiten
-- valores duplicados.
SELECT DISTINCT c.NOMBRE 
FROM COMERCIO c 
WHERE c.NOMBRE IN ('Sevilla','Madrid');
-- 19 ¿Qué clientes terminan su nombre en la letra “o”?
SELECT c.NOMBRE
FROM CLIENTE c 
WHERE c.NOMBRE LIKE '%o';
-- 20 ¿Qué clientes terminan su nombre en la letra “o” y, además, son mayores de
-- 30 años?
SELECT c.NOMBRE
FROM CLIENTE c 
WHERE c.NOMBRE LIKE '%o'
AND c.EDAD>30;
-- 21 Obtén un listado en el que aparezcan los programas cuya versión finalice
-- por una letra i, o cuyo nombre comience por una A o por una W.
SELECT p.NOMBRE
FROM PROGRAMA p 
WHERE p.NOMBRE LIKE '%i' OR p.NOMBRE LIKE 'A%' OR p.NOMBRE LIKE 'W%';
-- 22 Obtén un listado en el que aparezcan los programas cuya versión finalice
-- por una letra i, o cuyo nombre comience por una A y termine por una S.
SELECT p.NOMBRE
FROM PROGRAMA p 
WHERE p.NOMBRE LIKE '%i' OR p.NOMBRE LIKE 'A%' OR p.NOMBRE LIKE '%S';
-- 23 Obtén un listado en el que aparezcan los programas cuya versión finalice
-- por una letra i, y cuyo nombre no comience por una A.
SELECT p.NOMBRE
FROM PROGRAMA p 
WHERE p.NOMBRE LIKE '%i' OR p.NOMBRE NOT LIKE 'A%';
-- 24 Obtén una lista de empresas por orden alfabético ascendente.
SELECT c.NOMBRE
FROM COMERCIO c 
ORDER BY c.NOMBRE ASC;
-- 25 Genera un listado de empresas por orden alfabético descendente.
SELECT c.NOMBRE
FROM COMERCIO c 
ORDER BY c.NOMBRE DESC;
