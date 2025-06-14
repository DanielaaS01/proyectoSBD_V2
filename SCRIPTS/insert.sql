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

----MUSEOS-----

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

----HORARIOS----

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



-- ESTRUCTURAS FISICAS (Edificios y Pisos)
INSERT INTO ESTRUCTURAS_FISICAS(id_museo, id_estructura_fis, nombre, tipo, descripcion, direccion)
VALUES
-- MUSEO 1 - REINA SOFIA
(1, 1, 'EDIFICIO SABATINI', 'E', 'COLECCIÓN PERMANENTE Y ADMINISTRACIÓN', 'CALLE SANTA ISABEL, 52, 28012 MADRID'),
(1, 2, 'EDIFICIO NOUVEL', 'E', 'EXPOSICIONES TEMPORALES Y BIBLIOTECA', 'RONDA DE ATOCHA, 2, 28012 MADRID'),
(1, 3, 'PALACIO DE VELÁZQUEZ', 'E', 'EXPOS TEMPORALES DE GRAN FORMATO', 'PARQUE DEL RETIRO, MADRID'),
(1, 4, 'PALACIO DE CRISTAL', 'E', 'INSTALACIONES ARTÍSTICAS CONTEMPORÁNEAS', 'PARQUE DEL RETIRO, MADRID'),

-- MUSEO 2 - THYSSEN-BORNEMISZA
(2, 5, 'PALACIO DE VILLAHERMOSA', 'E', 'COLECCIÓN PERMANENTE Y AMPLIACIÓN', 'PASEO DEL PRADO, 8, 28014 MADRID'),

-- MUSEO 3 - GALLERIA NAZIONALE
(3, 6, 'PALACIO DE BELLAS ARTES', 'E', 'OBRAS SIGLO XIX Y XX', 'VIALE DELLE BELLE ARTI, 131, ROMA'),

-- MUSEO 4 - PINACOTECA DI BRERA
(4, 7, 'PALAZZO BRERA', 'E', 'COLECCIÓN HISTÓRICA PRINCIPAL', 'VIA BRERA, 28, 20121 MILÁN'),

-- MUSEO 5 - RIJKSMUSEUM
(5, 8, 'EDIFICIO PRINCIPAL', 'E', 'COLECCIÓN PERMANENTE', 'MUSEUMSTRAAT 1, 1071 XX ÁMSTERDAM'),
(5, 9, 'PABELLÓN ASIÁTICO', 'E', 'COLECCIÓN DE ARTE ASIÁTICO', 'JARDÍN SUR DEL MUSEO'),

-- MUSEO 6 - KUNSTMUSEUM
(6, 10, 'KUNSTMUSEUM DEN HAAG', 'E', 'COLECCIÓN PERMANENTE Y TEMPORALES', 'STADHOUDERSLAAN 41, LA HAYA'),

-- MUSEO 7 - MNAA
(7, 11, 'PALÁCIO DE ALVOR-POMBAL', 'E', 'COLECCIÓN PERMANENTE', 'RUA DAS JANELAS VERDES, LISBOA'),

-- MUSEO 8 - SOARES DOS REIS
(8, 12, 'PALÁCIO DOS CARRANCAS', 'E', 'SEDE DEL MUSEO', 'RUA DE DOM MANUEL II, OPORTO');

-- PISOS relacionados (con id_padre)

INSERT INTO ESTRUCTURAS_FISICAS(id_museo, id_estructura_fis, nombre, tipo, descripcion, id_museo_padre, id_padre)
VALUES
-- MUSEO 1 - REINA SOFÍA
(1, 13, 'PLANTA 2 - SABATINI', 'P', 'COLECCIÓN PERMANENTE', 1, 1),
(1, 14, 'PLANTA 4 - SABATINI', 'P', 'ESCULTURA CONTEMPORÁNEA', 1, 1),
(1, 15, 'PLANTA 1 - NOUVEL', 'P', 'AUDITORIO Y EXPOSICIONES', 1, 2),
(1, 16, 'PLANTA 2 - NOUVEL', 'P', 'DOCUMENTACIÓN Y CAFETERÍA', 1, 2),

-- MUSEO 2
(2, 17, 'PLANTA 1 - VILLAHERMOSA', 'P', 'RENACIMIENTO Y BARROCO', 2, 5),
(2, 18, 'PLANTA 2 - VILLAHERMOSA', 'P', 'ROMANTICISMO Y ARTE MODERNO', 2, 5),

-- MUSEO 3
(3, 19, 'PLANTA BAJA', 'P', 'ARTE DEL SIGLO XIX', 3, 6),
(3, 20, 'PLANTA ALTA', 'P', 'VANGUARDIAS Y CONTEMPORÁNEO', 3, 6),

-- MUSEO 4
(4, 21, 'PLANTA 1 - BRERA', 'P', 'RENACIMIENTO Y BARROCO', 4, 7),
(4, 22, 'PLANTA 2 - BRERA', 'P', 'SIGLO XIX Y ESCULTURA MODERNA', 4, 7),

