
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


-- Trigger function para validar la jerarquía de niveles
CREATE OR REPLACE FUNCTION validar_nivel_jerarquia_organizacional()
RETURNS TRIGGER AS $$
DECLARE
    v_nivel_padre INTEGER;
BEGIN
    -- Solo validar si tiene padre
    IF NEW.id_estructura_org_padre IS NOT NULL THEN
        SELECT nivel INTO v_nivel_padre
        FROM ESTRUCTURAS_ORGANIZACIONALES
        WHERE id_museo = NEW.id_museo_padre AND id_estructura_org = NEW.id_estructura_org_padre;

        IF v_nivel_padre IS NULL THEN
            RAISE EXCEPTION 'El nivel especificado no existe.';
        END IF;

        IF NEW.nivel <> v_nivel_padre + 1 THEN
            RAISE EXCEPTION 'El nivel debe ser exactamente uno más que el nivel del padre (%).', v_nivel_padre;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger para inserciones y actualizaciones
CREATE TRIGGER validar_nivel_jerarquia_organizacional
BEFORE INSERT OR UPDATE ON ESTRUCTURAS_ORGANIZACIONALES
FOR EACH ROW
EXECUTE FUNCTION validar_nivel_jerarquia_organizacional();



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




--para agregar

-- Obtener museos
CREATE OR REPLACE FUNCTION obtener_museos()
RETURNS TABLE(id_museo INTEGER, nombre VARCHAR, fecha_fundacion DATE) AS $$
BEGIN
  RETURN QUERY SELECT museos.id_museo, museos.nombre , museos.fecha_fundacion FROM museos ORDER BY museos.nombre;
END;
$$ LANGUAGE plpgsql;


-- Obtener estructuras organizacionales por museo
CREATE OR REPLACE FUNCTION obtener_estructuras_org_por_museo(id_museo_param INTEGER)
RETURNS TABLE(id_estructura_org INTEGER, nombre VARCHAR) AS $$
BEGIN
  RETURN QUERY
    SELECT estructuras_organizacionales.id_estructura_org, estructuras_organizacionales.nombre
    FROM estructuras_organizacionales
    WHERE estructuras_organizacionales.id_museo = id_museo_param
    ORDER BY estructuras_organizacionales.nombre;
END;
$$ LANGUAGE plpgsql;

-- Obtener idiomas
CREATE OR REPLACE FUNCTION obtener_idiomas()
RETURNS TABLE(id_idioma INTEGER, lengua VARCHAR) AS $$
BEGIN
  RETURN QUERY
    SELECT idiomas.id_idioma, idiomas.lengua
    FROM idiomas
    ORDER BY idiomas.lengua;
END;
$$ LANGUAGE plpgsql;

-- Obtener estructuras físicas por museo
CREATE OR REPLACE FUNCTION obtener_estructuras_fisicas_por_museo(id_museo_param INTEGER)
RETURNS TABLE(id_estructura_fis INTEGER, nombre VARCHAR) AS $$
BEGIN
  RETURN QUERY
    SELECT estructuras_fisicas.id_estructura_fis, estructuras_fisicas.nombre
    FROM estructuras_fisicas
    WHERE estructuras_fisicas.id_museo = id_museo_param
    ORDER BY estructuras_fisicas.nombre;
END;
$$ LANGUAGE plpgsql;

-- Obtener empleados de mantenimiento/vigilancia por tipo
CREATE OR REPLACE FUNCTION obtener_empleados_mant_vig_por_tipo(tipo_param CHAR)
RETURNS TABLE(id_mant_vig INTEGER, nombre VARCHAR, apellido VARCHAR) AS $$
BEGIN
  RETURN QUERY
    SELECT empleados_mant_vig.id_mant_vig, empleados_mant_vig.nombre, empleados_mant_vig.apellido
    FROM empleados_mant_vig
    WHERE empleados_mant_vig.tipo = tipo_param
    ORDER BY empleados_mant_vig.apellido, empleados_mant_vig.nombre;
END;
$$ LANGUAGE plpgsql;


-- HISTORICO EMPLEADOS 

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
    id_museo INTEGER,
    nombre_museo VARCHAR,
    id_estructura_org INTEGER,
    nombre_estructura VARCHAR,
    cargo CHAR,
    fecha_inicio DATE,
    fecha_fin DATE
)
LANGUAGE sql
AS $$
    SELECT 
        h.id_museo,
        m.nombre AS nombre_museo,
        h.id_estructura_org,
        eo.nombre AS nombre_estructura,
        h.cargo,
        h.fecha_inicio,
        h.fecha_fin
    FROM HISTORICOS_EMPLEADOS h
    JOIN ESTRUCTURAS_ORGANIZACIONALES eo 
        ON h.id_museo = eo.id_museo AND h.id_estructura_org = eo.id_estructura_org
    JOIN MUSEOS m 
        ON h.id_museo = m.id_museo
    WHERE h.num_expediente = p_num_expediente
    ORDER BY h.fecha_inicio DESC;
