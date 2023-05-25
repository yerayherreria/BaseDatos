-- 1. Devuelve el nombre del cliente con mayor límite de crédito.
-- josemi
SELECT clientes.nombre_cliente FROM (SELECT *      FROM cliente c      order by c.limite_credito DESC ) as clientes limit 1;
-- mio
SELECT *
FROM (SELECT c.nombre_cliente
	FROM cliente c
	order by c.limite_credito desc) as curro
limit 1;
-- 2. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT p.nombre 
from producto p 
where p.precio_venta = 
(SELECT max(p2.precio_venta)
from producto p2 ); 
-- 3. Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que
-- calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos
-- de la tabla detalle_pedido)
SELECT *
from (select p.nombre
	from producto p,detalle_pedido dp
	where p.codigo_producto=dp.codigo_producto
	GROUP by p.nombre
	order by sum(dp.cantidad) desc) as curro
limit 1;
-- 4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).
select c.nombre_cliente 
from cliente c 
where c.limite_credito > all (select sum(p.total)
from pago p
group by p.codigo_cliente);
-- 5. Devuelve el producto que más unidades tiene en stock.
SELECT *
from (select p.nombre
from producto p
order by p.cantidad_en_stock desc) as producto 
limit 1;
-- 6. Devuelve el producto que menos unidades tiene en stock.
SELECT *
from (select p.nombre
from producto p
order by p.cantidad_en_stock) as producto 
limit 1;
-- 7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
SELECT e2.nombre ,e2.apellido1 ,e2.apellido2 ,e2.email 
from empleado e2 
where e2.codigo_jefe = (SELECT e.codigo_empleado 
from empleado e
where e.nombre like 'Alberto');
-- 8. Devuelve el nombre del cliente con mayor límite de crédito.
SELECT c2.nombre_cliente 
from cliente c2 
WHERE c2.limite_credito = any (SELECT max(c.limite_credito)
from cliente c); 
-- 9. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT p2.nombre 
from producto p2 
where p2.precio_venta = all
(SELECT max(p.precio_venta)
from producto p);
-- 10. Devuelve el producto que menos unidades tiene en stock.
SELECT p2.nombre 
from producto p2 
where p2.cantidad_en_stock = all
(SELECT min(p.cantidad_en_stock)
from producto p);
-- 11. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
SELECT e.nombre ,e.apellido1 ,e.puesto 
from empleado e 
where e.codigo_empleado not in (SELECT c.codigo_empleado_rep_ventas 
from cliente c);
-- 12. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT c.nombre_cliente 
from cliente c 
WHERE c.codigo_cliente not in (SELECT p.codigo_cliente 
from pago p); 
-- 13. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
SELECT c.nombre_cliente 
from cliente c 
WHERE c.codigo_cliente in (SELECT p.codigo_cliente 
from pago p); 
-- 14. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT p.nombre 
from producto p 
where p.codigo_producto not in (SELECT dp.codigo_producto 
FROM detalle_pedido dp);
-- 15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT e2.nombre ,e2.apellido1 ,e2.apellido2 ,e2.puesto ,o.telefono 
from oficina o ,empleado e2 
where o.codigo_oficina = e2.codigo_oficina 
and e2.codigo_empleado not in (SELECT c.codigo_empleado_rep_ventas 
from cliente c);
-- 16. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes
-- de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT e2.codigo_oficina 
from empleado e2 
where e2.codigo_empleado not in (SELECT c.codigo_empleado_rep_ventas 
from cliente c ,pedido p ,detalle_pedido dp ,producto p2 
where c.codigo_cliente = p.codigo_cliente
and p.codigo_pedido = dp.codigo_pedido
and dp.codigo_producto = p2.codigo_producto
and p2.gama like 'Frutales');
-- 17. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
SELECT c.nombre_cliente 
from cliente c 
where c.codigo_cliente in (SELECT p.codigo_cliente 
								from pedido p)
and c.codigo_cliente not in (SELECT p2.codigo_cliente 
						from pago p2);