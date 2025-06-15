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

--ENTRADAS--
INSERT INTO ENTRADAS(id_museo,fecha_hora_emision,monto,tipo)
VALUES
--museo 1
(1,NOW(),18,'G'),
--museo 2
(2,NOW(),14,'G'),
(2,NOW(),10,'R'),
--museo 3
(3,NOW(),15,'G'),
(3,NOW(),2,'R'),
--museo 4
(4,NOW(),15,'G'),
(4,NOW(),10,'R'),
--museo 5
(5,NOW(),25,'G'),
(5,NOW(),12.5,'R'),

--museo 6
(6,NOW(),20,'G'),
(6,NOW(),9,'R'),
--museo 7
(7,NOW(),6,'G'),
(7,NOW(),3,'R'),
--museo 8
(8,NOW(),10,'G'),
(8,NOW(),5,'R');


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
VALUES ('GUERNICA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 1, 37, 1, '1952-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LA MUJER EN AZUL', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 2, 37, 1, '1881-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL ROSTRO DEL GRAN MASTURBADOR', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 3, 37, 1, '1908-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('CABEZA DE MUJER LLORANDO', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 1, 37, 1, '1939-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('RETRATO DE RAMÓN GÓMEZ DE LA SERNA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 4, 38, 1, '1888-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('TORSO DE MUJER', '100x80 CM', 'E', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 5, 38, 1, '1991-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('SANTA CATALINA DE ALEJANDRÍA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 6, 10, 2, '1984-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('SAN JERÓNIMO PENITENTE', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 7, 10, 2, '1937-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL TESTAMENTO DE ISABEL LA CATÓLICA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 8, 39, 2, '1994-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LA CASA JUNTO A LAS VÍAS DEL TREN', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 9, 39, 2, '1965-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('BUSTO DE HOMBRE JOVEN', '100x80 CM', 'E', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 10, 39, 2, '1988-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('CABEZA DE MUJER', '100x80 CM', 'E', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 11, 39, 2, '1900-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('AMOR SACRO Y AMOR PROFANO', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 12, 14, 3, '1894-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('CLEOPATRA', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 13, 14, 3, '1994-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LAS DOS MADRES', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 14, 40, 3, '1977-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL ESPEJO DE VENUS', '100x80 CM', 'P', 'MODERNISMO', 'ÓLEO SOBRE LIENZO', 15, 40, 3, '1990-01-01');
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


----ARTISTAS----
BEGIN;

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Pablo', 'Picasso', 'Picasso', '1881-10-25', '1973-04-08', 'Cubismo, Surrealismo, Simbolismo, Periodo Azul, Periodo Rosa, Periodo Africano. Conocido por pintura, escultura, grabado, ceramista, diseño escénico.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Salvador', 'Dalí', 'Dalí', '1904-05-11', '1989-01-23', 'Surrealismo, conocido por imágenes oníricas, muy imaginativo, influenciado por maestros del Renacimiento.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Victorio', 'Macho', 'Victorio Macho', '1887-12-23', '1966-07-13', 'Escultor contemporáneo español, influenciado por el Art Déco, conocido por retratos y obras públicas.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Pablo', 'Gargallo', 'Pablo Gargallo', '1881-01-17', '1934-12-28', 'Escultor y pintor español, pionero en el trabajo del metal y las formas abstractas, asociado al Cubismo, influenciado por el Modernismo catalán y el Art Nouveau.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Michelangelo Merisi', 'da Caravaggio', 'Caravaggio', '1571-09-29', '1610-07-18', 'Pintor barroco, conocido por su realismo intenso e inquietante, iluminación de claroscuro, observación naturalista de modelos, fuerte influencia en movimientos artísticos posteriores.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Doménikos', 'Theotokópoulos', 'El Greco', '1541-01-01', '1614-04-07', 'Pintura española, estilo dramático y expresionista altamente individual, figuras alargadas, temas religiosos, precursor del Expresionismo y el Cubismo.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Eduardo', 'Rosales Gallinas', 'Eduardo Rosales', '1836-11-04', '1873-09-13', 'Pintor español, escenas históricas, influenciado por el Purismo, Romanticismo, Orientalismo.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Edward', 'Hopper', 'Edward Hopper', '1882-07-22', '1967-05-15', 'Pintor realista americano, exploración de temas como la soledad, la alienación y las complejidades de la vida moderna, pinturas al óleo, grabado y acuarela.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('François-Auguste-René', 'Rodin', 'Auguste Rodin', '1840-11-12', '1917-11-17', 'Escultor francés, gran influencia en el arte moderno, realismo, simbolismo, impresionismo, trabajó con bronce, mármol, yeso y arcilla.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Julio', 'González', 'Julio González', '1876-09-21', '1942-03-27', 'Escultor español, pionero en la escultura de hierro soldado, Cubismo, Surrealismo, formas abstractas, trabajo del metal, dibujante.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Francesco', 'Hayez', 'Francesco Hayez', '1791-02-10', '1882-12-12', 'Romanticismo, conocido por grandes pinturas históricas, alegorías políticas y retratos. Figura crucial en la transición del Neoclasicismo al Romanticismo en el arte italiano.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Giovanni Maria', 'Benzoni', 'Giovanni Maria Benzoni', '1809-08-28', '1873-04-28', 'Escultor neoclásico, conocido por producir obras para viajeros del "Grand Tour", monumentos funerarios.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Giovanni', 'Segantini', 'Giovanni Segantini', '1858-01-15', '1899-09-28', 'Pintor italiano, paisajes alpinos, cuadros alegóricos, fusionó el contenido simbolista con el Neoimpresionismo (Divisionismo).');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Giulio Aristide', 'Sartorio', 'Giulio Aristide Sartorio', '1860-02-11', '1932-10-03', 'Pintor y director de cine italiano, simbolista, frescos, influenciado por los prerrafaelitas, pintura de paisaje.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Giacomo', 'Balla', 'Giacomo Balla', '1871-07-24', '1958-03-01', 'Artista italiano, miembro fundador del movimiento futurista, representó la luz, el movimiento y la velocidad. También escultor, fotógrafo.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Gino', 'Severini', 'Gino Severini', '1883-04-07', '1966-02-27', 'Pintor italiano, miembro destacado del movimiento futurista, sintetizó los estilos del Futurismo y el Cubismo, asociado al neoclasicismo, trabajó en mosaico y fresco.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Federico', 'Barocci', 'Federico Barocci', '1528-01-01', '1612-09-30', 'Pintor y grabador del Renacimiento italiano, muy estimado e influyente, prefigura el Barroco (Proto-Barroco), preparación meticulosa y ejecución dinámica, desarrolló un estilo único en el centro de Italia, Manierismo.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Piero di Benedetto', 'dei Franceschi', 'Piero della Francesca', '1415-01-01', '1492-10-12', 'Pintor italiano del Primer Renacimiento, pionero en la perspectiva, figuras humanas monumentales mediante el uso escultórico de la línea y la luz, uso original del color y la luz, también matemático.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Medardo', 'Rosso', 'Medardo Rosso', '1858-06-20', '1928-03-31', 'Escultor italiano, Impresionismo, Modernismo, estilo Post-Impresionista, favorecía la cera por su translucidez, exploró la luz y la forma, conciencia social.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Adolfo', 'Wildt', 'Adolfo Wildt', '1868-03-01', '1931-03-12', 'Escultor italiano, conocido por esculturas de mármol, mezcla simplicidad y sofisticación, modernista, influenciado por el Gótico, Barroco, movimiento Secesionista, Expresionismo, Simbolismo.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Johannes Theodorus', 'Toorop', 'Jan Toorop', '1858-12-20', '1928-03-03', 'Pintor neerlandés, trabajó en varios estilos incluyendo Simbolismo, Art Nouveau, Puntillismo, primeros trabajos influenciados por el Impresionismo de Ámsterdam, obras religiosas, ilustraciones de libros, carteles, vidrieras.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('George Hendrik', 'Breitner', 'George Hendrik Breitner', '1857-09-12', '1923-06-05', 'Pintor y fotógrafo neerlandés, figura importante del Impresionismo de Ámsterdam, conocido por escenas callejeras y puertos en un estilo realista, pintó al aire libre, utilizó la fotografía como referencia, realismo social.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Johan Barthold', 'Jongkind', 'Johan Barthold Jongkind', '1819-06-03', '1891-02-09', 'Pintor y grabador neerlandés, paisajes marinos, precursor del Impresionismo, se centró en la atmósfera, los efectos fugaces de la luz y los reflejos.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Isaac Lazarus', 'Israëls', 'Isaac Israëls', '1865-02-03', '1934-10-07', 'Pintor neerlandés, asociado al Impresionismo de Ámsterdam, pintura de la vida moderna, paisajes urbanos, vida callejera, damas elegantes, interiores de cafés y talleres de costura, paleta más colorida.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Nuno', 'Gonçalves', 'Nuno Gonçalves', '1425-01-01', '1491-01-01', 'Artista portugués, inició el Renacimiento portugués en la pintura, pintor de la corte, conocido por los Paneles de San Vicente, representó elementos de la sociedad portuguesa, pintura religiosa, retrato.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Jheronimus van', 'Aken', 'Hieronymus Bosch', '1450-01-01', '1516-08-09', 'Pintor neerlandés, pintor del norte de Europa de la Baja Edad Media, iconografía inusual, estilo complejo e individual, ilustraciones fantásticas de conceptos religiosos, representaciones macabras y pesadillescas del infierno, óleo sobre tabla de roble.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Maestre Portugués', 'Anónimo', 'Maestre Portugués Anónimo', NULL, NULL, 'Maestro de escultura religiosa, estilo Gótico.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Gil', 'Vicente', 'Gil Vicente', '1465-01-01', '1536-01-01', 'Dramaturgo y poeta portugués, actuó y dirigió sus propias obras, notable poeta lírico, temas religiosos, satírico, influenciado por el teatro popular e ibérico, humanismo de Erasmo y el Renacimiento italiano.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Columbano', 'Bordalo Pinheiro', 'Columbano', '1857-11-21', '1929-11-06', 'Pintor realista portugués, especializado en retratos, maestro del realismo en la pintura portuguesa, estilo independiente, paleta inusual.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('António Carvalho da', 'Silva', 'Silva Porto', '1850-11-11', '1893-07-01', 'Pintor naturalista portugués, enfoque en el paisaje, técnica de pincelada libre, parte del Grupo do Leão, figura humana reducida.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Maria Aurélia Martins de', 'Sousa', 'Aurélia de Sousa', '1866-06-13', '1922-05-26', 'Pintora portuguesa, estilo personal y naturalista, influencias del realismo, Impresionismo y Postimpresionismo, temas que incluyen retratos, paisajes y escenas de la vida cotidiana.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('António', 'Teixeira Lopes', 'Teixeira Lopes', '1866-01-01', '1942-01-01', 'Escultor portugués, naturalismo, temas dramáticos de maternidad, expresividad melancólica, influenciado por modelos escultóricos franceses.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('Rodolfo', 'Pinto do Couto', 'Rodolfo Pinto do Couto', '1888-01-01', '1945-01-01', 'Escultor portugués, activo en Portugal y Brasil, conocido por púlpitos de bronce, bustos y monumentos.');

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES ('José', 'Simões de Almeida (sobrinho)', 'Simões de Almeida (sobrinho)', '1880-06-17', '1950-03-02', 'Escultor naturalista portugués, conocido por bustos y monumentos, carácter oficial y conmemorativo, estudió en Lisboa, París y Roma.');

COMMIT;


----OBRAS_ARTISTAS----
BEGIN;
-- Museo 1: Reina Sofía
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (1, 1); -- Guernica - Pablo Picasso
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (2, 1); -- La mujer en azul - Pablo Picasso
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (3, 2); -- El rostro del gran masturbador - Salvador Dalí
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (4, 1); -- Cabeza de mujer llorando - Pablo Picasso
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (5, 3); -- Retrato de Ramón Gómez de la Serna - Victorio Macho
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (6, 4); -- Torso de mujer - Pablo Gargallo

-- Museo 2: Thyssen-Bornemisza
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (7, 5); -- Santa Catalina de Alejandría - Michelangelo Merisi da Caravaggio
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (8, 6); -- San Jerónimo penitente - Doménikos Theotokópoulos (El Greco)
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (9, 7); -- El testamento de Isabel la Católica - Eduardo Rosales Gallinas
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (10, 8); -- La casa junto a las vías del tren - Edward Hopper
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (11, 9); -- Busto de hombre joven - François-Auguste-René Rodin
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (12, 10); -- Cabeza de mujer - Julio González

-- La Galleria Nazionale
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (13, 11); -- Amor sacro y amor profano - Francesco Hayez
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (14, 12); -- Cleopatra - Giovanni Maria Benzoni
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (15, 13); -- Las dos madres - Giovanni Segantini
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (16, 14); -- El espejo de Venus - Giulio Aristide Sartorio
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (17, 15); -- Composizione - Giacomo Balla
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (18, 16); -- Scomposizione dinamica - Gino Severini

-- Pinacoteca di Brera
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (19, 11); -- El beso robado - Francesco Hayez
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (20, 5); -- La cena de Emaús - Michelangelo Merisi da Caravaggio
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (21, 17); -- La deposición de la cruz - Federico Barocci
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (22, 18); -- Virgen con el niño y santos - Piero di Benedetto dei Franceschi
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (23, 19); -- Figura femenina reclinada - Medardo Rosso
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (24, 20); -- Cabeza de mujer joven - Adolfo Wildt

-- Kunstmuseum Den Haag
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (25, 23); -- El puerto de Róterdam - Johan Barthold Jongkind
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (26, 21); -- Bodegón con floreros - Johannes Theodorus Toorop
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (27, 22); -- Mujer con sombrero rojo - George Hendrik Breitner
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (28, 24); -- Retrato de mujer sentada - Isaac Lazarus Israëls

-- Museu Nacional de Arte Antiga (MNAA)
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (29, 25); -- San Vicente y la Corte de Lisboa - Nuno Gonçalves
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (30, 26); -- La tentación de San Antonio - Jheronimus van Aken (Hieronymus Bosch)
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (31, 27); -- Virgen con el niño (Nossa Senhora da Piedade) - Maestre Portugués Anónimo
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (32, 28); -- San Juan Evangelista - Gil Vicente

-- Museu Nacional Soares dos Reis
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (33, 29); -- Retrato de Francisco de Lacerda - Columbano Bordalo Pinheiro
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (34, 30); -- Paisagem com Pinheiros - António Carvalho da Silva (Silva Porto)
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (35, 31); -- Barcos no Douro - Maria Aurélia Martins de Sousa (Aurélia de Sousa)
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (36, 32); -- Busto de Camilo Castelo Branco - António Teixeira Lopes
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (37, 33); -- Figura Sentada - Rodolfo Pinto do Couto
INSERT INTO OBRAS_ARTISTAS (id_obra, id_artista) VALUES (38, 34); -- Retrato de Senhora com Leque - José Simões de Almeida (sobrinho)

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
(1, 1, 'VANGUARDIAS HISTÓRICAS', 'OBRAS EMBLEMÁTICAS DE LAS VANGUARDIAS EUROPEAS DEL SIGLO XX', 'VANGUARDIAS', 1),
(1, 1, 'SURREALISMO Y VANGUARDIAS INTERNACIONALES', 'OBRAS DESTACADAS DEL MOVIMIENTO SURREALISTA', 'SURREALISMO', 2),
(1, 1, 'ARTE CONTEMPORÁNEO Y ESCULTURA', 'OBRAS ESCULTÓRICAS Y PICTÓRICAS DE TENDENCIAS ACTUALES', 'CONTEMPORÁNEO', 3);

-- Museo 2: Thyssen-Bornemisza
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(2, 2, 'RENACIMIENTO Y BARROCO', 'PINTURA RELIGIOSA Y CLÁSICA EUROPEA DE LOS SIGLOS XV AL XVII', 'RENACIMIENTO', 1),
(2, 2, 'ROMANTICISMO Y REALISMO', 'OBRAS DEL SIGLO XIX CON TEMÁTICA SOCIAL Y POLÍTICA', 'ROMANTICISMO', 2),
(2, 2, 'ESCULTURA CLÁSICA Y MODERNA', 'OBRAS ESCULTÓRICAS REPRESENTATIVAS DE DIVERSOS ESTILOS', 'ESCULTURA', 3);

-- Museo 3: La Galleria Nazionale
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(3, 3, 'ARTE DEL SIGLO XIX', 'OBRAS NEOCLÁSICAS Y ROMÁNTICAS ITALIANAS', 'NEOCLÁSICO', 1),
(3, 3, 'REALISMO Y SIMBOLISMO ITALIANO', 'OBRAS CON CARGA SOCIAL Y SIMBÓLICA', 'SIMBOLISMO', 2),
(3, 3, 'ARTE MODERNO Y VANGUARDIAS', 'PINTURA MODERNA E INNOVADORA DEL SIGLO XX', 'VANGUARDIA', 3);

-- Museo 4: Pinacoteca di Brera
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(4, 4, 'RENACIMIENTO ITALIANO', 'PINTURA RELIGIOSA RENACENTISTA', 'RENACIMIENTO', 1),
(4, 4, 'MANIERISMO Y BARROCO', 'OBRAS CON INTENSIDAD EMOCIONAL Y DRAMÁTICA', 'BARROCO', 2),
(4, 4, 'SIGLO XIX Y PRINCIPIOS DEL XX', 'OBRAS CON TEMAS MODERNOS Y POSTROMÁNTICOS', 'SIGLO XIX', 3);

-- Museo 6: Kunstmuseum Den Haag
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(6, 6, 'ARTE NEERLANDÉS DEL SIGLO XIX', 'REALISMO Y ROMANTICISMO HOLANDÉS', 'SIGLO XIX', 1);
(6, 6, 'ARTE MODERNO Y VANGUARDIAS', 'OBRAS DE PINTORES INFLUYENTES DEL SIGLO XX', 'MODERNO', 2),

-- Museo 7: MNAA
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(7, 7, 'PINTURA PORTUGUESA Y EUROPEA DEL RENACIMIENTO Y BARROCO', 'OBRAS CLAVES DEL PATRIMONIO RELIGIOSO Y CLÁSICO', 'BARROCO', 1),
(7, 7, 'ESCULTURA RELIGIOSA Y CLÁSICA', 'ESCULTURAS DE TEMÁTICA SACRA', 'ESCULTURA', 2);

-- Museo 8: Museu Nacional Soares dos Reis
INSERT INTO COLECCIONES (id_museo, id_estructura_org, nombre_coleccion, descripcion_caracteristicas, palabra_clave, orden_recorrido)
VALUES
(8, 8, 'PINTURA PORTUGUESA DEL SIGLO XIX Y XX', 'PAISAJES Y RETRATOS DE PINTORES PORTUGUESES', 'PINTURA', 1),
(8, 8, 'ESCULTURA CLÁSICA PORTUGUESA', 'ESCULTURAS DE GRANDES MAESTROS PORTUGUESES', 'ESCULTURA', 2);

COMMIT;



-- EMPLEADOS_PROFESIONALES --
BEGIN;

-- Empleados para Museos en España (Museo Nacional Centro de Arte Reina Sofía - ID 1)
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES ('ESP123456', 'Elena', NULL, 'García', 'Ruiz', '1985-03-15');

-- Empleados para Museos en España (Museo Nacional Thyssen-Bornemisza - ID 2)
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES ('ESP987654', 'Carlos', NULL, 'López', 'Fernández', '1980-11-22');

-- Empleados para Museos en Italia (La Galleria Nazionale - ID 3)
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES ('IT0123456', 'Sofia', NULL, 'Rossi', 'Bianchi', '1990-07-01');

-- Empleados para Museos en Italia (Pinacoteca di Brera - ID 4)
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES ('IT7890123', 'Marco', NULL, 'Conti', 'Ferrari', '1988-04-10');

-- Empleados para Museos en Países Bajos (Rijksmuseum - ID 5)
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES ('NL1234567', 'Anna', NULL, 'Jansen', 'de Boer', '1975-09-20');

-- Empleados para Museos en Países Bajos (Kunstmuseum Den Haag - ID 6)
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES ('NL7654321', 'Pieter', NULL, 'Bakker', 'Visser', '1982-01-05');

-- Empleados para Museos en Portugal (Museu Nacional de Arte Antiga (MNAA) - ID 7)
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES ('PT0011223', 'Beatriz', NULL, 'Silva', 'Costa', '1989-06-18');

-- Empleados para Museos en Portugal (Museu Nacional Soares dos Reis - ID 8)
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES ('PT3344556', 'João', NULL, 'Ferreira', 'Mendes', '1970-12-03');
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES ('PT6789012', 'Miguel', 'Sousa', 'Martins', 'Pereira', '1995-02-28');
COMMIT;


---IDIOMAS-
BEGIN;
INSERT INTO IDIOMAS (lengua) VALUES ('Español'); -- id_idioma = 1
INSERT INTO IDIOMAS (lengua) VALUES ('Inglés');   -- id_idioma = 2
INSERT INTO IDIOMAS (lengua) VALUES ('Italiano'); -- id_idioma = 3
INSERT INTO IDIOMAS (lengua) VALUES ('Portugués'); -- id_idioma = 4
INSERT INTO IDIOMAS (lengua) VALUES ('Neerlandés'); -- id_idioma = 5
INSERT INTO IDIOMAS (lengua) VALUES ('Francés');  -- id_idioma = 6
INSERT INTO IDIOMAS (lengua) VALUES ('Alemán');   -- id_idioma = 7
INSERT INTO IDIOMAS (lengua) VALUES ('Chino Mandarín'); -- id_idioma = 8
INSERT INTO IDIOMAS (lengua) VALUES ('Japonés');  -- id_idioma = 9
COMMIT;



---- IDIOMAS_EMPLEADOS ----
BEGIN;
-- Elena García (num_expediente = 1)
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (1, 1); -- Español
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (1, 2); -- Inglés

-- Carlos López (num_expediente = 2)
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (2, 1); -- Español
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (2, 6); -- Francés

-- Sofia Rossi (num_expediente = 3)
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (3, 3); -- Italiano
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (3, 2); -- Inglés
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (3, 7); -- Alemán

-- Marco Conti (num_expediente = 4)
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (4, 3); -- Italiano
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (4, 1); -- Español

-- Anna Jansen (num_expediente = 5)
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (5, 5); -- Neerlandés
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (5, 2); -- Inglés
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (5, 7); -- Alemán

-- Pieter Bakker (num_expediente = 6)
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (6, 5); -- Neerlandés
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (6, 2); -- Inglés

-- Beatriz Silva (num_expediente = 7)
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (7, 4); -- Portugués
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (7, 2); -- Inglés

-- João Ferreira (num_expediente = 8)
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (8, 4); -- Portugués
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (8, 1); -- Español

-- Miguel Martins (num_expediente = 9)
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (9, 4); -- Portugués
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (9, 2); -- Inglés
INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma) VALUES (9, 8); -- Chino Mandarín

COMMIT;


-- FORMACIONES PROFESIONALES --
BEGIN;
-- Empleado 1: Elena García (España)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (1, 'Máster en Dirección y Gestión de Museos', 2010, 'Especialización en gestión estratégica y cultural de instituciones museísticas.');

-- Empleado 2: Carlos López (España)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (2, 'Grado en Conservación y Restauración de Bienes Culturales', 2005, 'Especializado en técnicas de restauración de pintura y escultura antigua.');

-- Empleado 3: Sofia Rossi (Italia)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (3, 'Doctorado en Historia del Arte', 2018, 'Investigación profunda en arte renacentista italiano y curaduría de exposiciones.');

-- Empleado 4: Marco Conti (Italia)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (4, 'Posgrado en Museología Contemporánea', 2015, 'Enfoque en nuevas metodologías de exhibición y gestión de colecciones modernas.');

-- Empleado 5: Anna Jansen (Países Bajos)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (5, 'Máster en Estudios de Patrimonio y Cultura', 2000, 'Experiencia en catalogación y gestión de colecciones de arte neerlandés.');

-- Empleado 6: Pieter Bakker (Países Bajos)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (6, 'Licenciatura en Historia del Arte', 2008, 'Especialización en arte moderno y vanguardias europeas del siglo XX.');

-- Empleado 7: Beatriz Silva (Portugal)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (7, 'Grado en Gestión Cultural y Producción de Eventos', 2012, 'Habilidades en coordinación administrativa y logística para exposiciones.');

-- Empleado 8: João Ferreira (Portugal)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (8, 'Doctorado en Arte Barroco Portugués', 2016, 'Investigador y curador experto en el arte de la época dorada portuguesa.');

-- Empleado 9: Miguel Martins (Portugal)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (9, 'Máster en Comunicación y Marketing Cultural', 2020, 'Enfoque en la difusión digital y estrategias de comunicación para museos.');
COMMIT;



-- HISTORICOS EMPLEADOS_PROFESIONALES --
BEGIN;

-- Empleado 1 (Elena García Ruiz) para Museo 1 (Reina Sofía) - Directora
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (1, 1, 1, '2020-01-10', NULL, 'D');

-- Empleado 2 (Carlos López Fernández) para Museo 2 (Thyssen-Bornemisza) - Restaurador
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (2, 2, 2, '2021-05-20', NULL, 'R');

-- Empleado 3 (Sofia Rossi Bianchi) para Museo 3 (La Galleria Nazionale) - Curadora
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (3, 3, 3, '2022-03-01', NULL, 'C');

-- Empleado 4 (Marco Conti Ferrari) para Museo 4 (Pinacoteca di Brera) - Curador
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (4, 4, 4, '2022-08-15', NULL, 'C');

-- Empleado 5 (Anna Jansen de Boer) para Museo 5 (Rijksmuseum) - Curadora
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (5, 5, 5, '2023-02-01', NULL, 'C');

-- Empleado 6 (Pieter Bakker Visser) para Museo 6 (Kunstmuseum Den Haag) - Curador
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (6, 6, 6, '2023-06-01', NULL, 'C');

-- Empleado 7 (Beatriz Silva Costa) para Museo 7 (MNAA) - Administrativa
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (7, 7, 7, '2024-04-10', NULL, 'A');

-- Empleado 8 (João Ferreira Mendes) para Museo 8 (Soares dos Reis) - Curador
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (8, 8, 8, '2024-11-01', NULL, 'C');

-- Empleado 9 (Miguel Sousa	Martins	Pereira) para Museo 8 (Soares dos Reis) - Curador
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (8, 8, 9, '2024-12-01', NULL, 'A');
COMMIT;


--COLECCIONES_SALAS--
BEGIN;
-- Datos para el Museo 1
INSERT INTO COLECCIONES_SALAS VALUES (1, 1, 1, 37, 1,1); -- SALA 206
INSERT INTO COLECCIONES_SALAS VALUES (1, 1, 1, 37, 2,2); -- SALA 201
INSERT INTO COLECCIONES_SALAS VALUES (1, 1, 2, 37, 1,3); -- SALA 205
INSERT INTO COLECCIONES_SALAS VALUES (1, 1, 2, 37, 2,1); -- SALA 206
INSERT INTO COLECCIONES_SALAS VALUES (1, 1, 3, 38, 1,4); -- SALA 401
INSERT INTO COLECCIONES_SALAS VALUES (1, 1, 3, 38, 2,5); -- SALA 402

-- Datos para el Museo 2
INSERT INTO COLECCIONES_SALAS VALUES (2, 2, 4, 10, 1,6); -- SALA 12
INSERT INTO COLECCIONES_SALAS VALUES (2, 2, 5, 39, 1,9); -- SALA 30
INSERT INTO COLECCIONES_SALAS VALUES (2, 2, 6, 39, 1,11); -- SALA 31

-- Datos para el Museo 3
INSERT INTO COLECCIONES_SALAS VALUES (3, 3, 7, 14, 1,12); -- SALA 2
INSERT INTO COLECCIONES_SALAS VALUES (3, 3, 8, 40, 1,14); -- SALA 8
INSERT INTO COLECCIONES_SALAS VALUES (3, 3, 8, 40, 2,15); -- SALA 10

-- Datos para el Museo 4
INSERT INTO COLECCIONES_SALAS VALUES (4, 4, 10, 16, 2,17); -- SALA 15
INSERT INTO COLECCIONES_SALAS VALUES (4, 4, 10, 41, 1,20); -- SALA 37

-- Datos para el Museo 7
INSERT INTO COLECCIONES_SALAS VALUES (7, 7, 15, 32, 1,26); -- SALA 1
INSERT INTO COLECCIONES_SALAS VALUES (7, 7, 15, 32, 2,27); -- SALA 5
INSERT INTO COLECCIONES_SALAS VALUES (7, 7, 16, 32, 1,28); -- SALA 10

-- Datos para el Museo 8
INSERT INTO COLECCIONES_SALAS VALUES (8, 8, 17, 36, 1,30); -- SALA 3
INSERT INTO COLECCIONES_SALAS VALUES (8, 8, 17, 36, 2,31); -- SALA 4
COMMIT;


-- EMPLEADOS MANT VIG-
BEGIN;

-- Empleado 1 (España - Vigilante)
INSERT INTO EMPLEADOS_MANT_VIG (nombre, apellido, doc_identidad, tipo)
VALUES ('Javier', 'Ruiz', 'ESP543210', 'V');

-- Empleado 2 (España - Mantenimiento)
INSERT INTO EMPLEADOS_MANT_VIG (nombre, apellido, doc_identidad, tipo)
VALUES ('Carmen', 'Díaz', 'ESP098765', 'M');

-- Empleado 3 (Italia - Vigilante)
INSERT INTO EMPLEADOS_MANT_VIG (nombre, apellido, doc_identidad, tipo)
VALUES ('Giulia', 'Ricci', 'ITL456789', 'V');

-- Empleado 4 (Italia - Mantenimiento)
INSERT INTO EMPLEADOS_MANT_VIG (nombre, apellido, doc_identidad, tipo)
VALUES ('Luca', 'Moretti', 'ITL987654', 'M');

-- Empleado 5 (Países Bajos - Vigilante)
INSERT INTO EMPLEADOS_MANT_VIG (nombre, apellido, doc_identidad, tipo)
VALUES ('Sanne', 'Mulder', 'NLD112233', 'V');

-- Empleado 6 (Países Bajos - Mantenimiento)
INSERT INTO EMPLEADOS_MANT_VIG (nombre, apellido, doc_identidad, tipo)
VALUES ('Dirk', 'De Vries', 'NLD445566', 'M');

-- Empleado 7 (Portugal - Vigilante)
INSERT INTO EMPLEADOS_MANT_VIG (nombre, apellido, doc_identidad, tipo)
VALUES ('Ana', 'Santos', 'PRT789012', 'V');

-- Empleado 8 (Portugal - Mantenimiento)
INSERT INTO EMPLEADOS_MANT_VIG (nombre, apellido, doc_identidad, tipo)
VALUES ('Diogo', 'Gomes', 'PRT345678', 'M');

-- Empleado 9 (España - Vigilante)
INSERT INTO EMPLEADOS_MANT_VIG (nombre, apellido, doc_identidad, tipo)
VALUES ('Laura', 'Blanco', 'ESP111222', 'V');

COMMIT;