-------------------------------------------------------------------------------------------------------------------
--  ===========================================================================================================  --
--  ====================================== Triggers y Sus Funciones ===========================================  --
--  ===========================================================================================================  --
-------------------------------------------------------------------------------------------------------------------

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


--Trigger para validar que las entradas esten dentro del horario del museo
CREATE OR REPLACE FUNCTION validar_tipo_ticket_valido()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM TIPOS_TICKETS
        WHERE id_museo = NEW.id_museo
          AND tipo = NEW.tipo
          AND NEW.fecha_hora_emision::DATE >= fecha_inicio
          AND (fecha_fin IS NULL OR NEW.fecha_hora_emision::DATE <= fecha_fin)
    ) THEN
        RAISE EXCEPTION 'El tipo de ticket no está habilitado para esa fecha en este museo.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_tipo_ticket
BEFORE INSERT OR UPDATE ON ENTRADAS
FOR EACH ROW
EXECUTE FUNCTION validar_tipo_ticket_valido();


-- Triger para validar que no puedas crear un nuevo tipo ticket sin haber cerrado el otro 
CREATE OR REPLACE FUNCTION validar_tipo_ticket_unico()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.fecha_fin IS NULL THEN
        IF EXISTS (
            SELECT 1 FROM tipos_tickets
            WHERE id_museo = NEW.id_museo
              AND tipo = NEW.tipo
              AND fecha_fin IS NULL
        ) THEN
            RAISE EXCEPTION 'Ya existe un tipo ticket vigente (sin fecha fin) para ese museo y tipo.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_tipo_ticket_unico
BEFORE INSERT ON tipos_tickets
FOR EACH ROW
EXECUTE FUNCTION validar_tipo_ticket_unico();

--Validar que el lugar del museo sea tipo 'C' (ciudad)
CREATE OR REPLACE FUNCTION validar_lugar_ciudad()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM LUGARES_GEOGRAFICOS
        WHERE id_lugar = NEW.id_lugar AND tipo = 'C'
    ) THEN
        RAISE EXCEPTION 'El lugar asignado al museo debe ser una ciudad (tipo = C)';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_lugar_ciudad
BEFORE INSERT OR UPDATE ON MUSEOS
FOR EACH ROW
EXECUTE FUNCTION validar_lugar_ciudad();

--Verificar que una obra no se ubique en una sala cerrada en la fecha
CREATE OR REPLACE FUNCTION validar_sala_activa_para_obra()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM HISTORICOS_CIERRES
        WHERE id_museo = NEW.id_museo
          AND id_estructura_fis = NEW.id_estructura_fis
          AND id_sala = NEW.id_sala
          AND NEW.periodo BETWEEN fecha_inicio AND COALESCE(fecha_fin, NEW.periodo)
    ) THEN
        RAISE EXCEPTION 'No se puede asignar obra a una sala que está cerrada en esa fecha';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_sala_obra
BEFORE INSERT OR UPDATE ON OBRAS
FOR EACH ROW
EXECUTE FUNCTION validar_sala_activa_para_obra();

-- Evitar solapamiento de fechas en HISTORICOS_EMPLEADOS
CREATE OR REPLACE FUNCTION validar_solapamiento_hist_empleado()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM HISTORICOS_EMPLEADOS
        WHERE num_expediente = NEW.num_expediente
          AND id_museo = NEW.id_museo
          AND id_estructura_org = NEW.id_estructura_org
          AND (
              NEW.fecha_inicio BETWEEN fecha_inicio AND COALESCE(fecha_fin, NEW.fecha_inicio)
              OR
              COALESCE(NEW.fecha_fin, NEW.fecha_inicio) BETWEEN fecha_inicio AND COALESCE(fecha_fin, COALESCE(NEW.fecha_fin, NEW.fecha_inicio))
          )
    ) THEN
        RAISE EXCEPTION 'Asignación solapada para el mismo empleado en la misma estructura organizacional.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_solapamiento_hist_empleado
BEFORE INSERT OR UPDATE ON HISTORICOS_EMPLEADOS
FOR EACH ROW
EXECUTE FUNCTION validar_solapamiento_hist_empleado();

--Evitar duplicados de turno para empleado en mantenimiento mensual
CREATE OR REPLACE FUNCTION validar_turno_mantenimiento()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM MESES_ASIGNACIONES_EMPLEADOS
        WHERE id_museo = NEW.id_museo
          AND id_estructura_fis = NEW.id_estructura_fis
          AND id_mant_vig = NEW.id_mant_vig
          AND id_mes_anio = NEW.id_mes_anio
          AND turno = NEW.turno
    ) THEN
        RAISE EXCEPTION 'Asignación duplicada: el empleado ya tiene asignado ese turno en esa estructura y mes.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_turno_mantenimiento
