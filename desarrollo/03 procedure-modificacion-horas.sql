DROP PROCEDURE IF EXISTS UpdateHora;

delimiter $$

CREATE PROCEDURE UpdateHora( in id_up INT, IN nue_hora INT )
BEGIN

	DECLARE old_horas int;
	DECLARE m int;
	DECLARE rol int;
	DECLARE project int;
	declare nue_valor INT DEFAULT 0;

	
	insert into aud_modif_horas_trabajadas (horas_old,horas_new,mes,usuario,id_rol,project,id_mod,dia,tipo_accion)
	SELECT horas,nue_hora, mes,CURRENT_USER(), id_rol, id_project,id_up,CURDATE(),'U'  FROM horas_trabajadas WHERE id=id_up;
	
	UPDATE horas_trabajadas SET horas = nue_hora WHERE id=id_up;

	
	SELECT id_project, mes, id_rol INTO @project,@m,@rol from horas_trabajadas WHERE id=id_up;
		
	select SUM(horas) into @nue_valor FROM horas_trabajadas WHERE  id_project = @project AND id_rol = @rol and mes= @m and borrado=0 GROUP BY id_project;
	
	UPDATE liq_mensual SET horas = @nue_valor WHERE  id_project = @project and mes = @m AND id_rol=@rol;
	
END
$$