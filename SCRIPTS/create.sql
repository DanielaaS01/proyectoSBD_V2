--CREATE TABLE--

-- 1. LUGARES_GEOGRAFICOS
CREATE SEQUENCE seq_id_lugar_geografico START 1;
CREATE TABLE LUGARES_GEOGRAFICOS(
    id_lugar INTEGER DEFAULT nextval('seq_id_lugar_geografico') CONSTRAINT pk_lugares PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo CHAR(1) NOT NULL,  
    id_lugar_padre INTEGER
);   

ALTER TABLE LUGARES_GEOGRAFICOS
ADD CONSTRAINT check_tipo_lugar CHECK (tipo IN ('P', 'R', 'C')), -- 'P'=País, 'R'=Region, 'C'=Ciudad
ADD CONSTRAINT fk_lugar_padre FOREIGN KEY (id_lugar_padre) REFERENCES LUGARES_GEOGRAFICOS(id_lugar); 

-- 2. MUSEOS
CREATE SEQUENCE seq_id_museo START 1;

CREATE TABLE MUSEOS(
    id_museo INTEGER DEFAULT nextval('seq_id_museo') CONSTRAINT pk_museos PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    mision_proposito VARCHAR(450) NOT NULL,
    fecha_fundacion DATE NOT NULL,
    id_lugar INTEGER NOT NULL 
);

ALTER TABLE MUSEOS
ADD CONSTRAINT fk_museo_lugar FOREIGN KEY (id_lugar) REFERENCES LUGARES_GEOGRAFICOS(id_lugar),
ADD CONSTRAINT check_fecha_fundacion CHECK (fecha_fundacion <= CURRENT_DATE); -- La fecha de fundación no puede ser futura

-- 3. HORARIOS
CREATE TABLE HORARIOS(
    id_museo INTEGER NOT NULL,
    dia INTEGER NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL    
);

ALTER TABLE HORARIOS
ADD CONSTRAINT pk_horarios PRIMARY KEY (id_museo, dia),
ADD CONSTRAINT check_dia CHECK (dia BETWEEN 1 AND 7), -- 1=lunes, 2=martes, ..., 7=domingo
ADD CONSTRAINT fk_museo_horario FOREIGN KEY (id_museo) REFERENCES MUSEOS(id_museo),
ADD CONSTRAINT check_hora_inicio_fin CHECK (hora_inicio < hora_fin); -- La hora de inicio debe ser menor que la de fin

-- 4. ENTRADAS
CREATE SEQUENCE seq_num_ticket START 1;
CREATE TABLE ENTRADAS(
    id_museo INTEGER NOT NULL,
    numero_ticket INTEGER DEFAULT nextval('seq_num_ticket')  NOT NULL,
    fecha_hora_emision TIMESTAMP NOT NULL,
    monto NUMERIC NOT NULL,
    tipo CHAR(1) NOT NULL   
);

ALTER TABLE ENTRADAS
ADD CONSTRAINT check_entradas_tipo CHECK (tipo IN ('G', 'R')), -- 'G'=General, 'R'=Reducida   
ADD CONSTRAINT pk_entradas PRIMARY KEY (id_museo, numero_ticket),
ADD CONSTRAINT fk_entrada_museo FOREIGN KEY (id_museo) REFERENCES MUSEOS(id_museo),
ADD CONSTRAINT check_monto CHECK (monto > 0); -- El monto no puede ser negativo

-- 5. ESTRUCTURAS_FISICAS
CREATE SEQUENCE seq_id_estructura_fis START WITH 1;
CREATE TABLE ESTRUCTURAS_FISICAS(
    id_museo INTEGER NOT NULL,
    id_estructura_fis INTEGER DEFAULT nextval('seq_id_estructura_fis') NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo CHAR(1) NOT NULL,
    descripcion VARCHAR(300), 
    direccion VARCHAR(400),
    id_museo_padre INTEGER, 
    id_padre INTEGER
);

ALTER TABLE ESTRUCTURAS_FISICAS
ADD CONSTRAINT pk_estructuras_fisicas PRIMARY KEY (id_museo, id_estructura_fis),
ADD CONSTRAINT check_tipo_estructura CHECK (tipo IN ('E', 'P')), -- 'E'=Edificio, 'P'=Piso
ADD CONSTRAINT fk_estructura_fisica_padre FOREIGN KEY (id_museo_padre, id_padre) REFERENCES ESTRUCTURAS_FISICAS(id_museo, id_estructura_fis),
ADD CONSTRAINT fk_estructuras_museo FOREIGN KEY (id_museo) REFERENCES MUSEOS(id_museo);

