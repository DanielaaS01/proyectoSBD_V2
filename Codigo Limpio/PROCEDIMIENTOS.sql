-------------------------------------------------------------------------------------------------------------------
--  ===========================================================================================================  --
--  ==================================== Requerimientos individuales  =========================================  --
--  ===========================================================================================================  --
-------------------------------------------------------------------------------------------------------------------

                    
----------------------------------------------- RECURSOS HUMANOS ---------------------------------------------------

-----------------------------------------------------------------------
-- REQUERIMIENTO 1 - REGISTRO DE EMPLEADOS --
-----------------------------------------------------------------------
CREATE OR REPLACE FUNCTION validar_formato_doc_identidad(p_doc VARCHAR)
RETURNS VOID AS $$
DECLARE
  letras_validas TEXT;
  resto TEXT;
  i INTEGER;
  encontrado_digito BOOLEAN := FALSE;
  c CHAR;
BEGIN
  -- Validar longitud
  IF LENGTH(p_doc) NOT IN (8, 9) THEN
    RAISE EXCEPTION 'formato de pasaporte no valido';
  END IF;

  -- Validar que el primer carácter sea letra
  IF SUBSTRING(p_doc FROM 1 FOR 1) !~ '^[A-Z]$' THEN
    RAISE EXCEPTION 'formato de pasaporte no valido';
  END IF;

  -- Validar los primeros 3 caracteres
  letras_validas := SUBSTRING(p_doc FROM 1 FOR 3);
  FOR i IN 1..LENGTH(letras_validas) LOOP
    c := SUBSTRING(letras_validas FROM i FOR 1);
    IF c ~ '[0-9]' THEN
      encontrado_digito := TRUE;
    ELSIF encontrado_digito THEN
      -- Si ya se encontró un número y ahora aparece una letra => error
      RAISE EXCEPTION 'formato de pasaporte no valido';
    END IF;
  END LOOP;

  -- Validar que los caracteres a partir del cuarto sean todos números
  resto := SUBSTRING(p_doc FROM 4);
  IF resto ~ '[^0-9]' THEN
    RAISE EXCEPTION 'formato de pasaporte no valido';
  END IF;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION validar_fecha_nacimiento(p_fecha DATE)
RETURNS VOID AS $$
DECLARE
  edad_actual INTEGER;
BEGIN
  IF p_fecha > CURRENT_DATE THEN
    RAISE EXCEPTION 'fecha de nacimiento no valida';
  END IF;

  edad_actual := DATE_PART('year', AGE(CURRENT_DATE, p_fecha));

  IF edad_actual < 18 OR edad_actual > 100 THEN
    RAISE EXCEPTION 'fecha de nacimiento no valida';
  END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION validar_anio_formacion(p_anio INTEGER)
RETURNS VOID AS $$
DECLARE
  anio_actual INTEGER := EXTRACT(YEAR FROM CURRENT_DATE)::INTEGER;
BEGIN
  IF p_anio < 1900 OR p_anio >= anio_actual THEN
    RAISE EXCEPTION 'año de formacion no valido';
  END IF;

  IF LENGTH(p_anio::TEXT) != 4 THEN
    RAISE EXCEPTION 'año de formacion no valido';
  END IF;
END;
$$ LANGUAGE plpgsql;


-- PROCEDURE PARA REGISTRAR EMPLEADOS
CREATE OR REPLACE FUNCTION insertar_empleado(
    p_doc_identidad VARCHAR,
    p_primer_nombre VARCHAR,
    p_segundo_nombre VARCHAR,
    p_primer_apellido VARCHAR,
    p_segundo_apellido VARCHAR,
    p_fecha_nac DATE
) RETURNS INTEGER AS $$
DECLARE
    v_num_expediente INTEGER;
BEGIN
    PERFORM validar_formato_doc_identidad(UPPER(p_doc_identidad));
    PERFORM validar_fecha_nacimiento(p_fecha_nac);

    INSERT INTO EMPLEADOS_PROFESIONALES (
        doc_identidad, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nac
    ) VALUES (
        UPPER(p_doc_identidad), UPPER(p_primer_nombre), UPPER(p_segundo_nombre),
        UPPER(p_primer_apellido), UPPER(p_segundo_apellido), p_fecha_nac
    )
    RETURNING num_expediente INTO v_num_expediente;

    RETURN v_num_expediente;
END;
$$ LANGUAGE plpgsql;


