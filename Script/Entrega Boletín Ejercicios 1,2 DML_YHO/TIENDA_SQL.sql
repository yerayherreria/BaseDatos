create database TIENDA;
create user 'TIENDA'@'%' identified by 'TIENDA';
grant all on TIENDA.* to 'TIENDA'@'%';
use TIENDA;

CREATE TABLE FABRICANTE(
	CODIGO INTEGER(10),
	NOMBRE VARCHAR(100),
	CONSTRAINT PK_CODIGO PRIMARY KEY (CODIGO)
);

CREATE TABLE PRODUCTO(
	CODIGO INTEGER(10),
	NOMBRE VARCHAR(100),
	PRECIO DOUBLE,
	CODIGO_FABRICANTE INTEGER(10),
	CONSTRAINT PK_CODIGO_PRODUCTO PRIMARY KEY (CODIGO),
	CONSTRAINT FK_CODIGO_FABRICANTE FOREIGN KEY (CODIGO_FABRICANTE) REFERENCES FABRICANTE(CODIGO)
);

#Insertamos los datos.
#Tabla FABRICANTE
INSERT INTO FABRICANTE (CODIGO,NOMBRE)
VALUES (1,'Asus');
INSERT INTO FABRICANTE (CODIGO,NOMBRE)
VALUES (2,'Lenovo');
INSERT INTO FABRICANTE (CODIGO,NOMBRE)
VALUES (3,'Hewlett-Packard');
INSERT INTO FABRICANTE (CODIGO,NOMBRE)
VALUES (4,'Samsung');
INSERT INTO FABRICANTE (CODIGO,NOMBRE)
VALUES (5,'Seagate');
INSERT INTO FABRICANTE (CODIGO,NOMBRE)
VALUES (6,'Crucial');
INSERT INTO FABRICANTE (CODIGO,NOMBRE)
VALUES (7,'Gigabyte');
INSERT INTO FABRICANTE (CODIGO,NOMBRE)
VALUES (8,'Huawei');
INSERT INTO FABRICANTE (CODIGO,NOMBRE)
VALUES (9,'Xiaomi');

#Tabla PRODUCTO
INSERT INTO PRODUCTO (CODIGO,NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES (1,'Disco duro SATA3 1TB',86.99,5);
INSERT INTO PRODUCTO (CODIGO,NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES (2,'Memoria RAM DDR4 8GB',120,6);
INSERT INTO PRODUCTO (CODIGO,NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES (3,'Disco SSD 1 TB',150.99,4);
INSERT INTO PRODUCTO (CODIGO,NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES (4,'GeForce GTX 1050Ti',185,7);
INSERT INTO PRODUCTO (CODIGO,NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES (5,'GeForce GTX 1080 Xtreme',755,6);
INSERT INTO PRODUCTO (CODIGO,NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES (6,'Monitor 24 LED Full HD',202,1);
INSERT INTO PRODUCTO (CODIGO,NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES (7,'Monitor 27 LED Full HD',245.99,1);
INSERT INTO PRODUCTO (CODIGO,NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES (8,'Portátil Yoga 520',559,2);
INSERT INTO PRODUCTO (CODIGO,NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES (9,'Portátil Ideapd 320',444,2);
INSERT INTO PRODUCTO (CODIGO,NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES (10,'Impresora HP Deskjet 3720',59.99,3);
INSERT INTO PRODUCTO (CODIGO,NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES (11,'Impresora HP Laserjet Pro M26nw',180,3);

#1.Inserta un nuevo fabricante indicando su código y su nombre.
INSERT INTO FABRICANTE (CODIGO,NOMBRE)
VALUES (10,'MSI');

#2.Inserta un nuevo fabricante indicando solamente su nombre.(DA ERROR DEBIDO A QUE EL CODIGO ES NO NULO)
INSERT INTO FABRICANTE (NOMBRE)
VALUES ('APPLE');

#3.Inserta un nuevo producto asociado a uno de los nuevos fabricantes. La sentencia de inserción debe incluir: código, nombre, precio y código_fabricante.
INSERT INTO PRODUCTO (CODIGO,NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES (12,'PORTATIL MSI XVII',789,3);

#4.Inserta un nuevo producto asociado a uno de los nuevos fabricantes. La sentencia de inserción debe incluir: nombre, precio y código_fabricante.(DA ERROR DEBIDO A QUE EL CODIGO ES NO NULO)
INSERT INTO PRODUCTO (NOMBRE,PRECIO,CODIGO_FABRICANTE)
VALUES ('PORTATIL MSI XV',780,0);

#5.Elimina el fabricante Asus. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?
DELETE FROM FABRICANTE
WHERE NOMBRE='Asus';
#SQL Error [1451] [23000]: Cannot delete or update a parent row: a foreign key constraint fails (`TIENDA`.`PRODUCTO`, CONSTRAINT `FK_CODIGO_FABRICANTE` FOREIGN KEY (`CODIGO_FABRICANTE`) REFERENCES `FABRICANTE` (`CODIGO`))

#6.Elimina el fabricante Xiaomi. ¿Es posible eliminarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese posible borrarlo?
DELETE FROM FABRICANTE
WHERE NOMBRE='Xiaomi';

#7.Actualiza el código del fabricante Lenovo y asígnale el valor 20. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?
UPDATE FABRICANTE
SET CODIGO=20
WHERE NOMBRE='Lenovo';
#SQL Error [1451] [23000]: Cannot delete or update a parent row: a foreign key constraint fails (`TIENDA`.`PRODUCTO`, CONSTRAINT `FK_CODIGO_FABRICANTE` FOREIGN KEY (`CODIGO_FABRICANTE`) REFERENCES `FABRICANTE` (`CODIGO`))

#8.Actualiza el código del fabricante Huawei y asígnale el valor 30. ¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?
UPDATE FABRICANTE
SET CODIGO=30
WHERE NOMBRE='Huawei';

#9.Actualiza el precio de todos los productos sumándole 5 € al precio actual.
UPDATE PRODUCTO
SET precio=precio+5;
#Aviso sin WHERE

#10.Elimina todas las impresoras que tienen un precio menor de 200 €.
#NOSE