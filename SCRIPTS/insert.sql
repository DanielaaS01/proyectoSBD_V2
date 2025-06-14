----LUGARES GEOGRAFICOS-----
BEGIN;
-- PAISES
INSERT INTO LUGARES_GEOGRAFICOS(nombre, tipo, id_lugar_padre) VALUES
(UPPER('España'), 'P', NULL),              -- ID 1
(UPPER('Italia'), 'P', NULL),              -- ID 2
(UPPER('Países Bajos'), 'P', NULL),        -- ID 3
(UPPER('Portugal'), 'P', NULL);            -- ID 4

-- REGIONES
INSERT INTO LUGARES_GEOGRAFICOS(nombre, tipo, id_lugar_padre) VALUES
(UPPER('Comunidad de Madrid'), 'R', 1),         -- ID 5
(UPPER('Lacio'), 'R', 2),                       -- ID 6
(UPPER('Lombardía'), 'R', 2),                   -- ID 7
(UPPER('Holanda Septentrional'), 'R', 3),       -- ID 8
(UPPER('Holanda Meridional'), 'R', 3),          -- ID 9
(UPPER('Lisboa'), 'R', 4),                      -- ID 10
(UPPER('Oporto'), 'R', 4);                      -- ID 11

-- CIUDADES
INSERT INTO LUGARES_GEOGRAFICOS(nombre, tipo, id_lugar_padre) VALUES
(UPPER('Madrid'), 'C', 5),                      -- ID 12
(UPPER('Roma'), 'C', 6),                        -- ID 13
(UPPER('Milán'), 'C', 7),                       -- ID 14
(UPPER('Ámsterdam'), 'C', 8),                   -- ID 15
(UPPER('La Haya'), 'C', 9),                     -- ID 16
(UPPER('Lisboa'), 'C', 10),                     -- ID 17
(UPPER('Oporto'), 'C', 11);                     -- ID 18

COMMIT;

----MUSEOS-----
BEGIN;
INSERT INTO MUSEOS (nombre, mision_proposito, fecha_fundacion, id_lugar) VALUES
-- MUSEO 1
(UPPER('Museo Nacional Centro de Arte Reina Sofía'),
 UPPER('Conservar, investigar y difundir el arte moderno y contemporáneo. Facilitar el acceso democrático a la cultura. Ser un espacio para el pensamiento crítico, el debate y la creación contemporánea en sus múltiples lenguajes: pintura, escultura, videoarte, performance, fotografía, instalación y más. Actuar como un centro de referencia internacional en arte contemporáneo y como archivo de la memoria reciente española.'),
 DATE '1992-09-10', 12),

-- MUSEO 2
(UPPER('Museo Nacional Thyssen-Bornemisza'),
 UPPER('El Museo Nacional Thyssen-Bornemisza tiene como misión conservar, estudiar y difundir una de las colecciones de arte más importantes del mundo, abarcando desde el siglo XIII hasta el XX. Su objetivo es ofrecer al público una visión global de la historia del arte occidental, complementando las colecciones del Museo del Prado y del Museo Reina Sofía, y promoviendo el acceso a la cultura y la educación artística.'),
 DATE '1992-10-08', 12),

-- MUSEO 3
(UPPER('La Galleria Nazionale'),
 UPPER('La Galleria Nazionale tiene como misión conservar, estudiar y promover el arte moderno y contemporáneo, tanto italiano como internacional, desde el siglo XIX hasta la actualidad. Busca ser un centro dinámico que fomente el diálogo entre las obras y el público, ofreciendo una visión crítica y plural del arte.'),
 DATE '1885-03-05', 13),

-- MUSEO 4
(UPPER('Pinacoteca di Brera'),
 UPPER('La Pinacoteca di Brera tiene como misión conservar, estudiar y difundir una de las colecciones de arte más importantes de Italia, abarcando obras desde el siglo XIII hasta el XX. El museo busca ofrecer al público una visión integral de la historia del arte italiano, promoviendo la educación artística y el acceso a la cultura.'),
 DATE '1809-08-15', 14),

-- MUSEO 5
(UPPER('Rijksmuseum'),
 UPPER('El Rijksmuseum es el museo nacional de los Países Bajos, dedicado a contar la historia de 800 años de arte e historia neerlandesa, desde el año 1200 hasta la actualidad. Además, organiza varias exposiciones al año con obras de su propia colección y préstamos nacionales e internacionales.'),
 DATE '1885-07-13', 15),

