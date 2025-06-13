// reporte_obras.js

// Utilidad para limpiar nodos
function limpiarNodo(nodo) {
  while (nodo.firstChild) nodo.removeChild(nodo.firstChild);
}

// Cargar museos en el filtro
async function cargarMuseos() {
  const museoSelect = document.getElementById("museoFilter");
  limpiarNodo(museoSelect);
  const optionTodos = document.createElement("option");
  optionTodos.value = "";
  optionTodos.textContent = "Todos los museos";
  museoSelect.appendChild(optionTodos);

  try {
    const res = await fetch("/museos");
    const museos = await res.json();
    museos.forEach((museo) => {
      const opt = document.createElement("option");
      opt.value = museo.id_museo;
      opt.textContent = museo.nombre;
      museoSelect.appendChild(opt);
    });
  } catch (e) {
    mostrarNotificacion("Error al cargar museos", "error");
  }
}

// Cargar lista de obras según filtros
async function cargarObras() {
  const museo = document.getElementById("museoFilter").value;
  const tipo = document.getElementById("tipoObraFilter").value;
  const listaObras = document.getElementById("artworkList");
  limpiarNodo(listaObras);

  let url = "/obras";
  const params = [];
  if (museo) params.push(`museo=${encodeURIComponent(museo)}`);
  if (tipo) params.push(`tipo=${encodeURIComponent(tipo)}`);
  if (params.length) url += "?" + params.join("&");

  try {
    const res = await fetch(url);
    const obras = await res.json();

    document.getElementById(
      "artworkCount"
    ).textContent = `Mostrando ${obras.length} obras`;

    if (obras.length === 0) {
      listaObras.innerHTML = `<div class="no-results">No se encontraron obras con los filtros seleccionados</div>`;
      return;
    }

    obras.forEach((obra) => {
      const obraElement = document.createElement("div");
      obraElement.className = "artwork-item";
      obraElement.dataset.id = obra.id_obra;
      obraElement.innerHTML = `
        <div class="artwork-name">${obra.nombre}</div>
        <div class="artwork-meta">
          <span class="artwork-type ${
            obra.tipo === "P" ? "type-painting" : "type-sculpture"
          }">
            ${obra.tipo === "P" ? "Pintura" : "Escultura"}
          </span>
        </div>
      `;
      obraElement.addEventListener("click", () =>
        mostrarDetalleObra(obra.id_obra)
      );
      listaObras.appendChild(obraElement);
    });
  } catch (e) {
    mostrarNotificacion("Error al cargar obras", "error");
  }
}

