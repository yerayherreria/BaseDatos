--1. Teniendo en cuenta los residuos generados por todas las empresas,
--mostrar el código del residuo que más se ha generado por todas ellas.
SELECT *
FROM (SELECT RE.COD_RESIDUO
FROM RESIDUO_EMPRESA re
ORDER BY RE.COD_RESIDUO DESC)
WHERE ROWNUM=1;
--2. Mostrar el nombre dela empresa transportista que sólo trabajó para la empresa con nif R-12356711-Q
SELECT  E.NOMBRE_EMPTRANSPORTE 
FROM EMPRESATRANSPORTISTA e,TRASLADO t,EMPRESAPRODUCTORA e2 
WHERE E.NIF_EMPTRANSPORTE = T.NIF_EMPTRANSPORTE 
AND T.NIF_EMPRESA = E2.NIF_EMPRESA 
AND E2.NOMBRE_EMPRESA = (SELECT E.NOMBRE_EMPRESA 
                         FROM EMPRESAPRODUCTORA e 
                         WHERE E.NIF_EMPRESA LIKE 'R-12356711-Q');
--3. Mostrar el nombre de la empresa transportitas que realizó el primer transporte que está registrado en la base de datos.
SELECT * FROM(SELECT E.NOMBRE_EMPTRANSPORTE 
				FROM EMPRESATRANSPORTISTA e ,TRASLADO t
				WHERE E.NIF_EMPTRANSPORTE = T.NIF_EMPTRANSPORTE 
				ORDER BY T.FECHA_ENVIO)
WHERE ROWNUM=1;
--4. Mostrar todas las características de los traslados,
--para aquellos traslados cuyo coste sea superior a la media de todos los traslados.
SELECT *
FROM TRASLADO t 
WHERE T.COSTE > (SELECT AVG(NVL(T2.COSTE,0)) AS MEDIA
FROM TRASLADO t2);
--5. Obtener el nombre de las ciudades más cercanas entre las que se ha realizado un envío.
SELECT * FROM(SELECT D.CIUDAD_DESTINO 
                FROM TRASLADO t,DESTINO d 
                WHERE T.COD_DESTINO = D.COD_DESTINO
                ORDER BY T.KMS ASC)
WHERE ROWNUM <= 3;
--6. Obtener el nombre de las empresas que nunca han utilizado el Ferrocarril como medio de transporte.
SELECT E.NOMBRE_EMPTRANSPORTE 
FROM EMPRESATRANSPORTISTA e
WHERE E.NIF_EMPTRANSPORTE  NOT IN (SELECT T.NIF_EMPTRANSPORTE 
								FROM TRASLADO t
								WHERE T.TIPO_TRANSPORTE LIKE 'Ferrocarril');
--7. Obtener el nombre de la empresa que ha realizado más envíos a Madrid.
SELECT e.NOMBRE_EMPRESA 
FROM EMPRESAPRODUCTORA e 
WHERE e.NIF_EMPRESA = (SELECT * FROM (SELECT t.NIF_EMPRESA 
										FROM TRASLADO t , DESTINO d 
										WHERE t.COD_DESTINO = d.COD_DESTINO 
										AND d.CIUDAD_DESTINO LIKE 'Madrid'
										ORDER BY t.CANTIDAD DESC )
						WHERE rownum=1)
--8. Vamos a crear una nueva tabla llamada envios,que tendrá un campo llamdo Ciudad_destino,
--otro llamado ciudad_origen, y otro cantidad_total,
--en la que guardaremos donde van los residuos. La PRIMARY KEY de la tabla debe ser ciudad_destino y ciudad_origen,
--así podremos evitar que metan dos registros con la misma ciudad destino y origen.
--Cargar dicha tabla con los registros oportunos según nuestra base de datos,
--teniendo en cuenta que en cantidad total se debe guardar el total de las cantidades que se ha enviado desde ciudad_origen a ciudad_destino      
--9. Vamos a modificar la tabla residuo para añadir un nuevo campo llamado num_constituyentes. Una vez hayas añadido el nuevo campo crea la sentencia SQL necesaria para que este campo tomen los valores adecuados.
--10. Modifica la tabla empresaproductora añadiendo un campo nuevo llamado nif, que es el nif de la empresa matriz, es decir, de la que depende, por lo que este nuevo campo será una fk sobre el campo nif_empresa. Mostrar un listado en donde salga el nombre de la empresa matriz y el nombre de la empresa de la que depende ordenado por empresa matriz. El nuevo campo llamado nif tomará valores nulos cuando se trate de una empresa que no depende de nadie. No es necesario hacer los cambios, sólo la consulta.