BEFORE INSERT OR UPDATE ON MESES_ASIGNACIONES_EMPLEADOS
FOR EACH ROW
EXECUTE FUNCTION validar_turno_mantenimiento();


--Validar que no haya solapamiento de fechas de cierre de una misma sala
CREATE OR REPLACE FUNCTION validar_solapamiento_cierre_sala()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM HISTORICOS_CIERRES
        WHERE id_museo = NEW.id_museo
          AND id_estructura_fis = NEW.id_estructura_fis
          AND id_sala = NEW.id_sala
          AND (
              NEW.fecha_inicio BETWEEN fecha_inicio AND COALESCE(fecha_fin, NEW.fecha_inicio)
              OR
              COALESCE(NEW.fecha_fin, NEW.fecha_inicio) BETWEEN fecha_inicio AND COALESCE(fecha_fin, COALESCE(NEW.fecha_fin, NEW.fecha_inicio))
          )
    ) THEN
        RAISE EXCEPTION 'Existe un cierre solapado para esta sala en las fechas indicadas.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_solapamiento_cierre_sala
BEFORE INSERT OR UPDATE ON HISTORICOS_CIERRES
FOR EACH ROW
EXECUTE FUNCTION validar_solapamiento_cierre_sala();

--Validar que una obra no se registre más de una vez en el mismo museo y categoría
CREATE OR REPLACE FUNCTION validar_movimiento_activo_unico()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM HISTORICOS_MOVIMIENTOS
        WHERE id_obra = NEW.id_obra
          AND id_museo = NEW.id_museo
          AND fecha_fin IS NULL
    ) THEN
        RAISE EXCEPTION 'Ya existe un movimiento activo de esta obra en este museo.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_movimiento_unico_activo
BEFORE INSERT ON HISTORICOS_MOVIMIENTOS
FOR EACH ROW
WHEN (NEW.fecha_fin IS NULL)
EXECUTE FUNCTION validar_movimiento_activo_unico();

--Evitar superposición de eventos en la misma sala y museo
CREATE OR REPLACE FUNCTION validar_evento_no_superpuesto()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM EVENTOS
        WHERE id_museo = NEW.id_museo
          AND id_estructura_fis = NEW.id_estructura_fis
          AND id_sala = NEW.id_sala
          AND (
              NEW.fecha_inicio BETWEEN fecha_inicio AND fecha_fin
              OR
              NEW.fecha_fin BETWEEN fecha_inicio AND fecha_fin
              OR
              fecha_inicio BETWEEN NEW.fecha_inicio AND NEW.fecha_fin
          )
    ) THEN
        RAISE EXCEPTION 'Ya hay un evento programado en esa sala y fecha.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_evento_superpuesto
BEFORE INSERT OR UPDATE ON EVENTOS
FOR EACH ROW
WHEN (NEW.id_estructura_fis IS NOT NULL AND NEW.id_sala IS NOT NULL)
EXECUTE FUNCTION validar_evento_no_superpuesto();


--Validar que una actividad de mantenimiento registrada tenga fechas válidas y esté asignada
CREATE OR REPLACE FUNCTION validar_registro_mantenimiento()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.fecha_fin IS NOT NULL AND NEW.fecha_fin < NEW.fecha_inicio THEN
        RAISE EXCEPTION 'La fecha de fin no puede ser menor que la de inicio en un mantenimiento realizado.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_registro_mantenimiento
BEFORE INSERT OR UPDATE ON REGISTROS_ACT_REALIZADAS
FOR EACH ROW
EXECUTE FUNCTION validar_registro_mantenimiento();

--Validar que la sala asignada a una colección realmente exista y esté operativa
CREATE OR REPLACE FUNCTION validar_asignacion_coleccion_sala()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM HISTORICOS_CIERRES
        WHERE id_museo = NEW.id_museo
          AND id_estructura_fis = NEW.id_estructura_fis
          AND id_sala = NEW.id_sala
          AND CURRENT_DATE BETWEEN fecha_inicio AND COALESCE(fecha_fin, CURRENT_DATE)
    ) THEN
        RAISE EXCEPTION 'La sala asignada a la colección está cerrada actualmente.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_sala_coleccion
BEFORE INSERT OR UPDATE ON COLECCIONES_SALAS
FOR EACH ROW
EXECUTE FUNCTION validar_asignacion_coleccion_sala();


--Validar que la fecha de inicio laboral no sea antes de la fecha de nacimiento del empleado
CREATE OR REPLACE FUNCTION validar_fecha_inicio_empleado()
RETURNS TRIGGER AS $$
DECLARE
    fecha_nac DATE;
