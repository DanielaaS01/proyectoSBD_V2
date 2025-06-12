
-- funciones para validar registro de empleados
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
  IF p_anio < 1900 OR p_anio > anio_actual THEN
    RAISE EXCEPTION 'año de formacion no valido';
  END IF;

  IF LENGTH(p_anio::TEXT) != 4 THEN
    RAISE EXCEPTION 'año de formacion no valido';
  END IF;
END;
$$ LANGUAGE plpgsql;



-- TRIGGERS CON SUS FUNCIONES
-- Función del trigger
CREATE OR REPLACE FUNCTION fn_validar_empleado_profesional()
RETURNS TRIGGER AS $$
BEGIN
  -- Validar formato del documento
  PERFORM validar_formato_doc_identidad(UPPER(NEW.doc_identidad));

  -- Validar fecha de nacimiento
  PERFORM validar_fecha_nacimiento(NEW.fecha_nac);

  -- Forzar mayúsculas en los campos de texto
  NEW.doc_identidad := UPPER(NEW.doc_identidad);
  NEW.primer_nombre := UPPER(NEW.primer_nombre);
  NEW.segundo_nombre := UPPER(NEW.segundo_nombre);
  NEW.primer_apellido := UPPER(NEW.primer_apellido);
  NEW.segundo_apellido := UPPER(NEW.segundo_apellido);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger asociado
CREATE TRIGGER trg_validar_empleado_profesional
BEFORE INSERT OR UPDATE ON EMPLEADOS_PROFESIONALES
FOR EACH ROW
EXECUTE FUNCTION fn_validar_empleado_profesional();


-- Función del trigger
CREATE OR REPLACE FUNCTION fn_validar_formacion()
RETURNS TRIGGER AS $$
BEGIN
  -- Validar año
  PERFORM validar_anio_formacion(NEW.anio);

  -- Forzar mayúsculas
  NEW.nombre_titulo := UPPER(NEW.nombre_titulo);
  NEW.descripcion_especialidad := UPPER(NEW.descripcion_especialidad);

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger asociado
CREATE TRIGGER trg_validar_formacion
BEFORE INSERT OR UPDATE ON FORMACIONES_PROFESIONALES
FOR EACH ROW
EXECUTE FUNCTION fn_validar_formacion();


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


-- PARA ASIGNAR ACTIVIDADES DE MANTENIMIENTO Y VIGILANCIA A EMPLEADOS

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