$$;


-- funcion obtener informacion de una obra
CREATE OR REPLACE FUNCTION obtener_detalle_obra(p_id_obra INTEGER)
RETURNS TABLE(
    id_obra INTEGER,
    nombre VARCHAR,
    coleccion VARCHAR,
    periodo DATE,
    dimensiones VARCHAR,
    tipo CHAR,
    estilos VARCHAR,
    caracteristicas VARCHAR,
    artistas VARCHAR[], -- Arreglo de VARCHAR con separador seguro
    ubicacion VARCHAR,
    metodo_adquisicion VARCHAR,
    fecha_adquisicion DATE
) AS $$
DECLARE
    v_id_museo INTEGER;
    v_fecha_inicio_actual DATE;
    v_fecha_adquisicion DATE;
    v_metodo_adquisicion VARCHAR;
    v_fecha_inicio_anterior DATE;
    v_fecha_fin_anterior DATE;
    v_hubo_otro_museo BOOLEAN;
BEGIN
    -- 1. Museo y fecha_inicio del registro activo
    SELECT hm.id_museo, hm.fecha_inicio
    INTO v_id_museo, v_fecha_inicio_actual
    FROM historicos_movimientos hm
    WHERE hm.id_obra = p_id_obra AND hm.fecha_fin IS NULL
    ORDER BY hm.fecha_inicio DESC
    LIMIT 1;

    IF v_id_museo IS NULL THEN
        RETURN QUERY
        SELECT
            o.id_obra, o.nombre, NULL, o.periodo, o.dimension, o.tipo, o.estilos, o.caract_mat_tec,
            (
                SELECT array_agg(
                    'Nombre: ' || a.nombre || '; Apellido: ' || a.apellido || '; Nombre artistico: ' || COALESCE(a.nombre_artistico, '')
                )::VARCHAR[]
                FROM obras_artistas oa
                JOIN artistas a ON oa.id_artista = a.id_artista
                WHERE oa.id_obra = o.id_obra
            ),
            NULL, NULL, NULL
        FROM obras o
        WHERE o.id_obra = p_id_obra;
        RETURN;
    END IF;

    -- 2. Buscar la fecha de adquisición real (recursivo hacia atrás)
    v_fecha_adquisicion := v_fecha_inicio_actual;
    v_metodo_adquisicion := (
        SELECT CASE hm.tipo_llegada WHEN 'C' THEN 'Compra' WHEN 'D' THEN 'Donación' ELSE 'Desconocido' END
        FROM historicos_movimientos hm
        WHERE hm.id_obra = p_id_obra AND hm.id_museo = v_id_museo AND hm.fecha_inicio = v_fecha_inicio_actual
        LIMIT 1
    );

    LOOP
        SELECT hm.fecha_inicio, hm.fecha_fin
        INTO v_fecha_inicio_anterior, v_fecha_fin_anterior
        FROM historicos_movimientos hm
        WHERE hm.id_obra = p_id_obra
          AND hm.id_museo = v_id_museo
          AND hm.fecha_inicio < v_fecha_adquisicion
        ORDER BY hm.fecha_inicio DESC
        LIMIT 1;

        EXIT WHEN v_fecha_inicio_anterior IS NULL;

        SELECT EXISTS (
            SELECT 1
            FROM historicos_movimientos hm
            WHERE hm.id_obra = p_id_obra
              AND hm.id_museo <> v_id_museo
              AND hm.fecha_inicio > v_fecha_fin_anterior
              AND hm.fecha_inicio < v_fecha_adquisicion
        ) INTO v_hubo_otro_museo;

        IF v_hubo_otro_museo THEN
            EXIT;
        ELSE
            v_fecha_adquisicion := v_fecha_inicio_anterior;
            v_metodo_adquisicion := (
                SELECT CASE hm.tipo_llegada WHEN 'C' THEN 'Compra' WHEN 'D' THEN 'Donación' ELSE 'Desconocido' END
                FROM historicos_movimientos hm
                WHERE hm.id_obra = p_id_obra AND hm.id_museo = v_id_museo AND hm.fecha_inicio = v_fecha_inicio_anterior
                LIMIT 1
            );
        END IF;
    END LOOP;

    RETURN QUERY
    SELECT
        o.id_obra,
        o.nombre,
        (
            SELECT c.nombre_coleccion
            FROM historicos_movimientos hm
            JOIN colecciones c ON hm.id_museo = c.id_museo AND hm.id_estructura_org = c.id_estructura_org AND hm.id_coleccion = c.id_coleccion
            WHERE hm.id_obra = o.id_obra AND hm.fecha_fin IS NULL
            LIMIT 1
        ),
        o.periodo,
        o.dimension,
        o.tipo,
        o.estilos,
        o.caract_mat_tec,
        (
            SELECT array_agg(
                'Nombre: ' || a.nombre || '; Apellido: ' || a.apellido || '; Nombre artistico: ' || COALESCE(a.nombre_artistico, '')
            )::VARCHAR[]
            FROM obras_artistas oa
            JOIN artistas a ON oa.id_artista = a.id_artista
            WHERE oa.id_obra = o.id_obra
        ),
        (
            SELECT 
                (m.nombre || ', ' || ef.nombre || ', Sala ' || s.nombre)::VARCHAR
            FROM historicos_movimientos hm
            JOIN museos m ON hm.id_museo = m.id_museo
            JOIN estructuras_fisicas ef ON hm.id_museo = ef.id_museo AND hm.id_estructura_fis = ef.id_estructura_fis
            JOIN salas_exp s ON hm.id_museo = s.id_museo AND hm.id_estructura_fis = s.id_estructura_fis AND hm.id_sala = s.id_sala
            WHERE hm.id_obra = o.id_obra AND hm.fecha_fin IS NULL
            LIMIT 1
        ),
        v_metodo_adquisicion,
        v_fecha_adquisicion
    FROM obras o
    WHERE o.id_obra = p_id_obra;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtener_obras(p_id_museo INTEGER DEFAULT NULL, p_tipo CHAR DEFAULT NULL)