-- MUSEO 6
(UPPER('Kunstmuseum Den Haag'),
 UPPER('El Kunstmuseum Den Haag tiene como misión conservar, estudiar y difundir una de las colecciones de arte más importantes de Europa, abarcando desde el siglo XIX hasta la actualidad. El museo busca ofrecer al público una visión integral de la historia del arte moderno y contemporáneo, promoviendo la educación artística y el acceso a la cultura.'),
 DATE '1866-05-29', 16),

-- MUSEO 7
(UPPER('Museu Nacional de Arte Antiga'),
 UPPER('El Museu Nacional de Arte Antiga tiene como misión conservar, estudiar y difundir la más importante colección pública de arte antiguo de Portugal, abarcando obras desde la Edad Media hasta el siglo XIX. El museo busca ofrecer al público una visión integral del patrimonio artístico nacional e internacional, promoviendo la educación artística y el acceso a la cultura.'),
 DATE '1884-05-11', 17),

-- MUSEO 8
(UPPER('Museu Nacional Soares dos Reis'),
 UPPER('El Museu Nacional Soares dos Reis tiene como misión conservar, estudiar y difundir una de las colecciones de arte más importantes de Portugal, abarcando obras desde el siglo XVI hasta el XX. El museo busca ofrecer al público una visión integral del patrimonio artístico nacional, promoviendo la educación artística y el acceso a la cultura.'),
 DATE '1833-04-11', 18);
COMMIT;


----HORARIOS----
BEGIN;
 -- MUSEO 1
INSERT INTO HORARIOS(id_museo, dia, hora_inicio, hora_fin) VALUES
(1,1,'10:00','21:00'),
(1,3,'10:00','21:00'),
(1,4,'10:00','21:00'),
(1,5,'10:00','21:00'),
(1,6,'10:00','21:00'),
(1,7,'10:00','14:30');

-- MUSEO 2
INSERT INTO HORARIOS(id_museo, dia, hora_inicio, hora_fin) VALUES
(2,1,'12:00','16:00'),
(2,2,'10:00','19:00'),
(2,3,'10:00','19:00'),
(2,4,'10:00','19:00'),
(2,5,'10:00','19:00'),
(2,6,'10:00','23:00'),
(2,7,'10:00','19:00');

-- MUSEO 3
INSERT INTO HORARIOS(id_museo, dia, hora_inicio, hora_fin) VALUES
(3,2,'09:00','19:00'),
(3,3,'09:00','19:00'),
(3,4,'09:00','19:00'),
(3,5,'09:00','19:00'),
(3,6,'09:00','19:00'),
(3,7,'09:00','19:00');

-- MUSEO 4
INSERT INTO HORARIOS(id_museo, dia, hora_inicio, hora_fin) VALUES
(4,2,'08:00','19:15'),
(4,3,'08:00','19:15'),
(4,4,'08:00','19:15'),
(4,5,'08:00','19:15'),
(4,6,'08:00','19:15'),
(4,7,'08:00','19:15');

-- MUSEO 5
INSERT INTO HORARIOS(id_museo, dia, hora_inicio, hora_fin) VALUES
(5,1,'09:00','17:00'),
(5,2,'09:00','17:00'),
(5,3,'09:00','17:00'),
(5,4,'09:00','17:00'),
(5,5,'09:00','17:00'),
(5,6,'09:00','17:00'),
(5,7,'09:00','17:00');

-- MUSEO 6
INSERT INTO HORARIOS(id_museo, dia, hora_inicio, hora_fin) VALUES
(6,2,'10:00','17:00'),
(6,3,'10:00','17:00'),
(6,4,'10:00','17:00'),
(6,5,'10:00','17:00'),
(6,6,'10:00','17:00'),
(6,7,'10:00','17:00');

-- MUSEO 7
INSERT INTO HORARIOS(id_museo, dia, hora_inicio, hora_fin) VALUES
(7,2,'10:00','18:00'),
(7,3,'10:00','18:00'),
(7,4,'10:00','18:00'),
(7,5,'10:00','18:00'),
(7,6,'10:00','18:00'),
(7,7,'10:00','18:00');

-- MUSEO 8
INSERT INTO HORARIOS(id_museo, dia, hora_inicio, hora_fin) VALUES
(8,2,'10:00','18:00'),
(8,3,'10:00','18:00'),
(8,4,'10:00','18:00'),
(8,5,'10:00','18:00'),
(8,6,'10:00','18:00'),
(8,7,'10:00','18:00');
COMMIT; 


