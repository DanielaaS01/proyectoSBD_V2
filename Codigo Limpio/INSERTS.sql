-------------------------------------------------------------------------------------------------------------------
--  ===========================================================================================================  --
--  ========================================= Inserts de Tablas ===============================================  --
--  ===========================================================================================================  --
-------------------------------------------------------------------------------------------------------------------

                                                       --1--                                
-----------------------------------------------| LUGARES_GEOGRAFICOS |---------------------------------------------- 
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




                                                       --2--                              
-----------------------------------------------------| MUSEOS |--------------------------------------------------------------- 
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




                                                        --3--                                
-----------------------------------------------------| HORARIOS |------------------------------------------------------------- 
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




                                                        --4--                                
-----------------------------------------------------| ENTRADAS |------------------------------------------------------------- 



                                                        --5--                                
-----------------------------------------------| ESTRUCTURAS_FISICAS |--------------------------------------------------------
-- MUSEO 1: Reina Sofía
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(1, 'EDIFICIO SABATINI', 'E', 'COLECCIÓN PERMANENTE Y ADMINISTRACIÓN', 'CALLE SANTA ISABEL, 52, 28012 MADRID');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(1, 'PISO 1', 'P', 1, 1);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(1, 'EDIFICIO NOUVEL', 'E', 'AUDITORIO, BIBLIOTECA Y EXPOSICIONES TEMPORALES', 'RONDA DE ATOCHA, 2, 28012 MADRID');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(1, 'PISO 1', 'P', 1, 3);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(1, 'PALACIO DE VELÁZQUEZ', 'E', 'EXPOSICIONES DE GRAN FORMATO', 'PARQUE DEL RETIRO, MADRID');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(1, 'PISO 1', 'P', 1, 5);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(1, 'PALACIO DE CRISTAL', 'E', 'INSTALACIONES ARTÍSTICAS CONTEMPORÁNEAS', 'PARQUE DEL RETIRO, MADRID');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(1, 'PISO 1', 'P', 1, 7);

--MUSEO 2: Thyssen
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(2, 'PALACIO DE VILLAHERMOSA', 'E', 'COLECCIÓN PERMANENTE', 'PASEO DEL PRADO, 8, 28014 MADRID');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(2, 'PISO 1', 'P', 2, 9);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(2, 'AMPLIACIÓN CARMEN THYSSEN', 'E', 'EXPOSICIONES TEMPORALES', 'EDIFICIOS COLINDANTES');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(2, 'PISO 1', 'P', 2, 11);

-- MUSEO 3: La Galleria Nazionale
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(3, 'PALACIO DE BELLAS ARTES', 'E', 'SEDE PRINCIPAL Y EXPOSICIONES TEMPORALES', 'VIALE DELLE BELLE ARTI, 131, 00197 ROMA');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(3, 'PLANTA BAJA', 'P', 3, 13);

-- MUSEO 4: Pinacoteca di Brera
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(4, 'PALAZZO BRERA', 'E', 'SEDE PRINCIPAL Y COLECCIÓN PERMANENTE', 'VIA BRERA, 28, 20121 MILÁN');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(4, 'PISO 1', 'P', 4, 15);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(4, 'PALAZZO CITTERIO', 'E', 'ARTE MODERNO Y CONTEMPORÁNEO', 'VIA BRERA, 12, 20121 MILÁN');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(4, 'PISO 1', 'P', 4, 17);

-- MUSEO 5: Rijksmuseum
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(5, 'EDIFICIO PRINCIPAL', 'E', 'COLECCIÓN PERMANENTE', 'MUSEUMSTRAAT 1, 1071 XX ÁMSTERDAM');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(5, 'PISO 1', 'P', 5, 19);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(5, 'PABELLÓN ASIÁTICO', 'E', 'COLECCIÓN DE ARTE ASIÁTICO', 'JARDÍN SUR DEL RIJKSMUSEUM');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(5, 'PISO 1', 'P', 5, 21);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(5, 'ALA PHILIPS', 'E', 'EXPOSICIONES TEMPORALES', 'RIJKSMUSEUM');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(5, 'PISO 1', 'P', 5, 23);

-- MUSEO 6: Kunstmuseum Den Haag
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(6, 'KUNSTMUSEUM DEN HAAG', 'E', 'COLECCIÓN PERMANENTE', 'STADHOUDERSLAAN 41, LA HAYA');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(6, 'PISO 1', 'P', 6, 25);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(6, 'KM21', 'E', 'ARTE CONTEMPORÁNEO', 'STADHOUDERSLAAN 43, LA HAYA');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(6, 'PISO 1', 'P', 6, 27);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(6, 'FOTOMUSEUM DEN HAAG', 'E', 'MUSEO DE FOTOGRAFÍA', 'STADHOUDERSLAAN 43, LA HAYA');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(6, 'PISO 1', 'P', 6, 29);

-- MUSEO 7: Museu Nacional de Arte Antiga
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(7, 'PALÁCIO DE ALVOR-POMBAL', 'E', 'COLECCIÓN PRINCIPAL', 'RUA DAS JANELAS VERDES, LISBOA');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(7, 'PISO 1', 'P', 7, 31);

INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(7, 'ANEXO CONVENTO DE SANTO ALBERTO', 'E', 'EXPOSICIONES ADICIONALES', 'CONECTADO AL PRINCIPAL');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(7, 'PISO 1', 'P', 7, 33);

-- MUSEO 8: Museu Nacional Soares dos Reis
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, descripcion, direccion) VALUES 
(8, 'PALÁCIO DOS CARRANCAS', 'E', 'COLECCIÓN PRINCIPAL', 'RUA DE DOM MANUEL II, 44, OPORTO');
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(8, 'PLANTA BAJA', 'P', 8, 35);