-- 6. SALAS EXPOSICIONES
CREATE SEQUENCE seq_id_salas_exp START WITH 1;
CREATE TABLE SALAS_EXP (
    id_museo INTEGER NOT NULL,
    id_estructura_fis INTEGER NOT NULL,
    id_sala INTEGER DEFAULT nextval('seq_id_salas_exp') NOT NULL,
    nombre VARCHAR(100),
    descripcion VARCHAR(300)
);

ALTER TABLE SALAS_EXP
ADD CONSTRAINT pk_salas_exp PRIMARY KEY (id_museo, id_estructura_fis, id_sala),
ADD CONSTRAINT fk_salas_estructura_fisica FOREIGN KEY (id_museo, id_estructura_fis) REFERENCES ESTRUCTURAS_FISICAS(id_museo, id_estructura_fis);

-- 7. HISTORICOS CIERRES SALAS (para registrar cierres temporales de salas por mantenimiento, restauración, etc.)
CREATE TABLE HISTORICOS_CIERRES (
    id_museo INTEGER NOT NULL,
    id_estructura_fis INTEGER NOT NULL,
    id_sala INTEGER NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE  
);

ALTER TABLE HISTORICOS_CIERRES
ADD CONSTRAINT pk_historicos_cierres PRIMARY KEY (id_museo, id_estructura_fis, id_sala, fecha_inicio),
ADD CONSTRAINT fk_cierres_sala FOREIGN KEY (id_museo, id_estructura_fis, id_sala) REFERENCES SALAS_EXP (id_museo, id_estructura_fis, id_sala),
ADD CONSTRAINT check_fechas_cierre CHECK (fecha_fin >= fecha_inicio);

-- 8. EMPLEADOS MANTENIMIENTO VIGILANTE
CREATE SEQUENCE seq_id_mant_vig START 1;
CREATE TABLE EMPLEADOS_MANT_VIG(
    id_mant_vig INTEGER DEFAULT NEXTVAL('seq_id_mant_vig') NOT NULL, 
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    doc_identidad VARCHAR(20) UNIQUE NOT NULL,
    tipo CHAR(1) NOT NULL    
);

ALTER TABLE EMPLEADOS_MANT_VIG
ADD CONSTRAINT pk_empleados_mant_vig PRIMARY KEY (id_mant_vig),
ADD CONSTRAINT check_tipo_empleado CHECK (tipo IN ('M', 'V')); -- 'M'=Mantenimiento, 'V'=Vigilante

-- 9. ASIGNACIONES MENSUALES DE EMPLEADOS
CREATE TABLE MESES_ASIGNACIONES_EMPLEADOS(
    id_museo INTEGER NOT NULL,
    id_estructura_fis INTEGER NOT NULL,
    id_mant_vig INTEGER NOT NULL,
    id_mes_anio DATE NOT NULL,
    turno CHAR(1) NOT NULL    
);

ALTER TABLE MESES_ASIGNACIONES_EMPLEADOS
ADD CONSTRAINT pk_asig_mensual_empleado PRIMARY KEY (id_museo, id_estructura_fis, id_mant_vig, id_mes_anio),
ADD CONSTRAINT check_turno_valido CHECK (turno IN ('M', 'V', 'N')), -- 'M'=Mañana, 'v'=vespertino, 'N'=Noche
ADD CONSTRAINT fk_mes_asig_emp_estructura FOREIGN KEY (id_museo, id_estructura_fis) REFERENCES ESTRUCTURAS_FISICAS(id_museo, id_estructura_fis),
ADD CONSTRAINT fk_mes_asig_emp_mant_vig FOREIGN KEY (id_mant_vig) REFERENCES EMPLEADOS_MANT_VIG(id_mant_vig);

-- 10. EVENTOS
CREATE SEQUENCE seq_id_evento START 1;
CREATE TABLE EVENTOS(
    id_museo INTEGER NOT NULL,
    id_evento INTEGER DEFAULT NEXTVAL('seq_id_evento') NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    precio_persona NUMERIC,
    institucion_educativa VARCHAR(100),
    cantidad_persona INTEGER,
    id_estructura_fis INTEGER,
    id_sala INTEGER 
);

