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
 		 (1003,140,2,2),
  		 (1003,140,2,3),
		 (1004,120,2,4),
 		 (1004,120,2,1);
		 

-- insert ingreso horas
-- parametros leg_par, id_rol, id_project, mes, tipo_carga (s=40 , m=160), horas
CALL RendicionDeHoras(1001,1,1,11,"d",9);
CALL RendicionDeHoras(1001,1,1,11,"d",5);
CALL RendicionDeHoras(1001,1,1,11,"d",8);
CALL RendicionDeHoras(1001,1,1,11,"d",4);
CALL RendicionDeHoras(1001,1,1,11,"s",0);
CALL RendicionDeHoras(1003,2,1,11,"s",0);
CALL RendicionDeHoras(1003,2,1,11,"s",0);
CALL RendicionDeHoras(1003,3,1,11,"m",0);
CALL RendicionDeHoras(1002,3,1,11,"d",5);
CALL RendicionDeHoras(1002,3,1,11,"m",0);
CALL RendicionDeHoras(1004,4,1,11,"s",0);
CALL RendicionDeHoras(1001,2,2,11,"d",3);
CALL RendicionDeHoras(1001,1,1,12,"s",0);
CALL RendicionDeHoras(1002,3,1,12,"s",0);
CALL RendicionDeHoras(1003,3,1,12,"d",8);
CALL RendicionDeHoras(1004,3,1,12,"s",0);
CALL RendicionDeHoras(1002,4,1,12,"m",0);
CALL RendicionDeHoras(1001,2,2,12,"d",3);
CALL RendicionDeHoras(1001,1,2,11,"d",9);
CALL RendicionDeHoras(1001,1,2,11,"d",5);
CALL RendicionDeHoras(1001,1,2,11,"d",8);
CALL RendicionDeHoras(1001,1,2,11,"d",4);
CALL RendicionDeHoras(1001,1,2,11,"s",0);
CALL RendicionDeHoras(1003,2,2,11,"s",0);
CALL RendicionDeHoras(1003,2,2,11,"s",0);
CALL RendicionDeHoras(1003,3,2,11,"m",0);
CALL RendicionDeHoras(1002,3,2,11,"d",5);
CALL RendicionDeHoras(1002,3,2,11,"m",0);
CALL RendicionDeHoras(1004,4,2,11,"s",0);
CALL RendicionDeHoras(1002,1,3,11,"m",0);
CALL RendicionDeHoras(1003,2,3,11,"s",0);

-- llamada a store procedure
CALL liq_mensual(11,1);
CALL liq_mensual(11,2);
CALL liq_mensual(12,1);
CALL liq_mensual(12,2);

SELECT * FROM liq_mensual;

-- horas trabajadas proyecto 1

SELECT if (( select SUM(horas) FROM horas_trabajadas WHERE  id_project = 1 AND id_rol = 1 and mes= 11 GROUP BY id_project) = 66 , "Liquidacion mensual del proyecto proyecto1 en el mes 11 del rol Project Manager estan bien liquidadas","Algo anda Mal!" ) AS Resultado;

SELECT if (( select SUM(horas) FROM horas_trabajadas WHERE  id_project = 2 AND id_rol = 4 and mes= 12 GROUP BY id_project) is NULL , "Liquidacion mensual del proyecto proyecto1 en el mes 11 del rol Desarrollador estan bien liquidadas","Algo anda Mal!" ) AS Resultado;

SELECT if (( select SUM(horas) FROM horas_trabajadas WHERE  id_project = 1 AND id_rol = 3 and mes= 11 GROUP BY id_project) = 325 , "Liquidacion mensual del proyecto proyecto1 en el mes 11 del rol Tester estan bien liquidadas","Algo anda Mal!" ) AS Resultado;

SELECT if (( select SUM(horas) FROM horas_trabajadas WHERE  id_project = 1 AND id_rol = 4 and mes= 11 GROUP BY id_project) = 40 , "Liquidacion mensual del proyecto proyecto1 en el mes 11 del rol Administrador estan bien liquidadas","Algo anda Mal!" ) AS Resultado;

SELECT if (( select SUM(horas) FROM horas_trabajadas WHERE  id_project = 1 AND id_rol = 4 and mes= 11 GROUP BY id_project) = 0 , "Liquidacion mensual del proyecto proyecto1 en el mes 11 del rol Administrador estan bien liquidadas","Algo anda Mal! Sera la consulta?" ) AS Resultado;

-- Probar update horas_trabajadas

CALL UpdateHora(1,10);
CALL UpdateHora(6,9);
CALL UpdateHora(12,10);

--- Prueba Borrado Logico

call delete_logico(1);
call delete_logico(10);
call delete_logico(12);
call delete_logico(30);

-- Se ejecutaron estos comandos en Cmder

/* Usuario auditor */
show grants FOR auditor@'localhost';
/*
mysql> insert into cliente (nombre) values (Gustavo);
ERROR 1142 (42000): INSERT command denied to user 'auditor'@'localhost' for table 'cliente'
mysql> update cliente set nombre='Pirulo S.A' where id=1;
ERROR 1142 (42000): UPDATE command denied to user 'auditor'@'localhost' for table 'cliente'
mysql> alter table cliente DROP COLUMN nombre;
ERROR 1142 (42000): ALTER command denied to user 'auditor'@'localhost' for table 'cliente'


--Usuario administrador
*/
show grants FOR administrador@'localhost';

/*
alter table participante DROP COLUMN borrado;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0
mysql> insert into cliente (nombre) values ("Gustavo");
Query OK, 1 row affected (0.00 sec)
mysql> call delete_logico(10);
ERROR 1370 (42000): execute command denied to user 'administrador'@'localhost' for routine 'trabajopractico.delete_logico'
*/

show grants FOR sitio_web@'localhost';

show grants FOR sitio_web_revisor@'localhost';