create database desis_soubelet;
use desis_soubelet;

-- Tabla para almacenar las regiones
CREATE TABLE regiones (
    regionid INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

-- Tabla para almacenar las comunas relacionadas con las regiones
CREATE TABLE comunas (
    comunaid INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    regionid INT NOT NULL,
    FOREIGN KEY (regionid) REFERENCES regiones(regionid)
);

-- Tabla para almacenar los candidatos
CREATE TABLE candidatos (
    candidatoid INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla para almacenar los votantes
CREATE TABLE usuarios (
    usuarioid INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(255) NOT NULL,
    alias VARCHAR(255) NOT NULL,
    rut VARCHAR(12) NOT NULL,
    email VARCHAR(255) NOT NULL,
    regionid INT NOT NULL,
    comunaid INT NOT NULL,
    candidatoid INT NOT NULL,
    seleccion varchar(255) not null,
    CONSTRAINT UC_rut UNIQUE (rut),
    FOREIGN KEY (regionid) REFERENCES regiones(regionid),
    FOREIGN KEY (comunaid) REFERENCES comunas(comunaid),
    FOREIGN KEY (candidatoid) REFERENCES candidatos(candidatoid)
);

CREATE TABLE usuarios_checkbox (
    id int not null auto_increment,
    usuario_id int not null,
    seleccion varchar(255) not null,
    primary key (id),
    foreign key (usuario_id) references usuarios(usuarioid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Insertar Región 1 (Tarapacá)
INSERT INTO regiones (nombre) VALUES ('Tarapacá');

-- Insertar las comunas de la Región 1 (Tarapacá)
INSERT INTO comunas (nombre, regionid) VALUES
    ('Colchane', 1),
    ('Iquique', 1),
    ('Pica', 1),
    ('Pozo Almonte', 1);

-- Insertar Región 2 (Biobío)
INSERT INTO regiones (nombre) VALUES ('Biobío');

-- Insertar las comunas de la Región 2 (Biobío)
INSERT INTO comunas (nombre, regionid) VALUES
    ('Arauco', 2),
    ('Concepción', 2),
    ('Coronel', 2),
    ('Curanilahue', 2),
    ('San Pedro de la Paz', 2);

-- Insertar candidatos
INSERT INTO candidatos (nombre) VALUES ('Rock Británico');
INSERT INTO candidatos (nombre) VALUES ('Rock Americano');

SELECT * FROM usuarios;

/*Mostrar todos los campos, (regionid, comunaid, candidatoid en caracteres) */
SELECT 
    u.usuarioid, 
    u.nombre_completo, 
    u.alias, 
    u.rut, 
    u.email, 
    r.nombre AS nombre_region,
    c.nombre AS nombre_comuna,
    cd.nombre AS nombre_candidato,
    u.seleccion
FROM usuarios u
JOIN regiones r ON u.regionid = r.regionid
JOIN comunas c ON u.comunaid = c.comunaid
JOIN candidatos cd ON u.candidatoid = cd.candidatoid;