-- PROCEDURE PARA REGISTRAR FORMACIONES PROFESIONALES
CREATE OR REPLACE PROCEDURE insertar_formacion(
    p_num_expediente INTEGER,
    p_nombre_titulo VARCHAR,
    p_anio INTEGER,
    p_descripcion_especialidad VARCHAR
)
AS $$
BEGIN
    PERFORM validar_anio_formacion(p_anio);

    INSERT INTO FORMACIONES_PROFESIONALES (
        num_expediente, nombre_titulo, anio, descripcion_especialidad
    ) VALUES (
        p_num_expediente, UPPER(p_nombre_titulo), p_anio, UPPER(p_descripcion_especialidad)
    );
END;
$$ LANGUAGE plpgsql;


-- PROCEDURE PARA REGISTRAR HISTÓRICO DE EMPLEADOS
CREATE OR REPLACE PROCEDURE insertar_historico(
    p_num_expediente INTEGER,
    p_id_museo INTEGER,
    p_id_estructura_org INTEGER,
    p_fecha_inicio DATE,
    p_cargo CHAR(1)
)
AS $$
BEGIN
    INSERT INTO HISTORICOS_EMPLEADOS (
        id_museo, id_estructura_org, num_expediente, fecha_inicio, cargo
    ) VALUES (
        p_id_museo, p_id_estructura_org, p_num_expediente, p_fecha_inicio, p_cargo
    );
END;
$$ LANGUAGE plpgsql;


-- PROCEDURE PARA REGISTRAR HISTÓRICO DE EMPLEADOS
CREATE OR REPLACE PROCEDURE insertar_idiomas_empleado(
    p_num_expediente INTEGER,
    p_idiomas INTEGER[]
)
AS $$
BEGIN
    IF p_idiomas IS NULL OR array_length(p_idiomas, 1) = 0 THEN
        RAISE EXCEPTION 'Todo empleado debe hablar al menos un idioma';
    END IF;

    INSERT INTO IDIOMAS_EMPLEADOS (num_expediente, id_idioma)
    SELECT p_num_expediente, unnest(p_idiomas);
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insertar_nuevos_idiomas(p_lenguas VARCHAR[])
RETURNS INTEGER[] AS $$
DECLARE
  nueva_lengua VARCHAR;
  v_id INTEGER;
  v_ids INTEGER[] := '{}';
BEGIN
  FOREACH nueva_lengua IN ARRAY p_lenguas
  LOOP
    -- Insertar solo si no existe
    INSERT INTO IDIOMAS (lengua)
    VALUES (UPPER(nueva_lengua))
    ON CONFLICT (lengua) DO NOTHING;

    -- Obtener su ID (ya sea nuevo o existente)
    SELECT i.id_idioma INTO v_id
    FROM IDIOMAS i
    WHERE i.lengua = UPPER(nueva_lengua);

    v_ids := array_append(v_ids, v_id);
  END LOOP;

  RETURN v_ids;
END;
$$ LANGUAGE plpgsql;

