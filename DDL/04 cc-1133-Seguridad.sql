DROP USER IF EXISTS 'auditor'@'localhost','administrador'@'localhost','sitio_web'@'localhost','sitio_web_revisor'@'localhost';

CREATE USER 'auditor'@'localhost' IDENTIFIED BY 'auditor';
grant select on trabajopractico.* to auditor@'localhost';

CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'administrador';
GRANT ALTER,INSERT ON trabajopractico.* TO 'administrador'@'localhost';

CREATE USER 'sitio_web'@'localhost' IDENTIFIED BY 'sitio_web';
GRANT SELECT,INSERT ON trabajopractico.* TO 'sitio_web'@'localhost';

CREATE USER 'sitio_web_revisor'@'localhost' IDENTIFIED BY 'sitio_web_revisor';
GRANT INSERT,UPDATE ON trabajopractico.* TO 'sitio_web_revisor'@'localhost';
GRANT EXECUTE ON PROCEDURE trabajopractico.delete_logico TO 'sitio_web_revisor'@'localhost';

