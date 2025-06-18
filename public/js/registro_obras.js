// Elementos DOM
const artworkTypeSelect = document.getElementById("artworkType");
const depthGroup = document.getElementById("depthGroup");
const acquisitionTypeSelect = document.getElementById("acquisitionType");
const donorMuseumGroup = document.getElementById("donorMuseumGroup");
const isFeaturedCheckbox = document.getElementById("isFeatured");
const featuredOrderGroup = document.getElementById("featuredOrderGroup");
const newArtistBtn = document.getElementById("newArtistBtn");
const artistModal = document.getElementById("artistModal");
const closeModalBtn = document.querySelector(".close-modal");
const cancelArtistBtn = document.getElementById("cancelArtistBtn");
const artistForm = document.getElementById("artistForm");
const artistsTableBody = document.getElementById("artistsTableBody");
const noArtistsMessage = document.getElementById("noArtistsMessage");
const artistsTable = document.getElementById("artistsTable");
const addExistingArtistBtn = document.getElementById("addExistingArtistBtn");
const artistSelect = document.getElementById("artistSelect");
const museumSelect = document.getElementById("museum");
const collectionSelect = document.getElementById("collection");
const roomSelect = document.getElementById("room");
const collectionLoading = document.getElementById("collectionLoading");
const roomLoading = document.getElementById("roomLoading");

// Contador para IDs únicos de artistas
let artistCounter = 0;

// Variables globales para los datos cargados
let museos = [];
let artistas = [];

// Mostrar/ocultar campo de profundidad según el tipo de obra
artworkTypeSelect.addEventListener("change", function () {
  if (this.value === "E") {
    depthGroup.style.display = "block";
  } else {
    depthGroup.style.display = "none";
  }
});

// Mostrar/ocultar campo de museo donante según la forma de llegada
acquisitionTypeSelect.addEventListener("change", function () {
  if (this.value === "donacion") {
    donorMuseumGroup.style.display = "block";
    document.getElementById("donorMuseum").setAttribute("required", "");
  } else {
    donorMuseumGroup.style.display = "none";
    document.getElementById("donorMuseum").removeAttribute("required");
  }
});

// Mostrar/ocultar campo de orden destacado
isFeaturedCheckbox.addEventListener("change", function () {
  if (this.checked) {
    featuredOrderGroup.style.display = "block";
    document.getElementById("featuredOrder").setAttribute("required", "");
  } else {
    featuredOrderGroup.style.display = "none";
    document.getElementById("featuredOrder").removeAttribute("required");
  }
});

// Función para cargar museos y llenar el select
async function cargarMuseos() {
  const res = await fetch("/museos");
  museos = await res.json();
  museumSelect.innerHTML = '<option value="">Seleccione un museo</option>';
  document.getElementById("donorMuseum").innerHTML =
    '<option value="">Seleccione un museo</option>';
  museos.forEach((m) => {
    const opt = document.createElement("option");
    opt.value = m.id_museo;
    opt.textContent = m.nombre;
    museumSelect.appendChild(opt);

    // También para museos donantes
    const opt2 = document.createElement("option");
    opt2.value = m.id_museo;
    opt2.textContent = m.nombre;
    document.getElementById("donorMuseum").appendChild(opt2);
  });
}

// Función para cargar artistas y llenar el select
async function cargarArtistas() {
  const res = await fetch("/artistas");
  artistas = await res.json();
  artistSelect.innerHTML =
    '<option value="">Seleccione un artista existente</option>';
  artistas.forEach((a) => {
    const opt = document.createElement("option");
    opt.value = a.id_artista;
    opt.textContent = a.nombre_artistico || "(Sin nombre artístico)";
    artistSelect.appendChild(opt);
  });
}

