
-- funciones para validar registro de empleados
CREATE OR REPLACE FUNCTION validar_formato_doc_identidad(p_doc VARCHAR)
RETURNS VOID AS $$
BEGIN
  -- Longitud válida: 8 o 9 caracteres
  IF LENGTH(p_doc) < 8 OR LENGTH(p_doc) > 9 THEN
    RAISE EXCEPTION 'formato de pasaporte no valido';
  END IF;

  -- Primeros 3 caracteres pueden ser letras
  IF SUBSTRING(p_doc FROM 1 FOR 3) ~ '[^A-Z]' THEN
    RAISE EXCEPTION 'formato de pasaporte no valido';
  END IF;

  -- El resto solo números (si hay letras después del tercer carácter => error)
  IF SUBSTRING(p_doc FROM 4) ~ '[^0-9]' THEN
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
    RAISE EXCEPTION 'anio de formacion no valido';
  END IF;

  IF LENGTH(p_anio::TEXT) != 4 THEN
    RAISE EXCEPTION 'anio de formacion no valido';
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
    PERFORM validar_formato_doc_identidad(p_doc_identidad);
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


CREATE OR REPLACE FUNCTION insertar_idioma_nuevo(
    p_lengua VARCHAR
) RETURNS INTEGER AS $$
DECLARE
    v_id INTEGER;
BEGIN
    INSERT INTO IDIOMAS(lengua)
    VALUES (UPPER(p_lengua))
    RETURNING id_idioma INTO v_id;

    RETURN v_id;
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
