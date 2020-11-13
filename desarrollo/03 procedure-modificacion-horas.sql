DROP PROCEDURE IF EXISTS UpdateHora;

delimiter $$

CREATE PROCEDURE UpdateHora( in id_up INT, IN nue_hora INT )
BEGIN

	DECLARE old_horas int;
	DECLARE m int;
	DECLARE rol int;
	DECLARE project int;
	declare nue_valor INT DEFAULT 0;

	SELECT horas, mes, id_rol, id_project INTO @old_horas ,@m ,@rol ,@project FROM horas_trabajadas WHERE id=id_up;
	
	insert into aud_modif_horas_trabajadas (horas_old,horas_new,mes,usuario,id_rol,project,dia,tipo_accion,id_mod)
	VALUES (@old_horas,nue_hora,@m,CURRENT_USER(),@rol,@project, CURDATE(), 'U',@id_up);

	UPDATE horas_trabajadas SET horas = nue_hora WHERE id=id_up;

	select SUM(horas) into @nue_valor FROM horas_trabajadas WHERE  id_project = @project AND id_rol = @rol and mes= @m and borrado=0 GROUP BY id_project;
	
	if @rol = 1 then UPDATE liq_mensual SET hs_ProjectManager= @nue_valor WHERE  id_project=@project and mes=@m;
	ELSEIF @rol = 2 then UPDATE liq_mensual SET hs_Desarrollador=@nuevalor WHERE  id_project=@project and mes=@m;
	ELSEIF @rol = 3 then UPDATE liq_mensual SET hs_Tester=@nuevalor WHERE  id_project=@project and mes=@m;
	ELSEIF @rol = 4 then UPDATE liq_mensual SET hs_Administrador=@nuevalor WHERE  id_project=@project and mes=@m;
	END if;
	
END
$$