-- PROCEDURE PRINCIPAL PARA REGISTRAR EMPLEADO COMPLETO
CREATE OR REPLACE PROCEDURE registrar_empleado_profesional(
    p_doc_identidad VARCHAR,
    p_primer_nombre VARCHAR,
    p_segundo_nombre VARCHAR,
    p_primer_apellido VARCHAR,
    p_segundo_apellido VARCHAR,
    p_fecha_nac DATE,
    p_id_museo INTEGER,
    p_id_estructura_org INTEGER,
    p_fecha_inicio DATE,
    p_cargo CHAR(1),
    p_nombre_titulo VARCHAR,
    p_anio INTEGER,
    p_descripcion_especialidad VARCHAR,
    p_idiomas INTEGER[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_num_expediente INTEGER;
BEGIN
    v_num_expediente := insertar_empleado(
        p_doc_identidad,
        p_primer_nombre,
        p_segundo_nombre,
        p_primer_apellido,
        p_segundo_apellido,
        p_fecha_nac
    );

    CALL insertar_historico(
        v_num_expediente,
        p_id_museo,
        p_id_estructura_org,
        p_fecha_inicio,
        p_cargo
    );

    CALL insertar_formacion(
        v_num_expediente,
        p_nombre_titulo,
        p_anio,
        p_descripcion_especialidad
    );

    CALL insertar_idiomas_empleado(
        v_num_expediente,
        p_idiomas
    );
END;
$$;


-- REGISTRO DE EMPLEADOS DE MANTENIMIENTO Y VIGILANCIA
CREATE OR REPLACE PROCEDURE registrar_empleado_mantenimiento_vigilancia(
    p_nombre VARCHAR,
    p_apellido VARCHAR,
    p_doc_identidad VARCHAR,
    p_tipo CHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_existente INTEGER;
BEGIN
    -- Validar formato del documento
    PERFORM validar_formato_doc_identidad(UPPER(p_doc_identidad));

    -- Validar tipo permitido
    IF p_tipo NOT IN ('M', 'V') THEN
        RAISE EXCEPTION 'tipo de empleado no valido';
    END IF;

    -- Verificar si ya existe ese documento de identidad
    SELECT COUNT(*) INTO v_existente
    FROM EMPLEADOS_MANT_VIG
    WHERE doc_identidad = UPPER(p_doc_identidad);

    IF v_existente > 0 THEN
        RAISE EXCEPTION 'el documento de identidad ya está registrado';
    END IF;

    -- Insertar en mayúsculas
    INSERT INTO EMPLEADOS_MANT_VIG(nombre, apellido, doc_identidad, tipo)
    VALUES (
        UPPER(p_nombre),
        UPPER(p_apellido),
        UPPER(p_doc_identidad),
        p_tipo
    );
END;
$$;





-----------------------------------------------------------------------
-- REQUERIMIENTO 2 - MANTENIMIENTO DE HISTORIAS DE TRABAJO --
-----------------------------------------------------------------------

--Abrir historico de empleado
CREATE OR REPLACE PROCEDURE registrar_historico_empleado(
    p_id_museo INTEGER,
    p_id_estructura_org INTEGER,
    p_num_expediente INTEGER,
    p_fecha_inicio DATE,
    p_fecha_fin DATE,
    p_cargo CHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- 1. Validar que exista el museo y la estructura organizacional
    IF NOT EXISTS (
        SELECT 1 FROM ESTRUCTURAS_ORGANIZACIONALES
        WHERE id_museo = p_id_museo AND id_estructura_org = p_id_estructura_org
    ) THEN
        RAISE EXCEPTION 'La estructura organizacional no existe para el museo indicado.';
    END IF;

    -- 2. Validar que el empleado profesional exista
    IF NOT EXISTS (
        SELECT 1 FROM EMPLEADOS_PROFESIONALES
        WHERE num_expediente = p_num_expediente
    ) THEN
        RAISE EXCEPTION 'El número de expediente no existe.';
    END IF;

    -- 3. Validar que no haya ya un historico abierto para ese empleado
    IF EXISTS (
        SELECT 1 FROM HISTORICOS_EMPLEADOS
        WHERE num_expediente = p_num_expediente AND fecha_fin IS NULL
    ) THEN
        RAISE EXCEPTION 'El empleado ya tiene un historico de cargo activo. Debe cerrarse antes de asignar uno nuevo.';
    END IF;

    -- 5. Insertar el nuevo historico
    INSERT INTO HISTORICOS_EMPLEADOS (
        id_museo,
        id_estructura_org,
        num_expediente,
        fecha_inicio,
        fecha_fin,
        cargo
    ) VALUES (
        p_id_museo,
        p_id_estructura_org,
        p_num_expediente,
        p_fecha_inicio,
        p_fecha_fin,
        UPPER(p_cargo)
    );
    RAISE NOTICE 'historico registrado correctamente.';
END;
$$;


-- Cierre de historico de empleado
CREATE OR REPLACE PROCEDURE cerrar_historico_empleado(
    p_num_expediente INTEGER,
    p_fecha_fin DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_fecha_inicio_actual DATE;
BEGIN
    -- 1. Verificar que existe el historico activo exacto
    SELECT fecha_inicio INTO v_fecha_inicio_actual
    FROM HISTORICOS_EMPLEADOS
    WHERE num_expediente = p_num_expediente AND fecha_fin IS NULL;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No se encontró un historico activo con los datos especificados.';
    END IF;

    -- 2. Validar que la fecha de cierre sea posterior o igual al inicio
    IF p_fecha_fin < v_fecha_inicio_actual THEN
        RAISE EXCEPTION 'La fecha de fin no puede ser menor que la fecha de inicio.';
    END IF;

    -- 3. Actualizar el historico
    UPDATE HISTORICOS_EMPLEADOS
    SET fecha_fin = p_fecha_fin
    WHERE num_expediente = p_num_expediente AND fecha_fin IS NULL;

    RAISE NOTICE 'historico cerrado correctamente.';
END;
$$;


---ver historico empleados
CREATE OR REPLACE FUNCTION ver_historico_empleado(p_num_expediente INTEGER)
RETURNS TABLE (
    empleado VARCHAR,
    museo VARCHAR,
    departamento VARCHAR,
    cargo CHAR,
    fecha_inicio DATE,
    fecha_fin DATE
)
LANGUAGE sql
AS $$
    SELECT 
        TRIM(
            ep.primer_nombre || ' ' ||
            COALESCE(ep.segundo_nombre || ' ', '') ||
            ep.primer_apellido || ' ' ||
            ep.segundo_apellido
        ) AS empleado,
        m.nombre AS museo,
        eo.nombre AS departamento,
        h.cargo,
        h.fecha_inicio,
        h.fecha_fin
    FROM HISTORICOS_EMPLEADOS h
    JOIN EMPLEADOS_PROFESIONALES ep
        ON h.num_expediente = ep.num_expediente
    JOIN ESTRUCTURAS_ORGANIZACIONALES eo 
        ON h.id_museo = eo.id_museo AND h.id_estructura_org = eo.id_estructura_org
    JOIN MUSEOS m 
        ON h.id_museo = m.id_museo
    WHERE h.num_expediente = p_num_expediente
    ORDER BY h.fecha_inicio;
$$;


-----------------------------------------------------------------------
-- REQUERIMIENTO 3 - ASIGNACIONES DE MANTENIMIENTOS DE OBRAS --
-----------------------------------------------------------------------



-----------------------------------------------------------------------
-- REQUERIMIENTO 4 - ASIGNACIONES DE MANTENIMIENTO Y VIGILANCIA --
-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION truncar_a_mes(p_fecha DATE)
RETURNS DATE AS $$
BEGIN
    RETURN date_trunc('month', p_fecha)::DATE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION validar_turno_asignacion(p_turno CHAR)
RETURNS VOID AS $$
BEGIN
    IF p_turno NOT IN ('M', 'V', 'N') THEN
        RAISE EXCEPTION 'Turno inválido. Solo se permiten M (mañana), v (vespertino) o N (noche).';
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION verificar_existencia_empleado(p_id_mant_vig INTEGER)
RETURNS VOID AS $$
DECLARE
    v_existe INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_existe
    FROM EMPLEADOS_MANT_VIG
    WHERE id_mant_vig = p_id_mant_vig;

    IF v_existe = 0 THEN
        RAISE EXCEPTION 'El empleado con ID % no existe', p_id_mant_vig;
    END IF;
END;
$$ LANGUAGE plpgsql;
 

CREATE OR REPLACE FUNCTION verificar_existencia_estructura(
    p_id_museo INTEGER,
    p_id_estructura_fis INTEGER
)
RETURNS VOID AS $$
DECLARE
    v_existe INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_existe
    FROM ESTRUCTURAS_FISICAS
    WHERE id_museo = p_id_museo
      AND id_estructura_fis = p_id_estructura_fis;

    IF v_existe = 0 THEN
        RAISE EXCEPTION 'No existe la estructura física con ID % para el museo %',
                        p_id_estructura_fis, p_id_museo;
    END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION verificar_asignacion_preexistente(
    p_id_mant_vig INTEGER,
    p_id_museo INTEGER,
    p_id_estructura_fis INTEGER,
    p_id_mes_anio DATE,
    p_turno CHAR
)
RETURNS VOID AS $$
DECLARE
    v_existente INTEGER;
BEGIN
    -- 1. Validar duplicado exacto
    SELECT COUNT(*) INTO v_existente
    FROM MESES_ASIGNACIONES_EMPLEADOS
    WHERE id_mant_vig = p_id_mant_vig
      AND id_museo = p_id_museo
      AND id_estructura_fis = p_id_estructura_fis
      AND id_mes_anio = p_id_mes_anio
      AND turno = p_turno;

    IF v_existente > 0 THEN
        RAISE EXCEPTION 'El empleado ya tiene esa asignación registrada exactamente igual.';
    END IF;

    -- 2. Validar asignación solapada en otra estructura con mismo mes y turno
    SELECT COUNT(*) INTO v_existente
    FROM MESES_ASIGNACIONES_EMPLEADOS
    WHERE id_mant_vig = p_id_mant_vig
      AND id_mes_anio = p_id_mes_anio
      AND turno = p_turno
      AND (id_museo != p_id_museo OR id_estructura_fis != p_id_estructura_fis);

    IF v_existente > 0 THEN
        RAISE EXCEPTION 'El empleado ya tiene asignado ese turno en otra estructura en el mismo mes.';
    END IF;
END;
$$ LANGUAGE plpgsql;


-- PROCEDURE PRINCIPAL PARA ASIGNAR A EMPLEADO
CREATE OR REPLACE PROCEDURE asignar_empleado(
    p_id_mant_vig INTEGER,
    p_id_museo INTEGER,
    p_id_estructura_fis INTEGER,
    p_fecha DATE,
    p_turno CHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_fecha_mes DATE;
BEGIN
    -- 1. Validar existencia del empleado
    PERFORM verificar_existencia_empleado(p_id_mant_vig);

    -- 2. Validar existencia de la estructura física asociada al museo
    PERFORM verificar_existencia_estructura(p_id_museo, p_id_estructura_fis);

    -- 3. Validar turno
    PERFORM validar_turno_asignacion(UPPER(p_turno));

    -- 4. Truncar la fecha a mes
    v_fecha_mes := truncar_a_mes(p_fecha);

    -- 5. Validar que no haya conflicto o duplicado
    PERFORM verificar_asignacion_preexistente(
        p_id_mant_vig,
        p_id_museo,
        p_id_estructura_fis,
        v_fecha_mes,
        UPPER(p_turno) 
    );
    

    -- 6. Insertar en mayúsculas (aunque solo aplica al turno, ya que los IDs son enteros)
    INSERT INTO MESES_ASIGNACIONES_EMPLEADOS (
        id_museo,
        id_estructura_fis,
        id_mant_vig,
        id_mes_anio,
        turno
    ) VALUES (
        p_id_museo,
        p_id_estructura_fis,
        p_id_mant_vig,
        v_fecha_mes,
        UPPER(p_turno)
    );
END;
$$;


-- PROCEDURE PARA OBTENER TODAS LAS ASIGNACIONES DEL EMPLEADO
CREATE OR REPLACE FUNCTION obtener_asignaciones_empleado(p_id_mant_vig INTEGER)
RETURNS TABLE (
  id_museo INTEGER,
  nombre_museo VARCHAR,
  id_estructura_fis INTEGER,
  nombre_estructura VARCHAR,
  fecha DATE,
  turno CHAR(1),
  tipo CHAR(1)
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    m.id_museo,
    mu.nombre AS nombre_museo,
    m.id_estructura_fis,
    ef.nombre AS nombre_estructura,
    m.id_mes_anio AS fecha,
    m.turno,
    emv.tipo
  FROM MESES_ASIGNACIONES_EMPLEADOS m
    JOIN MUSEOS mu ON mu.id_museo = m.id_museo
    JOIN ESTRUCTURAS_FISICAS ef ON ef.id_estructura_fis = m.id_estructura_fis
    JOIN EMPLEADOS_MANT_VIG emv ON emv.id_mant_vig = m.id_mant_vig
  WHERE m.id_mant_vig = p_id_mant_vig
  ORDER BY m.id_mes_anio DESC;
END;
$$ LANGUAGE plpgsql;




------------------------------------- ADMINISTRACIÓN GENERAL DEL MUSEO ---------------------------------------------------

-----------------------------------------------------------------------
-- REQUERIMIENTO 1.1 - MANTENIMIENTO ESTRUCTURA FISICA --
-----------------------------------------------------------------------
--crear nueva estructura fisica
CREATE OR REPLACE PROCEDURE crear_estructura_fisica(
    p_id_museo INTEGER,
    p_nombre VARCHAR,
    p_tipo CHAR,
    p_descripcion VARCHAR,
    p_direccion VARCHAR,
    p_id_museo_padre INTEGER,
    p_id_padre INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO ESTRUCTURAS_FISICAS(
        id_museo, nombre, tipo, descripcion, direccion, id_museo_padre, id_padre
    ) VALUES (
        p_id_museo, p_nombre, p_tipo, p_descripcion, p_direccion, p_id_museo_padre, p_id_padre
    );
END;
$$;

--actualizar estructura fisica
CREATE OR REPLACE PROCEDURE actualizar_estructura_fisica(
    p_nombre VARCHAR,
    p_descripcion VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE ESTRUCTURAS_FISICAS
    SET nombre = p_nombre,
        descripcion = p_descripcion
    WHERE id_museo = p_id_museo AND id_estructura_fis = p_id_estructura_fis;
END;
$$;



-----------------------------------------------------------------------
-- REQUERIMIENTO 1.2 - MANTENIMIENTO ESTRUCTURA ORGANIZACIONAL --
-----------------------------------------------------------------------
-- Crear nueva estructura organizacional
CREATE OR REPLACE PROCEDURE crear_estructura_organizacional(
    p_id_museo INTEGER,
    p_nombre VARCHAR,
    p_tipo CHAR,
    p_descripcion VARCHAR,
    p_nivel INTEGER,
    p_id_museo_padre INTEGER,
    p_id_estructura_org_padre INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO ESTRUCTURAS_ORGANIZACIONALES(
        id_museo, nombre, tipo, descripcion, nivel, id_museo_padre, id_estructura_org_padre
    ) VALUES (
        p_id_museo, p_nombre, p_tipo, p_descripcion, p_nivel, p_id_museo_padre, p_id_estructura_org_padre
    );
END;
$$;

-- Actualizar estructura organizacional
CREATE OR REPLACE PROCEDURE actualizar_estructura_organizacional(
    p_id_museo INTEGER,
    p_id_estructura_org INTEGER,
    p_nombre VARCHAR,
    p_descripcion VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE ESTRUCTURAS_ORGANIZACIONALES
    SET nombre = p_nombre,
        descripcion = p_descripcion
    WHERE id_museo = p_id_museo AND id_estructura_org = p_id_estructura_org;
END;
$$;



-----------------------------------------------------------------------
-- REQUERIMIENTO 2 - CALCULO DE RANKING --
-----------------------------------------------------------------------

-- FUNCION AUXILIAR: VISITAS ANUALES POR MUSEO
CREATE OR REPLACE FUNCTION visitas_anuales_museo(p_id_museo INTEGER, p_anio INTEGER)
RETURNS INTEGER AS $$
DECLARE
    v_visitas INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_visitas
    FROM ENTRADAS
    WHERE id_museo = p_id_museo
      AND EXTRACT(YEAR FROM fecha_hora_emision) = p_anio;
    RETURN v_visitas;
END;
$$ LANGUAGE plpgsql;



-- FUNCION AUXILIAR: ROTACION ANUAL POR MUSEO 
CREATE OR REPLACE FUNCTION rotacion_anual_museo(p_id_museo INTEGER, p_anio INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    v_salidas INTEGER;
    v_prom_activos NUMERIC;
BEGIN
    -- Salidas: empleados cuyo fecha_fin está en el año
    SELECT COUNT(*) INTO v_salidas
    FROM HISTORICOS_EMPLEADOS
    WHERE id_museo = p_id_museo
      AND fecha_fin IS NOT NULL
      AND EXTRACT(YEAR FROM fecha_fin) = p_anio;

    -- Promedio de empleados activos por mes en el año
    WITH meses AS (
        SELECT generate_series(1,12) AS mes
    ),
    activos_mes AS (
        SELECT
            m.mes,
            COUNT(DISTINCT h.num_expediente) AS cant
        FROM meses m
        LEFT JOIN HISTORICOS_EMPLEADOS h
            ON h.id_museo = p_id_museo
            AND h.fecha_inicio <= make_date(p_anio, m.mes, 1)
            AND (h.fecha_fin IS NULL OR h.fecha_fin >= make_date(p_anio, m.mes, 1))
        GROUP BY m.mes
    )
    SELECT AVG(cant)::NUMERIC INTO v_prom_activos FROM activos_mes;

    IF v_prom_activos IS NULL OR v_prom_activos = 0 THEN
        RETURN 0;
    END IF;

    RETURN v_salidas / v_prom_activos;
END;
$$ LANGUAGE plpgsql;


-- RANKING MUNDIAL DE MUSEOS EN TABLA
CREATE OR REPLACE FUNCTION ranking_mundial_museos(p_anio INTEGER)
RETURNS TABLE (
    nombre_museo VARCHAR,
    visitas INTEGER,
    rotacion NUMERIC,
    score NUMERIC
) AS $$
DECLARE
    v_max_visitas INTEGER;
    v_max_rotacion NUMERIC;
BEGIN
    SELECT MAX(visitas_anuales_museo(id_museo, p_anio)) INTO v_max_visitas FROM MUSEOS;
    SELECT MAX(rotacion_anual_museo(id_museo, p_anio)) INTO v_max_rotacion FROM MUSEOS;

    RETURN QUERY
    SELECT
        m.nombre,
        visitas_anuales_museo(m.id_museo, p_anio) AS visitas,
        rotacion_anual_museo(m.id_museo, p_anio) AS rotacion,
        CASE 
            WHEN v_max_visitas = 0 THEN 0
            ELSE (visitas_anuales_museo(m.id_museo, p_anio)::NUMERIC / v_max_visitas) / 
                 (1 + CASE WHEN v_max_rotacion > 0 THEN rotacion_anual_museo(m.id_museo, p_anio) / v_max_rotacion ELSE 0 END)
        END AS score
    FROM MUSEOS m
    ORDER BY score DESC, nombre;
END;
$$ LANGUAGE plpgsql;

-- RANKING POR PAÍS DE MUSEOS EN TABLA
CREATE OR REPLACE FUNCTION ranking_pais_museos(p_anio INTEGER, p_id_pais INTEGER)
RETURNS TABLE (
    nombre_museo VARCHAR,
    visitas INTEGER,
    rotacion NUMERIC,
    score NUMERIC
) AS $$
DECLARE
    v_max_visitas INTEGER;
    v_max_rotacion NUMERIC;
BEGIN
    SELECT MAX(visitas_anuales_museo(m.id_museo, p_anio))
      INTO v_max_visitas
      FROM MUSEOS m
      JOIN LUGARES_GEOGRAFICOS l ON m.id_lugar = l.id_lugar
      WHERE (l.tipo = 'C' AND l.id_lugar_padre = p_id_pais)
         OR (l.tipo = 'P' AND l.id_lugar = p_id_pais);

    SELECT MAX(rotacion_anual_museo(m.id_museo, p_anio))
      INTO v_max_rotacion
      FROM MUSEOS m
      JOIN LUGARES_GEOGRAFICOS l ON m.id_lugar = l.id_lugar
      WHERE (l.tipo = 'C' AND l.id_lugar_padre = p_id_pais)
         OR (l.tipo = 'P' AND l.id_lugar = p_id_pais);

    RETURN QUERY
    SELECT
        m.nombre,
        visitas_anuales_museo(m.id_museo, p_anio) AS visitas,
        rotacion_anual_museo(m.id_museo, p_anio) AS rotacion,
        CASE 
            WHEN v_max_visitas = 0 THEN 0
            ELSE (visitas_anuales_museo(m.id_museo, p_anio)::NUMERIC / v_max_visitas) / 
                 (1 + CASE WHEN v_max_rotacion > 0 THEN rotacion_anual_museo(m.id_museo, p_anio) / v_max_rotacion ELSE 0 END)
        END AS score
    FROM MUSEOS m
    JOIN LUGARES_GEOGRAFICOS l ON m.id_lugar = l.id_lugar
    WHERE (l.tipo = 'C' AND l.id_lugar_padre = p_id_pais)
       OR (l.tipo = 'P' AND l.id_lugar = p_id_pais)
    ORDER BY score DESC, nombre;
END;
$$ LANGUAGE plpgsql;

-----------------------------------------------------------------------
-- REQUERIMIENTO 3 - ADMINISTRACION DE OBRAS Y COLECCIONES --
-----------------------------------------------------------------------

--Buscar obras por criterios (artista, colección, periodo, sala)
CREATE OR REPLACE FUNCTION buscar_obras(
    p_nombre_artista TEXT DEFAULT NULL,
    p_id_coleccion   INT  DEFAULT NULL,
    p_periodo        DATE DEFAULT NULL,
    p_id_sala        INT  DEFAULT NULL
)
RETURNS TABLE (
    id_obra       INT,
    nombre_obra   TEXT,
    nombre_artista TEXT,
    tipo          CHAR(1),
    periodo       DATE,
    id_sala       INT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    o.id_obra,
    o.nombre::TEXT,
    CONCAT(a.nombre, ' ', a.apellido)::TEXT,
    o.tipo,
    o.periodo,
    o.id_sala
  FROM OBRAS o
  JOIN OBRAS_ARTISTAS oa ON o.id_obra = oa.id_obra
  JOIN ARTISTAS a        ON a.id_artista = oa.id_artista
  WHERE
    (p_nombre_artista IS NULL
     OR (
         a.nombre                 ILIKE '%' || p_nombre_artista || '%' 
      OR a.apellido               ILIKE '%' || p_nombre_artista || '%'
      OR a.nombre_artistico       ILIKE '%' || p_nombre_artista || '%'
      OR (a.nombre || ' ' || a.apellido) ILIKE '%' || p_nombre_artista || '%'
     )
    )
    AND (p_id_coleccion IS NULL OR EXISTS (
          SELECT 1 
            FROM HISTORICOS_MOVIMIENTOS h 
           WHERE h.id_obra      = o.id_obra 
             AND h.id_coleccion = p_id_coleccion
        ))
    AND (p_periodo IS NULL OR o.periodo = p_periodo)
    AND (p_id_sala  IS NULL OR o.id_sala = p_id_sala);
END;
$$ LANGUAGE plpgsql;



--Generar itinerario recomendado de visita
CREATE OR REPLACE FUNCTION obtener_itinerario_visita(
    p_id_museo INT
)
RETURNS TABLE (
    nombre_coleccion TEXT,
    nombre_sala TEXT,
    orden INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.nombre_coleccion::TEXT,
        s.nombre::TEXT,
        cs.orden_recorrido
    FROM COLECCIONES c
    JOIN COLECCIONES_SALAS cs ON 
        c.id_museo = cs.id_museo AND 
        c.id_estructura_org = cs.id_estructura_org AND 
        c.id_coleccion = cs.id_coleccion
    JOIN SALAS_EXP s ON 
        s.id_museo = cs.id_museo AND 
        s.id_estructura_fis = cs.id_estructura_fis AND 
        s.id_sala = cs.id_sala
    WHERE c.id_museo = p_id_museo
    ORDER BY cs.orden_recorrido;
END;
$$ LANGUAGE plpgsql;


--Registrar movimiento de una obra (Compra, donación, adquisicion)
CREATE OR REPLACE FUNCTION registrar_movimiento_obra(
    p_id_museo INT,
    p_id_obra INT,
    p_tipo_llegada CHAR,
    p_destacada BOOLEAN,
    p_orden_recomendado INT,
    p_valor NUMERIC,
    p_id_estructura_fis INT,
    p_id_sala INT,
    p_id_estructura_org INT,
    p_id_coleccion INT,
    p_num_expediente INT,
    p_id_museo_origen INT DEFAULT NULL,
    p_fecha_inicio DATE DEFAULT CURRENT_DATE
) RETURNS VOID AS $$
BEGIN
    INSERT INTO HISTORICOS_MOVIMIENTOS (
        id_museo, id_obra, fecha_inicio, tipo_llegada, destacada,
        orden_recomendado, valor_monetario, id_estructura_fis, id_sala,
        id_estructura_org, id_coleccion, num_expediente, id_museo_origen
    )
    VALUES (
        p_id_museo, p_id_obra, p_fecha_inicio, p_tipo_llegada, p_destacada,
        p_orden_recomendado, p_valor, p_id_estructura_fis, p_id_sala,
        p_id_estructura_org, p_id_coleccion, p_num_expediente, p_id_museo_origen
    );
END;
$$ LANGUAGE plpgsql;


--Asignar un mantenimiento a una obra
CREATE OR REPLACE FUNCTION asignar_mantenimiento_obra(
    p_id_museo INT,
    p_id_obra INT,
    p_id_cat_museo INT,
    p_actividad VARCHAR,
    p_frecuencia CHAR,
    p_tipo_responsable CHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO MANTENIMIENTOS_ASIGNADOS (
        id_museo, id_obra, id_cat_museo, actividad,
        frecuencia, tipo_responsable
    )
    VALUES (
        p_id_museo, p_id_obra, p_id_cat_museo, p_actividad,
        p_frecuencia, p_tipo_responsable
    );
END;
$$ LANGUAGE plpgsql;


--Registrar actividad de mantenimiento realizada
CREATE OR REPLACE FUNCTION registrar_mantenimiento_realizado(
    p_id_museo INT,
    p_id_obra INT,
    p_id_cat_museo INT,
    p_id_mant_asig INT,
    p_num_expediente INT,
    p_fecha_inicio DATE,
    p_fecha_fin DATE,
    p_observaciones VARCHAR
) RETURNS VOID AS $$
BEGIN
    INSERT INTO REGISTROS_ACT_REALIZADAS (
        id_museo, id_obra, id_cat_museo, id_mant_asig,
        num_expediente, fecha_inicio, fecha_fin, observaciones
    )
    VALUES (
        p_id_museo, p_id_obra, p_id_cat_museo, p_id_mant_asig,
        p_num_expediente, p_fecha_inicio, p_fecha_fin, p_observaciones
    );
END;
$$ LANGUAGE plpgsql;



--Consultar obras no disponibles actualmente (por mantenimiento o restauración)
CREATE OR REPLACE FUNCTION consultar_obras_no_disponibles(
    p_fecha DATE DEFAULT CURRENT_DATE
)
RETURNS TABLE (
    id_obra INT,
    nombre_obra VARCHAR,
    motivo TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT o.id_obra, o.nombre, 'En mantenimiento/restauración' AS motivo
    FROM OBRAS o
    JOIN HISTORICOS_MOVIMIENTOS h ON o.id_obra = h.id_obra
    JOIN REGISTROS_ACT_REALIZADAS r ON 
        h.id_museo = r.id_museo AND 
        h.id_obra = r.id_obra AND 
        h.id_cat_museo = r.id_cat_museo
    WHERE 
        r.fecha_fin IS NULL OR p_fecha BETWEEN r.fecha_inicio AND r.fecha_fin;
END;
$$ LANGUAGE plpgsql;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------