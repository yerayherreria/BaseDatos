--1. Número de clientes que tienen alguna factura con IVA 16%.
SELECT COUNT(C.CODCLI)
FROM CLIENTES c ,FACTURAS f2 
WHERE C.CODCLI = F2.CODCLI 
AND F2.IVA IN (SELECT IVA 
FROM FACTURAS f
WHERE F.IVA=16);
--2. Número de clientes que no tienen ninguna factura con un 16% de IVA.
SELECT COUNT(C.CODCLI)
FROM CLIENTES c ,FACTURAS f2 
WHERE C.CODCLI = F2.CODCLI 
AND F2.IVA NOT IN (SELECT IVA 
FROM FACTURAS f
WHERE F.IVA=16);
--3. Número de clientes que en todas sus facturas tienen un 16% de IVA (los clientes deben tener al menos una factura).
SELECT COUNT(C.CODCLI)
FROM CLIENTES c ,FACTURAS f2 
WHERE C.CODCLI = F2.CODCLI 
AND F2.IVA = ALL (SELECT IVA 
FROM FACTURAS f
WHERE F.IVA=16);
--4. Fecha de la factura con mayor importe (sin tener en cuenta descuentos ni impuestos).
SELECT F2.FECHA 
FROM FACTURAS f2,LINEAS_FAC lf2 
WHERE LF2.CODFAC =F2.CODFAC 
AND LF2.PRECIO =(SELECT MAX(LF.PRECIO)
FROM FACTURAS f ,LINEAS_FAC lf 
WHERE F.CODFAC = LF.CODFAC);
--5. Número de pueblos en los que no tenemos clientes.
SELECT COUNT(C2.CODPUE)
FROM CLIENTES c2 
WHERE C2.CODPUE =
(SELECT COUNT(C.CODCLI)
FROM CLIENTES c 
WHERE C.CODPUE IS NULL);
--6. Número de artículos cuyo stock supera las 20 unidades, con precio superior a 15 euros y de los que no hay ninguna factura en el último trimestre del año pasado.
SELECT COUNT(a.CODART)
FROM ARTICULOS a, LINEAS_FAC lf
WHERE a.CODART = lf.CODART
AND a.STOCK >20
AND lf.PRECIO >15
AND lf.CODFAC NOT IN (SELECT CODFAC FROM FACTURAS
WHERE EXTRACT(YEAR FROM FECHA) = EXTRACT(YEAR FROM SYSDATE -1) 
AND EXTRACT(MONTH FROM FECHA) BETWEEN 10 AND 12);				
--7. Obtener el número de clientes que en todas las facturas del año pasado han pagado IVA (no se ha pagado IVA si es cero o nulo).
SELECT COUNT(CODCLI)
FROM FACTURAS
WHERE CODCLI NOT IN (SELECT F.CODCLI FROM FACTURAS F 
WHERE EXTRACT(YEAR FROM F.FECHA)=EXTRACT(YEAR FROM SYSDATE)-1
AND (F.IVA =0 OR F.IVA IS NULL));
--8. Clientes (código y nombre) que fueron preferentes durante el mes de noviembre del año pasado y que en diciembre de ese mismo año 
--no tienen ninguna factura. Son clientes preferentes de un mes aquellos que han solicitado más de 60,50 euros en facturas durante ese mes, 
--sin tener en cuenta descuentos ni impuestos.
SELECT c.CODCLI , c.NOMBRE 
FROM CLIENTES c , FACTURAS f 
WHERE c.CODCLI = f.CODCLI 
AND EXTRACT (YEAR FROM f.FECHA) = EXTRACT (YEAR FROM SYSDATE)-1
AND EXTRACT (MONTH FROM f.FECHA) IN (11, 12)
AND f.CODFAC IN (SELECT lf.CODFAC 
FROM LINEAS_FAC lf
WHERE lf.CANT * lf.PRECIO >60.5 );
--9. Código, descripción y precio de los diez artículos más caros.
SELECT *
FROM (SELECT a.CODART , a.DESCRIP, a.PRECIO
FROM ARTICULOS a
ORDER BY a.PRECIO DESC)
WHERE ROWNUM <=10;
--10. Nombre de la provincia con mayor número de clientes.
SELECT *
FROM (SELECT pc.NOMBRE, COUNT(c.CODCLI) 
FROM CLIENTES c , PUEBLOS p, PROVINCIAS pc
WHERE c.CODPUE = p.CODPUE
AND p.CODPRO = pc.CODPRO
GROUP BY pc.NOMBRE
ORDER BY COUNT(c.CODCLI) DESC) 
WHERE ROWNUM=1;
--11. Código y descripción de los artículos cuyo precio es mayor de 90,15 euros y se han vendido menos de 10 unidades (o ninguna) durante el año pasado.
SELECT ARTICULOS.CODART, ARTICULOS.DESCRIP
FROM ARTICULOS, LINEAS_FAC, FACTURAS
WHERE ARTICULOS.CODART = LINEAS_FAC.CODART 
AND LINEAS_FAC.CODFAC = FACTURAS.CODFAC
AND ARTICULOS.PRECIO > 90.15
AND EXTRACT(YEAR FROM FECHA) = (EXTRACT(YEAR FROM SYSDATE)-1)
AND ARTICULOS.CODART IN(SELECT CODART
FROM LINEAS_FAC
GROUP BY CODART
HAVING SUM(NVL(CANT,0)) < 10);
--DUDA
--12. Código y descripción de los artículos cuyo precio es más de tres mil veces mayor que el precio mínimo de cualquier artículo.
SELECT A.CODART,A.DESCRIP 
FROM ARTICULOS a 
WHERE (A.PRECIO * 3000) > ALL (SELECT MIN(A.PRECIO)
FROM ARTICULOS a);
--13. Nombre del cliente con mayor facturación.
SELECT *
FROM (SELECT c.NOMBRE
FROM CLIENTES c, FACTURAS f, LINEAS_FAC fc
WHERE c.CODCLI = f.CODCLI 
AND f.CODFAC = fc.CODFAC 
GROUP BY c.NOMBRE
ORDER BY MAX(fc.PRECIO*fc.CANT) DESC) 
WHERE ROWNUM =1;
--14. Código y descripción de aquellos artículos con un precio superior a la media y que hayan sido comprados por más de 5 clientes.
SELECT A2.CODART,A2.DESCRIP 
FROM LINEAS_FAC lf, ARTICULOS a2,FACTURAS f,CLIENTES c 
WHERE LF.CODART = A2.CODART AND LF.CODFAC = F.CODFAC 
AND C.CODCLI = F.CODCLI AND A2.PRECIO > (SELECT AVG(A.PRECIO)
FROM ARTICULOS a)
GROUP BY A2.CODART,A2.DESCRIP
HAVING COUNT(C.CODCLI) > 5;