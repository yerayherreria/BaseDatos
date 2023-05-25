--1.Teniendo en cuenta los residuos generados por todas las empresas, mostrar el código del residuo que más se ha generado por todas ellas.
SELECT *
FROM (SELECT RE.COD_RESIDUO
FROM RESIDUO_EMPRESA re
ORDER BY RE.CANTIDAD DESC)
WHERE ROWNUM=1;
--2.Mostrar el nombre de la empresa transportista que sólo trabajó para la empresa con nif R-12356711-Q
SELECT DISTINCT E.NOMBRE_EMPTRANSPORTE 
FROM EMPRESATRANSPORTISTA e ,TRASLADO t 
WHERE T.NIF_EMPTRANSPORTE = E.NIF_EMPTRANSPORTE 
AND T.NIF_EMPRESA = (SELECT E2.NIF_EMPRESA 
					FROM EMPRESAPRODUCTORA e2
					WHERE E2.NIF_EMPRESA LIKE 'R-12356711-Q');
--3.Mostrar el nombre de la empresa transportitas que realizó el primer transporte que está registrado en la base de datos.
SELECT *
FROM (SELECT E.NOMBRE_EMPTRANSPORTE 
FROM EMPRESATRANSPORTISTA e ,TRASLADO t 
WHERE T.NIF_EMPTRANSPORTE = E.NIF_EMPTRANSPORTE 
ORDER BY T.FECHA_ENVIO)
WHERE ROWNUM=1;
--4.Mostrar todas las características de los traslados, para aquellos traslados cuyo coste sea superior a la media de todos los traslados.
SELECT *
FROM TRASLADO t 
WHERE T.COSTE > (SELECT AVG(NVL(T2.COSTE,0))
FROM TRASLADO t2);
--5.Obtener el nombre de las ciudades más cercanas entre las que se ha realizado un envío.
SELECT DISTINCT E.CIUDAD_EMPRESA ,D.CIUDAD_DESTINO 
FROM EMPRESAPRODUCTORA e ,TRASLADO t ,DESTINO d
WHERE E.NIF_EMPRESA = T.NIF_EMPRESA 
AND T.COD_DESTINO = D.COD_DESTINO 
AND T.KMS = (SELECT MIN(T2.KMS)
FROM TRASLADO t2);
--6.Obtener el nombre de las empresas que nunca han utilizado el Ferrocarril como medio de transporte.
CREATE VIEW CURRO 
(NOMBRE)
AS
SELECT DISTINCT E.NOMBRE_EMPTRANSPORTE 
FROM EMPRESATRANSPORTISTA e ,TRASLADO t 
WHERE T.NIF_EMPTRANSPORTE = E.NIF_EMPTRANSPORTE 
AND T.NIF_EMPTRANSPORTE NOT IN (SELECT T2.NIF_EMPTRANSPORTE 
FROM TRASLADO t2
WHERE T.TIPO_TRANSPORTE LIKE 'Ferrocaril');
--7.Obtener el nombre de la empresa que ha realizado más envíos a Madrid.
SELECT e.NOMBRE_EMPRESA 
FROM EMPRESAPRODUCTORA e 
WHERE e.NIF_EMPRESA  = (SELECT * FROM (SELECT t.NIF_EMPRESA 
		                            FROM DESTINO d JOIN TRASLADO t ON t.COD_DESTINO = d.COD_DESTINO 
		                            WHERE d.CIUDAD_DESTINO  LIKE 'Madrid'
		                            GROUP BY t.NIF_EMPRESA
		                        ORDER BY count(t.COD_DESTINO) DESC) 
                        WHERE rownum=1);
--8.	Vamos a crear una nueva tabla llamada envios, que tendrá un campo llamdo Ciudad_destino, otro
--llamado ciudad_origen, y otro cantidad_total, en la que guardaremos donde van los residuos. La primary key de la tabla debe ser ciudad_destino y ciudad_origen, así podremos evitar que metan dos registros con la misma ciudad destino y origen.
--Cargar dicha tabla con los registros oportunos según nuestra base de datos, teniendo en cuenta que en cantidad total se debe guardar el total de las cantidades que se ha enviado desde ciudad_origen a ciudad_destino
CREATE TABLE ENVIOS(
	CIUDAD_DESTINO VARCHAR2(15),	
	CIUDAD_ORIGEN VARCHAR2(15),	
	CANTIDAD_TOTAL NUMBER(10),
	CONSTRAINT PK_ENVIOS PRIMARY KEY (CIUDAD_DESTINO,CIUDAD_ORIGEN)
);
INSERT INTO ENVIOS (CIUDAD_DESTINO,CIUDAD_ORIGEN,CANTIDAD_TOTAL) SELECT D.CIUDAD_DESTINO ,E.CIUDAD_EMPRESA ,SUM(T.CANTIDAD)
														FROM EMPRESAPRODUCTORA e JOIN TRASLADO t
														ON E.NIF_EMPRESA =T.NIF_EMPRESA JOIN DESTINO d 
														ON T.COD_DESTINO = D.COD_DESTINO
														GROUP BY D.CIUDAD_DESTINO,E.CIUDAD_EMPRESA; 
SELECT * FROM ENVIOS;
--9.Vamos a modificar la tabla residuo para añadir un nuevo campo llamado num_constituyentes. Una vez hayas añadido el nuevo campo crea la sentencia sql necesaria para que este campo tomen los valores adecuados.
ALTER TABLE RESIDUO ADD NUM_CONSTITUYENTES NUMBER(20);
UPDATE RESIDUO R 
SET R.NUM_CONSTITUYENTES = (SELECT COUNT(RC.COD_CONSTITUYENTE)
							FROM RESIDUO_CONSTITUYENTE rc,RESIDUO r2
						WHERE RC.COD_RESIDUO=R2.COD_RESIDUO
						AND R2.COD_RESIDUO = R.COD_RESIDUO
						GROUP BY R2.COD_RESIDUO);
SELECT * FROM RESIDUO r;
--10.	Modifica la tabla empresaproductora añadiendo un campo nuevo llamado nif, que es el nif de la empresa matriz, es decir, de la que depende, por lo que este nuevo campo será una fk sobre el campo nif_empresa. Mostrar un listado en donde salga el nombre de la empresa matriz y el nombre de la empresa de la que depende ordenado por empresa matriz. El nuevo campo llamado nif tomará valores nulos cuando se trate de una empresa que no depende de nadie. No es necesario hacer los cambios, sólo la consulta.
ALTER TABLE EMPRESAPRODUCTORA ADD NIF VARCHAR2(10);
ALTER TABLE EMPRESAPRODUCTORA ADD CONSTRAINT FK_NIFRE FOREIGN KEY (NIF) REFERENCES EMPRESAPRODUCTORA(NIF_EMPRESA) ON DELETE CASCADE;

SELECT E.NIF_EMPRESA AS EMPRESA_MATRIZ, E.NIF AS EMPRESA_DEPENDE
FROM EMPRESAPRODUCTORA e
WHERE E.NIF_EMPRESA = E.NIF
ORDER BY E.NIF_EMPRESA;