ALTER TABLE EVENTOS
ADD CONSTRAINT pk_eventos PRIMARY KEY (id_museo, id_evento),
ADD CONSTRAINT fk_museo_evento FOREIGN KEY (id_museo) REFERENCES MUSEOS(id_museo),
ADD CONSTRAINT fk_evento_sala FOREIGN KEY (id_museo, id_estructura_fis, id_sala) REFERENCES SALAS_EXP(id_museo, id_estructura_fis, id_sala),
ADD CONSTRAINT check_eventos_fechas CHECK (fecha_fin >= fecha_inicio);

-- 11. RESUMENES HISTORICOS 
CREATE TABLE RESUMENES_HISTORICOS(
    id_museo INTEGER NOT NULL,
    anio INTEGER NOT NULL,
    hechos VARCHAR(200) NOT NULL   
);

ALTER TABLE RESUMENES_HISTORICOS
ADD CONSTRAINT pk_resumenes_hist PRIMARY KEY (id_museo, anio),
ADD CONSTRAINT fk_resumenes_museo FOREIGN KEY (id_museo) REFERENCES MUSEOS(id_museo),
ADD CONSTRAINT check_anio_valido CHECK (anio BETWEEN 1800 AND EXTRACT(YEAR FROM CURRENT_DATE)::INTEGER);

-- 12. TIPOS TICKETS
CREATE TABLE TIPOS_TICKETS(
    id_museo INTEGER NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    precio NUMERIC NOT NULL,
    tipo CHAR(1) NOT NULL   
);

ALTER TABLE TIPOS_TICKETS
ADD CONSTRAINT pk_tipos_tickets PRIMARY KEY (id_museo, fecha_inicio),
ADD CONSTRAINT fk_tipo_ticket_museo FOREIGN KEY (id_museo) REFERENCES MUSEOS(id_museo),
ADD CONSTRAINT check_tipo_ticket CHECK (tipo IN ('G', 'R', 'E')),  -- G: General, R: Reducida, E: Exonerada
ADD CONSTRAINT check_ticket_fechas CHECK (fecha_fin >= fecha_inicio);

-- 13. OBRAS 
create SEQUENCE seq_id_obra START 1;
CREATE TABLE OBRAS(
    id_obra INTEGER DEFAULT NEXTVAL('seq_id_obra') CONSTRAINT pk_obras PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    dimension VARCHAR(200) NOT NULL,
    tipo CHAR(1) NOT NULL,
    estilos VARCHAR(200) NOT NULL,
    caract_mat_tec VARCHAR(300) NOT NULL,
    id_sala INTEGER NOT NULL,                       --revisar not null
    id_estructura_fis INTEGER NOT NULL,         --revisar not null
    id_museo INTEGER NOT NULL,              --revisar not null
    periodo DATE   
);

ALTER TABLE OBRAS
ADD CONSTRAINT check_tipo_obra CHECK (tipo IN ('E', 'P')),   -- 'E'=Escultura, 'P'=Pintura
ADD CONSTRAINT fk_obra_sala FOREIGN KEY (id_museo,id_estructura_fis,id_sala) REFERENCES SALAS_EXP(id_museo,id_estructura_fis,id_sala);

-- 14. ARTISTAS
CREATE SEQUENCE seq_id_artista START 1;
CREATE TABLE ARTISTAS(
    id_artista INTEGER DEFAULT NEXTVAL('seq_id_artista') CONSTRAINT pk_artistas PRIMARY KEY,
    caract_est_tec VARCHAR(300) NOT NULL,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    nombre_artistico VARCHAR(100),
    fecha_nac DATE,
    fecha_def DATE
);

ALTER TABLE ARTISTAS
ADD CONSTRAINT check_fecha_art CHECK (fecha_def IS NULL OR fecha_def >= fecha_nac);

-- 15. OBRAS_ARTISTAS (relación muchos a muchos entre OBRAS y ARTISTAS)
CREATE TABLE OBRAS_ARTISTAS(
    id_obra INTEGER NOT NULL,
    id_artista INTEGER NOT NULL   
);

ALTER TABLE OBRAS_ARTISTAS
ADD CONSTRAINT pk_obras_artistas PRIMARY KEY (id_obra, id_artista),
ADD CONSTRAINT fk_obra_art_artista FOREIGN KEY (id_artista) REFERENCES ARTISTAS(id_artista),
ADD CONSTRAINT fk_obra_art_obra FOREIGN KEY (id_obra) REFERENCES OBRAS(id_obra);