-- MUSEO 5
(5, 23, 'GALERÍA DE HONOR', 'P', 'SIGLO DE ORO NEERLANDÉS', 5, 8),
(5, 24, 'GALERÍA DE ESCULTURA', 'P', 'ESCULTURA EUROPEA', 5, 8),

-- MUSEO 6
(6, 25, 'ALA MONDRIAN', 'P', 'NEOPLASTICISMO', 6, 10),
(6, 26, 'PLANTA 1', 'P', 'SIMBOLISMO Y REALISMO', 6, 10),

-- MUSEO 7
(7, 27, 'PLANTA BAJA', 'P', 'ARTE PORTUGUÉS Y EUROPEO', 7, 11),
(7, 28, 'PLANTA 1', 'P', 'ARTE COLONIAL Y RELIGIOSO', 7, 11),

-- MUSEO 8
(8, 29, 'PLANTA BAJA', 'P', 'PINTURA DEL SIGLO XIX', 8, 12),
(8, 30, 'PLANTA 1', 'P', 'ESCULTURA MODERNA', 8, 12);


-- ========================
-- MUSEO 1 - REINA SOFÍA
-- ========================
INSERT INTO SALAS_EXP(id_museo, id_estructura_fis, id_sala, nombre, descripcion)
VALUES
(1, 13, 201, 'SALA 201.02', 'PINTURA AZUL'),
(1, 13, 202, 'SALA 202', 'CUBISMO Y MUJERES'),
(1, 13, 205, 'SALA 205.02', 'CUBISMO JUAN GRIS'),
(1, 13, 206, 'SALA 206', 'PINTURA GUERNICA Y EXPRESIÓN'),
(1, 13, 213, 'SALA 205.13', 'SURREALISMO INTERNACIONAL'),
(1, 14, 401, 'SALA 401', 'RETRATO REALISTA'),
(1, 14, 402, 'SALA 402', 'ESCULTURA MODERNA'),
(1, 14, 403, 'SALA 403', 'ESCULTURA EXPRESIONISTA');

-- ========================
-- MUSEO 2 - THYSSEN
-- ========================
INSERT INTO SALAS_EXP(id_museo, id_estructura_fis, id_sala, nombre, descripcion)
VALUES
(2, 17, 6, 'SALA 6', 'RENACIMIENTO'),
(2, 17, 9, 'SALA 9', 'RENACIMIENTO VENECIANO'),
(2, 17, 12, 'SALA 12', 'BARROCO ITALIANO'),
(2, 17, 13, 'SALA 13', 'MANIERISMO ESPAÑOL'),
(2, 18, 29, 'SALA 29', 'REALISMO HISTÓRICO'),
(2, 18, 30, 'SALA 30', 'REALISMO AMERICANO'),
(2, 18, 31, 'SALA 31', 'ESCULTURA VANGUARDISTA'),
(2, 18, 32, 'SALA 32', 'IMAGINACIÓN SURREALISTA'),
(2, 18, 33, 'SALA 33', 'ESCULTURA MODERNA'),
(2, 18, 99, 'PATIO EXTERIOR', 'FIGURA RECLINADA');

-- ========================
-- MUSEO 3 - GALLERIA NAZIONALE
-- ========================
INSERT INTO SALAS_EXP(id_museo, id_estructura_fis, id_sala, nombre, descripcion)
VALUES
(3, 19, 2, 'SALA 2', 'ROMANTICISMO'),
(3, 19, 3, 'SALA 3', 'EL BESO'),
(3, 19, 4, 'SALA 4', 'CLEOPATRA ESCULTURA'),
(3, 19, 5, 'SALA 5', 'NINFA DORMIDA'),
(3, 20, 8, 'SALA 8', 'SIMBOLISMO'),
(3, 20, 9, 'SALA 9', 'SIMBOLISMO PREVIATI'),
(3, 20, 10, 'SALA 10', 'SIMBOLISMO VENUS'),
(3, 20, 13, 'SALA 13', 'FUTURISMO ESCULTURA'),
(3, 20, 14, 'SALA 14', 'FUTURISMO BALANCEADO'),
(3, 20, 15, 'SALA 15', 'METAFÍSICA ITALIANA');

