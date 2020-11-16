/*   
	Store PROCEDURE Liquidacion Mensual 
*/

DROP PROCEDURE IF EXISTS liq_mensual;

delimiter ##

CREATE PROCEDURE liq_mensual( in mes_liq INT, IN project INT )
BEGIN
	INSERT INTO liq_mensual (horas,id_rol,mes,id_project,anio)
		SELECT sum(horas),id_rol,mes_liq,id_project,YEAR(NOW()) FROM horas_trabajadas 
		where mes=mes_liq AND id_project=project AND borrado=0
		GROUP BY id_rol,id_project;

END
##