-- 16. EMPLEADOS PROFESIONALES
CREATE SEQUENCE seq_num_expediente START 1;
CREATE TABLE EMPLEADOS_PROFESIONALES (
    num_expediente INTEGER DEFAULT NEXTVAL('seq_num_expediente') CONSTRAINT pk_empleados_profesionales PRIMARY KEY,
    doc_identidad VARCHAR(20) UNIQUE NOT NULL,
    primer_nombre VARCHAR(100) NOT NULL,
    segundo_nombre VARCHAR(100),
    primer_apellido VARCHAR(100) NOT NULL,
    segundo_apellido VARCHAR(100) NOT NULL,
    fecha_nac DATE NOT NULL
);
 
-- 17. IDIOMAS 
CREATE SEQUENCE seq_id_idioma START 1;
CREATE TABLE IDIOMAS(
    id_idioma INTEGER DEFAULT NEXTVAL('seq_id_idioma') CONSTRAINT pk_idioma PRIMARY KEY,
    lengua VARCHAR(100) UNIQUE NOT NULL
);

-- 18. IDIOMAS_EMPLEADOS (relación muchos a muchos entre EMPLEADOS_PROFESIONALES e IDIOMAS)
CREATE TABLE IDIOMAS_EMPLEADOS (
    num_expediente INTEGER NOT NULL,
    id_idioma INTEGER NOT NULL 
);

ALTER TABLE IDIOMAS_EMPLEADOS
ADD CONSTRAINT pk_idiomas_empleados PRIMARY KEY (num_expediente, id_idioma),
ADD CONSTRAINT fk_idioma_emp FOREIGN KEY (num_expediente) REFERENCES EMPLEADOS_PROFESIONALES(num_expediente),
ADD CONSTRAINT fk_idioma FOREIGN KEY (id_idioma) REFERENCES IDIOMAS(id_idioma);


-- 19. FORMACIONES PROFESIONALES
CREATE SEQUENCE seq_id_form_prof START 1;
CREATE TABLE FORMACIONES_PROFESIONALES (
    num_expediente INTEGER NOT NULL,
    id_form_prof INTEGER DEFAULT NEXTVAL('seq_id_form_prof') NOT NULL,
    nombre_titulo VARCHAR(100) NOT NULL,
    anio INTEGER NOT NULL,
    descripcion_especialidad VARCHAR(300) NOT NULL
    
);

ALTER TABLE FORMACIONES_PROFESIONALES
ADD CONSTRAINT pk_formaciones_profesionales PRIMARY KEY (num_expediente, id_form_prof),
ADD CONSTRAINT fk_form_prof_emp FOREIGN KEY (num_expediente) REFERENCES EMPLEADOS_PROFESIONALES(num_expediente),
ADD CONSTRAINT check_anio_formacion CHECK (anio BETWEEN 1900 AND EXTRACT(YEAR FROM CURRENT_DATE)::INTEGER);


-- 20. ESTRUCTURAS ORGANIZACIONALES
CREATE SEQUENCE seq_id_estructura_org START 1;
CREATE TABLE ESTRUCTURAS_ORGANIZACIONALES(
    id_museo INTEGER NOT NULL,
    id_estructura_org INTEGER DEFAULT NEXTVAL('seq_id_estructura_org') NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo CHAR(1) NOT NULL,
    descripcion VARCHAR(300) NOT NULL,
    nivel INTEGER NOT NULL CHECK (nivel >= 1),
    id_museo_padre INTEGER,
    id_estructura_org_padre INTEGER    
);

ALTER TABLE ESTRUCTURAS_ORGANIZACIONALES
ADD CONSTRAINT pk_estructuras_org PRIMARY KEY (id_museo, id_estructura_org),
ADD CONSTRAINT fk_estructura_org_museo FOREIGN KEY (id_museo) REFERENCES MUSEOS(id_museo),
ADD CONSTRAINT fk_estructura_org_padre FOREIGN KEY (id_museo_padre, id_estructura_org_padre) REFERENCES ESTRUCTURAS_ORGANIZACIONALES(id_museo, id_estructura_org),
ADD CONSTRAINT check_tipo_estructura_org CHECK (tipo IN ('D', 'P', 'S', 'B', 'C')); -- Dirección, Departamento, Sección, Subdepartamento, Subsección