----ESTRUCTURAS FÍSICAS----
BEGIN;
-- MUSEO 1
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(1, 'EDIFICIO SABATINI', 'E', 'COLECCIÓN PERMANENTE Y ADMINISTRACIÓN', 'CALLE SANTA ISABEL, 52, 28012 MADRID');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(1, 'PISO 1 - EDIFICIO SABATINI', 'P', 1, 1);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(1, 'EDIFICIO NOUVEL', 'E', 'AUDITORIO, BIBLIOTECA Y EXPOSICIONES TEMPORALES', 'RONDA DE ATOCHA, 2, 28012 MADRID');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(1, 'PISO 1 - EDIFICIO NOUVEL', 'P', 1, 3);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(1, 'PALACIO DE VELÁZQUEZ', 'E', 'EXPOSICIONES DE GRAN FORMATO', 'PARQUE DEL RETIRO, MADRID');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(1, 'PISO 1 - PALACIO DE VELÁZQUEZ', 'P', 1, 5);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(1, 'PALACIO DE CRISTAL', 'E', 'INSTALACIONES ARTÍSTICAS CONTEMPORÁNEAS', 'PARQUE DEL RETIRO, MADRID');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(1, 'PISO 1 - PALACIO DE CRISTAL', 'P', 1, 7);

-- MUSEO 2
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(2, 'PALACIO DE VILLAHERMOSA', 'E', 'COLECCIÓN PERMANENTE', 'PASEO DEL PRADO, 8, 28014 MADRID');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(2, 'PISO 1 - PALACIO DE VILLAHERMOSA', 'P', 2, 9);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(2, 'AMPLIACIÓN CARMEN THYSSEN', 'E', 'EXPOSICIONES TEMPORALES', 'EDIFICIOS COLINDANTES');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(2, 'PISO 1 - AMPLIACIÓN CARMEN THYSSEN', 'P', 2, 11);

-- MUSEO 3
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(3, 'PALACIO DE BELLAS ARTES', 'E', 'SEDE PRINCIPAL Y EXPOSICIONES TEMPORALES', 'VIALE DELLE BELLE ARTI, 131, 00197 ROMA');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(3, 'PLANTA BAJA - PALACIO DE BELLAS ARTES', 'P', 3, 13);

-- MUSEO 4
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(4, 'PALAZZO BRERA', 'E', 'SEDE PRINCIPAL Y COLECCIÓN PERMANENTE', 'VIA BRERA, 28, 20121 MILÁN');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(4, 'PISO 1 - PALAZZO BRERA', 'P', 4, 15);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(4, 'PALAZZO CITTERIO', 'E', 'ARTE MODERNO Y CONTEMPORÁNEO', 'VIA BRERA, 12, 20121 MILÁN');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(4, 'PISO 1 - PALAZZO CITTERIO', 'P', 4, 17);

-- MUSEO 5
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(5, 'EDIFICIO PRINCIPAL', 'E', 'COLECCIÓN PERMANENTE', 'MUSEUMSTRAAT 1, 1071 XX ÁMSTERDAM');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(5, 'PISO 1 - EDIFICIO PRINCIPAL', 'P', 5, 19);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(5, 'PABELLÓN ASIÁTICO', 'E', 'COLECCIÓN DE ARTE ASIÁTICO', 'JARDÍN SUR DEL RIJKSMUSEUM');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(5, 'PISO 1 - PABELLÓN ASIÁTICO', 'P', 5, 21);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(5, 'ALA PHILIPS', 'E', 'EXPOSICIONES TEMPORALES', 'RIJKSMUSEUM');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(5, 'PISO 1 - ALA PHILIPS', 'P', 5, 23);

-- MUSEO 6
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(6, 'KUNSTMUSEUM DEN HAAG', 'E', 'COLECCIÓN PERMANENTE', 'STADHOUDERSLAAN 41, LA HAYA');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(6, 'PISO 1 - KUNSTMUSEUM DEN HAAG', 'P', 6, 25);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(6, 'KM21', 'E', 'ARTE CONTEMPORÁNEO', 'STADHOUDERSLAAN 43, LA HAYA');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(6, 'PISO 1 - KM21', 'P', 6, 27);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(6, 'FOTOMUSEUM DEN HAAG', 'E', 'MUSEO DE FOTOGRAFÍA', 'STADHOUDERSLAAN 43, LA HAYA');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(6, 'PISO 1 - FOTOMUSEUM DEN HAAG', 'P', 6, 29);