RETURNS TABLE(id_obra INTEGER, nombre VARCHAR, tipo CHAR, id_museo INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT o.id_obra, o.nombre, o.tipo, o.id_museo
    FROM obras o
    WHERE (p_id_museo IS NULL OR o.id_museo = p_id_museo)
      AND (p_tipo IS NULL OR o.tipo = p_tipo);
END;
$$ LANGUAGE plpgsql;

-- Obtener artistas
CREATE OR REPLACE FUNCTION obtener_artistas()
RETURNS TABLE(
  id_artista       INTEGER,
  nombre_artistico VARCHAR
) AS $$
BEGIN
  RETURN QUERY
    SELECT a.id_artista,
           a.nombre_artistico
      FROM artistas a
     WHERE a.nombre_artistico IS NOT NULL;
END;
$$ LANGUAGE plpgsql;


-------RESUMEN HISTORICO DEL MUSEO
--insertar resumen hsitorico
CREATE OR REPLACE PROCEDURE registrar_resumen_historico_museo(
  p_id_museo INTEGER,
  p_anio INTEGER,
  p_hechos TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
  IF p_anio < 1800 OR p_anio > EXTRACT(YEAR FROM CURRENT_DATE) THEN
    RAISE EXCEPTION 'Año fuera de rango válido';
  END IF;
  IF NOT EXISTS (SELECT 1 FROM museos WHERE id_museo = p_id_museo) THEN
    RAISE EXCEPTION 'Museo no existe';
  END IF;
  IF EXISTS (SELECT 1 FROM resumenes_historicos_museo WHERE id_museo = p_id_museo AND anio = p_anio) THEN
    RAISE EXCEPTION 'Ya existe un resumen para ese museo y año';
  END IF;
  INSERT INTO resumenes_historicos_museo(id_museo, anio, hechos)
  VALUES (p_id_museo, p_anio, p_hechos);
END;
$$;


------MANTENIMIENTO ESTRUCTURA FISICA----------

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
    p_descripcion VARCHAR,
    p_direccion VARCHAR,
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE ESTRUCTURAS_FISICAS
    SET nombre = p_nombre,
        descripcion = p_descripcion,
        direccion = p_direccion,
    WHERE id_museo = p_id_museo AND id_estructura_fis = p_id_estructura_fis;
END;
$$;


-- PROCEDURES PARA INSERTAR OBRAS CON ARTISTAS

-- Tipo de retorno para las funciones de inserción
CREATE TYPE obra_artista_result AS (
  id_obra    INTEGER,
  id_artista INTEGER
);

-- Funciones para insertar obras con artista
CREATE OR REPLACE FUNCTION insertar_pintura_con_artista(
  p_nombre            VARCHAR,
  p_dimension         VARCHAR,
  p_estilos           VARCHAR,
  p_caract_mat_tec    VARCHAR,
  p_periodo           DATE,
  p_id_museo          INTEGER,
  p_id_estructura_fis INTEGER,
  p_id_sala           INTEGER,
  p_id_artista        INTEGER DEFAULT NULL,
  -- Campos para artista nuevo (si p_id_artista IS NULL)
  p_nombre_art        VARCHAR DEFAULT NULL,
  p_apellido_art      VARCHAR DEFAULT NULL,
  p_nombre_artistico  VARCHAR DEFAULT NULL,
  p_fecha_nac_art     DATE    DEFAULT NULL,
  p_fecha_def_art     DATE    DEFAULT NULL,
  p_caract_est_tec    VARCHAR DEFAULT NULL
)
RETURNS obra_artista_result
LANGUAGE plpgsql
AS $$
DECLARE
  v_id_artista INTEGER := p_id_artista;
  v_id_obra    INTEGER;
BEGIN
  -- 1) Si no vino artista existente, insertamos uno nuevo
  IF v_id_artista IS NULL AND p_nombre_art IS NOT NULL THEN
    INSERT INTO ARTISTAS(
      caract_est_tec, nombre, apellido,
      nombre_artistico, fecha_nac, fecha_def
    ) VALUES (
      p_caract_est_tec, p_nombre_art, p_apellido_art,
      p_nombre_artistico, p_fecha_nac_art, p_fecha_def_art
    )
    RETURNING id_artista INTO v_id_artista;
  END IF;

  -- 2) Insertar Pintura (tipo 'P')
  INSERT INTO OBRAS(
    nombre, dimension, tipo,
    estilos, caract_mat_tec,
    id_sala, id_estructura_fis,
    id_museo, periodo
  ) VALUES (
    p_nombre, p_dimension, 'P',
    p_estilos, p_caract_mat_tec,
    p_id_sala, p_id_estructura_fis,
    p_id_museo, p_periodo
  )
  RETURNING id_obra INTO v_id_obra;

  -- 3) Vincular obra ↔ artista
  INSERT INTO OBRAS_ARTISTAS(id_obra, id_artista)
    VALUES (v_id_obra, v_id_artista);

  -- 4) Devolver ambos IDs
  RETURN ROW(v_id_obra, v_id_artista);