-- ========================
-- MUSEO 4 - BRERA
-- ========================
INSERT INTO SALAS_EXP(id_museo, id_estructura_fis, id_sala, nombre, descripcion)
VALUES
(4, 21, 6, 'SALA 6', 'CRISTO MUERTO'),
(4, 21, 7, 'SALA 7', 'VIRGEN CON NIÑO'),
(4, 21, 15, 'SALA 15', 'CENA DE EMAÚS'),
(4, 21, 19, 'SALA 19', 'MATRIMONIO VIRGEN'),
(4, 21, 20, 'SALA 20', 'DEPOSICIÓN'),
(4, 22, 27, 'SALA 27', 'MACCHIAIOLI'),
(4, 22, 28, 'SALA 28', 'REALISMO'),
(4, 22, 29, 'SALA 29', 'ESCULTURA IMPRESIONISTA'),
(4, 22, 30, 'SALA 30', 'EXPRESIONISMO ESCULTÓRICO'),
(4, 22, 32, 'SALA 32', 'NEOCLÁSICO FRANCÉS'),
(4, 22, 37, 'SALA 37', 'EL BESO ROBADO');
-- ========================
-- MUSEO 5 - RIJKSMUSEUM
-- ========================
INSERT INTO SALAS_EXP(id_museo, id_estructura_fis, id_sala, nombre, descripcion)
VALUES
(5, 23, 23, 'SALA 2.3', 'GALERÍA DE HONOR - BARROCO NEERLANDÉS'),
(5, 23, 24, 'SALA 2.4', 'SÍNDICOS DEL GREMIO'),
(5, 23, 25, 'SALA 2.5', 'LA NOVIA JUDÍA'),
(5, 23, 26, 'SALA 2.6', 'AUTORRETRATO SOMBRERO'),
(5, 23, 27, 'SALA 2.7', 'MUJER CON PERLA ROJA'),
(5, 24, 31, 'ESCULTURA 1', 'BUSTO GUILLERMO I'),
(5, 24, 32, 'ESCULTURA 2', 'CABEZA DE ANCIANO'),
(5, 24, 33, 'ESCULTURA 3', 'FIGURA JUSTICIA');

-- ========================
-- MUSEO 6 - KUNSTMUSEUM
-- ========================
INSERT INTO SALAS_EXP(id_museo, id_estructura_fis, id_sala, nombre, descripcion)
VALUES
(6, 25, 1, 'SALA MONDRIAN 1', 'COMPOSICIÓN NEOPLASTICISTA'),
(6, 25, 2, 'SALA MONDRIAN 2', 'VICTORY BOOGIE WOOGIE'),
(6, 26, 3, 'SALA IMPRESIONISTAS', 'PUERTO Y RETRATO'),
(6, 26, 4, 'SALA REALISMO', 'MUJER SOMBRERO ROJO'),
(6, 26, 5, 'SALA SIMBOLISMO', 'BODEGÓN FLOREROS'),
(6, 26, 6, 'SALA ESCULTORES', 'AUTORRETRATO'),
(6, 26, 7, 'JARDÍN DE ESCULTURAS', 'FIGURAS FEMENINAS'),
(6, 26, 8, 'PATIO CENTRAL', 'FIGURA EN MOVIMIENTO');

-- ========================
-- MUSEO 7 - MNAA
-- ========================
INSERT INTO SALAS_EXP(id_museo, id_estructura_fis, id_sala, nombre, descripcion)
VALUES
(7, 27, 1, 'SALA 1', 'SAN VICENTE'),
(7, 27, 5, 'SALA 5', 'TENTACIÓN DE SAN ANTONIO'),
(7, 27, 6, 'SALA 6', 'RETRATO DE DAMA'),
(7, 27, 7, 'SALA 7', 'SAN JERÓNIMO'),
(7, 27, 8, 'SALA 8', 'DESCENDIMIENTO'),
(7, 27, 10, 'SALA 10', 'VIRGEN CON NIÑO'),
(7, 27, 11, 'SALA 11', 'SAN JUAN EVANGELISTA'),
(7, 28, 12, 'SALA 12', 'BAJORRELIEVE ANUNCIACIÓN'),
(7, 28, 13, 'SALA ASIA-PORTUGUÉS', 'BIOMBO NAMBAN'),
(7, 28, 14, 'SALA GOA-BRASIL', 'TRÍPTICO DEL ROSARIO'),
(7, 28, 15, 'SALA INDIA PORTUGUESA', 'CRISTO DE MARFIL');

-- ========================
-- MUSEO 8 - SOARES DOS REIS
-- ========================
INSERT INTO SALAS_EXP(id_museo, id_estructura_fis, id_sala, nombre, descripcion)
VALUES
(8, 29, 3, 'SALA 3', 'RETRATO FRANCISCO LACERDA'),
(8, 29, 4, 'SALA 4', 'PAISAJE CON PINHEIROS'),
(8, 29, 5, 'SALA 5', 'BARCOS EN EL DOURO'),
(8, 29, 6, 'SALA 6', 'MUJER CON XALE ROJO'),
(8, 29, 7, 'SALA 6B', 'DAMA CON GUANTES'),
(8, 29, 8, 'SALA 6C', 'FIGURA EN EL CAMPO'),
(8, 29, 9, 'SALA CENTRAL', 'O DESTERRADO'),
(8, 30, 10, 'SALA ESCULTURA MODERNA', 'MENINA CON GATO');