// Función para cargar colecciones, salas y empleados según museo
museumSelect.addEventListener("change", async function () {
  const idMuseo = this.value;

  // Resetear selects
  collectionSelect.innerHTML =
    '<option value="">Seleccione una colección</option>';
  roomSelect.innerHTML = '<option value="">Seleccione una sala</option>';
  document.getElementById("responsibleEmployee").innerHTML =
    '<option value="">Seleccione un empleado</option>';
  collectionSelect.disabled = true;
  roomSelect.disabled = true;
  document.getElementById("responsibleEmployee").disabled = true;

  if (!idMuseo) return;

  // Colecciones
  collectionLoading.style.display = "block";
  fetch(`/colecciones?museoId=${idMuseo}`)
    .then((res) => res.json())
    .then((data) => {
      collectionSelect.innerHTML =
        '<option value="">Seleccione una colección</option>';
      data.forEach((c) => {
        const opt = document.createElement("option");
        opt.value = c.id_coleccion;
        opt.textContent = c.nombre_coleccion || c.nombre;
        collectionSelect.appendChild(opt);
      });
      collectionSelect.disabled = false;
      collectionLoading.style.display = "none";
    });

  // Empleados profesionales responsables (con parámetro)
  fetch(`/empleados_profesionales_por_museo?id_museo=${idMuseo}`)
    .then(res => res.json())
    .then(data => {
        const responsibleEmployeeSelect = document.getElementById('responsibleEmployee');
        responsibleEmployeeSelect.innerHTML = '<option value="">Seleccione un empleado</option>';
        data.forEach(e => {
            const opt = document.createElement('option');
            opt.value = e.num_expediente;
            opt.textContent = e.nombre_completo;
            responsibleEmployeeSelect.appendChild(opt);
        });
        responsibleEmployeeSelect.disabled = false;
    });
});

// Cuando cambia la colección, cargar salas asociadas a esa colección
collectionSelect.addEventListener("change", async function () {
  const idMuseo = museumSelect.value;
  const idColeccion = this.value;

  roomSelect.innerHTML = '<option value="">Seleccione una sala</option>';
  roomSelect.disabled = true;

  if (!idMuseo || !idColeccion) return;

  roomLoading.style.display = "block";
  fetch(`/salas-por-coleccion?id_museo=${idMuseo}&id_coleccion=${idColeccion}`)
    .then((res) => res.json())
    .then((data) => {
      roomSelect.innerHTML = '<option value="">Seleccione una sala</option>';
      data.forEach((s) => {
        const opt = document.createElement("option");
        opt.value = s.id_sala;
        opt.textContent = s.nombre;
        roomSelect.appendChild(opt);
      });
      roomSelect.disabled = false;
      roomLoading.style.display = "none";
    });
});

// Abrir modal de nuevo artista
newArtistBtn.addEventListener("click", function () {
  artistModal.style.display = "block";
  document.body.style.overflow = "hidden";
});

// Cerrar modal
function closeModal() {
  artistModal.style.display = "none";
  document.body.style.overflow = "auto";
  artistForm.reset();
}

closeModalBtn.addEventListener("click", closeModal);
cancelArtistBtn.addEventListener("click", closeModal);

// Cerrar modal al hacer clic fuera del contenido
window.addEventListener("click", function (event) {
  if (event.target === artistModal) {
    closeModal();
  }
});

// Función para actualizar la visibilidad de la tabla de artistas
function updateArtistsTableVisibility() {
  if (artistsTableBody.children.length > 0) {
    artistsTable.style.display = "table";
    noArtistsMessage.style.display = "none";
  } else {
    artistsTable.style.display = "none";
    noArtistsMessage.style.display = "block";
  }
}

