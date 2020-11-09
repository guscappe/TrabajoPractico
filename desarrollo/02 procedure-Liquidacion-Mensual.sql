---   Store PROCEDURE Liquidacion Mensual -----

DROP PROCEDURE IF EXISTS liq_mensual;

delimiter ##

CREATE PROCEDURE liq_mensual( in mes_liq INT, IN project INT )
BEGIN
	DECLARE hs INT DEFAULT 0;
	DECLARE idrol INT ;
	DECLARE idProject INT;
	DECLARE ProjManager INT DEFAULT 0;
	DECLARE tester INT DEFAULT 0;
	DECLARE admin INT DEFAULT 0;
	DECLARE des INT DEFAULT 0;
	DECLARE done INT DEFAULT 0;
	DECLARE hora
	CURSOR FOR 
		SELECT horas,id_rol,id_project FROM horas_trabajadas where mes=mes_liq AND id_project=project;
	DECLARE continue handler FOR NOT FOUND SET done = true;
	OPEN hora;
	mi_ciclo:loop
		SET done= FALSE;
		fetch hora INTO hs,idrol,idproject;
		if done then
			leave mi_ciclo;
		end if;
		if idrol=1 then 
			set ProjManager=ProjManager+hs;
		ELSEIF idrol=2 then 
			set des=des+hs;
		ELSEIF idrol=3 then 
			set tester=tester+hs;
		ELSEIF idrol=4 then 
			set admin=admin+hs;
		END if;
	END loop mi_ciclo;
	close hora;
	INSERT INTO liq_mensual (mes, id_project,anio, hs_ProjectManager, hs_Desarrollador, hs_Tester , hs_Administrador)
	VALUES (mes_liq,project,YEAR(NOW()),ProjManager,des,tester,admin);
END
##