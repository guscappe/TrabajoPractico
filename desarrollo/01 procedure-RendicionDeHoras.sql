---   Store PROCEDURE rendicion hora -----

DROP PROCEDURE IF EXISTS RendicionDeHoras;

delimiter $$

CREATE PROCEDURE RendicionDeHoras( in leg_par int,in id_rol INT,in id_project int,in mes int,in tipo_carga CHAR(1), in horas INT )
BEGIN

	if tipo_carga="d" then
		INSERT INTO horas_trabajadas (leg_par,horas,id_rol,id_project,mes,fecha)
		VALUES (leg_par,horas,id_rol,id_project,mes,CURDATE());
	ELSEIF tipo_carga="s" then
		INSERT INTO horas_trabajadas (leg_par,horas,id_rol,id_project,mes)
		VALUES (leg_par,40,id_rol,id_project,mes);
	ELSEIF tipo_carga="m" then
		INSERT INTO horas_trabajadas (leg_par,horas,id_rol,id_project,mes)
		VALUES (leg_par,160,id_rol,id_project,mes);
	END if;
END
$$