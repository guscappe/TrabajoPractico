/*   Store PROCEDURE Eliminacion logica */

DROP PROCEDURE IF EXISTS delete_logico;

delimiter $$

CREATE PROCEDURE delete_logico( in id_borrar INT)
BEGIN
	
	DECLARE m INT DEFAULT 0;
	declare project INT DEFAULT 0;
	declare rol INT DEFAULT 0;
	DECLARE hay_liq INT;
	
	UPDATE horas_trabajadas SET borrado = 1 WHERE  id = id_borrar;
	
	INSERT INTO aud_modif_horas_trabajadas (usuario ,dia ,id_mod, tipo_accion)
		VALUES (CURRENT_USER(), CURDATE(),id_borrar,'D');
		
	SELECT id_project, mes, id_rol INTO @project,@m,@rol from horas_trabajadas WHERE id=id_borrar;
	
	SELECT count(mes) INTO @hay_liq FROM liq_mensual WHERE id_project = @project AND mes = @m AND id_rol= @rol ; 
	
	if @hay_liq = 1 then
	
		select SUM(horas) into @nue_valor  FROM horas_trabajadas WHERE  id_project = @project AND id_rol = @rol AND mes= @m AND borrado = 0 GROUP BY id_project;
				
		UPDATE liq_mensual SET horas = @nue_valor WHERE  id_project = @project and mes = @m AND id_rol=@rol;

	END if;

END
$$