---   Store PROCEDURE Eliminacion logica -----

DROP PROCEDURE IF EXISTS delete_logico;

delimiter $$

CREATE PROCEDURE delete_logico( in id_borrar INT)
BEGIN

	UPDATE horas_trabajadas SET borrado = 1 WHERE  id = id_borrar;
	
	INSERT INTO aud_modif_horas_trabajadas (usuario , dia, tipo_accion)
		VALUES (CURRENT_USER(), CURDATE(),'D');

END
$$

