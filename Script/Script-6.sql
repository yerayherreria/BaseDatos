--1. Realiza un procedimiento que reciba un número de departamento y muestre por pantalla su
--nombre y localidad.
CREATE OR REPLACE PROCEDURE EJER1(DEPT NUMBER)
AS
	NOMBRE VARCHAR2(30);
	LOCALIDAD VARCHAR2(34);
BEGIN
	SELECT D.DNAME ,D.LOC INTO NOMBRE,LOCALIDAD
	FROM DEPT d
	WHERE D.DEPTNO = DEPT;
	DBMS_OUTPUT.PUT_LINE ('NOMBRE: ' || NOMBRE);
 	DBMS_OUTPUT.PUT_LINE ('LOCALIDAD: ' || LOCALIDAD);
END;
BEGIN
	EJER1(10);
END;

--2. Realiza una función devolver_sal que reciba un nombre de departamento y devuelva la suma
--de sus salarios.
CREATE OR REPLACE FUNCTION DEVOLVER_SAL(DEPT VARCHAR2)
RETURN NUMBER 
AS 
	SUMA_SALARIO NUMBER;
BEGIN 
	SELECT SUM(E.SAL) INTO SUMA_SALARIO
	FROM EMP e ,DEPT d
	WHERE E.DEPTNO = D.DEPTNO 
	AND D.DNAME LIKE DEPT;
	RETURN SUMA_SALARIO;
END;

SELECT DEVOLVER_SAL('ACCOUNTING') FROM DUAL;

--3. Realiza un procedimiento MostrarAbreviaturas que muestre las tres primeras letras del
--nombre de cada empleado.
CREATE OR REPLACE PROCEDURE EJER3
AS
	CURSOR TRES_LETRAS IS 
	SELECT E.ENAME
	FROM EMP e;

BEGIN
	FOR registro IN TRES_LETRAS
	LOOP
		DBMS_OUTPUT.PUT_LINE ('NOMBRE: ' || SUBSTR(registro.ENAME,3));

	END LOOP;

END;
BEGIN
	EJER3;
END;

--4. Realiza un procedimiento que reciba un número de departamento y muestre una lista de sus
--empleados.
CREATE OR REPLACE PROCEDURE EJER4(DEPT NUMBER)
AS
	CURSOR EJR4 IS 
	SELECT E.ENAME
	FROM EMP e
	WHERE E.DEPTNO = DEPT;
BEGIN
	FOR registro IN EJR4
	LOOP
		DBMS_OUTPUT.PUT_LINE ('NOMBRE: ' || registro.ENAME);

	END LOOP;

END;
BEGIN
	EJER4(10);
END;

--5. Realiza un procedimiento MostrarJefes que reciba el nombre de un departamento y muestre
--los nombres de los empleados de ese departamento que son jefes de otros empleados.Trata las
--excepciones que consideres necesarias.
CREATE OR REPLACE PROCEDURE MostrarJefes(DEPT VARCHAR2)
AS
	CURSOR JEFES IS 
	SELECT E.ENAME
	FROM EMP e, EMP e2 ,DEPT d
	WHERE E.EMPNO = E2.MGR 
	AND E.DEPTNO = D.DEPTNO 
	AND E2.DEPTNO = D.DEPTNO
	AND D.DNAME LIKE DEPT;
BEGIN
	FOR registro IN JEFES
	LOOP
		DBMS_OUTPUT.PUT_LINE ('NOMBRE: ' || registro.ENAME);

	END LOOP;

END;
BEGIN
	MostrarJefes('ACCOUNTING');
END;

--6. Hacer un procedimiento que muestre el nombre y el salario del empleado cuyo código es
--7082
CREATE OR REPLACE PROCEDURE EJER6
AS
	NOMBRE_EMPLE EMP.ENAME%TYPE;
	SALARIO_EMPLE EMP.SAL%TYPE;
	NODATA EXCEPTION;
BEGIN
	SELECT E.ENAME,E.SAL INTO NOMBRE_EMPLE,SALARIO_EMPLE
	FROM EMP E
	WHERE E.EMPNO = 7082;
	
	IF NOMBRE_EMPLE IS NULL OR SALARIO_EMPLE = 0 THEN
		RAISE NODATA;
	ELSE
	DBMS_OUTPUT.PUT_LINE('Nombre: ' || NOMBRE_EMPLE || ' salario: ' || SALARIO_EMPLE);
	END IF;
	
	EXCEPTION
	WHEN NODATA OR NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE('ERROR. EL EMPLEADO NO EXISTE');
END;
BEGIN
	EJER6;
END;

--7. Realiza un procedimiento llamado HallarNumEmp que recibiendo un nombre de
--departamento, muestre en pantalla el número de empleados de dicho departamento
--Si el departamento no tiene empleados deberá mostrar un mensaje informando de ello. Si el
--departamento no existe se tratará la excepción correspondiente.
CREATE OR REPLACE PROCEDURE HallarNumEmp(NOMBRE VARCHAR2)
AS 
	CONT NUMBER;
	NODATA EXCEPTION;
