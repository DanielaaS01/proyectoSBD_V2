// public/js/registro_obras.js

document.addEventListener("DOMContentLoaded", () => {
  const tipoSelect = document.getElementById("tipo_obra");
  const formPintura = document.getElementById("form-pintura");
  const formEscultura = document.getElementById("form-escultura");
  const mensajePintura = document.getElementById("mensaje-pintura");
  const mensajeEscultura = document.getElementById("mensaje-escultura");

  // Mostrar/ocultar formularios según selección
  tipoSelect.addEventListener("change", () => {
    const tipo = tipoSelect.value;
    formPintura.classList.toggle("active", tipo === "pintura");
    formEscultura.classList.toggle("active", tipo === "escultura");
    mensajePintura.textContent = "";
    mensajeEscultura.textContent = "";
  });

  // Inicializar selects de museos, estructuras, salas y artistas
  ["pintura", "escultura"].forEach((tipo) => {
    const nuevoDiv = document.getElementById(`form-nuevo-artista-${tipo}`);

    cargarMuseos(`id_museo_${tipo}`);
    cargarArtistas(`id_artista_${tipo}`);
    cargarEmpleados(`num_expediente_${tipo}`);

    // Deshabilitar campos de nuevo artista por defecto
    nuevoDiv.querySelectorAll("input, textarea").forEach((el) => {
      el.disabled = true;
      el.required = false;
    });

    // Mostrar formulario de nuevo artista
    document
      .getElementById(`btn-nuevo-artista-${tipo}`)
      .addEventListener("click", () => {
        // Mostrar campos
        nuevoDiv.style.display = "block";
        nuevoDiv.querySelectorAll("input, textarea").forEach((el) => {
          el.disabled = false;
          el.required = true;
        });
        // Deshabilitar selector existente
        document.getElementById(`id_artista_${tipo}`).disabled = true;
      });

    // Cargar estructuras y salas
    document
      .getElementById(`id_museo_${tipo}`)
      .addEventListener("change", (e) => {
        limpiarSelect(`id_estructura_fis_${tipo}`);
        limpiarSelect(`id_sala_${tipo}`);
        cargarEstructuras(e.target.value, `id_estructura_fis_${tipo}`);
        limpiarSelect(`id_coleccion_${tipo}`);
        document.getElementById(`orden_coleccion_${tipo}`).textContent =
          "Seleccione una colección para ver el orden.";
        document.getElementById(`nuevo_orden_${tipo}`).disabled = true;
        cargarColecciones(
          e.target.value,
          `id_coleccion_${tipo}`,
          `orden_coleccion_${tipo}`
        );
      });
    document
      .getElementById(`id_estructura_fis_${tipo}`)
      .addEventListener("change", () => {
        limpiarSelect(`id_sala_${tipo}`);
        cargarSalas(
          `id_museo_${tipo}`,
          `id_estructura_fis_${tipo}`,
          `id_sala_${tipo}`
        );
      });
    // Al cambiar colección -> mostrar orden y habilitar nuevo orden
    document
      .getElementById(`id_coleccion_${tipo}`)
      .addEventListener("change", (e) => {
        const sel = e.target;
        const orden = sel.selectedOptions[0]?.dataset?.orden_recorrido || "";
        const panel = document.getElementById(`orden_coleccion_${tipo}`);
        panel.textContent = orden.split(",").join(" → ");
        const input = document.getElementById(`nuevo_orden_${tipo}`);
        const count = orden ? orden.split(",").length : 0;
        input.disabled = false;
        input.min = 1;
        input.max = count + 1;
      });
  });

  // Submit handler genérico para pintura y escultura
  ["pintura", "escultura"].forEach((tipo) => {
    const form = document.getElementById(`form-${tipo}`);
    const mensaje = document.getElementById(`mensaje-${tipo}`);
    form.addEventListener("submit", async (e) => {
      e.preventDefault();
      const f = e.target;
      // Definir nuevoDiv local para evitar ReferenceError
      const nuevoDiv = document.getElementById(`form-nuevo-artista-${tipo}`);

      // 1) Campos de la obra
      const payload = {
        nombre: f.nombre.value,
        dimension: f.dimension.value,
        estilos: f.estilos.value,
        caract_mat_tec: f.caract_mat_tec.value,
        periodo: f.periodo.value,
        id_museo: parseInt(f.id_museo.value, 10),
        id_estructura_fis: parseInt(f.id_estructura_fis.value, 10),
        id_sala: parseInt(f.id_sala.value, 10),
        id_coleccion: parseInt(f.id_coleccion.value, 10),
        num_expediente: parseInt(f.num_expediente.value, 10),
        nuevo_orden: parseInt(f.nuevo_orden.value, 10),
      };

      // 2) Validar artista existente o nuevo
      const selArtista = f.id_artista.value;
      if (selArtista) {
        // Artista existente
        payload.id_artista = parseInt(selArtista, 10);
      } else {
        // Nuevo artista
        payload.artistaNew = {
          nombre: document.getElementById(`nuevo_nombre_${tipo.charAt(0)}`)
            .value,
          apellido: document.getElementById(`nuevo_apellido_${tipo.charAt(0)}`)
            .value,
          nombre_artistico: document.getElementById(
            `nuevo_artistico_${tipo.charAt(0)}`
          ).value,
          fecha_nac: document.getElementById(`nuevo_nac_${tipo.charAt(0)}`)
            .value,
          fecha_def: document.getElementById(`nuevo_def_${tipo.charAt(0)}`)
            .value,
          caract_est_tec: document.getElementById(
            `nuevo_est_tec_${tipo.charAt(0)}`
          ).value,
        };
      }

      // 3) Envío al servidor
      try {
        const res = await fetch(`/${tipo}`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });
        const result = await res.json();
        if (res.ok) {
          mensaje.textContent =
            result.mensaje ||
            `${
              tipo.charAt(0).toUpperCase() + tipo.slice(1)
            } registrado y vinculado`;
          mensaje.style.color = "green";
          form.reset();
          // Ocultar y reset nuevo artista
          nuevoDiv.style.display = "none";
          nuevoDiv
            .querySelectorAll("input, textarea")
            .forEach((el) => (el.disabled = true));
          nuevoDiv
            .querySelectorAll("input, textarea")
            .forEach((el) => (el.required = false));
          document.getElementById(`id_artista_${tipo}`).disabled = false;
        } else {
          mensaje.textContent = `Error: ${result.error}`;
          mensaje.style.color = "red";
        }
      } catch (err) {
        console.error(err);
        mensaje.textContent = `Error al registrar ${tipo}`;
        mensaje.style.color = "red";
      }
    });
  });
});

