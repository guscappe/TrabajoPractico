-- CREATE DATABASE TrabajoPractico;

-- USE trabajopractico;

DROP TABLE IF EXISTS asignaciones;
DROP table IF EXISTS liq_mensual;
DROP table IF EXISTS horas_trabajadas;
DROP table IF EXISTS proyecto;
DROP table IF EXISTS participante;
DROP table IF EXISTS cliente;
DROP table IF EXISTS roles;
DROP table IF EXISTS aud_modif_horas_trabajadas;

-- Creacion Entidad Participante

CREATE TABLE participante (
	legajo INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL 
);

-- Creacion Entidad Cliente

CREATE TABLE cliente (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL
);

-- Creacion Entidad Proyecto
-- FK con cliente

CREATE TABLE proyecto (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(200) NOT NULL,
	id_cliente INT NOT NULL,
	id_ctrocosto INT NOT NULL,
	id_ctrofact INT NOT NULL,
	
	CONSTRAINT fk_id_cliente
	foreign KEY (id_cliente)
	references cliente(id)
);

-- Creacion Entidad Roles

CREATE TABLE roles (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	descripcion VARCHAR(50) NOT NULL
);

-- Creacion Entidad Asignaciones
-- FK con participante,proyecto,roles

CREATE TABLE asignaciones (
	leg_part INT NOT null,
	horas INT NOT null,
	id_proyect INT NOT null,
	id_rol int NOT NULL,

	CONSTRAINT fk_legajo_participante
	foreign KEY (leg_part)
	references participante(legajo),
	
	CONSTRAINT fk_id_proyecto
	foreign KEY (id_proyect)
	references proyecto(id),
	
	CONSTRAINT fk_id_rol
	FOREIGN KEY (id_rol)
	REFERENCES roles(id)
);

-- Creacion Entidad Horas Trabajadas
-- FK con participante,proyecto,roles

CREATE TABLE horas_trabajadas (
	id INT AUTO_INCREMENT PRIMARY KEY,
	leg_par INT NOT NULL,
	horas INT NOT NULL,
	id_rol INT NOT NULL,
	id_project INT NOT NULL,
	mes INT,
	fecha DATE,
	
	CONSTRAINT fk_legajo_part
	FOREIGN KEY (leg_par)
	REFERENCES participante(legajo),
	
	CONSTRAINT fk_rol
	FOREIGN KEY (id_rol)
	REFERENCES roles(id),
	
	CONSTRAINT fk_id_proyect
	FOREIGN KEY (id_project)
	REFERENCES proyecto(id)
);
/*
   Creacion Entidad Liquidacion Mensual
   FK con proyecto
*/

CREATE TABLE liq_mensual(
	id INT AUTO_INCREMENT PRIMARY KEY,
	horas INT,
	id_rol INT NOT NULL,
	mes INT NOT NULL,
	id_project INT NOT NULL,
	anio INT NOT NULL,
	
	CONSTRAINT fk_id_proyec
	FOREIGN KEY (id_project)
	REFERENCES proyecto(id),

	CONSTRAINT fk_idrol
	FOREIGN KEY (id_rol)
	REFERENCES roles(id)

);



-- Creacion Entidad Auditoria modificacion horas trabajadas

CREATE TABLE aud_modif_horas_trabajadas(
	id INT AUTO_INCREMENT PRIMARY KEY,
	horas_old INT,
	horas_new INT,
	mes INT,
	usuario VARCHAR(50),
	id_rol INT,
	project INT,
	id_mod INT,
	dia DATE
);