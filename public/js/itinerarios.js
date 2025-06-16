document.addEventListener("DOMContentLoaded", () => {
  // Elementos del DOM
  const museumSelect = document.getElementById("museum");
  const itineraryTypeOptions = document.querySelectorAll(".type-option");
  const generateBtn = document.getElementById("generateBtn");
  const artworksItinerary = document.getElementById("artworksItinerary");
  const collectionsItinerary = document.getElementById("collectionsItinerary");
  const artworksList = document.getElementById("artworksList");
  const collectionsList = document.getElementById("collectionsList");
  const artworksMuseumBadge = document.getElementById("artworksMuseumBadge");
  const collectionsMuseumBadge = document.getElementById("collectionsMuseumBadge");
  const printArtworksBtn = document.getElementById("printArtworksBtn");
  const printCollectionsBtn = document.getElementById("printCollectionsBtn");
  const pdfArtworksBtn = document.getElementById("pdfArtworksBtn");
  const pdfCollectionsBtn = document.getElementById("pdfCollectionsBtn");

  // Estado
  let museos = [];
  let museoSeleccionado = null;
  let tipoItinerario = "artworks"; // artworks o collections

  // Función para capitalizar solo la primera letra y el resto en minúsculas
  function capitalizar(str) {
    if (!str || typeof str !== "string") return "";
    return str
      .toLowerCase()
      .replace(/(^|\s|\.)([a-záéíóúüñ])/g, (m, p1, p2) => p1 + p2.toUpperCase());
  }

  // Cargar museos desde el backend y poblar el select
  async function cargarMuseos() {
    try {
      const res = await fetch("/museos");
      museos = await res.json();
      museumSelect.innerHTML = "";
      museos.forEach(museo => {
        const opt = document.createElement("option");
        opt.value = museo.id_museo;
        opt.textContent = capitalizar(museo.nombre); // <-- Capitaliza aquí
        museumSelect.appendChild(opt);
      });
      museoSeleccionado = museos[0]?.id_museo || null;
      actualizarBadges();
    } catch (e) {
      alert("Error cargando museos");
    }
  }

  function getMuseoNombreById(id) {
    const museo = museos.find(m => m.id_museo == id);
    return museo ? museo.nombre : "";
  }

  function actualizarBadges() {
    const nombre = getMuseoNombreById(museoSeleccionado);
    if (artworksMuseumBadge) artworksMuseumBadge.textContent = nombre;
    if (collectionsMuseumBadge) collectionsMuseumBadge.textContent = nombre;
  }

  museumSelect.addEventListener("change", e => {
    museoSeleccionado = Number(e.target.value);
    actualizarBadges();
    limpiarItinerarios();
  });

  itineraryTypeOptions.forEach(opt => {
    opt.addEventListener("click", () => {
      itineraryTypeOptions.forEach(o => o.classList.remove("selected"));
      opt.classList.add("selected");
      tipoItinerario = opt.dataset.type;
      mostrarItinerario();
      limpiarItinerarios();
    });
  });

  function mostrarItinerario() {
    if (tipoItinerario === "artworks") {
      artworksItinerary.style.display = "block";
      collectionsItinerary.style.display = "none";
    } else {
      artworksItinerary.style.display = "none";
      collectionsItinerary.style.display = "block";
    }
  }

  function limpiarItinerarios() {
    artworksList.innerHTML = "";
    collectionsList.innerHTML = "";
  }

  generateBtn.addEventListener("click", async () => {
    if (!museoSeleccionado) {
      alert("Seleccione un museo");
      return;
    }
    limpiarItinerarios();
    actualizarBadges();

    // Mostrar solo la sección correspondiente al tipo de itinerario
    if (tipoItinerario === "artworks") {
      artworksItinerary.style.display = "block";
      collectionsItinerary.style.display = "none";
      await cargarItinerarioObras();
    } else {
      artworksItinerary.style.display = "none";
      collectionsItinerary.style.display = "block";
      await cargarItinerarioColecciones();
    }
  });

  // Elimina los botones de imprimir y deja solo el de PDF
  if (printArtworksBtn) printArtworksBtn.style.display = "none";
  if (printCollectionsBtn) printCollectionsBtn.style.display = "none";

  // PDF para Obras Destacadas
  if (pdfArtworksBtn) {
    pdfArtworksBtn.addEventListener("click", async function () {
      const panel = document.getElementById("artworksItinerary");
      if (!panel || panel.style.display === "none") return;
      // Oculta el botón PDF antes de capturar
      pdfArtworksBtn.classList.add("oculto-para-pdf");
      await new Promise((r) => setTimeout(r, 200));

      const fecha = new Date();
      const fechaStr = fecha.toLocaleDateString("es-ES");
      const horaStr = fecha.toLocaleTimeString("es-ES", { hour: "2-digit", minute: "2-digit" });

      html2canvas(panel, { scale: 2 }).then((canvas) => {
        pdfArtworksBtn.classList.remove("oculto-para-pdf");
        const pdf = new window.jspdf.jsPDF({
          orientation: "landscape",
          unit: "pt",
          format: [576, 430],
        });
        const pageWidth = pdf.internal.pageSize.getWidth();
        const pageHeight = pdf.internal.pageSize.getHeight();
        const headerHeight = 60;
        const marginX = 40;
        const marginY = 20;
        const colorMostaza = "#D4AF37";
        const colorAzulOscuro = "#002F5F";
        const colorTexto = "#333333";
        const colorBeigeClaro = "#FAF9F0";
        const imgWidth = pageWidth - marginX * 2;
        const imgHeight = (canvas.height * imgWidth) / canvas.width;
        const usableHeight = pageHeight - headerHeight - marginY * 2;
        const usableHeightOther = pageHeight - marginY * 2;
        const totalPages = Math.ceil(imgHeight / usableHeight);

        for (let page = 0; page < totalPages; page++) {
          if (page > 0) pdf.addPage();
          let offsetY, sourceY, sourceHeight, pageImgHeight;
          if (page === 0) {
            pdf.setFillColor(colorBeigeClaro);
            pdf.rect(0, 0, pageWidth, headerHeight, "F");
            pdf.setFont("helvetica", "bold");
            pdf.setFontSize(13);
            pdf.setTextColor(colorAzulOscuro);
            pdf.text("Itinerario de Obras Destacadas", marginX, marginY + 8);
            pdf.setFont("helvetica", "normal");
            pdf.setFontSize(8);
            pdf.setTextColor(colorTexto);
            pdf.text("Generación de reporte por grupo especializado: grupo 4", marginX, marginY + 20);
            pdf.text(`Fecha de generación: ${fechaStr} ${horaStr}`, pageWidth - marginX, marginY + 20, { align: "right" });
            pdf.setDrawColor(colorMostaza);
            pdf.setLineWidth(2);
            pdf.line(marginX, marginY + 30, pageWidth - marginX, marginY + 30);
            offsetY = headerHeight + marginY - 20;
            sourceY = 0;
            sourceHeight = Math.floor(Math.min(usableHeight * (canvas.height / imgHeight), canvas.height));
            pageImgHeight = (sourceHeight * imgWidth) / canvas.width;
          } else {
            offsetY = marginY - 5;
            sourceY = Math.floor(usableHeight * (canvas.height / imgHeight) + (page - 1) * usableHeightOther * (canvas.height / imgHeight));
            sourceHeight = Math.floor(Math.min(usableHeightOther * (canvas.height / imgHeight), canvas.height - sourceY));
            pageImgHeight = (sourceHeight * imgWidth) / canvas.width;
          }
          const pageCanvas = document.createElement("canvas");
          pageCanvas.width = canvas.width;
          pageCanvas.height = sourceHeight;
          const ctx = pageCanvas.getContext("2d");
          ctx.drawImage(canvas, 0, sourceY, canvas.width, sourceHeight, 0, 0, canvas.width, sourceHeight);
          const pageImgData = pageCanvas.toDataURL("image/png");
          pdf.addImage(pageImgData, "PNG", marginX, offsetY, imgWidth, pageImgHeight);
        }
        pdf.save("itinerario_obras_destacadas.pdf");
      });
    });
  }

  // PDF para Colecciones
  if (pdfCollectionsBtn) {
    pdfCollectionsBtn.addEventListener("click", async function () {
      const panel = document.getElementById("collectionsItinerary");
      if (!panel || panel.style.display === "none") return;
      pdfCollectionsBtn.classList.add("oculto-para-pdf");
      await new Promise((r) => setTimeout(r, 200));

      const fecha = new Date();
      const fechaStr = fecha.toLocaleDateString("es-ES");
      const horaStr = fecha.toLocaleTimeString("es-ES", { hour: "2-digit", minute: "2-digit" });

      html2canvas(panel, { scale: 2 }).then((canvas) => {
        pdfCollectionsBtn.classList.remove("oculto-para-pdf");
        const pdf = new window.jspdf.jsPDF({
          orientation: "landscape",
          unit: "pt",
          format: [576, 430],
        });
        const pageWidth = pdf.internal.pageSize.getWidth();
        const pageHeight = pdf.internal.pageSize.getHeight();
        const headerHeight = 60;
        const marginX = 40;
        const marginY = 20;
        const colorMostaza = "#D4AF37";
        const colorAzulOscuro = "#002F5F";
        const colorTexto = "#333333";
        const colorBeigeClaro = "#FAF9F0";
        const imgWidth = pageWidth - marginX * 2;
        const imgHeight = (canvas.height * imgWidth) / canvas.width;
        const usableHeight = pageHeight - headerHeight - marginY * 2;
        const usableHeightOther = pageHeight - marginY * 2;
        const totalPages = Math.ceil(imgHeight / usableHeight);

        for (let page = 0; page < totalPages; page++) {
          if (page > 0) pdf.addPage();
          let offsetY, sourceY, sourceHeight, pageImgHeight;
          if (page === 0) {
            pdf.setFillColor(colorBeigeClaro);
            pdf.rect(0, 0, pageWidth, headerHeight, "F");
            pdf.setFont("helvetica", "bold");
            pdf.setFontSize(13);
            pdf.setTextColor(colorAzulOscuro);
            pdf.text("Itinerario de Colecciones", marginX, marginY + 8);
            pdf.setFont("helvetica", "normal");
            pdf.setFontSize(8);
            pdf.setTextColor(colorTexto);
            pdf.text("Generación de reporte por grupo especializado: grupo 4", marginX, marginY + 20);
            pdf.text(`Fecha de generación: ${fechaStr} ${horaStr}`, pageWidth - marginX, marginY + 20, { align: "right" });
            pdf.setDrawColor(colorMostaza);
            pdf.setLineWidth(2);
            pdf.line(marginX, marginY + 30, pageWidth - marginX, marginY + 30);
            offsetY = headerHeight + marginY - 20;
            sourceY = 0;
            sourceHeight = Math.floor(Math.min(usableHeight * (canvas.height / imgHeight), canvas.height));
            pageImgHeight = (sourceHeight * imgWidth) / canvas.width;
          } else {
            offsetY = marginY - 5;
            sourceY = Math.floor(usableHeight * (canvas.height / imgHeight) + (page - 1) * usableHeightOther * (canvas.height / imgHeight));
            sourceHeight = Math.floor(Math.min(usableHeightOther * (canvas.height / imgHeight), canvas.height - sourceY));
            pageImgHeight = (sourceHeight * imgWidth) / canvas.width;
          }
          const pageCanvas = document.createElement("canvas");
          pageCanvas.width = canvas.width;
          pageCanvas.height = sourceHeight;
          const ctx = pageCanvas.getContext("2d");
          ctx.drawImage(canvas, 0, sourceY, canvas.width, sourceHeight, 0, 0, canvas.width, sourceHeight);
          const pageImgData = pageCanvas.toDataURL("image/png");
          pdf.addImage(pageImgData, "PNG", marginX, offsetY, imgWidth, pageImgHeight);
        }
        pdf.save("itinerario_colecciones.pdf");
      });
    });
  }

  // Cargar y renderizar itinerario de obras destacadas
  async function cargarItinerarioObras() {
    try {
      const res = await fetch(`/itinerario/obras-destacadas?id_museo=${museoSeleccionado}`);
      const obras = await res.json();
      if (!Array.isArray(obras) || obras.length === 0) {
        artworksList.innerHTML = `<div style="padding:1em;">No hay obras destacadas para este museo.</div>`;
        return;
      }
      obras.sort((a, b) => a.orden_recomendado - b.orden_recomendado);
      artworksList.innerHTML = obras.map((obra, idx) => renderObraStop(obra, idx + 1)).join("");
    } catch (e) {
      artworksList.innerHTML = `<div style="padding:1em;color:red;">Error cargando obras destacadas.</div>`;
    }
  }

  function renderObraStop(obra, numero) {
    const icono = obra.tipo_obra === "Escultura"
      ? `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 12c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0-5c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 10c-2.33 0-7 1.17-7 3.5V19h14v-1.5c0-2.33-4.67-3.5-7-3.5zm0-2c2.76 0 8 1.31 8 4v3H4v-3c0-2.69 5.24-4 8-4z"></path></svg>`
      : `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M20 4v12H4V4h16m0-2H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2z"></path><path d="M8.5 11.5l2.5 3 3.5-4.5 4.5 6H5z"></path></svg>`;
    const badge = obra.tipo_obra === "Escultura"
      ? `<div class="artwork-type-badge badge-sculpture">Escultura</div>`
      : `<div class="artwork-type-badge badge-painting">Pintura</div>`;
    return `
      <div class="artwork-stop">
        <div class="stop-marker">${numero}</div>
        <div class="artwork-card">
          <div class="artwork-header">
            <h3 class="artwork-title">${capitalizar(obra.nombre_obra)}</h3>
            <div class="artwork-artist">por ${capitalizar(obra.artistas || "Desconocido")}</div>
            <div class="artwork-type-icon">${icono}</div>
          </div>
          <div class="artwork-details">
            <div class="location-info">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"></path></svg>
              <span class="location-text">${capitalizar(obra.sala)}</span>
            </div>
            <div class="location-info">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M3 13h8V3H3v10zm0 8h8v-6H3v6zm10 0h8V11h-8v10zm0-18v6h8V3h-8z"></path></svg>
              <span class="location-text">${capitalizar(obra.piso)}</span>
            </div>
            <div class="location-info">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M12 7V3H2v18h20V7H12zM6 19H4v-2h2v2zm0-4H4v-2h2v2zm0-4H4V9h2v2zm0-4H4V5h2v2zm4 12H8v-2h2v2zm0-4H8v-2h2v2zm0-4H8V9h2v2zm0-4H8V5h2v2zm10 12h-8v-2h2v-2h-2v-2h2v-2h-2V9h8v10zm-2-8h-2v2h2v-2zm0 4h-2v2h2v-2z"></path></svg>
              <span class="location-text">${capitalizar(obra.edificio)}</span>
            </div>
            ${badge}
          </div>
        </div>
      </div>
    `;
  }

  // Cargar y renderizar itinerario de colecciones (con diseño de plantilla)
  async function cargarItinerarioColecciones() {
    try {
      const res = await fetch(`/itinerario/colecciones?id_museo=${museoSeleccionado}`);
      const colecciones = await res.json();
      if (!Array.isArray(colecciones) || colecciones.length === 0) {
        collectionsList.innerHTML = `<div style="padding:1em;">No hay colecciones para este museo.</div>`;
        return;
      }
      // Agrupar por colección y ordenar
      const agrupadas = {};
      colecciones.forEach(item => {
        const key = `${item.orden_coleccion}||${item.nombre_coleccion}`;
        if (!agrupadas[key]) agrupadas[key] = [];
        agrupadas[key].push(item);
      });
      // Ordenar colecciones por orden_coleccion
      const ordenColecciones = Object.keys(agrupadas)
        .map(k => ({
          key: k,
          orden: agrupadas[k][0].orden_coleccion,
          nombre: agrupadas[k][0].nombre_coleccion
        }))
        .sort((a, b) => a.orden - b.orden);

      // Renderizar cada colección como .collection-node
      collectionsList.innerHTML = ordenColecciones.map((col, idx) => {
        const salas = agrupadas[col.key].sort((a, b) => a.orden_sala - b.orden_sala);
        return renderCollectionNode(col.nombre, salas, idx + 1);
      }).join("");
    } catch (e) {
      collectionsList.innerHTML = `<div style="padding:1em;color:red;">Error cargando colecciones.</div>`;
    }
  }

  // Renderiza una colección con el diseño de la plantilla
  function renderCollectionNode(nombreColeccion, salas, numero) {
    return `
      <div class="collection-node">
        <div class="collection-marker">${numero}</div>
        <div class="collection-card">
          <div class="collection-header">
            <h3 class="collection-title">${capitalizar(nombreColeccion)}</h3>
          </div>
          <div class="room-list">
            <div class="room-grid">
              ${salas.map(sala => `
                <div class="room-card">
                  <div class="room-name">${capitalizar(sala.nombre_sala)}</div>
                  <div class="room-location">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                      <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/>
                    </svg>
                    ${capitalizar(sala.nombre_piso)}, ${capitalizar(sala.nombre_edificio)}
                  </div>
                </div>
              `).join("")}
            </div>
          </div>
        </div>
      </div>
    `;
  }

  // OCULTA AMBAS SECCIONES AL INICIAR
  artworksItinerary.style.display = "none";
  collectionsItinerary.style.display = "none";

  // Inicializar
  cargarMuseos();
 // mostrarItinerario();
});