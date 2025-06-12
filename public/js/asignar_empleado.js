// Elementos del DOM
const museoPrincipal = document.getElementById("museoPrincipal");
const seleccionarMuseoBtn = document.getElementById("seleccionarMuseo");
const asignacionesSection = document.getElementById("asignacionesSection");
const museoSelect = document.getElementById("museo");
const estructuraSelect = document.getElementById("estructura");
const tipoEmpleadoSelect = document.getElementById("tipoEmpleado");
const empleadoSelect = document.getElementById("empleado");
const mesInput = document.getElementById("mes");
const turnoSelect = document.getElementById("turno");
const assignmentForm = document.getElementById("assignmentForm");
const notification = document.getElementById("notification");
const notificationIcon = document.getElementById("notificationIcon");
const notificationMessage = document.getElementById("notificationMessage");
const notificationClose = document.getElementById("notificationClose");
const employeeAssignmentsContainer = document.getElementById("employeeAssignmentsContainer");
const noEmployeeSelected = document.getElementById("noEmployeeSelected");
const employeeInfo = document.getElementById("employeeInfo");
const yearSelector = document.getElementById("yearSelector");
const yearSelect = document.getElementById("yearSelect");
const assignmentsByMonth = document.getElementById("assignmentsByMonth");

// Estado global
let museos = [];
let estructurasFisicas = [];
let empleados = [];
let asignaciones = [];
let museoSeleccionado = null;
let empleadoSeleccionado = null;

// Utilidad: mostrar notificación
function showNotification(msg, type = "success") {
  notification.classList.remove("notification-success", "notification-error", "show");
  notificationIcon.innerHTML =
    type === "success"
      ? `<path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/>`
      : `<path d="M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z"/>`;
  notification.classList.add(type === "success" ? "notification-success" : "notification-error");
  notificationMessage.textContent = msg;
  setTimeout(() => notification.classList.add("show"), 100);
  setTimeout(() => notification.classList.remove("show"), 4000);
}
notificationClose.onclick = () => notification.classList.remove("show");

// 1. Cargar museos al inicio
async function cargarMuseos() {
  const res = await fetch("/museos");
  museos = await res.json();
  museoPrincipal.innerHTML = museos
    .map(
      (m) => `<option value="${m.id_museo}">${m.nombre}</option>`
    )
    .join("");
  // Actualizar contador
  document.querySelector(".museum-count").textContent = museos.length;
}
cargarMuseos();

// 2. Seleccionar museo principal
seleccionarMuseoBtn.onclick = () => {
  museoSeleccionado = museoPrincipal.value;
  if (!museoSeleccionado) return;
  asignacionesSection.style.display = "";
  // Llenar select del formulario con el museo seleccionado
  museoSelect.innerHTML = museos
    .filter((m) => m.id_museo == museoSeleccionado)
    .map((m) => `<option value="${m.id_museo}">${m.nombre}</option>`)
    .join("");
  cargarEstructurasFisicas();
  limpiarFormulario();
  limpiarPanelAsignaciones();
};

// 3. Cargar estructuras físicas según museo
async function cargarEstructurasFisicas() {
  estructuraSelect.innerHTML = `<option disabled selected>Cargando...</option>`;
  const res = await fetch(`/estructuras-fisicas?id_museo=${museoSeleccionado}`);
  estructurasFisicas = await res.json();
  estructuraSelect.innerHTML =
    `<option value="" disabled selected>Seleccione una estructura</option>` +
    estructurasFisicas
      .map(
        (e) => `<option value="${e.id_estructura_fis}">${e.nombre}</option>`
      )
      .join("");
}

// 4. Cambiar tipo de empleado → cargar empleados
tipoEmpleadoSelect.onchange = async () => {
  empleadoSelect.innerHTML = `<option disabled selected>Cargando...</option>`;
  const tipo = tipoEmpleadoSelect.value;
  if (!tipo) return;
  const res = await fetch(`/empleados-mant-vig?tipo=${tipo}`);
  empleados = await res.json();
  empleadoSelect.innerHTML =
    `<option value="" disabled selected>Seleccione un empleado</option>` +
    empleados
      .map(
        (e) =>
          `<option value="${e.id_mant_vig}">${e.nombre} ${e.apellido}</option>`
      )
      .join("");
  limpiarPanelAsignaciones();
};

// 5. Cambiar empleado → mostrar asignaciones
empleadoSelect.onchange = () => {
  empleadoSeleccionado = empleadoSelect.value;
  if (empleadoSeleccionado) {
    mostrarAsignacionesEmpleado(empleadoSeleccionado);
  } else {
    limpiarPanelAsignaciones();
  }
};

