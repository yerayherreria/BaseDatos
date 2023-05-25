-- 1. VISUALIZAR EL NÚMERO DE EMPLEADOS DE CADA DEPARTAMENTO. UTILIZAR
-- GROUP BY PARA AGRUPAR POR DEPARTAMENTO.
SELECT COUNT(e.EMP_NO)
FROM EMPLE e 
GROUP BY e.DEPT_NO;
-- 2. VISUALIZAR LOS DEPARTAMENTOS CON MÁS DE 5 EMPLEADOS. UTILIZAR GROUP
-- BY PARA AGRUPAR POR DEPARTAMENTO Y HAVING PARA ESTABLECER LA CONDICIÓN
-- SOBRE LOS GRUPOS.
SELECT COUNT(e.EMP_NO)
FROM EMPLE e 
GROUP BY e.DEPT_NO
HAVING COUNT(e.EMP_NO)>5;
-- 3. HALLAR LA MEDIA DE LOS SALARIOS DE CADA DEPARTAMENTO (UTILIZAR LA FUNCIÓN
-- AVG Y GROUP BY).
SELECT AVG(e.SALARIO)
FROM EMPLE e 
GROUP BY e.DEPT_NO;
-- 4. VISUALIZAR EL NOMBRE DE LOS EMPLEADOS VENDEDORES DEL DEPARTAMENTO
-- ʻVENTASʼ (NOMBRE DEL DEPARTAMENTO=ʼVENTASʼ, OFICIO=ʼVENDEDORʼ).
SELECT e.EMP_NO  
FROM EMPLE e 
WHERE e.OFICIO LIKE 'VENDEDOR';
-- 5. VISUALIZAR EL NÚMERO DE VENDEDORES DEL DEPARTAMENTO ʻVENTASʼ (UTILIZAR
-- LA FUNCIÓN COUNT SOBRE LA CONSULTA ANTERIOR).
SELECT COUNT(e.EMP_NO)  
FROM EMPLE e 
WHERE e.OFICIO LIKE 'VENDEDOR';
-- 6. VISUALIZAR LOS OFICIOS DE LOS EMPLEADOS DEL DEPARTAMENTO ʻVENTASʼ.
SELECT e.OFICIO
FROM EMPLE e,DEPART d  
WHERE e.DEPT_NO = d.DEPT_NO  
AND d.DNOMBRE LIKE 'VENTAS';
-- 7. A PARTIR DE LA TABLA EMPLE, VISUALIZAR EL NÚMERO DE EMPLEADOS DE CADA
-- DEPARTAMENTO CUYO OFICIO SEA ʻEMPLEADOʼ (UTILIZAR GROUP BY PARA
-- AGRUPAR POR DEPARTAMENTO. EN LA CLÁUSULA WHERE HABRÁ QUE INDICAR QUE EL
-- OFICIO ES ʻEMPLEADOʼ).
SELECT COUNT(e.EMP_NO)
FROM EMPLE e 
WHERE e.OFICIO LIKE 'EMPLEADO'
GROUP BY e.DEPT_NO;
-- 8. VISUALIZAR EL DEPARTAMENTO CON MÁS EMPLEADOS.
-- DUDA
-- SELECT COUNT(e.EMP_NO) 
-- FROM EMPLE e 
-- GROUP BY e.DEPT_NO;
-- 9. MOSTRAR LOS DEPARTAMENTOS CUYA SUMA DE SALARIOS SEA MAYOR QUE LA
-- MEDIA DE SALARIOS DE TODOS LOS EMPLEADOS.
-- DUDA
-- SELECT e.DEPT_NO
-- FROM EMPLE e 
-- GROUP BY DEPT_NO 
-- HAVING AVG(e.SALARIO)>SUM(e.SALARIO);
-- 10. PARA CADA OFICIO OBTENER LA SUMA DE SALARIOS.
SELECT SUM(e.SALARIO)
FROM EMPLE e 
GROUP BY e.OFICIO;
-- 11. VISUALIZAR LA SUMA DE SALARIOS DE CADA OFICIO DEL DEPARTAMENTO
-- ʻVENTASʼ.
SELECT SUM(e.SALARIO)
FROM EMPLE e, DEPART d 
WHERE e.DEPT_NO = d.DEPT_NO 
AND d.DNOMBRE LIKE 'VENTAS'
GROUP BY e.OFICIO;
-- 12. VISUALIZAR EL NÚMERO DE DEPARTAMENTO QUE TENGA MÁS EMPLEADOS CUYO
-- OFICIO SEA EMPLEADO.
-- DUDA
-- SELECT e.DEPT_NO
-- FROM EMPLE e 
-- WHERE e.OFICIO LIKE 'EMPLEADO'
-- GROUP BY e.DEPT_NO;
-- 13. MOSTRAR EL NÚMERO DE OFICIOS DISTINTOS DE CADA DEPARTAMENTO.
SELECT COUNT(DISTINCT e.OFICIO)
FROM EMPLE e;
-- 14. MOSTRAR LOS DEPARTAMENTOS QUE TENGAN MÁS DE DOS PERSONAS
-- TRABAJANDO EN LA MISMA PROFESIÓN.
SELECT e.DEPT_NO
FROM EMPLE e
GROUP BY e.DEPT_NO,e.OFICIO
HAVING COUNT(*)>2;

