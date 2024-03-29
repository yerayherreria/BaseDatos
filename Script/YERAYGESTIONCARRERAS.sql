--CREACION 
CREATE OR REPLACE
PACKAGE YERAYGESTIONCARRERAS IS
  version NUMBER := 1.0;
  
  FUNCTION LISTADOCABALLOS RETURN NUMBER;
  PROCEDURE AGREGARCABALLOS(NOMBRE_CABALLO VARCHAR2, PESO VARCHAR2, FECHA_NACIMIENTO DATE, NACIONALIDAD VARCHAR2,DNI_DUE VARCHAR2, NOMBRE_DUE VARCHAR2);
 
END YERAYGESTIONCARRERAS;





--CUERPO 
CREATE OR REPLACE
PACKAGE BODY YERAYGESTIONCARRERAS IS

	  PROCEDURE CARRE.AGREGARCABALLOS(NOMBRE_CABALLO VARCHAR2, PESO VARCHAR2, FECHA_NACIMIENTO DATE, NACIONALIDAD VARCHAR2,DNI_DUE VARCHAR2, NOMBRE_DUE VARCHAR2)
	IS 
		NACIONA VARCHAR2(30);
		CANTIDAD_DUE NUMBER;
		COD_PERS NUMBER;
		COD_CAB NUMBER;
		COD_DUE NUMBER;
	BEGIN
		SELECT COUNT(P.DNI) INTO CANTIDAD_DUE
		FROM PERSONAS p ,CABALLOS c 
		WHERE P.CODIGO = C.PROPIETARIO 
		AND P.DNI LIKE DNI_DUE;
	
		IF CANTIDAD_DUE = 0 THEN
			SELECT MAX(P.CODIGO)+1 INTO COD_PERS
			FROM PERSONAS p;
		
			SELECT MAX(C.CODCABALLO)+1 INTO COD_CAB
			FROM CABALLOS c;
		
		 	INSERT INTO PERSONAS(CODIGO,DNI,NOMBRE,APELLIDOS,DIRECCION,FECHA_NACIMIENTO) 
		 	VALUES (COD_PERS, DNI_DUE, NOMBRE_DUE, NULL,NULL,NULL);
		 	INSERT INTO CABALLOS(CODCABALLO, NOMBRE, PESO, FECHANACIMIENTO, PROPIETARIO, NACIONALIDAD) 
		 	VALUES(COD_CAB, NOMBRE_CABALLO, PESO, FECHA_NACIMIENTO, COD_PERS, NACIONALIDAD);
		
		ELSE
		 	SELECT P.CODIGO INTO COD_DUE
		 	FROM PERSONAS p 
		 	WHERE P.DNI LIKE DNI_DUE;
		 
		 	INSERT INTO CABALLOS(CODCABALLO, NOMBRE, PESO, FECHANACIMIENTO, PROPIETARIO, NACIONALIDAD) 
			VALUES(COD_CAB, NOMBRE_CABALLO, PESO, FECHA_NACIMIENTO, COD_DUE, NACIONALIDAD);
		END IF;
		 
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				COD_PERS:=COD_PERS+1;
				INSERT INTO PERSONAS(CODIGO ,DNI ,NOMBRE) VALUES (COD_PERS ,DNI_DUE ,NOMBRE_DUE);
			
		SELECT C.NACIONALIDAD INTO NACIONA
		FROM CABALLOS c 
		WHERE C.CODCABALLO = COD_CAB;
			
		IF NACIONA IS NULL THEN
			UPDATE CABALLOS 
			SET NACIONALIDAD = 'ESPAÑOLA' 
			WHERE CODCABALLO = COD_CAB;
		END IF;
			
		WHEN OTHERS THEN
			ROLLBACK;
	END AGREGARCABALLOS;

  FUNCTION LISTADOCABALLOS
	RETURN NUMBER 
	IS 
		--CURSOR EXPLICITO PARA MOSTRAR LOS CABALLOS
		CURSOR MOSTRAR_CABALLO IS 
		SELECT C.CODCABALLO AS CODIGO ,C.NOMBRE AS CABALLO_NOMBRE ,C.PESO AS PESO, P.NOMBRE AS NOMBRE_PROPIETARIO
		FROM CABALLOS c, PERSONAS p
		WHERE C.PROPIETARIO = P.CODIGO
		ORDER BY C.NACIONALIDAD ,P.NOMBRE DESC;
		
		--CURSOR EXPLICITO PARA MOSTRAR LAS CARRERAS
		CURSOR MOSTRAR_CARRERA (MOSTRAR_CABALLO CABALLOS.CODCABALLO%TYPE) IS
		SELECT C.NOMBRECARRERA AS NOMBRECARRERA ,P2.NOMBRE AS NOMBRE_JOC ,C.FECHAHORA AS FECHA ,P.POSICIONFINAL AS POSICION ,C.IMPORTEPREMIO AS IMPORTE 
		FROM CARRERAS c ,PARTICIPACIONES p ,PERSONAS p2 ,CABALLOS c2 
		WHERE C.CODCARRERA = P.CODCARRERA 
		AND C2.CODCABALLO = P.CODCABALLO  
		AND P.JOCKEY = P2.CODIGO 
		AND C2.CODCABALLO = MOSTRAR_CABALLO
		ORDER BY C.NOMBRECARRERA ,C.FECHAHORA DESC; 
	
		NUM_CABALLOS NUMBER:=0;
		CARRERAS_GANADAS NUMBER:=0;
		TOTAL_IMPORTE NUMBER:=0;
	BEGIN 
		DBMS_OUTPUT.PUT_LINE('INFORME DE LOS CABALLOS EXISTENTES EN LA BASE DE DATOS');
		DBMS_OUTPUT.PUT_LINE(' ');
		FOR REGISTRO_CABALLO IN MOSTRAR_CABALLO LOOP
			DBMS_OUTPUT.PUT_LINE('CABALLO: '||REGISTRO_CABALLO.CABALLO_NOMBRE);
			DBMS_OUTPUT.PUT_LINE('PESO: '||REGISTRO_CABALLO.PESO);
			DBMS_OUTPUT.PUT_LINE('NOMBRE DEL DUEÑO: '||REGISTRO_CABALLO.NOMBRE_PROPIETARIO);
			DBMS_OUTPUT.PUT_LINE(' ');
			FOR REGISTRO_CARRERA IN MOSTRAR_CARRERA(REGISTRO_CABALLO.CODIGO) LOOP
				DBMS_OUTPUT.PUT_LINE('	NOMBRE DE CARRERA: '||REGISTRO_CARRERA.NOMBRECARRERA);
				DBMS_OUTPUT.PUT_LINE('	NOMBRE DE JOCKEY: '||REGISTRO_CARRERA.NOMBRE_JOC);
				DBMS_OUTPUT.PUT_LINE('	FECHA: '||REGISTRO_CARRERA.FECHA);
				DBMS_OUTPUT.PUT_LINE('	POSICION FINAL: '||REGISTRO_CARRERA.POSICION);
				DBMS_OUTPUT.PUT_LINE('	IMPORTE PREMIO: '||REGISTRO_CARRERA.IMPORTE);
				DBMS_OUTPUT.PUT_LINE(' ');
				
				IF REGISTRO_CARRERA.POSICION=1 THEN
					CARRERAS_GANADAS:=CARRERAS_GANADAS+1;
				END IF;
				TOTAL_IMPORTE:=TOTAL_IMPORTE+REGISTRO_CARRERA.IMPORTE;
			END LOOP;
			DBMS_OUTPUT.PUT_LINE('	CARRERA GANADAS: '||CARRERAS_GANADAS);
			DBMS_OUTPUT.PUT_LINE('	IMPORTE_TOTAL: '||TOTAL_IMPORTE);
			CARRERAS_GANADAS:=0;
			TOTAL_IMPORTE:=0;
			NUM_CABALLOS:=NUM_CABALLOS+1;
		END LOOP;
		RETURN NUM_CABALLOS;
	END LISTADOCABALLOS;

END YERAYGESTIONCARRERAS;

SELECT YERAYGESTIONCARRERAS.LISTADOCABALLOS FROM DUAL;

BEGIN
	YERAYGESTIONCARRERAS.AGREGARCABALLOS('CURRO', '550KG', TO_DATE('05/05/2020','DD/MM/YYYY'), 'ESPAÑOLA', '12345678a', 'MANOLO');
END;