-- 21. HISTORICOS EMPLEADOS (para registrar asignaciones y cambios de cargo de empleados profesionales)
CREATE TABLE HISTORICOS_EMPLEADOS(
    id_museo INTEGER NOT NULL,
    id_estructura_org INTEGER NOT NULL,
    num_expediente INTEGER NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    cargo char(1) NOT NULL
);

ALTER TABLE HISTORICOS_EMPLEADOS
ADD CONSTRAINT pk_historico_empleados PRIMARY KEY (id_museo, id_estructura_org, num_expediente, fecha_inicio),
ADD CONSTRAINT fk_historico_emp_estruct_org FOREIGN KEY (id_museo, id_estructura_org) REFERENCES ESTRUCTURAS_ORGANIZACIONALES(id_museo, id_estructura_org),
ADD CONSTRAINT fk_historico_emp_emp_profesional FOREIGN KEY (num_expediente) REFERENCES EMPLEADOS_PROFESIONALES(num_expediente),
ADD CONSTRAINT check_cargo_valido CHECK (cargo IN ('D','R','C','A')), -- D: Director, R: Restaurador, C: Curador, A: Administrativo
ADD CONSTRAINT check_fechas_hist CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio);

-- 22. COLECCIONES
CREATE SEQUENCE seq_id_coleccion START 1;
CREATE TABLE COLECCIONES(
    id_museo INTEGER NOT NULL,
    id_estructura_org INTEGER NOT NULL,
    id_coleccion INTEGER DEFAULT NEXTVAL('seq_id_coleccion') NOT NULL,
    nombre_coleccion VARCHAR(400) NOT NULL,
    descripcion_caracteristicas VARCHAR(400) NOT NULL,
    palabra_clave VARCHAR(100) NOT NULL,
    orden_recorrido INTEGER NOT NULL
);

ALTER TABLE COLECCIONES
ADD CONSTRAINT pk_colecciones PRIMARY KEY(id_museo,id_estructura_org,id_coleccion),
ADD CONSTRAINT fk_coleccion_estruct_org FOREIGN KEY (id_museo,id_estructura_org) REFERENCES ESTRUCTURAS_ORGANIZACIONALES(id_museo,id_estructura_org);


-- 23. COLECCIONES_SALAS (relación muchos a muchos entre COLECCIONES y SALAS_EXP)
CREATE TABLE COLECCIONES_SALAS(
    id_museo INTEGER NOT NULL,
    id_estructura_org INTEGER NOT NULL,
    id_coleccion INTEGER NOT NULL,
    id_estructura_fis INTEGER NOT NULL,
    id_sala INTEGER NOT NULL,
    orden_recorrido INTEGER NOT NULL
);

ALTER TABLE COLECCIONES_SALAS
ADD CONSTRAINT pk_colecciones_salas PRIMARY KEY (id_museo, id_estructura_org, id_coleccion, id_estructura_fis, id_sala),
ADD CONSTRAINT fk_coleccion_sala_sala_exp FOREIGN KEY (id_museo,id_estructura_fis,id_sala) REFERENCES SALAS_EXP(id_museo,id_estructura_fis,id_sala),
ADD CONSTRAINT fk_coleccion_sala_coleccion FOREIGN KEY (id_museo,id_estructura_org,id_coleccion) REFERENCES COLECCIONES(id_museo,id_estructura_org,id_coleccion);


--24. HISTORICOS_MOVIMIENTOS (para registrar movimientos de obras entre museos, salas, etc.)
CREATE SEQUENCE seq_id_cat_museo START 1;
CREATE TABLE HISTORICOS_MOVIMIENTOS (
    id_museo INTEGER NOT NULL,
    id_obra INTEGER NOT NULL,
    id_cat_museo INTEGER DEFAULT NEXTVAL('seq_id_cat_museo') NOT NULL,
    fecha_inicio DATE NOT NULL,
    tipo_llegada CHAR(1) NOT NULL,
    destacada BOOLEAN NOT NULL DEFAULT FALSE,
    orden_recomendado INTEGER,
    valor_monetario NUMERIC,
    id_estructura_fis INTEGER NOT NULL,
    id_sala INTEGER NOT NULL,
    id_estructura_org INTEGER NOT NULL,
    id_coleccion INTEGER NOT NULL,
    num_expediente INTEGER NOT NULL,
    id_museo_origen INTEGER,
    fecha_fin DATE
);