// Mostrar detalle de una obra
async function mostrarDetalleObra(obraId) {
  // Marcar como activa en la lista
  document.querySelectorAll(".artwork-item").forEach((item) => {
    item.classList.toggle("active", Number(item.dataset.id) === Number(obraId));
  });

  try {
    const res = await fetch(`/obras/${obraId}`);
    if (!res.ok) {
      mostrarNotificacion("Error al cargar detalle de la obra", "error");
      return;
    }
    const obra = await res.json();

    // Mostrar el detalle
    document.getElementById("noArtworkSelected").style.display = "none";
    document.getElementById("artworkDetail").style.display = "block";

    // Título
    document.getElementById("detailTitle").textContent = obra.nombre || "-";
    document.getElementById("nombreObra").textContent = obra.nombre || "-";
    document.getElementById("tipoObra").textContent =
      obra.tipo === "P" ? "Pintura" : obra.tipo === "E" ? "Escultura" : "-";
    document.getElementById("coleccion").textContent = obra.coleccion || "-";
    document.getElementById("periodo").textContent = obra.periodo
      ? typeof obra.periodo === "string"
        ? obra.periodo
        : obra.periodo.toString()
      : "-";
    document.getElementById("dimensiones").textContent =
      obra.dimensiones || "-";
    document.getElementById("ubicacion").textContent = obra.ubicacion || "-";

    // Estilos
    const estilosContainer = document.getElementById("estilos");
    limpiarNodo(estilosContainer);
    if (obra.estilos) {
      obra.estilos.split(",").forEach((estilo) => {
        if (estilo.trim()) {
          const tag = document.createElement("span");
          tag.className = "tag";
          tag.textContent = estilo.trim();
          estilosContainer.appendChild(tag);
        }
      });
    } else {
      estilosContainer.textContent = "-";
    }

    // Materiales y características
    document.getElementById("materiales").textContent =
      obra.caracteristicas || "-";
    // Características ya incluidas en materiales (según tu HTML)

    // ARTISTAS
const artistasContainer = document.getElementById("artistasContainer");
limpiarNodo(artistasContainer);

if (obra && Array.isArray(obra.artistas) && obra.artistas.length > 0) {
  obra.artistas.forEach(info => {
    let nombre = "", apellido = "", nombre_artistico = "";

    info.split(";").forEach(parte => {
      const [clave, valor] = parte.split(":").map(s => s.trim());
      if (clave && valor !== undefined) {
        if (clave.toLowerCase().includes("nombre artistico")) nombre_artistico = valor;
        else if (clave.toLowerCase() === "nombre") nombre = valor;
        else if (clave.toLowerCase() === "apellido") apellido = valor;
      }
    });

    // Lógica de visualización según disponibilidad
    let contenidoNombre = "";
    let contenidoRol = "";

    if (nombre_artistico && (!nombre || !apellido)) {
      contenidoNombre = nombre_artistico;
      contenidoRol = "Nombre real no conocido";
    } else {
      contenidoNombre = nombre_artistico || `${nombre} ${apellido}`.trim();
      contenidoRol = `${nombre} ${apellido}`.trim();
    }

    const artistaCard = document.createElement("div");
    artistaCard.className = "artist-card";
    artistaCard.innerHTML = `
      <div class="artist-info">
        <div class="artist-name">${contenidoNombre}</div>
        <div class="artist-role">${contenidoRol}</div>
      </div>
    `;
    artistasContainer.appendChild(artistaCard);
  });
} else {
  artistasContainer.innerHTML = '<div class="artist-card">Artista Desconocido</div>';
}


    // Adquisición
    let fechaFormateada = "-";
    if (obra.fecha_adquisicion) {
      const fecha = new Date(obra.fecha_adquisicion);
      if (!isNaN(fecha)) {
        const dia = String(fecha.getDate()).padStart(2, '0');
        const mes = String(fecha.getMonth() + 1).padStart(2, '0');
        const anio = fecha.getFullYear();
        fechaFormateada = `${dia}/${mes}/${anio}`;
      }
    }
    document.getElementById("fechaAdquisicion").textContent = fechaFormateada;

    // Badge de adquisición
    const badgeAdquisicion = document.getElementById("badgeAdquisicion");
    if (obra.metodo_adquisicion) {
      if (obra.metodo_adquisicion.toLowerCase().includes("compra")) {
        badgeAdquisicion.className = "acquisition-badge badge-acquired";
        badgeAdquisicion.textContent = "Adquirida por el museo";
      } else if (
        obra.metodo_adquisicion.toLowerCase().includes("donación") ||
        obra.metodo_adquisicion.toLowerCase().includes("donada")
      ) {
        badgeAdquisicion.className = "acquisition-badge badge-donated";
        badgeAdquisicion.textContent = "Donada al museo";
      } else {
        badgeAdquisicion.className = "acquisition-badge";
        badgeAdquisicion.textContent = obra.metodo_adquisicion;
      }
    } else {
      badgeAdquisicion.className = "acquisition-badge";
      badgeAdquisicion.textContent = "";
    }

    // Imagen (placeholder siempre)
    
  } catch (e) {
    mostrarNotificacion("Error al cargar detalle de la obra", "error");
  }
}

// Notificación
function mostrarNotificacion(mensaje, tipo) {
  const notification = document.getElementById("notification");
  const notificationIcon = document.getElementById("notificationIcon");
  const notificationMessage = document.getElementById("notificationMessage");
  if (tipo === "success") {
    notification.className = "notification notification-success show";
    notificationIcon.innerHTML =
      '<path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/>';
  } else {
    notification.className = "notification notification-error show";
    notificationIcon.innerHTML =
      '<path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/>';
  }
  notificationMessage.textContent = mensaje;
  setTimeout(() => {
    notification.className = "notification";
  }, 3000);
}