// Añadir artista desde el formulario modal
artistForm.addEventListener("submit", function (event) {
  event.preventDefault();

  const firstName = document.getElementById("artistFirstName").value.trim();
  const lastName = document.getElementById("artistLastName").value.trim();
  const artisticName = document.getElementById("artisticName").value.trim();
  const birthDate = document.getElementById("birthDate").value || "";
  const deathDate = document.getElementById("deathDate").value || "";
  const caractEstTec = document.getElementById("artistCharacteristics").value.trim();

  if (!firstName && !lastName && !artisticName && !caractEstTec) {
    alert("Debe ingresar al menos un dato del artista");
    return;
  }

  // Crear nombre para mostrar
  const displayName = artisticName
    ? `${firstName} ${lastName} (${artisticName})`
    : `${firstName} ${lastName}`;

  // Guardar datos completos
  const artistaData = {
    nombre: firstName,
    apellido: lastName,
    nombre_artistico: artisticName,
    fecha_nac: birthDate,
    fecha_def: deathDate,
    caract_est_tec: caractEstTec,
  };

  // Añadir artista a la tabla
  addArtistToTable(displayName, "Nuevo", ++artistCounter, artistaData);

  // Cerrar modal y resetear formulario
  closeModal();
});

// Añadir artista existente
addExistingArtistBtn.addEventListener("click", function () {
  const selectedOption = artistSelect.options[artistSelect.selectedIndex];

  if (selectedOption.value) {
    addArtistToTable(selectedOption.text, "Existente", selectedOption.value);
    artistSelect.selectedIndex = 0;
  }
});

// Función para añadir artista a la tabla
function addArtistToTable(name, type, id, artistaData = null) {
  // Verificar si el artista ya está en la tabla
  const existingRows = artistsTableBody.querySelectorAll("tr");
  for (let i = 0; i < existingRows.length; i++) {
    if (existingRows[i].dataset.id === id.toString()) {
      alert("Este artista ya está asociado a la obra");
      return;
    }
  }

  const row = document.createElement("tr");
  row.dataset.id = id;
  row.dataset.type = type;

  // Si es nuevo, guarda los datos completos como atributos data-*
  if (type === "Nuevo" && artistaData) {
    row.dataset.nombre = artistaData.nombre || "";
    row.dataset.apellido = artistaData.apellido || "";
    row.dataset.nombreArtistico = artistaData.nombre_artistico || "";
    row.dataset.fechaNac = artistaData.fecha_nac || "";
    row.dataset.fechaDef = artistaData.fecha_def || "";
    row.dataset.caractEstTec = artistaData.caract_est_tec || "";
  }

  row.innerHTML = `
    <td>${name}</td>
    <td>${type}</td>
    <td class="action-cell">
        <button type="button" class="artist-action-btn remove" title="Eliminar artista">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                <path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/>
            </svg>
        </button>
        <input type="hidden" name="artists[]" value="${id}">
    </td>
  `;

  // Añadir evento para eliminar artista
  const removeBtn = row.querySelector(".artist-action-btn.remove");
  removeBtn.addEventListener("click", function () {
    row.remove();
    updateArtistsTableVisibility();
  });

  artistsTableBody.appendChild(row);
  updateArtistsTableVisibility();
}

// Inicialización
document.addEventListener("DOMContentLoaded", function () {
  // Ocultar campos opcionales al inicio
  depthGroup.style.display = "none";
  donorMuseumGroup.style.display = "none";
  featuredOrderGroup.style.display = "none";

  // Inicializar la visibilidad de la tabla de artistas
  updateArtistsTableVisibility();

  // Cargar museos y artistas
  cargarMuseos();
  cargarArtistas();
});