-- 15. DADA LA TABLA HERRAMIENTAS, VISUALIZAR POR CADA ESTANTERÍA LA SUMA
-- DE LAS UNIDADES.
SELECT SUM(h.UNIDADES) 
FROM HERRAMIENTAS h 
GROUP BY h.ESTANTERIA;

-- 16. VISUALIZAR LA ESTANTERÍA CON MÁS UNIDADES DE LA TABLA HERRAMIENTAS.
-- ESTANTERÍA
-- DUDA
-- SELECT SUM(h.UNIDADES) AS SUMA_UNIDADES
-- FROM HERRAMIENTAS h 
-- GROUP BY h.ESTANTERIA
-- HAVING SUM(h.UNIDADES)=MAX(SUMA_UNIDADES);

-- 17. MOSTRAR EL NÚMERO DE MÉDICOS QUE PERTENECEN A CADA HOSPITAL,
-- ORDENADO POR NÚMERO DESCENDENTE DE HOSPITAL.
SELECT COUNT(m.DNI)
FROM MEDICOS m 
GROUP BY m.COD_HOSPITAL;

-- 18. REALIZAR UNA CONSULTA EN LA QUE SE MUESTRE POR CADA HOSPITAL EL
-- NOMBRE DE LAS ESPECIALIDADES QUE TIENE.
SELECT DISTINCT m.COD_HOSPITAL, m.ESPECIALIDAD 
FROM MEDICOS m;

-- 19. REALIZAR UNA CONSULTA EN LA QUE APAREZCA POR CADA HOSPITAL Y EN CADA
-- ESPECIALIDAD EL NÚMERO DE MÉDICOS (TENDRÁS QUE PARTIR DE LA CONSULTA ANTERIOR
-- Y UTILIZAR GROUP BY).
SELECT m.ESPECIALIDAD ,h.NOMBRE ,COUNT(*)
FROM MEDICOS m ,HOSPITALES h 
WHERE m.COD_HOSPITAL = h.COD_HOSPITAL
GROUP BY h.NOMBRE,m.ESPECIALIDAD;

-- 20. OBTENER POR CADA HOSPITAL EL NÚMERO DE EMPLEADOS.
SELECT COUNT(*) AS NUMERO_EMPLEADOS
FROM PERSONA p 
GROUP BY p.COD_HOSPITAL;

-- 21. OBTENER POR CADA ESPECIALIDAD EL NÚMERO DE TRABAJADORES.
SELECT COUNT(*) AS NUMERO_TRABAJADORES
FROM MEDICOS m  
GROUP BY m.ESPECIALIDAD;