-- OTROS PISOS--
-- Museo 1: Reina Sofía
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(1, 'PISO 2', 'P', 1, 1);
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(1, 'PISO 4', 'P', 1, 1);
--Museo 2: Thyssen
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(2, 'PISO 2', 'P', 2, 9);
-- Museo 3: La Galleria Nazionale
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(3, 'PISO 1', 'P', 3, 13);
-- Museo 4: Pinacoteca di Brera
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre)VALUES 
(4, 'PISO 2', 'P', 4, 15);
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(4, 'PISO 2', 'P', 4, 17);
-- Museo 6: Kunstmuseum Den Haag
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(6, 'PISO 2', 'P', 6, 25);
--Museo 8: Museu Nacional Soares dos Reis 
INSERT INTO ESTRUCTURAS_FISICAS (id_museo, nombre, tipo, id_museo_padre, id_padre) VALUES 
(8, 'PISO 1', 'P', 8, 35);




                                                        --6--                                
----------------------------------------------------| SALAS_EXP |-------------------------------------------------------------
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




                                                        --7--                                
------------------------------------------------| HISTORICOS_CIERRES |-------------------------------------------------------------




                                                        --8--                                
------------------------------------------------| EMPLEADOS_MANT_VIG |-------------------------------------------------------------




                                                        --9--                                
------------------------------------------| MESES_ASIGNACIONES_EMPLEADOS |-----------------------------------------------------------




                                                        --10--                                
-----------------------------------------------------| EVENTOS |----------------------------------------------------------------------




                                                        --11--                                
-----------------------------------------------| RESUMENES_HISTORICOS |---------------------------------------------------------------------- 




                                                        --12--                                
---------------------------------------------------| TIPOS_TICKETS |------------------------------------------------------------------------




                                                        --13--                                
-------------------------------------------------------| OBRAS |-----------------------------------------------------------------------------
--Museo 1: Reina Sofía
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('GUERNICA', '349.3 X 776.6', 'P', 'CUBISMO, EXPRESIONISMO', 'ÓLEO SOBRE LIENZO', 1, 37, 1, '1937-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LA MUJER EN AZUL', '32 X 65', 'P', 'PERIODO AZUL', 'ÓLEO SOBRE LIENZO', 2, 37, 1, '1901-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL ROSTRO DEL GRAN MASTURBADOR', '110 X 150', 'P', 'SURREALISMO', 'ÓLEO SOBRE LIENZO', 3, 37, 1, '1929-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('CABEZA DE MUJER LLORANDO', '60 X 49', 'P', 'CUBISMO EXPRESIONISTA', 'ÓLEO SOBRE LIENZO', 1, 37, 1, '1937-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('RETRATO DE RAMÓN GÓMEZ DE LA SERNA', '65 X 40 X 35', 'E', 'REALISMO', 'BRONCE FUNDIDO', 4, 38, 1, '1931-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('TORSO DE MUJER', '70 X 40 X 35', 'E', 'CUBISMO ESCULTÓRICO', 'HIERRO FORJADO', 5, 38, 1, '1925-01-01');

--Museo 2: Thyssen
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('SANTA CATALINA DE ALEJANDRÍA', '173 X 133', 'P', 'BARROCO', 'ÓLEO SOBRE LIENZO', 6, 10, 2, '1598-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('SAN JERÓNIMO PENITENTE', '108 X 89', 'P', 'MANIERISMO', 'ÓLEO SOBRE LIENZO', 7, 10, 2, '1600-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL TESTAMENTO DE ISABEL LA CATÓLICA', '390 X 541', 'P', 'REALISMO HISTÓRICO', 'ÓLEO SOBRE LIENZO', 8, 39, 2, '1864-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LA CASA JUNTO A LAS VÍAS DEL TREN', '61 X 73.7', 'P', 'REALISMO AMERICANO', 'ÓLEO SOBRE LIENZO', 9, 39, 2, '1925-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('BUSTO DE HOMBRE JOVEN', '55 X 40 X 30', 'E', 'ESCULTURA CLÁSICA MODERNA', 'BRONCE', 10, 39, 2, '1890-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('CABEZA DE MUJER', '50 X 30 X 30', 'E', 'VANGUARDIA ESPAÑOLA', 'HIERRO', 11, 39, 2, '1932-01-01');

--Museo 3: La Galleria Nazionale
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('AMOR SACRO Y AMOR PROFANO', '85 X 118', 'P', 'ROMANTICISMO', 'ÓLEO SOBRE LIENZO', 12, 14, 3, '1850-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('CLEOPATRA', '150 X 60 X 60', 'E', 'NEOCLASICISMO', 'MÁRMOL BLANCO', 13, 14, 3, '1870-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LAS DOS MADRES', '125 X 100', 'P', 'SIMBOLISMO / REALISMO', 'ÓLEO SOBRE LIENZO', 14, 40, 3, '1889-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL ESPEJO DE VENUS', '190 X 170', 'P', 'SIMBOLISMO ITALIANO', 'ÓLEO SOBRE LIENZO', 15, 40, 3, '1895-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('COMPOSIZIONE', '90 X 120', 'P', 'FUTURISMO', 'ÓLEO SOBRE LIENZO', 16, 40, 3, '1915-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('SCOMPOSIZIONE DINAMICA', '110 X 80', 'P', 'FUTURISMO', 'ÓLEO SOBRE LIENZO', 16, 40, 3, '1914-01-01');

--Museo 4: Pinacoteca di Brera
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LA CENA DE EMAÚS', '141 X 196', 'P', 'BARROCO', 'ÓLEO SOBRE LIENZO', 17, 16, 4, '1606-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LA DEPOSICIÓN DE LA CRUZ', '303  X 184', 'P', 'MANIERISMO', 'ÓLEO SOBRE LIENZO', 18, 16, 4, '1567-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('VIRGEN CON EL NIÑO Y SANTOS', '248 X 148', 'P', 'QUATTROCENTO', 'TÉMPERA SOBRE TABLA', 19, 16, 4, '1472-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL BESO ROBADO', '112 X 88', 'P', 'ROMANTICISMO', 'ÓLEO SOBRE LIENZO', 20, 41, 4, '1859-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('FIGURA FEMENINA RECLINADA', '100 X 160 X 80', 'E', 'IMPRESIONISMO ESCULTÓRICO', 'CERA Y YESO', 21, 41, 4, '1905-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('CABEZA DE MUJER JOVEN', '55 X 40 X 30', 'E', 'EXPRESIONISMO', 'MÁRMOL', 22, 41, 4, '1912-01-01');

--Museo 6: Kunstmuseum Den Haag
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('BODEGÓN CON FLOREROS', '65 X 50', 'P', 'SIMBOLISMO', 'ÓLEO SOBRE LIENZO', 23, 26, 6, '1912-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('MUJER CON SOMBRERO ROJO', '80 X 60', 'P', 'REALISMO NEERLANDÉS', 'ÓLEO SOBRE LIENZO', 24, 26, 6, '1895-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('EL PUERTO DE RÓTERDAM', '55 X 90', 'P', 'IMPRESIONISMO TEMPRANO', 'ÓLEO SOBRE LIENZO', 25, 43, 6, '1860-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('RETRATO DE MUJER SENTADA', '100 X 75', 'P', 'IMPRESIONISMO', 'ÓLEO SOBRE LIENZO', 25, 43, 6, '1901-01-01');

-- Museo 7: Museu Nacional de Arte Antiga
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('SAN VICENTE Y LA CORTE DE LISBOA', '200 X 100', 'P', 'GÓTICO TARDÍO / RENACIMIENTO', 'TÉMPERA SOBRE TABLA', 26, 32, 7, '1470-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('LA TENTACIÓN DE SAN ANTONIO', '131.5 X 220', 'P', 'GÓTICO FLAMENCO / FANTÁSTICO', 'ÓLEO SOBRE TABLA', 27, 32, 7, '1500-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('VIRGEN CON EL NIÑO', '130 X 70 X 50', 'E', 'GÓTICO', 'MADERA TALLADA Y POLICROMADA', 28, 32, 7, '1400-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('SAN JUAN EVANGELISTA', '150 X 50 X 40', 'E', 'RENACIMIENTO PORTUGUÉS', 'MADERA POLICROMADA', 29, 32, 7, '1500-01-01');

-- Museo 8: Museu Nacional Soares dos Reis
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('RETRATO DE FRANCISCO DE LACERDA', '120 X 90', 'P', 'REALISMO / RETRATO PSICOLÓGICO', 'ÓLEO SOBRE LIENZO', 30, 36, 8, '1900-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('PAISAGEM COM PINHEIROS', '75 X 110', 'P', 'NATURALISMO PORTUGUÉS', 'ÓLEO SOBRE LIENZO', 31, 36, 8, '1880-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('BARCOS NO DOURO', '80 X 60', 'P', 'REALISMO', 'ÓLEO SOBRE LIENZO', 32, 36, 8, '1901-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('BUSTO DE CAMILO CASTELO BRANCO', '60 X 45 X 35', 'E', 'REALISMO', 'BRONCE', 33, 36, 8, '1895-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('FIGURA SENTADA', '130 X 90 X 80', 'E', 'MODERNISMO PORTUGUÉS', 'BRONCE', 34, 44, 8, '1930-01-01');
INSERT INTO OBRAS (nombre, dimension, tipo, estilos, caract_mat_tec, id_sala, id_estructura_fis, id_museo, periodo)
VALUES ('RETRATO DE SENHORA COM LEQUE', '110 X 70 X 60', 'E', 'SIMBOLISMO', 'MÁRMOL', 33, 36, 8, '1910-01-01');



                                                        --14--                                
-----------------------------------------------------| ARTISTAS |-------------------------------------------------------------------------------
INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Pablo'), UPPER('Picasso'), UPPER('Picasso'), '1881-10-25', '1973-04-08', UPPER('Cubismo, Surrealismo, Simbolismo, Periodo Azul, Periodo Rosa, Periodo Africano. Conocido por pintura, escultura, grabado, ceramista, diseño escénico.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Salvador'), UPPER('Dalí'), UPPER('Dalí'), '1904-05-11', '1989-01-23', UPPER('Surrealismo, conocido por imágenes oníricas, muy imaginativo, influenciado por maestros del Renacimiento.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Victorio'), UPPER('Macho'), UPPER('Victorio Macho'), '1887-12-23', '1966-07-13', UPPER('Escultor contemporáneo español, influenciado por el Art Déco, conocido por retratos y obras públicas.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Pablo'), UPPER('Gargallo'), UPPER('Pablo Gargallo'), '1881-01-17', '1934-12-28', UPPER('Escultor y pintor español, pionero en el trabajo del metal y las formas abstractas, asociado al Cubismo, influenciado por el Modernismo catalán y el Art Nouveau.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Michelangelo Merisi'), UPPER('da Caravaggio'), UPPER('Caravaggio'), '1571-09-29', '1610-07-18', UPPER('Pintor barroco, conocido por su realismo intenso e inquietante, iluminación de claroscuro, observación naturalista de modelos, fuerte influencia en movimientos artísticos posteriores.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Doménikos'), UPPER('Theotokópoulos'), UPPER('El Greco'), '1541-01-01', '1614-04-07', UPPER('Pintura española, estilo dramático y expresionista altamente individual, figuras alargadas, temas religiosos, precursor del Expresionismo y el Cubismo.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Eduardo'), UPPER('Rosales Gallinas'), UPPER('Eduardo Rosales'), '1836-11-04', '1873-09-13', UPPER('Pintor español, escenas históricas, influenciado por el Purismo, Romanticismo, Orientalismo.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Edward'), UPPER('Hopper'), UPPER('Edward Hopper'), '1882-07-22', '1967-05-15', UPPER('Pintor realista americano, exploración de temas como la soledad, la alienación y las complejidades de la vida moderna, pinturas al óleo, grabado y acuarela.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('François-Auguste-René'), UPPER('Rodin'), UPPER('Auguste Rodin'), '1840-11-12', '1917-11-17', UPPER('Escultor francés, gran influencia en el arte moderno, realismo, simbolismo, impresionismo, trabajó con bronce, mármol, yeso y arcilla.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Julio'), UPPER('González'), UPPER('Julio González'), '1876-09-21', '1942-03-27', UPPER('Escultor español, pionero en la escultura de hierro soldado, Cubismo, Surrealismo, formas abstractas, trabajo del metal, dibujante.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Francesco'), UPPER('Hayez'), UPPER('Francesco Hayez'), '1791-02-10', '1882-12-12', UPPER('Romanticismo, conocido por grandes pinturas históricas, alegorías políticas y retratos. Figura crucial en la transición del Neoclasicismo al Romanticismo en el arte italiano.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Giovanni Maria'), UPPER('Benzoni'), UPPER('Giovanni Maria Benzoni'), '1809-08-28', '1873-04-28', UPPER('Escultor neoclásico, conocido por producir obras para viajeros del "Grand Tour", monumentos funerarios.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Giovanni'), UPPER('Segantini'), UPPER('Giovanni Segantini'), '1858-01-15', '1899-09-28', UPPER('Pintor italiano, paisajes alpinos, cuadros alegóricos, fusionó el contenido simbolista con el Neoimpresionismo (Divisionismo).'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Giulio Aristide'), UPPER('Sartorio'), UPPER('Giulio Aristide Sartorio'), '1860-02-11', '1932-10-03', UPPER('Pintor y director de cine italiano, simbolista, frescos, influenciado por los prerrafaelitas, pintura de paisaje.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Giacomo'), UPPER('Balla'), UPPER('Giacomo Balla'), '1871-07-24', '1958-03-01', UPPER('Artista italiano, miembro fundador del movimiento futurista, representó la luz, el movimiento y la velocidad. También escultor, fotógrafo.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Gino'), UPPER('Severini'), UPPER('Gino Severini'), '1883-04-07', '1966-02-27', UPPER('Pintor italiano, miembro destacado del movimiento futurista, sintetizó los estilos del Futurismo y el Cubismo, asociado al neoclasicismo, trabajó en mosaico y fresco.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Federico'), UPPER('Barocci'), UPPER('Federico Barocci'), '1528-01-01', '1612-09-30', UPPER('Pintor y grabador del Renacimiento italiano, muy estimado e influyente, prefigura el Barroco (Proto-Barroco), preparación meticulosa y ejecución dinámica, desarrolló un estilo único en el centro de Italia, Manierismo.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Piero di Benedetto'), UPPER('dei Franceschi'), UPPER('Piero della Francesca'), '1415-01-01', '1492-10-12', UPPER('Pintor italiano del Primer Renacimiento, pionero en la perspectiva, figuras humanas monumentales mediante el uso escultórico de la línea y la luz, uso original del color y la luz, también matemático.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Medardo'), UPPER('Rosso'), UPPER('Medardo Rosso'), '1858-06-20', '1928-03-31', UPPER('Escultor italiano, Impresionismo, Modernismo, estilo Post-Impresionista, favorecía la cera por su translucidez, exploró la luz y la forma, conciencia social.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Adolfo'), UPPER('Wildt'), UPPER('Adolfo Wildt'), '1868-03-01', '1931-03-12', UPPER('Escultor italiano, conocido por esculturas de mármol, mezcla simplicidad y sofisticación, modernista, influenciado por el Gótico, Barroco, movimiento Secesionista, Expresionismo, Simbolismo.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Johannes Theodorus'), UPPER('Toorop'), UPPER('Jan Toorop'), '1858-12-20', '1928-03-03', UPPER('Pintor neerlandés, trabajó en varios estilos incluyendo Simbolismo, Art Nouveau, Puntillismo, primeros trabajos influenciados por el Impresionismo de Ámsterdam, obras religiosas, ilustraciones de libros, carteles, vidrieras.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('George Hendrik'), UPPER('Breitner'), UPPER('George Hendrik Breitner'), '1857-09-12', '1923-06-05', UPPER('Pintor y fotógrafo neerlandés, figura importante del Impresionismo de Ámsterdam, conocido por escenas callejeras y puertos en un estilo realista, pintó al aire libre, utilizó la fotografía como referencia, realismo social.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Johan Barthold'), UPPER('Jongkind'), UPPER('Johan Barthold Jongkind'), '1819-06-03', '1891-02-09', UPPER('Pintor y grabador neerlandés, paisajes marinos, precursor del Impresionismo, se centró en la atmósfera, los efectos fugaces de la luz y los reflejos.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Isaac Lazarus'), UPPER('Israëls'), UPPER('Isaac Israëls'), '1865-02-03', '1934-10-07', UPPER('Pintor neerlandés, asociado al Impresionismo de Ámsterdam, pintura de la vida moderna, paisajes urbanos, vida callejera, damas elegantes, interiores de cafés y talleres de costura, paleta más colorida.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Nuno'), UPPER('Gonçalves'), UPPER('Nuno Gonçalves'), '1425-01-01', '1491-01-01', UPPER('Artista portugués, inició el Renacimiento portugués en la pintura, pintor de la corte, conocido por los Paneles de San Vicente, representó elementos de la sociedad portuguesa, pintura religiosa, retrato.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Jheronimus van'), UPPER('Aken'), UPPER('Hieronymus Bosch'), '1450-01-01', '1516-08-09', UPPER('Pintor neerlandés, pintor del norte de Europa de la Baja Edad Media, iconografía inusual, estilo complejo e individual, ilustraciones fantásticas de conceptos religiosos, representaciones macabras y pesadillescas del infierno, óleo sobre tabla de roble.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Maestre Portugués'), UPPER('Anónimo'), UPPER('Maestre Portugués Anónimo'), NULL, NULL, UPPER('Maestro de escultura religiosa, estilo Gótico.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Gil'), UPPER('Vicente'), UPPER('Gil Vicente'), '1465-01-01', '1536-01-01', UPPER('Dramaturgo y poeta portugués, actuó y dirigió sus propias obras, notable poeta lírico, temas religiosos, satírico, influenciado por el teatro popular e ibérico, humanismo de Erasmo y el Renacimiento italiano.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Columbano'), UPPER('Bordalo Pinheiro'), UPPER('Columbano'), '1857-11-21', '1929-11-06', UPPER('Pintor realista portugués, especializado en retratos, maestro del realismo en la pintura portuguesa, estilo independiente, paleta inusual.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('António Carvalho da'), UPPER('Silva'), UPPER('Silva Porto'), '1850-11-11', '1893-07-01', UPPER('Pintor naturalista portugués, enfoque en el paisaje, técnica de pincelada libre, parte del Grupo do Leão, figura humana reducida.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Maria Aurélia Martins de'), UPPER('Sousa'), UPPER('Aurélia de Sousa'), '1866-06-13', '1922-05-26', UPPER('Pintora portuguesa, estilo personal y naturalista, influencias del realismo, Impresionismo y Postimpresionismo, temas que incluyen retratos, paisajes y escenas de la vida cotidiana.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('António'), UPPER('Teixeira Lopes'), UPPER('Teixeira Lopes'), '1866-01-01', '1942-01-01', UPPER('Escultor portugués, naturalismo, temas dramáticos de maternidad, expresividad melancólica, influenciado por modelos escultóricos franceses.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('Rodolfo'), UPPER('Pinto do Couto'), UPPER('Rodolfo Pinto do Couto'), '1888-01-01', '1945-01-01', UPPER('Escultor portugués, activo en Portugal y Brasil, conocido por púlpitos de bronce, bustos y monumentos.'));

INSERT INTO ARTISTAS (nombre, apellido, nombre_artistico, fecha_nac, fecha_def, caract_est_tec)
VALUES (UPPER('José'), UPPER('Simões de Almeida (sobrinho)'), UPPER('Simões de Almeida (sobrinho)'), '1880-06-17', '1950-03-02', UPPER('Escultor naturalista portugués, conocido por bustos y monumentos, carácter oficial y conmemorativo, estudió en Lisboa, París y Roma.'));



                                                        --15--                                
--------------------------------------------------| OBRAS_ARTISTAS |-----------------------------------------------------------------------------
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




                                                        --16--                                
----------------------------------------------| EMPLEADOS_PROFESIONALES |-------------------------------------------------------------------------------
-- Empleado para Museo Nacional Centro de Arte Reina Sofía - ID 1
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES (UPPER('ESP123456'), UPPER('Elena'), NULL, UPPER('García'), UPPER('Ruiz'), '1985-03-15');

-- Empleado para Museo Nacional Thyssen-Bornemisza - ID 2
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES (UPPER('ESP987654'), UPPER('Carlos'), NULL, UPPER('López'), UPPER('Fernández'), '1980-11-22');

-- Empleado para La Galleria Nazionale - ID 3
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES (UPPER('IT0123456'), UPPER('Sofia'), NULL, UPPER('Rossi'), UPPER('Bianchi'), '1990-07-01');

-- Empleado para Pinacoteca di Brera - ID 4
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES (UPPER('IT7890123'), UPPER('Marco'), NULL, UPPER('Conti'), UPPER('Ferrari'), '1988-04-10');

-- Empleado para Museo Rijksmuseum - ID 5
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES (UPPER('NL1234567'), UPPER('Anna'), NULL, UPPER('Jansen'), UPPER('de Boer'), '1975-09-20');

-- Empleado para Museo Kunstmuseum Den Haag - ID 6
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES (UPPER('NL7654321'), UPPER('Pieter'), NULL, UPPER('Bakker'), UPPER('Visser'), '1982-01-05');

-- Empleado para Museu Nacional de Arte Antiga (MNAA) - ID 7
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES (UPPER('PT0011223'), UPPER('Beatriz'), NULL, UPPER('Silva'), UPPER('Costa'), '1989-06-18');

-- Empleados para Museu Nacional Soares dos Reis - ID 8
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES (UPPER('PT3344556'), UPPER('João'), NULL, UPPER('Ferreira'), UPPER('Mendes'), '1970-12-03');
INSERT INTO EMPLEADOS_PROFESIONALES (doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac)
VALUES (UPPER('PT6789012'), UPPER('Miguel'), UPPER('Sousa'), UPPER('Martins'), UPPER('Pereira'), '1995-02-28');

 


                                                        --17--                                
-----------------------------------------------------| IDIOMAS |---------------------------------------------------------------------------------------
INSERT INTO IDIOMAS (lengua) VALUES (UPPER('Español')); -- id_idioma = 1
INSERT INTO IDIOMAS (lengua) VALUES (UPPER('Inglés'));   -- id_idioma = 2
INSERT INTO IDIOMAS (lengua) VALUES (UPPER('Italiano')); -- id_idioma = 3
INSERT INTO IDIOMAS (lengua) VALUES (UPPER('Portugués')); -- id_idioma = 4
INSERT INTO IDIOMAS (lengua) VALUES (UPPER('Neerlandés')); -- id_idioma = 5
INSERT INTO IDIOMAS (lengua) VALUES (UPPER('Francés'));  -- id_idioma = 6
INSERT INTO IDIOMAS (lengua) VALUES (UPPER('Alemán'));   -- id_idioma = 7
INSERT INTO IDIOMAS (lengua) VALUES (UPPER('Chino Mandarín')); -- id_idioma = 8
INSERT INTO IDIOMAS (lengua) VALUES (UPPER('Japonés'));  -- id_idioma = 9




                                                        --18--                                
-------------------------------------------------| IDIOMAS_EMPLEADOS |----------------------------------------------------------------------------------
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




                                                        --19--                                
---------------------------------------------| FORMACIONES_PROFESIONALES |----------------------------------------------------------------------------------
-- Empleado 1: Elena García (España)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (1, UPPER('Máster en Curaduría de Arte y Museografía'), 2010, UPPER('Especialización en investigación, selección y exhibición de colecciones de arte.'));

-- Empleado 2: Carlos López (España)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (2, UPPER('Grado en Conservación y Restauración de Bienes Culturales'), 2005, UPPER('Especializado en técnicas de restauración de pintura y escultura antigua.'));

-- Empleado 3: Sofia Rossi (Italia)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (3, UPPER('Doctorado en Historia del Arte'), 2018, UPPER('Investigación profunda en arte renacentista italiano y curaduría de exposiciones.'));

-- Empleado 4: Marco Conti (Italia)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (4, UPPER('Posgrado en Museología Contemporánea'), 2015, UPPER('Enfoque en nuevas metodologías de exhibición y gestión de colecciones modernas.'));

-- Empleado 5: Anna Jansen (Países Bajos)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (5, UPPER('Máster en Estudios de Patrimonio y Cultura'), 2000, UPPER('Experiencia en catalogación y gestión de colecciones de arte neerlandés.'));

-- Empleado 6: Pieter Bakker (Países Bajos)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (6, UPPER('Licenciatura en Historia del Arte'), 2008, UPPER('Especialización en arte moderno y vanguardias europeas del siglo XX.'));

-- Empleado 7: Beatriz Silva (Portugal)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (7, UPPER('Grado en Historia del Arte y Curaduría'), 2012, UPPER('Formación en la teoría y práctica de la curaduría y gestión de exposiciones.'));

-- Empleado 8: João Ferreira (Portugal)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (8, UPPER('Doctorado en Arte Barroco Portugués'), 2016, UPPER('Investigador y curador experto en el arte de la época dorada portuguesa.'));

-- Empleado 9: Miguel Martins (Portugal)
INSERT INTO FORMACIONES_PROFESIONALES (num_expediente, nombre_titulo, anio, descripcion_especialidad)
VALUES (9, UPPER('Máster en Estudios Curatoriales y Crítica de Arte'), 2020, UPPER('Enfoque en la interpretación, crítica y presentación de obras de arte en contextos museísticos.'));




                                                        --20--                                
-------------------------------------------| ESTRUCTURAS_ORGANIZACIONALES |-------------------------------------------------------------------------------
INSERT INTO ESTRUCTURAS_ORGANIZACIONALES (id_museo, nombre, tipo, descripcion, nivel)
VALUES 
(1, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(2, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(3, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(4, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(5, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(6, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(7, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(8, 'DIRECCIÓN DE COLECCIONES', 'D', 'GESTIÓN Y CURADURÍA DE COLECCIONES', 1),
(8, 'DEPARTAMENTO DE INVESTIGACIÓN', 'D', 'INVESTIGACIÓN DE OBRAS ADQUIRIDAS', 1);




                                                        --21--                                
-----------------------------------------------| HISTORICOS_EMPLEADOS |----------------------------------------------------------------------------------
-- Empleado 1 (Elena García Ruiz) para Museo 1 (Reina Sofía) - Curadora
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (1, 1, 1, '2020-01-10', NULL, 'C');

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

-- Empleado 7 (Beatriz Silva Costa) para Museo 7 (MNAA) - Curador
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (7, 7, 7, '2024-04-10', NULL, 'C');

-- Empleado 8 (João Ferreira Mendes) para Museo 8 (Soares dos Reis) - Curador
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (8, 8, 8, '2024-11-01', NULL, 'C');

-- Empleado 9 (Miguel Sousa	Martins	Pereira) para Museo 8 (Soares dos Reis) - Curador
INSERT INTO HISTORICOS_EMPLEADOS (id_museo, id_estructura_org, num_expediente, fecha_inicio, fecha_fin, cargo)
VALUES (8, 8, 9, '2024-12-01', NULL, 'C');



                                                        --22--                                
----------------------------------------------------| COLECCIONES |------------------------------------------------------------------------------------
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
(6, 6, 'ARTE NEERLANDÉS DEL SIGLO XIX', 'REALISMO Y ROMANTICISMO HOLANDÉS', 'SIGLO XIX', 1),
(6, 6, 'ARTE MODERNO Y VANGUARDIAS', 'OBRAS DE PINTORES INFLUYENTES DEL SIGLO XX', 'MODERNO', 2);

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




                                                        --23--                                
------------------------------------------------| COLECCIONES_SALAS |------------------------------------------------------------------------------------
--- Museo 1: Reina Sofía (id_museo = 1)
-- Colección 1: VANGUARDIAS HISTÓRICAS 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (1, 1, 1, 37, 1, 2); -- Sala 206
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (1, 1, 1, 37, 2, 1); -- Sala 201 
-- Colección 2: SURREALISMO Y VANGUARDIAS INTERNACIONALES
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (1, 1, 2, 37, 3, 2); -- Sala 205 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (1, 1, 2, 37, 1, 1); -- Sala 206
-- Colección 3: ARTE CONTEMPORÁNEO Y ESCULTURA 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (1, 1, 3, 38, 4, 1); -- Sala 401
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (1, 1, 3, 38, 5, 2); -- Sala 402

--- Museo 2: Museo Nacional Thyssen-Bornemisza (id_museo = 2) ---
-- Colección 1: RENACIMIENTO Y BARROCO 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (2, 2, 4, 10, 6, 1); -- Sala 12
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (2, 2, 4, 10, 7, 2); -- Sala 13
-- Colección 2: ROMANTICISMO Y REALISMO 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (2, 2, 5, 39, 8, 1); -- Sala 29
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (2, 2, 5, 39, 9, 2); -- Sala 30
-- Colección 4: ESCULTURA CLÁSICA Y MODERNA 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (2, 2, 6, 39, 10, 2); -- Sala 33
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (2, 2, 6, 39, 11, 1); -- Sala 31

--- Museo 3: La Galleria Nazionale
-- Colección 1: ARTE DEL SIGLO XIX (NEOCLASICISMO Y ROMANTICISMO) 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (3, 3, 7, 14, 12, 1); -- Sala 2
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (3, 3, 7, 14, 13, 2); -- Sala 4
-- Colección 2: REALISMO Y SIMBOLISMO ITALIANO 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (3, 3, 8, 40, 14, 1); -- Sala 8
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (3, 3, 8, 40, 15, 2); -- Sala 10
-- Colección 3: ARTE MODERNO Y VANGUARDIAS 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (3, 3, 9, 40, 16, 1); -- Sala 14

--- Museo 4: Pinacoteca di Brera 
-- Colección 1: RENACIMIENTO ITALIANO
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (4, 4, 10, 41, 20, 1); -- Sala 37
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (4, 4, 10, 16, 17, 2); -- Sala 15
-- Colección 2: MANIERISMO Y BARROCO 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (4, 4, 11, 16, 18, 1); -- Sala 20
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (4, 4, 11, 16, 19, 2); -- Sala 7
-- Colección 3: SIGLO XIX Y PRINCIPIOS DEL XX (id_coleccion = 12, id_estructura_org = 4)
-- Obras: Figura femenina reclinada (Sala 29), Cabeza de mujer joven (Sala 30)
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (4, 4, 12, 41, 21, 1); -- Sala 29
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (4, 4, 12, 41, 22, 2); -- Sala 30

--- Museo 6: Kunstmuseum Den Haag (id_museo = 6) ---

-- Colección 1: ARTE MODERNO Y VANGUARDIAS
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (6, 6, 14, 43, 25, 1); -- Sala Impresionistas
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (6, 6, 14, 26, 23, 2); -- Sala Arte Simbólico
-- Colección 2: ARTE NEERLANDÉS DEL SIGLO XIX 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (6, 6, 13, 26, 24, 1); -- Sala Realismo
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (6, 6, 13, 43, 25, 2); -- Sala Impresionistas

--- Museo 7: Museu Nacional de Arte Antiga (MNAA)
-- Colección 1: PINTURA PORTUGUESA Y EUROPEA DEL RENACIMIENTO Y BARROCO 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (7, 7, 15, 32, 26, 1); -- Sala 1
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (7, 7, 15, 32, 27, 2); -- Sala 5
-- Colección 2: ESCULTURA RELIGIOSA Y CLÁSICA 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (7, 7, 16, 32, 28, 1); -- Sala 10
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (7, 7, 16, 32, 29, 2); -- Sala 11

--- Museo 8: Museu Nacional Soares dos Reis 
-- Colección 1: PINTURA PORTUGUESA DEL SIGLO XIX Y XX 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (8, 8, 17, 36, 30, 1); -- Sala 3
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (8, 8, 17, 36, 31, 2); -- Sala 4
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (8, 8, 17, 36, 32, 3); -- Sala 5
-- Colección 2: ESCULTURA CLÁSICA PORTUGUESA 
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (8, 8, 18, 36, 33, 1); -- Sala de escultura
INSERT INTO COLECCIONES_SALAS (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala, orden_recorrido) VALUES (8, 8, 18, 44, 34, 2); -- Sala de escultura moderna




                                                        --24--                                
----------------------------------------------| HISTORICOS_MOVIMIENTOS |--------------------------------------------------------------------------------
-- Museo 1: Reina Sofía 
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(1, 1, '1992-07-26', 'A', TRUE, 1, 99999999.99, 37, 1, 1, 1, 1, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(1, 2, '1992-07-26', 'A', TRUE, 2, 10000000.00, 37, 2, 1, 1, 1, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(1, 3, '1992-07-26', 'A', TRUE, 1, 20000000.00, 37, 3, 1, 2, 1, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(1, 4, '1994-05-12', 'C', TRUE, 2, 100000000.00, 37, 1, 1, 2, 1, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(1, 5, '1993-02-10', 'A', TRUE, 1, 600000.00, 38, 4, 1, 3, 1, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(1, 6, '1995-11-20', 'C', TRUE, 2, 850000.00, 38, 5, 1, 3, 1, NULL, NULL);

-- Museo 2: Thyssen-Bornemisza
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(2, 7, '1993-10-08', 'A', TRUE, 1, 110000000.00, 10, 6, 2, 4, 2, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(2, 8, '1993-10-08', 'A', FALSE, NULL, 8000000.00, 10, 7, 2, 4, 2, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(2, 9, '1993-10-08', 'A', FALSE, NULL, 15000000.00, 39, 8, 2, 5, 2, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(2, 10, '1993-10-08', 'A', TRUE, 1, 35000000.00, 39, 9, 2, 5, 2, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(2, 11, '1993-10-08', 'A', FALSE, NULL, 4000000.00, 39, 10, 2, 6, 2, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(2, 12, '1993-10-08', 'A', TRUE, 1, 6000000.00, 39, 11, 2, 6, 2, NULL, NULL);

-- Museo 3: La Galleria Nazionale
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(3, 13, '1915-05-15', 'A', TRUE, 1, 18000000.00, 14, 12, 3, 7, 3, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(3, 14, '1915-05-15', 'A', FALSE, NULL, 8000000.00, 14, 13, 3, 7, 3, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(3, 15, '1915-05-15', 'A', TRUE, 1, 12000000.00, 40, 14, 3, 8, 3, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(3, 16, '1915-05-15', 'A', TRUE, 2, 16000000.00, 40, 15, 3, 8, 3, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(3, 17, '1915-05-15', 'A', FALSE, NULL, 10000000.00, 40, 16, 3, 9, 3, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(3, 18, '1915-05-15', 'A', FALSE, NULL, 11000000.00, 40, 16, 3, 9, 3, NULL, NULL);

-- Museo 4: Pinacoteca di Brera
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(4, 19, '1859-01-01', 'A', TRUE, 1, 90000000.00, 41, 20, 4, 10, 4, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(4, 20, '1809-08-15', 'A', TRUE, 2, 100000000.00, 16, 17, 4, 10, 4, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(4, 21, '1809-08-15', 'A', FALSE, NULL, 25000000.00, 16, 18, 4, 11, 4, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(4, 22, '1809-08-15', 'A', FALSE, NULL, 35000000.00, 16, 19, 4, 11, 4, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(4, 23, '1903-01-01', 'A', FALSE, NULL, 4000000.00, 41, 21, 4, 12, 4, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(4, 24, '1903-01-01', 'A', FALSE, NULL, 5000000.00, 41, 22, 4, 12, 4, NULL, NULL);

--Museo 6: Kunstmuseum Den Haag
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(6, 25, '1935-05-29', 'A', FALSE, NULL, 5000000.00, 43, 25, 6, 14, 6, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(6, 26, '1935-05-29', 'A', FALSE, NULL, 3000000.00, 26, 23, 6, 13, 6, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(6, 27, '1935-05-29', 'A', FALSE, NULL, 4000000.00, 26, 24, 6, 14, 6, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(6, 28, '1935-05-29', 'A', FALSE, NULL, 4500000.00, 43, 25, 6, 14, 6, NULL, NULL);

-- Museo 7: Museu Nacional de Arte Antiga (MNAA)
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(7, 29, '1884-05-11', 'A', TRUE, 1, 99999999.99, 32, 26, 7, 15, 7, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(7, 30, '1884-05-11', 'A', TRUE, 2, 90000000.00, 32, 27, 7, 15, 7, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(7, 31, '1884-05-11', 'A', TRUE, 1, 2000000.00, 32, 28, 7, 16, 7, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(7, 32, '1884-05-11', 'A', FALSE, NULL, 1200000.00, 32, 29, 7, 16, 7, NULL, NULL);

-- Museo 8: Museu Nacional Soares dos Reis
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(8, 33, '1942-01-01', 'A', TRUE, 1, 2000000.00, 36, 30, 8, 17, 8, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(8, 34, '1942-01-01', 'A', TRUE, 2, 1500000.00, 36, 31, 8, 17, 8, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(8, 35, '1942-01-01', 'A', FALSE, NULL, 800000.00, 36, 32, 8, 17, 8, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(8, 36, '1942-01-01', 'A', FALSE, NULL, 600000.00, 36, 33, 8, 18, 8, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(8, 37, '1942-01-01', 'A', FALSE, NULL, 750000.00, 44, 34, 8, 18, 8, NULL, NULL);
INSERT INTO HISTORICOS_MOVIMIENTOS (id_museo, id_obra, fecha_inicio, tipo_llegada, destacada, orden_recomendado, valor_monetario, id_estructura_fis, id_sala, id_estructura_org, id_coleccion, num_expediente, id_museo_origen, fecha_fin) VALUES
(8, 38, '1942-01-01', 'A', FALSE, NULL, 1000000.00, 36, 33, 8, 18, 8, NULL, NULL);



                                                        --25--                                
---------------------------------------------| MANTENIMIENTOS_ASIGNADOS |------------------------------------------------------------------------------





                                                        --26--                                
---------------------------------------------| REGISTROS_ACT_REALIZADAS |-------------------------------------------------------------------------------