// Auxiliares
async function cargarMuseos(selectId) {
  try {
    const res = await fetch("/museos");
    const museos = await res.json();
    const sel = document.getElementById(selectId);
    museos.forEach((m) => {
      const opt = document.createElement("option");
      opt.value = m.id_museo;
      opt.textContent = m.nombre;
      sel.appendChild(opt);
    });
  } catch (err) {
    console.error("Error museos:", err);
    alert("No se pudieron cargar museos");
  }
}

async function cargarArtistas(selectId) {
  try {
    const res = await fetch("/artistas");
    const artistas = await res.json();
    const sel = document.getElementById(selectId);
    artistas.forEach((a) => {
      const opt = document.createElement("option");
      opt.value = a.id_artista;
      opt.textContent = a.nombre_artistico || `${a.nombre} ${a.apellido}`;
      sel.appendChild(opt);
    });
  } catch (err) {
    console.error("Error artistas:", err);
    alert("No se pudieron cargar artistas");
  }
}

async function cargarEmpleados(selectId) {
  try {
    const res = await fetch("/empleados_profesionales");
    const empleados = await res.json();
    const sel = document.getElementById(selectId);
    empleados.forEach((emp) => {
      const opt = document.createElement("option");
      opt.value = emp.num_expediente;
      opt.textContent = emp.nombre_completo;
      sel.appendChild(opt);
    });
  } catch (err) {
    console.error("Error empleados:", err);
    alert("No se pudieron cargar empleados profesionales");
  }
}

async function cargarEstructuras(idMuseo, selectId) {
  try {
    const res = await fetch(`/estructuras-fisicas?id_museo=${idMuseo}`);
    const estructuras = await res.json();
    const sel = document.getElementById(selectId);
    sel.disabled = false;
    estructuras.forEach((e) => {
      const opt = document.createElement("option");
      opt.value = e.id_estructura_fis;
      opt.textContent = e.nombre;
      sel.appendChild(opt);
    });
  } catch (err) {
    console.error(err);
    alert("No se pudieron cargar estructuras");
  }
}

// Carga colecciones filtradas por museo
async function cargarColecciones(museoId, selectId, ordenPanelId) {
  try {
    const res = await fetch(`/colecciones?museoId=${museoId}`);
    const colecciones = await res.json();
    const sel = document.getElementById(selectId);
    sel.disabled = false;
    colecciones.forEach((col) => {
      const opt = document.createElement("option");
      opt.value = col.id_coleccion;
      opt.textContent = col.nombre;
      // Guardar orden_recorrido en data attribute
      opt.dataset.orden_recorrido = col.orden_recorrido;
      sel.appendChild(opt);
    });
  } catch (err) {
    console.error("Error colecciones:", err);
    alert("No se pudieron cargar colecciones");
  }
}

async function cargarSalas(idMuseoSel, idEstructuraSel, selectId) {
  try {
    const idMuseo = document.getElementById(idMuseoSel).value;
    const idEstr = document.getElementById(idEstructuraSel).value;
    const res = await fetch(
      `/salas?id_museo=${idMuseo}&id_estructura_fis=${idEstr}`
    );
    const salas = await res.json();
    const sel = document.getElementById(selectId);
    sel.disabled = false;
    salas.forEach((s) => {
      const opt = document.createElement("option");
      opt.value = s.id_sala;
      opt.textContent = s.nombre;
      sel.appendChild(opt);
    });
  } catch (err) {
    console.error(err);
    alert("No se pudieron cargar salas");
  }
}

function limpiarSelect(id) {
  const sel = document.getElementById(id);
  while (sel.options.length > 1) sel.remove(1);
}