BEGIN
	SELECT COUNT(E.EMPNO) INTO CONT 
	FROM EMP e ,DEPT d
	WHERE E.DEPTNO = D.DEPTNO 
	AND D.DNAME LIKE NOMBRE;
	
	IF NOMBRE IS NULL OR CONT = 0 THEN
		RAISE NODATA;
	ELSE
		DBMS_OUTPUT.PUT_LINE('NUMERO EMPLEADOS: '||CONT);
	END IF;
	
	EXCEPTION
	WHEN NODATA OR NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE('ERROR. NO HAY EMPLEADOS.');
END;
BEGIN
	HallarNumEmp('ACCOUNTING');
END;

--8. Hacer un procedimiento que reciba como parámetro un código de empleado y devuelva su
--nombre.
CREATE OR REPLACE PROCEDURE EJER8(CODIGO NUMBER)
AS
	NOMBRE_EMPLE EMP.ENAME%TYPE;
	NODATA EXCEPTION;
BEGIN
	SELECT E.ENAME INTO NOMBRE_EMPLE
	FROM EMP E
	WHERE E.EMPNO = CODIGO;
	
	IF NOMBRE_EMPLE IS NULL OR CODIGO IS NULL THEN
		RAISE NODATA;
	ELSE
	DBMS_OUTPUT.PUT_LINE('Nombre: ' || NOMBRE_EMPLE);
	END IF;
	
	EXCEPTION
	WHEN NODATA OR NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE('ERROR. EL EMPLEADO NO EXISTE');
END;
BEGIN
	EJER8(7499);
END;

--9. Codificar un procedimiento que reciba una cadena y la visualice al revés.
CREATE OR REPLACE PROCEDURE EJER9(CADENA VARCHAR2)
AS 
	CADENA2 VARCHAR2(100);
BEGIN
	FOR CARACTER IN REVERSE 1..LENGTH(CADENA)
	LOOP
		CADENA2 := CADENA2||SUBSTR(CADENA,CARACTER,1);
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(CADENA2);
END;
BEGIN
	EJER9('HOLA');
END;

--10. Escribir un procedimiento que reciba una fecha y escriba el año, en número, correspondiente a
--esa fecha.
CREATE OR REPLACE PROCEDURE EJER10(FECHA DATE)
AS 
	ANNIO NUMBER;
BEGIN
	ANNIO := EXTRACT(YEAR FROM FECHA);
	DBMS_OUTPUT.PUT_LINE(ANNIO);
END;
BEGIN
	EJER10(TO_DATE('06/06/2023','DD/MM/YYYY'));
END;

--11. Realiza una función llamada CalcularCosteSalarial que reciba un nombre de departamento y
--devuelva la suma de los salarios y comisiones de los empleados de dicho departamento.
/*CREATE OR REPLACE FUNCTION EJER11(NOMBRE VARCHAR2)
RETURN NUMBER
IS
	SALARIO NUMBER;
	COMISION NUMBER;
BEGIN
	SELECT SUM(E.SAL),SUM(E.COMM) INTO SALARIO, COMISION 
	FROM EMP E
	WHERE E.DEPTNO =NOMBRE;

DBMS_OUTPUT.PUT_LINE(SALARIO);
DBMS_OUTPUT.PUT_LINE(COMISION);
END;

SELECT EJER11('SALES') FROM DUAL;*/

--12. Codificar un procedimiento que permita borrar un empleado cuyo número se pasará en la
--llamada. Si no existiera dar el correspondiente mensaje de error.
CREATE OR REPLACE PROCEDURE EJER12(NOMBRE VARCHAR2)
AS 
BEGIN 
	DELETE FROM EMP e
	WHERE E.ENAME LIKE NOMBRE;
END;
BEGIN 
	EJER12('SMITH');
END;

--13. Realiza un procedimiento MostrarCostesSalariales que muestre los nombres de todos los
--departamentos y el coste salarial de cada uno de ellos
/*CREATE OR REPLACE PROCEDURE EJER13
AS 
	CURSOR DEP IS 
	SELECT D.DNAME ,SUM(E.SAL)
	FROM DEPT d,EMP e
	WHERE D.DEPTNO = E.DEPTNO
	GROUP BY D.DNAME;
BEGIN
	FOR REGISTRO IN DEP
	LOOP
		DBMS_OUTPUT.PUT_LINE('DEPARTAMENTO: '|| REGISTRO.DNAME);
	END LOOP;
END;
BEGIN
	EJER13;
END;*/

--14. Escribir un procedimiento que modifique la localidad de un departamento. El procedimiento
--recibirá como parámetros el número del departamento y la localidad nueva.
CREATE OR REPLACE PROCEDURE EJER14(DEPART NUMBER,LOCALIDAD VARCHAR2)
AS
BEGIN
	UPDATE DEPT SET LOC = LOCALIDAD
	WHERE DEPTNO = DEPART;
END;
BEGIN
	EJER14(40,'SEVILLA');
END;

--15. Realiza un procedimiento MostrarMasAntiguos que muestre el nombre del empleado más
--antiguo de cada departamento junto con el nombre del departamento. Trata las excepciones
--que consideres necesarias.
/*CREATE OR REPLACE PROCEDURE EJER15
AS 
	CURSOR DEPT IS 
	SELECT D.DEPTNO ,D.DNAME 
	FROM DEPT d;
	NOMBRE EMP.ENAME%TYPE;
BEGIN
	
END;
*/
