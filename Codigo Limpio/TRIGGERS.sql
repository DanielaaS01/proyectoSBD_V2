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