// 6. Mostrar asignaciones del empleado
async function mostrarAsignacionesEmpleado(idEmpleado) {
  noEmployeeSelected.style.display = "none";
  employeeInfo.style.display = "";
  yearSelector.style.display = "";
  assignmentsByMonth.innerHTML = `<div class="no-assignments">Cargando asignaciones...</div>`;

  // Mostrar info básica del empleado
  const empleado = empleados.find((e) => e.id_mant_vig == idEmpleado);
  employeeInfo.innerHTML = empleado
    ? `
      <div class="employee-info">
        <div class="employee-avatar">${empleado.nombre[0] || "?"}</div>
        <div class="employee-details">
          <div class="employee-name-large">${empleado.nombre} ${empleado.apellido}</div>
          <div class="employee-position">
            <svg class="position-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10" /></svg>
            ${tipoEmpleadoSelect.options[tipoEmpleadoSelect.selectedIndex].text}
          </div>
        </div>
      </div>
    `
    : "";

  // Consultar asignaciones
  const res = await fetch(`/asignaciones-empleado?id_mant_vig=${idEmpleado}`);
  asignaciones = await res.json();

  // Agrupar por año y mes
  const agrupadas = {};
  asignaciones.forEach((a) => {
  const fecha = new Date(a.fecha);
  const year = fecha.getFullYear();
  const month = fecha.toLocaleString("es-ES", { month: "long" });
  if (!agrupadas[year]) agrupadas[year] = {};
  if (!agrupadas[year][month]) agrupadas[year][month] = [];
  agrupadas[year][month].push(a);
});

  // Llenar selector de año
  const years = Object.keys(agrupadas).sort((a, b) => b - a);
  yearSelect.innerHTML = years
    .map((y) => `<option value="${y}">${y}</option>`)
    .join("");
  yearSelector.style.display = years.length ? "" : "none";

  // Mostrar asignaciones del año más reciente
  if (years.length) {
    mostrarAsignacionesPorAño(years[0], agrupadas);
    yearSelect.onchange = () =>
      mostrarAsignacionesPorAño(yearSelect.value, agrupadas);
  } else {
    assignmentsByMonth.innerHTML = `<div class="no-assignments">Sin asignaciones para este empleado.</div>`;
  }
}

function mostrarAsignacionesPorAño(year, agrupadas) {
  const meses = agrupadas[year] || {};
  assignmentsByMonth.innerHTML = Object.keys(meses).length
    ? Object.entries(meses)
        .map(
          ([mes, asigns]) => `
        <div class="month-header">
          <svg class="month-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><rect width="24" height="24" fill="none"/><path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM7 10h5v5H7z"/></svg>
          ${mes}
        </div>
        ${asigns
          .map(
            (a) => `
          <div class="assignment-card">
            <div class="assignment-header">
              <span class="assignment-title">${a.nombre_estructura}</span>
              <span class="assignment-type type-${
                a.tipo === "M" ? "maintenance" : "security"
              }">
                ${a.tipo === "M" ? "Mantenimiento" : "Vigilancia"}
              </span>
            </div>
            <div class="assignment-details">
              <br>
              Turno: ${
                a.turno === "M"
                  ? "Mañana"
                  : a.turno === "V"
                  ? "Vespertino"
                  : "Noche"
              }
            </div>
            <div class="assignment-location">
              <svg class="location-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><circle cx="12" cy="10" r="3"/><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7z"/></svg>
              Museo: ${a.nombre_museo}
            </div>
          </div>
        `
          )
          .join("")}
      `
        )
        .join("")
    : `<div class="no-assignments">Sin asignaciones para este año.</div>`;
}

// 7. Enviar formulario de asignación
assignmentForm.onsubmit = async (e) => {
  e.preventDefault();
  // Validar campos
  if (
    !museoSeleccionado ||
    !estructuraSelect.value ||
    !tipoEmpleadoSelect.value ||
    !empleadoSelect.value ||
    !mesInput.value ||
    !turnoSelect.value
  ) {
    showNotification("Complete todos los campos", "error");
    return;
  }
  // Enviar datos
  const body = {
    id_museo: museoSeleccionado,
    id_estructura_fis: estructuraSelect.value,
    id_mant_vig: empleadoSelect.value,
    fecha: mesInput.value + "-01",
    turno: turnoSelect.value,
  };
  try {
    const res = await fetch("/asignar-empleado", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    });
    const data = await res.json();
    if (res.ok) {
      showNotification("Asignación realizada con éxito", "success");
      mostrarAsignacionesEmpleado(empleadoSelect.value);
      assignmentForm.reset();
      // Mantener selects de museo y tipo
      museoSelect.value = museoSeleccionado;
      tipoEmpleadoSelect.value = body.tipo;
    } else {
      showNotification(data.error || "Error al asignar", "error");
    }
  } catch (err) {
    showNotification("Error de red", "error");
  }
};

// Utilidades para limpiar
function limpiarFormulario() {
  estructuraSelect.innerHTML = `<option value="" disabled selected>Seleccione una estructura</option>`;
  tipoEmpleadoSelect.value = "";
  empleadoSelect.innerHTML = `<option value="" disabled selected>Seleccione un empleado</option>`;
  mesInput.value = "";
  turnoSelect.value = "";
}
function limpiarPanelAsignaciones() {
  noEmployeeSelected.style.display = "";
  employeeInfo.style.display = "none";
  yearSelector.style.display = "none";
  assignmentsByMonth.innerHTML = "";
}