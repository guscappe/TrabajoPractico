-- procedimiento recalcular la liq_mensual

DROP PROCEDURE IF EXISTS recal_liq_mensual;

delimiter $$

CREATE PROCEDURE recal_liq_mensual( in idproject INT, in idrol INT,in m int )
BEGIN

	select @nue_valor:=SUM(horas) FROM horas_trabajadas WHERE  id_project = idproject AND id_rol = idrol and mes= m GROUP BY id_project;
		
		if idrol=1 then 
			UPDATE liq_mensual SET hs_ProjectManager= @nue_valor WHERE  id_project =idproject and mes=m;
		ELSEIF idrol=2 then 
			UPDATE liq_mensual SET hs_Desarrollador=@nuevalor WHERE  id_project =idproject and mes=m;
		ELSEIF idrol=3 then 
			UPDATE liq_mensual SET hs_Tester=@nuevalor WHERE  id_project =idproject and mes=m;
		ELSEIF idrol=4 then 
			UPDATE liq_mensual SET hs_Administrador=@nuevalor WHERE  id_project =idproject and mes=m;
		END if;
		
END
$$