-- 22. VISUALIZAR LA ESPECIALIDAD QUE TENGA MÁS MÉDICOS.
-- DUDA
-- SELECT COUNT(*) AS NUMERO_TRABAJADORES
-- FROM MEDICOS m  
-- GROUP BY m.ESPECIALIDAD
-- HAVING COUNT(*)=(SELECT MAX(COUNT(*) FROM MEDICOS m2 GROUP BY m2.ESPECIALIDAD );

-- 23. ¿CUÁL ES EL NOMBRE DEL HOSPITAL QUE TIENE MAYOR NÚMERO DE PLAZAS?
SELECT h.NOMBRE
FROM HOSPITALES h 
WHERE h.NUM_PLAZAS = (SELECT MAX(h2.NUM_PLAZAS) FROM HOSPITALES h2);

-- 24. VISUALIZAR LAS DIFERENTES ESTANTERÍAS DE LA TABLA HERRAMIENTAS
-- ORDENADOS DESCENDENTEMENTE POR ESTANTERÍA.
SELECT DISTINCT h3.ESTANTERIA
FROM HERRAMIENTAS h3
ORDER BY h3.ESTANTERIA DESC;

-- 25. AVERIGUAR CUÁNTAS UNIDADES TIENE CADA ESTANTERÍA.
SELECT SUM(h.UNIDADES)
FROM HERRAMIENTAS h 
GROUP BY h.ESTANTERIA;

-- 26. VISUALIZAR LAS ESTANTERÍAS QUE TENGAN MÁS DE 15 UNIDADES
SELECT SUM(h.UNIDADES)
FROM HERRAMIENTAS h 
GROUP BY h.ESTANTERIA
HAVING SUM(h.UNIDADES)>15;

-- 27. ¿CUÁL ES LA ESTANTERÍA QUE TIENE MÁS UNIDADES?
-- DUDA
-- SELECT SUM(h.UNIDADES)
-- FROM HERRAMIENTAS h 
-- GROUP BY h.ESTANTERIA
-- HAVING SUM(h.UNIDADES)=(SELECT MAX(SUM(h2.UNIDADES) FROM HERRAMIENTAS h2 GROUP BY h2.ESTANTERIA);

-- 28. A PARTIR DE LAS TABLAS EMPLE Y DEPART MOSTRAR LOS DATOS DEL
-- DEPARTAMENTO QUE NO TIENE NINGÚN EMPLEADO.
SELECT d.DNOMBRE ,d.DEPT_NO ,d.LOC 
FROM DEPART d
WHERE d.DEPT_NO NOT IN (SELECT e.DEPT_NO FROM EMPLE e) ;

-- 29. MOSTRAR EL NÚMERO DE EMPLEADOS DE CADA DEPARTAMENTO. EN LA SALIDA
-- SE DEBE MOSTRAR TAMBIÉN LOS DEPARTAMENTOS QUE NO TIENEN NINGÚN
-- EMPLEADO.
SELECT d.DEPT_NO,COUNT(e.DEPT_NO)    
FROM DEPART d LEFT JOIN EMPLE e ON e.DEPT_NO=d.DEPT_NO     
GROUP BY d.DEPT_NO; 

-- 30. OBTENER LA SUMA DE SALARIOS DE CADA DEPARTAMENTO, MOSTRANDO LAS
-- COLUMNAS DEPT_NO, SUMA DE SALARIOS Y DNOMBRE. EN EL RESULTADO
-- TAMBIÉN SE DEBEN MOSTRAR LOS DEPARTAMENTOS QUE NO TIENEN ASIGNADOS
-- EMPLEADOS.
-- DUDA
-- SELECT d.DEPT_NO,(SUM(SALARIO),'0.0') AS SUMA_SALARIO    
-- FROM EMPLE e RIGHT JOIN DEPART d ON e.DEPT_NO=d.DEPT_NO      
-- GROUP BY d.DEPT_NO;

-- 31. UTILIZAR LA FUNCIÓN IFNULL EN LA CONSULTA ANTERIOR PARA QUE EN EL CASO
-- DE QUE UN DEPARTAMENTO NO TENGA EMPLEADOS, APAREZCA COMO SUMA DE
-- SALARIOS EL VALOR 0.
SELECT d.DEPT_NO,IFNULL(SUM(SALARIO),'0.0') AS SUMA_SALARIO 
FROM EMPLE e RIGHT JOIN DEPART d ON e.DEPT_NO=d.DEPT_NO
GROUP BY d.DEPT_NO;
-- 32. OBTENER EL NÚMERO DE MÉDICOS QUE PERTENECEN A CADA HOSPITAL,
-- MOSTRANDO LAS COLUMNAS COD_HOSPITAL, NOMBRE Y NÚMERO DE
-- MÉDICOS. EN EL RESULTADO DEBEN APARECER TAMBIÉN LOS DATOS DE LOS
-- HOSPITALES QUE NO TIENEN MÉDICOS.
SELECT h.COD_HOSPITAL,h.NOMBRE,COUNT(m.DNI)        
FROM MEDICOS m RIGHT JOIN HOSPITALES h ON h.COD_HOSPITAL=m.COD_HOSPITAL      
GROUP BY h.COD_HOSPITAL;