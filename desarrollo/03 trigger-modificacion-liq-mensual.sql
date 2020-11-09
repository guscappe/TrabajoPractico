DROP TRIGGER trg_actualiza_horas_trabajadas

delimiter $$
CREATE TRIGGER trg_actualiza_horas_trabajadas
	AFTER UPDATE
	ON horas_trabajadas
	#-- cual es el comienzo del procedimiento
	FOR EACH row
	begin
		
		DECLARE diferencia INT DEFAULT 0;
		declare nue_valor INT DEFAULT 0;
		# si el resultado da negatico hay que quitar horas en la liq_mensual
		set diferencia = OLD.horas - NEW.horas;
		
		INSERT INTO aud_modif_horas_trabajadas (horas_old, horas_new, mes, usuario , id_rol , project, dia, dif)
		VALUES (OLD.horas,NEW.horas,OLD.mes,CURRENT_USER(),OLD.id_rol,OLD.id_project, NOW(), diferencia);
		
		CALL recal_liq_mensual(OLD.id_project,OLD.id_rol,OLD.mes);
		
	END;
$$

