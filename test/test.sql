-- Si vacia las tablas algunas tienen primary ket auto increment por lo tanto en la seguda carga va a fallar porque no va a existir el id

DELETE FROM asignaciones;
DELETE FROM liq_mensual;
DELETE FROM horas_trabajadas;
DELETE FROM proyecto;
DELETE FROM participante;
DELETE FROM cliente;
DELETE FROM roles;

-- Insert Participantes

INSERT INTO Participante (legajo,nombre)
VALUES (1001,"Pepe"),
		 (1002,"Jose"),
		 (1003,"Oscar"),
		 (1004,"Roberto");


-- Insert clientes
INSERT INTO cliente (nombre)
VALUES ("Pirulo SA."),
		 ("Perez Consultoria"),
		 ("Gomez e hijos");

-- Insertproyecto
INSERT INTO proyecto(nombre,id_cliente,id_ctrocosto,id_ctrofact)
VALUES ("proyecto1",1,1,2),
		 ("proyecto2",2,3,1),
		 ("proyecto3",3,2,4);


-- Insert Roles
INSERT INTO roles(descripcion)
VALUES ("Project Manager"),
		 ("Desarrollador"),
		 ("Tester"),
 		 ("Administrador");
		 
-- Insert Asignaciones
INSERT INTO asignaciones( leg_part,horas,id_proyect,id_rol)
VALUES (1001,120,1,1),
		 (1001,120,2,2),
 		 (1002,100,3,1),
		 (1002,100,1,3),
		 (1002,90,2,4),
		 (1003,150,3,2),
		 (1003,140,1,2),
		 (1004,120,2,1);

-- insert ingreso horas
-- parametros leg_par, id_rol, id_project, mes, tipo_carga (s=40 , m=160), horas
CALL ingreso_horas(1001,1,1,11,"d",9);
CALL ingreso_horas(1001,1,1,11,"s",0);
CALL ingreso_horas(1001,2,2,11,"d",3);
CALL ingreso_horas(1002,3,1,11,"m",0);
CALL ingreso_horas(1003,3,1,11,"m",0);
CALL ingreso_horas(1004,4,1,11,"s",0);
CALL ingreso_horas(1002,3,1,11,"d",5);
CALL ingreso_horas(1001,1,1,12,"s",0);
CALL ingreso_horas(1001,2,2,12,"d",3);
CALL ingreso_horas(1002,3,1,12,"s",0);
CALL ingreso_horas(1003,3,1,12,"d",8);
CALL ingreso_horas(1004,3,1,12,"s",0);
CALL ingreso_horas(1002,4,1,12,"m",0);

-- llamada a store procedure
CALL liq_mensual(12,1);
CALL liq_mensual(12,2);
CALL liq_mensual(11,1);
CALL liq_mensual(11,2);

SELECT * FROM liq_mensual;

-- horas trabajadas proyecto 1

SELECT if (( select SUM(horas) FROM horas_trabajadas WHERE  id_project = 1 AND id_rol = 1 and mes= 11 GROUP BY id_project) = 49 , "Liquidacion mensual del proyecto proyecto1 en el mes 11 del rol Project Manager estan bien liquidadas","Algo anda Mal!" ) AS Resultado;

SELECT if (( select SUM(horas) FROM horas_trabajadas WHERE  id_project = 1 AND id_rol = 2 and mes= 11 GROUP BY id_project) is NULL , "Liquidacion mensual del proyecto proyecto1 en el mes 11 del rol Desarrollador estan bien liquidadas","Algo anda Mal!" ) AS Resultado;

SELECT if (( select SUM(horas) FROM horas_trabajadas WHERE  id_project = 1 AND id_rol = 3 and mes= 11 GROUP BY id_project) = 325 , "Liquidacion mensual del proyecto proyecto1 en el mes 11 del rol Tester estan bien liquidadas","Algo anda Mal!" ) AS Resultado;

SELECT if (( select SUM(horas) FROM horas_trabajadas WHERE  id_project = 1 AND id_rol = 4 and mes= 11 GROUP BY id_project) = 40 , "Liquidacion mensual del proyecto proyecto1 en el mes 11 del rol Administrador estan bien liquidadas","Algo anda Mal!" ) AS Resultado;

-- Probar update horas_trabajadas

UPDATE horas_trabajadas SET horas= 11 WHERE  leg_par=1001 and id_rol=1 and id_project =1 and mes=11;
UPDATE horas_trabajadas SET horas= 9 WHERE  leg_par=1001 and id_rol=2 and id_project =2 and mes=12;
UPDATE horas_trabajadas SET horas= 11 WHERE  leg_par=1001 and id_rol=2 and id_project =2 and mes=12;

--- Prueba Borrado Logico

call delete_logico(10);
call delete_logico(11);