// Cerrar notificación al hacer clic en X
document.addEventListener("DOMContentLoaded", function () {
  document
    .getElementById("notificationClose")
    .addEventListener("click", function () {
      document.getElementById("notification").className = "notification";
    });



  // Botón para imprimir reporte
  document.getElementById("printReport").addEventListener("click", function () {
  window.print();
});

// Botón para exportar a PDF
document.getElementById("exportPDF").addEventListener("click", async function () {
  const detailPanel = document.getElementById("artworkDetail");
  if (!detailPanel || detailPanel.style.display === "none") {
    mostrarNotificacion("Seleccione una obra para exportar", "error");
    return;
  }
  mostrarNotificacion("Generando PDF...", "success");
  await new Promise(r => setTimeout(r, 300));

  // Oculta los botones dentro del panel de detalles
  const btnPDF = detailPanel.querySelector("#exportPDF");
  const btnPrint = detailPanel.querySelector("#printReport");
  if (btnPDF) btnPDF.classList.add("oculto-para-pdf");
  if (btnPrint) btnPrint.classList.add("oculto-para-pdf");

  // Espera a que el DOM se actualice
  await new Promise(r => setTimeout(r, 200));

  // Fecha y hora actual
  const fecha = new Date();
  const fechaStr = fecha.toLocaleDateString("es-ES");
  const horaStr = fecha.toLocaleTimeString("es-ES", { hour: '2-digit', minute: '2-digit' });

  html2canvas(detailPanel, { scale: 2 }).then(canvas => {
    // Vuelve a mostrar los botones después de capturar
    if (btnPDF) btnPDF.classList.remove("oculto-para-pdf");
    if (btnPrint) btnPrint.classList.remove("oculto-para-pdf");

    const imgData = canvas.toDataURL("image/png");
    const pdf = new window.jspdf.jsPDF({
      orientation: "landscape",
      unit: "pt",
      format: [400, 576]
    });

    const pageWidth = pdf.internal.pageSize.getWidth();

    // Colores de la paleta
    const colorMostaza = "#D4AF37";
    const colorAzulOscuro = "#002F5F";
    const colorTexto = "#333333";
    const colorBeigeClaro = "#FAF9F0";

    // Fondo superior
    pdf.setFillColor(colorBeigeClaro);
    pdf.rect(0, 0, pageWidth, 80, "F");

    // Responsable y fecha
    pdf.setFont("helvetica", "normal");
    pdf.setFontSize(8);
    pdf.setTextColor(colorTexto);
    pdf.text("Generación de reporte por grupo especializado: grupo 4", 40, 40);
    pdf.text(`Fecha de generación: ${fechaStr} ${horaStr}`, pageWidth - 40, 40, { align: "right" });

    // Línea separadora mostaza
    pdf.setDrawColor(colorMostaza);
    pdf.setLineWidth(2);
    pdf.line(40, 50, pageWidth - 40, 50);

    // Imagen del panel de detalles
    const imgWidth = pageWidth - 80;
    const imgHeight = canvas.height * imgWidth / canvas.width;
    pdf.addImage(imgData, "PNG", 40, 60, imgWidth, imgHeight);

    pdf.save("detalle_obra.pdf");
  });
});


  // Filtros
  document
    .getElementById("aplicarFiltros")
    .addEventListener("click", function () {
      cargarObras();
      mostrarNotificacion("Filtros aplicados correctamente", "success");
    });

  // Inicializar filtros y obras
  cargarMuseos().then(cargarObras);

  // Mostrar animaciones después de cargar
  setTimeout(() => {
    document.querySelector(".filters-section").style.opacity = "1";
    document.querySelector(".artwork-list-container").style.opacity = "1";
    document.querySelector(".artwork-detail-container").style.opacity = "1";
  }, 100);
});