ALTER TABLE HISTORICOS_MOVIMIENTOS
ADD CONSTRAINT pk_historicos_movimientos PRIMARY KEY (id_museo, id_obra, id_cat_museo),
ADD CONSTRAINT check_tipo_llegada CHECK (tipo_llegada IN ('C','D','A')), -- 'C'=Compra, 'D'=Donación
ADD CONSTRAINT fk_historico_mov_obra FOREIGN KEY (id_obra) REFERENCES OBRAS(id_obra),
ADD CONSTRAINT fk_historico_mov_museo_actual FOREIGN KEY (id_museo) REFERENCES MUSEOS(id_museo),
ADD CONSTRAINT fk_historico_mov_museo_origen FOREIGN KEY (id_museo_origen) REFERENCES MUSEOS(id_museo),
ADD CONSTRAINT fk_historico_mov_sala_exp FOREIGN KEY (id_museo,id_estructura_fis,id_sala) REFERENCES SALAS_EXP(id_museo,id_estructura_fis,id_sala),
ADD CONSTRAINT fk_historico_mov_emp_prof FOREIGN KEY (num_expediente) REFERENCES EMPLEADOS_PROFESIONALES(num_expediente),
ADD CONSTRAINT fk_historico_mov_coleccion FOREIGN KEY (id_museo,id_estructura_org,id_coleccion) REFERENCES COLECCIONES(id_museo,id_estructura_org,id_coleccion);

-- 25. MANTENIMIENTOS_ASIGNADOS (para registrar actividades de mantenimiento asignadas a obras)
CREATE SEQUENCE seq_id_mantenimiento_asig START 1;
CREATE TABLE MANTENIMIENTOS_ASIGNADOS(
    id_museo INTEGER NOT NULL,
    id_obra INTEGER NOT NULL,
    id_cat_museo INTEGER NOT NULL,
    id_mant_asig INTEGER DEFAULT NEXTVAL('seq_id_mantenimiento_asig') NOT NULL, 
    actividad VARCHAR(300) NOT NULL,
    frecuencia CHAR(1) NOT NULL,
    tipo_responsable CHAR(1) NOT NULL
);

ALTER TABLE MANTENIMIENTOS_ASIGNADOS
ADD CONSTRAINT pk_mantenimientos_asignados PRIMARY KEY (id_museo, id_obra, id_cat_museo, id_mant_asig), 
ADD CONSTRAINT fk_mant_asig_historico_mov FOREIGN KEY (id_museo,id_obra,id_cat_museo) REFERENCES HISTORICOS_MOVIMIENTOS(id_museo,id_obra,id_cat_museo),
ADD CONSTRAINT check_frecuencia CHECK (frecuencia IN ('D','S','M','A')), -- Diario, Semanal, Mensual, Anual
ADD CONSTRAINT check_tipo_responsable CHECK (tipo_responsable IN ('C','R','O')); -- Curador, Restaurador, Otro

-- 26. REGISTROS_ACT_REALIZADAS (para registrar actividades de mantenimiento realizadas)
CREATE SEQUENCE seq_id_registro_act START 1;
CREATE TABLE REGISTROS_ACT_REALIZADAS (
    id_museo INTEGER NOT NULL,
    id_obra INTEGER NOT NULL,
    id_cat_museo INTEGER NOT NULL,
    id_mant_asig INTEGER NOT NULL,
    num_expediente INTEGER NOT NULL, 
    id_registro_act INTEGER DEFAULT NEXTVAL('seq_id_registro_act') NOT NULL, 
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    observaciones VARCHAR(300) NOT NULL    
);

ALTER TABLE REGISTROS_ACT_REALIZADAS
ADD CONSTRAINT pk_regis_act_realizadas PRIMARY KEY (id_museo, id_obra, id_cat_museo, id_mant_asig, id_registro_act),
ADD CONSTRAINT fk_regis_act_mant_asig FOREIGN KEY (id_museo, id_obra, id_cat_museo, id_mant_asig) REFERENCES MANTENIMIENTOS_ASIGNADOS(id_museo, id_obra, id_cat_museo, id_mant_asig),
ADD CONSTRAINT fk_regis_act_emp_prof FOREIGN KEY (num_expediente) REFERENCES EMPLEADOS_PROFESIONALES(num_expediente),
ADD CONSTRAINT check_fechas_regis CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio);