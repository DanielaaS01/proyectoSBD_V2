// public/js/asignar_empleado.js

document.addEventListener("DOMContentLoaded", () => {
  const museoSelect = document.getElementById("museoPrincipal");
  const museoFormSelect = document.getElementById("museo");
  const estructuraSelect = document.getElementById("estructura");
  const tipoEmpleadoSelect = document.getElementById("tipoEmpleado");
  const empleadoSelect = document.getElementById("empleado");
  const asignacionesSection = document.getElementById("asignacionesSection");
  const seleccionarBtn = document.getElementById("seleccionarMuseo");
  const assignmentForm = document.getElementById("assignmentForm");
  const notification = document.getElementById("notification");
  const notificationMessage = document.getElementById("notificationMessage");
  const notificationClose = document.getElementById("notificationClose");
  const noEmployeeSelected = document.getElementById("noEmployeeSelected");
  const employeeInfo = document.getElementById("employeeInfo");
  const assignmentsByMonth = document.getElementById("assignmentsByMonth");

  // Deshabilitar el select de empleados hasta que se seleccione tipo
  empleadoSelect.disabled = true;

  // 1. Cargar museos
  fetch("/museos")
    .then(res => res.json())
    .then(data => {
      museoSelect.innerHTML = data.map(m => `<option value="${m.id_museo}">${m.nombre}</option>`).join("");
    });

  // 2. Al seleccionar un museo y hacer clic en "Seleccionar"
  seleccionarBtn.addEventListener("click", () => {
    const idMuseo = museoSelect.value;
    if (!idMuseo) return;

    // Mostrar secciones
    asignacionesSection.style.display = "flex";

    // Llenar museo en el form
    museoFormSelect.innerHTML = `<option selected value="${idMuseo}">${museoSelect.options[museoSelect.selectedIndex].text}</option>`;
    museoFormSelect.disabled = true;

    // Cargar estructuras físicas
    fetch(`/estructuras-fisicas?id_museo=${idMuseo}`)
      .then(res => res.json())
      .then(data => {
        estructuraSelect.innerHTML = data.map(e => `<option value="${e.id_estructura_fis}">${e.nombre}</option>`).join("");
      });
  });

  // 3. Cambiar tipo de empleado => cargar empleados
  tipoEmpleadoSelect.addEventListener("change", () => {
    const tipo = tipoEmpleadoSelect.value;
    if (!tipo) return;

    empleadoSelect.disabled = true;
    empleadoSelect.innerHTML = `<option disabled selected>Cargando...</option>`;

    fetch(`/empleados-mant-vig?tipo=${tipo}`)
      .then(res => res.json())
      .then(data => {
        if (data.length === 0) {
          empleadoSelect.innerHTML = `<option disabled selected>No hay empleados</option>`;
        } else {
          empleadoSelect.innerHTML = data.map(e => `<option value="${e.id_mant_vig}">${e.nombre} ${e.apellido}</option>`).join("");
          empleadoSelect.disabled = false;
        }
      })
      .catch(() => {
        empleadoSelect.innerHTML = `<option disabled selected>Error al cargar</option>`;
      });
  });

  // 4. Al seleccionar un empleado, mostrar asignaciones
  empleadoSelect.addEventListener("change", () => {
    const id = empleadoSelect.value;
    if (!id) return;

    fetch(`/asignaciones-empleado?id_mant_vig=${id}`)
      .then(res => res.json())
      .then(data => {
        noEmployeeSelected.style.display = "none";
        employeeInfo.style.display = "block";
        assignmentsByMonth.innerHTML = "";

        if (data.length === 0) {
          assignmentsByMonth.innerHTML = `<p>No tiene asignaciones activas.</p>`;
        } else {
          const agrupado = {};
          data.forEach(a => {
            const mes = new Date(a.id_mes_anio).toLocaleString("es-ES", { month: "long", year: "numeric" });
            if (!agrupado[mes]) agrupado[mes] = [];
            agrupado[mes].push(a);
          });

          for (const mes in agrupado) {
            const items = agrupado[mes]
              .map(a => `<li><strong>Museo:</strong> ${a.nombre_museo} | <strong>Estructura:</strong> ${a.nombre_estructura} | <strong>Turno:</strong> ${a.turno}</li>`)
              .join("");
            assignmentsByMonth.innerHTML += `<div class="asig-mes"><h4>${mes}</h4><ul>${items}</ul></div>`;
          }
        }
      })
      .catch(() => {
        assignmentsByMonth.innerHTML = `<p>Error al cargar asignaciones.</p>`;
      });
  });

  // 5. Enviar formulario
  assignmentForm.addEventListener("submit", async e => {
    e.preventDefault();

    const payload = {
      id_museo: parseInt(museoFormSelect.value),
      id_estructura_fis: parseInt(estructuraSelect.value),
      id_mant_vig: parseInt(empleadoSelect.value),
      fecha: document.getElementById("mes").value + "-01",
      turno: document.getElementById("turno").value
    };

    try {
      const res = await fetch("/asignar-empleado", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload)
      });

      const result = await res.json();
      if (!res.ok) throw new Error(result.error);

      mostrarNotificacion("Asignación realizada exitosamente", true);
      assignmentForm.reset();
      empleadoSelect.disabled = true;
      assignmentsByMonth.innerHTML = "";
      employeeInfo.style.display = "none";
      noEmployeeSelected.style.display = "block";
    } catch (err) {
      mostrarNotificacion(err.message || "Error al asignar", false);
    }
  });

  // 6. Cerrar notificación
  notificationClose.addEventListener("click", () => {
    notification.classList.remove("show");
  });

  // 7. Función para mostrar notificación
  function mostrarNotificacion(mensaje, exito = true) {
    notificationMessage.textContent = mensaje;
    notification.classList.remove("notification-success", "notification-error");
    notification.classList.add(exito ? "notification-success" : "notification-error");
    notification.classList.add("show");
    setTimeout(() => notification.classList.remove("show"), 4000);
  }
});
