DROP TRIGGER trg_actualiza_horas_trabajadas;

delimiter $$
CREATE TRIGGER trg_actualiza_horas_trabajadas
	AFTER UPDATE
	ON horas_trabajadas
	#-- cual es el comienzo del procedimiento
	FOR EACH row
	begin
		
		DECLARE diferencia INT DEFAULT 0;
		declare nue_valor INT DEFAULT 0;
		
		set diferencia = OLD.horas - NEW.horas;
		
		INSERT INTO aud_modif_horas_trabajadas (horas_old, horas_new, mes, usuario , id_rol , project, dia, dif,tipo_accion)
		VALUES (OLD.horas,NEW.horas,OLD.mes,CURRENT_USER(),OLD.id_rol,OLD.id_project, NOW(), diferencia.'U');

		IF ( select COUNT(id_project) FROM liq_mensual WHERE  id_project = OLD.id_project and mes= OLD.mes GROUP BY id_project ) THEN 

			select SUM(horas) into @nue_valor  FROM horas_trabajadas WHERE  id_project = OLD.id_project AND id_rol = OLD.id_rol and mes= OLD.mes GROUP BY id_project;
			
			if OLD.id_rol=1 then 
				UPDATE liq_mensual SET hs_ProjectManager= @nue_valor WHERE  id_project =OLD.id_project and mes=OLD.mes;
			ELSEIF OLD.id_rol=2 then 
				UPDATE liq_mensual SET hs_Desarrollador=@nue_valor WHERE  id_project =OLD.id_project and mes=OLD.mes;
			ELSEIF OLD.id_rol=3 then 
				UPDATE liq_mensual SET hs_Tester=@nue_valor WHERE  id_project =OLD.id_project and mes=m;
			ELSEIF OLD.id_rol=4 then 
				UPDATE liq_mensual SET hs_Administrador=@nue_valor WHERE  id_project =OLD.id_project and mes=OLD.mes;
			END if;
		END IF;

	END;
$$