BEGIN
    SELECT EMPLEADOS_PROFESIONALES.fecha_nac INTO fecha_nac
    FROM EMPLEADOS_PROFESIONALES
    WHERE EMPLEADOS_PROFESIONALES.num_expediente = NEW.num_expediente;

    IF fecha_nac IS NOT NULL AND NEW.fecha_inicio < fecha_nac THEN
        RAISE EXCEPTION 'La fecha de inicio del cargo no puede ser anterior a la fecha de nacimiento del empleado.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_inicio_empleado
BEFORE INSERT OR UPDATE ON HISTORICOS_EMPLEADOS
FOR EACH ROW
EXECUTE FUNCTION validar_fecha_inicio_empleado();

--Evitar solapamiento de horarios en el mismo día y museo
CREATE OR REPLACE FUNCTION validar_solapamiento_horarios()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM HORARIOS
        WHERE id_museo = NEW.id_museo
          AND dia = NEW.dia
          AND (
              NEW.hora_inicio BETWEEN hora_inicio AND hora_fin
              OR
              NEW.hora_fin BETWEEN hora_inicio AND hora_fin
              OR
              hora_inicio BETWEEN NEW.hora_inicio AND NEW.hora_fin
          )
    ) THEN
        RAISE EXCEPTION 'El horario se solapa con otro ya registrado para este día.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_solapamiento_horarios
BEFORE INSERT OR UPDATE ON HORARIOS
FOR EACH ROW
EXECUTE FUNCTION validar_solapamiento_horarios();


--Validar la jerarquia de lugar geografico 
CREATE OR REPLACE FUNCTION trg_check_lugar_jerarquia()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
  CASE NEW.tipo
    WHEN 'P' THEN
      -- País: no debe tener padre
      IF NEW.id_lugar_padre IS NOT NULL THEN
        RAISE EXCEPTION 'Un país (tipo=P) no puede tener id_lugar_padre';
      END IF;

    WHEN 'R' THEN
      -- Región: debe tener padre tipo P
      IF NEW.id_lugar_padre IS NULL THEN
        RAISE EXCEPTION 'Una región (tipo=R) debe tener un id_lugar_padre';
      ELSIF NOT EXISTS (
        SELECT 1
          FROM LUGARES_GEOGRAFICOS lg
         WHERE lg.id_lugar = NEW.id_lugar_padre
           AND lg.tipo     = 'P'
      ) THEN
        RAISE EXCEPTION 'El lugar padre % no es un país (tipo=P)', NEW.id_lugar_padre;
      END IF;

    WHEN 'C' THEN
      -- Ciudad: debe tener padre tipo R
      IF NEW.id_lugar_padre IS NULL THEN
        RAISE EXCEPTION 'Una ciudad (tipo=C) debe tener un id_lugar_padre';
      ELSIF NOT EXISTS (
        SELECT 1
          FROM LUGARES_GEOGRAFICOS lg
         WHERE lg.id_lugar = NEW.id_lugar_padre
           AND lg.tipo     = 'R'
      ) THEN
        RAISE EXCEPTION 'El lugar padre % no es una región (tipo=R)', NEW.id_lugar_padre;
      END IF;

    ELSE
      RAISE EXCEPTION 'Tipo de lugar desconocido: %', NEW.tipo;
  END CASE;

  RETURN NEW;
END;
$$;

CREATE TRIGGER trg_lugar_jerarquia
  BEFORE INSERT OR UPDATE ON LUGARES_GEOGRAFICOS
  FOR EACH ROW
  EXECUTE FUNCTION trg_check_lugar_jerarquia();


--Validar que la jerarquia de estructura física sea correcta
CREATE OR REPLACE FUNCTION trg_check_estructura_fisica_jerarquia()
  RETURNS trigger
  LANGUAGE plpgsql
AS $$
BEGIN
    CASE NEW.tipo
        WHEN 'E' THEN
        -- Edificio: no debe tener padre
        IF NEW.id_padre IS NOT NULL THEN
            RAISE EXCEPTION 'Un edificio (tipo=E) no puede tener id_padre';
        END IF;

    WHEN 'P' THEN
        -- Piso: debe tener padre tipo E
        IF NEW.id_padre IS NULL THEN
            RAISE EXCEPTION 'Un piso (tipo=P) debe tener un id_padre';
        ELSIF NOT EXISTS (
            SELECT 1
            FROM ESTRUCTURAS_FISICAS ef
            WHERE ef.id_estructura_fis = NEW.id_padre
              AND ef.tipo = 'E'
        ) THEN
            RAISE EXCEPTION 'El padre % de un piso no es un edificio (tipo=E)', NEW.id_padre;
        END IF;
    ELSE
        RAISE EXCEPTION 'Tipo de estructura física desconocido: %', NEW.tipo;
END CASE;

RETURN NEW;
END;
$$;