// Envío del formulario principal
document
  .getElementById("artworkForm")
  .addEventListener("submit", async function (event) {
    event.preventDefault();

    // Validar que haya al menos un artista
    if (artistsTableBody.children.length === 0) {
      mostrarMensaje("Debe asociar al menos un artista a la obra", "error");
      return;
    }

    // Obtener datos del formulario
    const tipoObra = document.getElementById("artworkType").value;
    const nombre = document.getElementById("artworkName").value;
    const periodo = document.getElementById("period").value || null;
    const ancho = document.getElementById("width").value;
    const alto = document.getElementById("height").value;
    const profundidad = document.getElementById("depth").value;
    const dimension =
      tipoObra === "E"
        ? `${ancho} X ${alto} X ${profundidad}`
        : `${ancho} X ${alto}`;
    const estilos = document.getElementById("styles").value;
    const caract_mat_tec = document.getElementById("characteristics").value;
    const valor_monetario =
      document.getElementById("monetaryValue").value || null;
    const id_museo = museumSelect.value;
    const id_coleccion = collectionSelect.value;
    const id_sala = roomSelect.value;
    const num_expediente = document.getElementById("responsibleEmployee").value;
    const tipo_llegada = (() => {
      const val = document.getElementById("acquisitionType").value;
      if (val === "compra") return "C";
      if (val === "donacion") return "D";
      if (val === "adquisicion") return "A";
      return null;
    })();
    const id_museo_origen =
      document.getElementById("donorMuseum").value || null;
    const fecha_inicio = document.getElementById("arrivalDate").value;
    const destacada = document.getElementById("isFeatured").checked;
    const orden_recomendado =
      document.getElementById("featuredOrder").value || null;

    // Artistas asociados
    let artistas_existentes = [];
    let nuevos_artistas = [];
    for (let row of artistsTableBody.children) {
      if (row.cells[1].textContent === "Existente") {
        artistas_existentes.push(parseInt(row.dataset.id));
      } else if (row.cells[1].textContent === "Nuevo") {
        // Tomar los datos del data
        const artistaData = row.dataset;
        console.log("Artista nuevo dataset:", artistaData); // <-- Agrega esto
        const artistaStr = [
          artistaData.caractEstTec,
          artistaData.nombre,
          artistaData.apellido,
          artistaData.nombreArtistico,
          artistaData.fechaNac,
          artistaData.fechaDef
        ].join("|");
        nuevos_artistas.push(artistaStr);
      }
    }

    // Construir el body para el registro
    const body = {
      nombre,
      dimension,
      tipo: tipoObra,
      estilos,
      caract_mat_tec,
      id_sala: parseInt(id_sala),
      id_museo: parseInt(id_museo),
      periodo: periodo || null,
      artistas_existentes,
      nuevos_artistas,
      fecha_inicio,
      tipo_llegada,
      destacada,
      orden_recomendado: orden_recomendado ? parseInt(orden_recomendado) : null,
      valor_monetario: valor_monetario ? parseFloat(valor_monetario) : null,
      id_coleccion: parseInt(id_coleccion),
      num_expediente: parseInt(num_expediente),
      id_museo_origen: id_museo_origen ? parseInt(id_museo_origen) : null
    };

    // Enviar petición al backend
    try {
      const res = await fetch("/registrar-obra", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      const data = await res.json();
      if (res.ok) {
        mostrarMensaje("Obra registrada correctamente", "success");
        this.reset();
        artistsTableBody.innerHTML = "";
        updateArtistsTableVisibility();
      } else {
        mostrarMensaje(data.error || "Error al registrar la obra", "error");
      }
    } catch (err) {
      mostrarMensaje("Error de conexión con el servidor", "error");
    }
  });

// Función para mostrar mensajes de estado
function mostrarMensaje(msg, tipo) {
  const formStatus = document.querySelector(".form-status");
  formStatus.textContent = msg;
  formStatus.className = "form-status " + tipo;
  setTimeout(() => {
    formStatus.scrollIntoView({ behavior: "smooth" });
  }, 100);
}

// Inicialización
document.addEventListener("DOMContentLoaded", function () {
  // Ocultar campos opcionales al inicio
  depthGroup.style.display = "none";
  donorMuseumGroup.style.display = "none";
  featuredOrderGroup.style.display = "none";

  // Inicializar la visibilidad de la tabla de artistas
  updateArtistsTableVisibility();

  // Cargar museos y artistas
  cargarMuseos();
  cargarArtistas();
});