-- MUSEO 7
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(7, 'PALÁCIO DE ALVOR-POMBAL', 'E', 'COLECCIÓN PRINCIPAL', 'RUA DAS JANELAS VERDES, LISBOA');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(7, 'PISO 1 - PALÁCIO DE ALVOR-POMBAL', 'P', 7, 31);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(7, 'ANEXO CONVENTO DE SANTO ALBERTO', 'E', 'EXPOSICIONES ADICIONALES', 'CONECTADO AL PRINCIPAL');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(7, 'PISO 1 - ANEXO CONVENTO DE SANTO ALBERTO', 'P', 7, 33);

-- MUSEO 8
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion)
VALUES 
(8, 'PALÁCIO DOS CARRANCAS', 'E', 'COLECCIÓN PRINCIPAL', 'RUA DE DOM MANUEL II, 44, OPORTO');

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(8, 'PLANTA BAJA - PALÁCIO DOS CARRANCAS', 'P', 8, 35);
--Para las obras--
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(1, 'PISO 2 - EDIFICIO SABATINI', 'P', 1, 1);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(1, 'PISO 4 - EDIFICIO SABATINI', 'P', 1, 1);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(2, 'PISO 2 - PALACIO DE VILLAHERMOSA', 'P', 2, 9);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(3, 'PISO 1 - PALACIO DE BELLAS ARTES', 'P', 3, 13);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(4, 'PISO 2 - PALAZZO BRERA', 'P', 4, 15);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(4, 'PISO 2 - PALAZZO CITTERIO', 'P', 4, 17);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(6, 'PISO 2 - KUNSTMUSEUM DEN HAAG', 'P', 6, 25);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)
VALUES 
(8, 'PISO 1 - PALÁCIO DOS CARRANCAS', 'P', 8, 35);
COMMIT;
 
----SALAS DE EXPOSICIÓN-----
BEGIN;

INSERT INTO SALAS_EXP (id_museo, id_estructura_fis, nombre) VALUES
-- Museo 1: Reina Sofía
(1, 37, 'SALA 206'),
(1, 37, 'SALA 201'),
(1, 37, 'SALA 205'),
(1, 38, 'SALA 401'),
(1, 38, 'SALA 402'),

-- Museo 2: Thyssen
(2, 10, 'SALA 12'),
(2, 10, 'SALA 13'),
(2, 39, 'SALA 29'),
(2, 39, 'SALA 30'),
(2, 39, 'SALA 33'),
(2, 39, 'SALA 31'),

-- Museo 3: Galleria Nazionale
(3, 14, 'SALA 2'),
(3, 14, 'SALA 4'),
(3, 40, 'SALA 8'),
(3, 40, 'SALA 10'),
(3, 40, 'SALA 14'),

-- Museo 4: Pinacoteca di Brera
(4, 16, 'SALA 15'),
(4, 16, 'SALA 20'),
(4, 16, 'SALA 7'),
(4, 41, 'SALA 37'),
(4, 41, 'SALA 29'),
(4, 41, 'SALA 30'),

-- Museo 6: Kunstmuseum
(6, 26, 'SALA ARTE SIMBÓLICO'),
(6, 26, 'SALA REALISMO'),
(6, 43, 'SALA IMPRESIONISTAS'),

-- Museo 7: MNAA
(7, 32, 'SALA 1'),
(7, 32, 'SALA 5'),
(7, 32, 'SALA 10'),
(7, 32, 'SALA 11'),

-- Museo 8: Soares dos Reis
(8, 36, 'SALA 3'),
(8, 36, 'SALA 4'),
(8, 36, 'SALA 5'),
(8, 36, 'SALA DE ESCULTURA'),
(8, 44, 'SALA DE ESCULTURA MODERNA');

COMMIT;


----OBRAS DE ARTE-----

BEGIN;

INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('GUERNICA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 35, 37, 1, '1952-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LA MUJER EN AZUL', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 36, 37, 1, '1881-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL ROSTRO DEL GRAN MASTURBADOR', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 37, 37, 1, '1908-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('CABEZA DE MUJER LLORANDO', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 35, 37, 1, '1939-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('RETRATO DE RAMÓN GÓMEZ DE LA SERNA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 38, 38, 1, '1888-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('TORSO DE MUJER', '100x80 CM', 'E', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 39, 38, 1, '1991-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('SANTA CATALINA DE ALEJANDRÍA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 40, 10, 2, '1984-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('SAN JERÓNIMO PENITENTE', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 41, 10, 2, '1937-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL TESTAMENTO DE ISABEL LA CATÓLICA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 42, 39, 2, '1994-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LA CASA JUNTO A LAS VÍAS DEL TREN', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 43, 39, 2, '1965-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('BUSTO DE HOMBRE JOVEN', '100x80 CM', 'E', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 44, 39, 2, '1988-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('CABEZA DE MUJER', '100x80 CM', 'E', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 45, 39, 2, '1900-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('AMOR SACRO Y AMOR PROFANO', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 46, 14, 3, '1894-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('CLEOPATRA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 47, 14, 3, '1994-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LAS DOS MADRES', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 48, 40, 3, '1977-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL ESPEJO DE VENUS', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 49, 40, 3, '1990-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('COMPOSIZIONE', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 50, 40, 3, '1938-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('SCOMPOSIZIONE DINAMICA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 50, 40, 3, '1890-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LA CENA DE EMAÚS', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 51, 16, 4, '1928-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LA DEPOSICIÓN DE LA CRUZ', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 52, 16, 4, '1973-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('VIRGEN CON EL NIÑO Y SANTOS', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 53, 16, 4, '1931-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL BESO ROBADO', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 54, 41, 4, '1979-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('FIGURA FEMENINA RECLINADA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 55, 41, 4, '1890-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('CABEZA DE MUJER JOVEN', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 56, 41, 4, '1898-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('BODEGÓN CON FLOREROS', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 57, 26, 6, '1967-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('MUJER CON SOMBRERO ROJO', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 58, 26, 6, '1968-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL PUERTO DE RÓTERDAM', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 59, 43, 6, '1989-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('RETRATO DE MUJER SENTADA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 59, 43, 6, '1978-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('SAN VICENTE Y LA CORTE DE LISBOA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 60, 32, 7, '1986-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LA TENTACIÓN DE SAN ANTONIO', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 61, 32, 7, '1981-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('VIRGEN CON EL NIÑO', '100x80 CM', 'E', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 62, 32, 7, '1912-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('SAN JUAN EVANGELISTA', '100x80 CM', 'E', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 63, 32, 7, '1920-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('RETRATO DE FRANCISCO DE LACERDA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 64, 36, 8, '1940-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('PAISAGEM COM PINHEIROS', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 65, 36, 8, '1890-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('BARCOS NO DOURO', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 66, 36, 8, '1897-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('BUSTO DE CAMILO CASTELO BRANCO', '100x80 CM', 'E', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 67, 36, 8, '1930-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('FIGURA SENTADA', '100x80 CM', 'E', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 68, 44, 8, '1926-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('RETRATO DE SENHORA COM LEQUE', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 67, 36, 8, '1888-01-01');

COMMIT;


--ARTISTAS--
BEGIN;

INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'PABLO', 'PICASSO', 'PICASSO', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'PABLO', 'PICASSO', 'PICASSO', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'SALVADOR', 'DALÍ', 'DALÍ', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'PABLO', 'PICASSO', 'PICASSO', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'JOSÉ', 'GUTIÉRREZ', 'GÓMEZ DE LA SERNA', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'DESCONOCIDO', '', '', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'FERNANDO', 'YÁÑEZ', 'YÁÑEZ DE LA ALMEDINA', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'EL', 'GRECO', 'EL GRECO', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'FRANCISCO', 'PRADILLA', 'PRADILLA', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'EDWARD', 'HOPPER', 'HOPPER', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'AUGUSTE', 'RODIN', 'RODIN', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'CAMILLE', 'CLAUDEL', 'CLAUDEL', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'TIZIANO', 'VECELLIO', 'TIZIANO', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'GUIDO', 'RENI', 'RENI', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'GIOVANNI', 'SEGANTINI', 'SEGANTINI', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'EDWARD', 'BURNE-JONES', 'BURNE-JONES', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'GIACOMO', 'BALLA', 'BALLA', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'UMBERTO', 'BOCCIONI', 'BOCCIONI', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'CARAVAGGIO', '', 'CARAVAGGIO', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'PETER', 'RUBENS', 'RUBENS', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'RAFAEL', 'SANZIO', 'RAFAEL', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'FRANCESCO', 'HAYEZ', 'HAYEZ', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'GIORGIO', 'MORANDI', 'MORANDI', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'AMÉDÉE', 'MODIGLIANI', 'MODIGLIANI', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'JAN', 'TOOROP', 'TOOROP', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'THÉO', 'VAN RYSSELBERGHE', 'RYSSELBERGHE', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'JOHAN', 'BARTHOLD', 'JONGKIND', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'ISAAC', 'ISRAËLS', 'ISRAËLS', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'NUNO', 'GONÇALVES', 'GONÇALVES', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'HIERONYMUS', 'BOSCH', 'EL BOSCO', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'JOSÉ', 'FERREIRA', 'FERREIRA', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'ANTÓNIO', 'TEIXEIRA', 'TEIXEIRA', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'COLUMBANO', 'BORDALO', 'PINHEIRO', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'SILVA', 'PORTO', 'PORTO', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'ANTÓNIO', 'CARNEIRO', 'CARNEIRO', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'ANTÓNIO', 'TEIXEIRA', 'TEIXEIRA', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'JOAQUIM', 'MACHADO', 'MACHADO', '1880-01-01', '1950-01-01');
INSERT INTO ARTISTAS (caract_est_tec, nombre, apellido, nombre_artistico, fecha_nac, fecha_def)
VALUES ('ARTISTA DESTACADO EN ESTILO CLÁSICO O MODERNO', 'ANTÓNIO', 'TEIXEIRA', 'TEIXEIRA', '1880-01-01', '1950-01-01');

COMMIT;


--OBRAS_ARTISTAS--

BEGIN;

INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (1, 1);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (2, 2);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (3, 3);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (4, 4);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (5, 5);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (6, 6);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (7, 7);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (8, 8);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (9, 9);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (10, 10);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (11, 11);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (12, 12);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (13, 13);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (14, 14);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (15, 15);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (16, 16);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (17, 17);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (18, 18);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (19, 19);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (20, 20);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (21, 21);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (22, 22);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (23, 23);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (24, 24);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (25, 25);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (26, 26);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (27, 27);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (28, 28);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (29, 29);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (30, 30);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (31, 31);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (32, 32);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (33, 33);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (34, 34);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (35, 35);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (36, 36);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (37, 37);
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (38, 38);

COMMIT;

-- ESTRUCTURAS ORGANIZACIONALES --
BEGIN;

-- Dirección de Colecciones (nivel 1) por museo
INSERT INTO ESTRUCTURAS_ORGANIZACIONALES (id_museo, nombre, tipo, descripcion, nivel)
VALUES 
(1, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(2, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(3, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(4, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(5, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(6, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(7, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(8, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1);

COMMIT;

--COLECCIONES--
BEGIN;

-- Museo 1: Reina Sofía
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(1, 1, 'VANGUARDIAS HISTÓRICAS', 'OBRAS EMBLEMÁTICAS DE LAS VANGUARDIAS EUROPEAS DEL SIGLO XX', 'VANGUARDIAS', '1'),
(1, 1, 'SURREALISMO Y VANGUARDIAS INTERNACIONALES', 'OBRAS DESTACADAS DEL MOVIMIENTO SURREALISTA', 'SURREALISMO', '2'),
(1, 1, 'ARTE CONTEMPORÁNEO Y ESCULTURA', 'OBRAS ESCULTÓRICAS Y PICTÓRICAS DE TENDENCIAS ACTUALES', 'CONTEMPORÁNEO', '3');

-- Museo 2: Thyssen-Bornemisza
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(2, 2, 'RENACIMIENTO Y BARROCO', 'PINTURA RELIGIOSA Y CLÁSICA EUROPEA DE LOS SIGLOS XV AL XVII', 'RENACIMIENTO', '1'),
(2, 2, 'ROMANTICISMO Y REALISMO', 'OBRAS DEL SIGLO XIX CON TEMÁTICA SOCIAL Y POLÍTICA', 'ROMANTICISMO', '2'),
(2, 2, 'ESCULTURA CLÁSICA Y MODERNA', 'OBRAS ESCULTÓRICAS REPRESENTATIVAS DE DIVERSOS ESTILOS', 'ESCULTURA', '3');

-- Museo 3: La Galleria Nazionale
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(3, 3, 'ARTE DEL SIGLO XIX', 'OBRAS NEOCLÁSICAS Y ROMÁNTICAS ITALIANAS', 'NEOCLÁSICO', '1'),
(3, 3, 'REALISMO Y SIMBOLISMO ITALIANO', 'OBRAS CON CARGA SOCIAL Y SIMBÓLICA', 'SIMBOLISMO', '2'),
(3, 3, 'ARTE MODERNO Y VANGUARDIAS', 'PINTURA MODERNA E INNOVADORA DEL SIGLO XX', 'VANGUARDIA', '3');

-- Museo 4: Pinacoteca di Brera
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(4, 4, 'RENACIMIENTO ITALIANO', 'PINTURA RELIGIOSA RENACENTISTA', 'RENACIMIENTO', '1'),
(4, 4, 'MANIERISMO Y BARROCO', 'OBRAS CON INTENSIDAD EMOCIONAL Y DRAMÁTICA', 'BARROCO', '2'),
(4, 4, 'SIGLO XIX Y PRINCIPIOS DEL XX', 'OBRAS CON TEMAS MODERNOS Y POSTROMÁNTICOS', 'SIGLO XIX', '3');

-- Museo 6: Kunstmuseum Den Haag
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(6, 6, 'ARTE MODERNO Y VANGUARDIAS', 'OBRAS DE PINTORES INFLUYENTES DEL SIGLO XX', 'MODERNO', '1'),
(6, 6, 'ARTE NEERLANDÉS DEL SIGLO XIX', 'REALISMO Y ROMANTICISMO HOLANDÉS', 'SIGLO XIX', '2');

-- Museo 7: MNAA
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(7, 7, 'PINTURA PORTUGUESA Y EUROPEA DEL RENACIMIENTO Y BARROCO', 'OBRAS CLAVES DEL PATRIMONIO RELIGIOSO Y CLÁSICO', 'BARROCO', '1'),
(7, 7, 'ESCULTURA RELIGIOSA Y CLÁSICA', 'ESCULTURAS DE TEMÁTICA SACRA', 'ESCULTURA', '2');

-- Museo 8: Museu Nacional Soares dos Reis
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(8, 8, 'PINTURA PORTUGUESA DEL SIGLO XIX Y XX', 'PAISAJES Y RETRATOS DE PINTORES PORTUGUESES', 'PINTURA', '1'),
(8, 8, 'ESCULTURA CLÁSICA PORTUGUESA', 'ESCULTURAS DE GRANDES MAESTROS PORTUGUESES', 'ESCULTURA', '2');

COMMIT;


-- COLECCIONES_SALAS --
BEGIN;

-- Museo 1: Reina Sofía
INSERT INTO COLECCIONES_SALAS VALUES (1, 1, 1, 37, 35); -- SALA 206
INSERT INTO COLECCIONES_SALAS VALUES (1, 1, 1, 37, 36); -- SALA 201
INSERT INTO COLECCIONES_SALAS VALUES (1, 1, 2, 37, 37); -- SALA 205
INSERT INTO COLECCIONES_SALAS VALUES (1, 1, 2, 37, 35); -- SALA 206
INSERT INTO COLECCIONES_SALAS VALUES (1, 1, 3, 38, 38); -- SALA 401
INSERT INTO COLECCIONES_SALAS VALUES (1, 1, 3, 38, 39); -- SALA 402

-- Museo 2: Thyssen-Bornemisza
INSERT INTO COLECCIONES_SALAS VALUES (2, 2, 4, 10, 40); -- SALA 12
INSERT INTO COLECCIONES_SALAS VALUES (2, 2, 4, 10, 41); -- SALA 13
INSERT INTO COLECCIONES_SALAS VALUES (2, 2, 5, 39, 42); -- SALA 29
INSERT INTO COLECCIONES_SALAS VALUES (2, 2, 5, 39, 43); -- SALA 30
INSERT INTO COLECCIONES_SALAS VALUES (2, 2, 6, 39, 44); -- SALA 33
INSERT INTO COLECCIONES_SALAS VALUES (2, 2, 6, 39, 45); -- SALA 31

-- Museo 3: La Galleria Nazionale
INSERT INTO COLECCIONES_SALAS VALUES (3, 3, 7, 14, 46); -- SALA 2
INSERT INTO COLECCIONES_SALAS VALUES (3, 3, 7, 14, 47); -- SALA 4
INSERT INTO COLECCIONES_SALAS VALUES (3, 3, 8, 40, 48); -- SALA 8
INSERT INTO COLECCIONES_SALAS VALUES (3, 3, 8, 40, 49); -- SALA 10
INSERT INTO COLECCIONES_SALAS VALUES (3, 3, 9, 40, 50); -- SALA 14

-- Museo 4: Pinacoteca di Brera
INSERT INTO COLECCIONES_SALAS VALUES (4, 4, 10, 16, 51); -- SALA 15
INSERT INTO COLECCIONES_SALAS VALUES (4, 4, 11, 16, 52); -- SALA 20
INSERT INTO COLECCIONES_SALAS VALUES (4, 4, 11, 16, 53); -- SALA 7
INSERT INTO COLECCIONES_SALAS VALUES (4, 4, 10, 41, 54); -- SALA 37
INSERT INTO COLECCIONES_SALAS VALUES (4, 4, 12, 41, 55); -- SALA 29
INSERT INTO COLECCIONES_SALAS VALUES (4, 4, 12, 41, 56); -- SALA 30

-- Museo 6: Kunstmuseum Den Haag
INSERT INTO COLECCIONES_SALAS VALUES (6, 6, 13, 43, 59); -- SALA IMPRESIONISTAS
INSERT INTO COLECCIONES_SALAS VALUES (6, 6, 13, 26, 57); -- SALA ARTE SIMBÓLICO
INSERT INTO COLECCIONES_SALAS VALUES (6, 6, 14, 26, 58); -- SALA REALISMO
INSERT INTO COLECCIONES_SALAS VALUES (6, 6, 14, 43, 59); -- SALA IMPRESIONISTAS

-- Museo 7: MNAA
INSERT INTO COLECCIONES_SALAS VALUES (7, 7, 15, 32, 60); -- SALA 1
INSERT INTO COLECCIONES_SALAS VALUES (7, 7, 15, 32, 61); -- SALA 5
INSERT INTO COLECCIONES_SALAS VALUES (7, 7, 16, 32, 62); -- SALA 10
INSERT INTO COLECCIONES_SALAS VALUES (7, 7, 16, 32, 63); -- SALA 11

-- Museo 8: Soares dos Reis
INSERT INTO COLECCIONES_SALAS VALUES (8, 8, 17, 36, 64); -- SALA 3
INSERT INTO COLECCIONES_SALAS VALUES (8, 8, 17, 36, 65); -- SALA 4
INSERT INTO COLECCIONES_SALAS VALUES (8, 8, 17, 36, 66); -- SALA 5
INSERT INTO COLECCIONES_SALAS VALUES (8, 8, 18, 36, 67); -- SALA ESCULTURA
INSERT INTO COLECCIONES_SALAS VALUES (8, 8, 18, 44, 68); -- SALA ESCULTURA MODERNA

COMMIT;

-- INFO EMPLEADOS (REVISAR PQ ESTA EN INGLES xd)--
BEGIN;
INSERT INTO IDIOMAS (lengua) VALUES ('PORTUGUÉS');
INSERT INTO IDIOMAS (lengua) VALUES ('FRANCÉS');
INSERT INTO IDIOMAS (lengua) VALUES ('ALEMÁN');
INSERT INTO IDIOMAS (lengua) VALUES ('CATALÁN');
INSERT INTO IDIOMAS (lengua) VALUES ('ESPAÑOL');
INSERT INTO IDIOMAS (lengua) VALUES ('INGLÉS');
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad) VALUES (1, 'ENGINEER, MANUFACTURING SYSTEMS', 1996, 'DE-ENGINEERED 5THGENERATION ABILITY');
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad) VALUES (2, 'BUILDING SERVICES ENGINEER', 1997, 'OPEN-SOURCE HIGH-LEVEL STRUCTURE');
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad) VALUES (3, 'ACCOMMODATION MANAGER', 1996, 'SYNERGIZED ECO-CENTRIC THROUGHPUT');
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad) VALUES (4, 'RESEARCH SCIENTIST (MATHS)', 2006, 'PROGRAMMABLE MULTI-STATE STANDARDIZATION');
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad) VALUES (5, 'HEALTH AND SAFETY INSPECTOR', 2003, 'INNOVATIVE RADICAL ANALYZER');
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad) VALUES (6, 'CAMERA OPERATOR', 2009, 'FUNDAMENTAL DYNAMIC CAPABILITY');
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad) VALUES (7, 'RUNNER, BROADCASTING/FILM/VIDEO', 2014, 'SECURED MULTI-STATE ARCHITECTURE');
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad) VALUES (8, 'LECTURER, HIGHER EDUCATION', 2004, 'STAND-ALONE NEEDS-BASED ATTITUDE');
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (1, 5);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (2, 6);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (3, 6);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (3, 1);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (4, 2);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (4, 6);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (5, 4);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (5, 6);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (5, 3);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (6, 2);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (6, 3);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (7, 6);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (7, 4);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (8, 6);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (8, 4);
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (8, 1);
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo) VALUES (1, 1, 1, '2019-01-13', NULL, 'A');
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo) VALUES (2, 2, 2, '2015-08-07', NULL, 'A');
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo) VALUES (3, 3, 3, '2022-01-19', NULL, 'D');
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo) VALUES (4, 4, 4, '2019-10-01', NULL, 'R');
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo) VALUES (5, 5, 5, '2016-07-16', NULL, 'A');
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo) VALUES (6, 6, 6, '2016-04-30', NULL, 'R');
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo) VALUES (7, 7, 7, '2016-07-15', NULL, 'D');
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo) VALUES (8, 8, 8, '2022-12-27', NULL, 'R');
COMMIT;