END;
$$;

-- Función para insertar escultura con artista
CREATE OR REPLACE FUNCTION insertar_escultura_con_artista(
  p_nombre            VARCHAR,
  p_dimension         VARCHAR,
  p_estilos           VARCHAR,
  p_caract_mat_tec    VARCHAR,
  p_periodo           DATE,
  p_id_museo          INTEGER,
  p_id_estructura_fis INTEGER,
  p_id_sala           INTEGER,
  p_id_artista        INTEGER DEFAULT NULL,
  -- Campos para artista nuevo
  p_nombre_art        VARCHAR DEFAULT NULL,
  p_apellido_art      VARCHAR DEFAULT NULL,
  p_nombre_artistico  VARCHAR DEFAULT NULL,
  p_fecha_nac_art     DATE    DEFAULT NULL,
  p_fecha_def_art     DATE    DEFAULT NULL,
  p_caract_est_tec    VARCHAR DEFAULT NULL
)
RETURNS obra_artista_result
LANGUAGE plpgsql
AS $$
DECLARE
  v_id_artista INTEGER := p_id_artista;
  v_id_obra    INTEGER;
BEGIN
  -- 1) Crear artista si no existe
  IF v_id_artista IS NULL AND p_nombre_art IS NOT NULL THEN
    INSERT INTO ARTISTAS(
      caract_est_tec, nombre, apellido,
      nombre_artistico, fecha_nac, fecha_def
    ) VALUES (
      p_caract_est_tec, p_nombre_art, p_apellido_art,
      p_nombre_artistico, p_fecha_nac_art, p_fecha_def_art
    )
    RETURNING id_artista INTO v_id_artista;
  END IF;

  -- 2) Insertar Escultura (tipo 'E')
  INSERT INTO OBRAS(
    nombre, dimension, tipo,
    estilos, caract_mat_tec,
    id_sala, id_estructura_fis,
    id_museo, periodo
  ) VALUES (
    p_nombre, p_dimension, 'E',
    p_estilos, p_caract_mat_tec,
    p_id_sala, p_id_estructura_fis,
    p_id_museo, p_periodo
  )
  RETURNING id_obra INTO v_id_obra;

  -- 3) Vincular obra ↔ artista
  INSERT INTO OBRAS_ARTISTAS(id_obra, id_artista)
    VALUES (v_id_obra, v_id_artista);

  -- 4) Retornar IDs
  RETURN ROW(v_id_obra, v_id_artista);
END;
$$;

---MANTENIMIENTO DE ESTRUCTURA ORGANIZACIONAL

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
        tipo = p_tipo,
        descripcion = p_descripcion
    WHERE id_museo = p_id_museo AND id_estructura_org = p_id_estructura_org;
END;
$$;
