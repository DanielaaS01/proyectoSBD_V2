console.log("reporte_artista.js CARGADO");

function formateaFecha(fecha) {
  if (!fecha) return "-";
  // Si ya es tipo Date o tiene solo la fecha
  if (typeof fecha === "string" && fecha.length >= 10) {
    return fecha.substring(0, 10);
  }
  return fecha;
}

// Cuando el DOM esté listo, carga los artistas
window.addEventListener("DOMContentLoaded", () => {
  console.log("DOM listo, ejecutando cargarArtistas");
  cargarArtistas();
});

// Función para cargar artistas en el select
async function cargarArtistas() {
  console.log("Entrando a cargarArtistas");
  const select = document.getElementById("artistaSelect");
  select.innerHTML = '<option value="">Seleccione un artista...</option>';
  try {
    const res = await fetch("/artistas");
    console.log("Fetch hecho a /artistas, status:", res.status);
    const artistas = await res.json();
    console.log("Respuesta de /artistas:", artistas);

    artistas.forEach((a) => {
      // Armado seguro del nombre mostrado:
      let nombreMostrado = "";
      if (a.nombre_artistico) {
        nombreMostrado = a.nombre_artistico;
        // Si hay nombre o apellido, agrégalos entre paréntesis
        if (a.nombre || a.apellido) {
          nombreMostrado += " (";
          if (a.nombre) nombreMostrado += a.nombre;
          if (a.nombre && a.apellido) nombreMostrado += " ";
          if (a.apellido) nombreMostrado += a.apellido;
          nombreMostrado += ")";
        }
      } else {
        // Si no hay nombre artístico, solo nombre y apellido si existen
        if (a.nombre && a.apellido)
          nombreMostrado = `${a.nombre} ${a.apellido}`;
        else if (a.nombre) nombreMostrado = a.nombre;
        else if (a.apellido) nombreMostrado = a.apellido;
        else nombreMostrado = "Sin nombre";
      }
      const opt = document.createElement("option");
      opt.value = a.id_artista;
      opt.textContent = nombreMostrado;
      select.appendChild(opt);
    });

    console.log("Opciones agregadas al select:", select.options.length);
  } catch (e) {
    alert("Error al cargar artistas: " + e);
  }
}

// Evento al seleccionar un artista
document
  .getElementById("artistaSelect")
  .addEventListener("change", async function () {
    const id_artista = this.value;
    if (!id_artista) {
      document.getElementById("artistaDetail").style.display = "none";
      document.getElementById("noArtistaSelected").style.display = "flex";
      document.getElementById("obrasArtistaList").innerHTML = "";
      document.getElementById("obrasCount").textContent = "Mostrando 0 obras";
      return;
    }
    await mostrarFichaArtista(id_artista);
  });

// Función para mostrar la ficha del artista seleccionado
async function mostrarFichaArtista(id_artista) {
  try {
    const res = await fetch(
      `/ficha-artista?id_artista=${encodeURIComponent(id_artista)}`
    );
    const data = await res.json();
    if (!data || data.length === 0) {
      mostrarNotificacion("No se encontró información del artista", "error");
      return;
    }

    // Mostrar la ficha
    document.getElementById("noArtistaSelected").style.display = "none";
    document.getElementById("artistaDetail").style.display = "block";

    const row = data[0];
    document.getElementById("artistaNombre").textContent =
      row.nombre_artistico || row.nombre_completo || "-";
    document.getElementById("nombreCompleto").textContent =
      row.nombre_completo || "-";
    document.getElementById("nombreArtistico").textContent =
      row.nombre_artistico || "-";
    document.getElementById("fechaNacimiento").textContent = formateaFecha(
      row.fecha_nac
    );
    document.getElementById("fechaDefuncion").textContent = formateaFecha(
      row.fecha_def
    );
    document.getElementById("estilosArtista").textContent =
      row.caract_est_tec || "-";
    document.getElementById("tecnicasArtista").textContent =
      row.caract_est_tec || "-";

    // Listar obras
    const lista = document.getElementById("listaObrasMuseos");
    lista.innerHTML = "";
    let count = 0;
    data.forEach((obra) => {
      if (obra.obra) {
        count++;
        lista.innerHTML += `
                  <div>
                    <b>${
                      obra.obra
                    }</b> <span style="color:#888;font-size:0.95em">(${
          obra.tipo_obra
        })</span>
                    <br><span style="font-size:0.93em">Museo: ${
                      obra.museo_exhibicion || "-"
                    }</span>
                  </div>
                  <hr style="margin:6px 0;">
                `;
      }
    });
    if (count === 0) {
      lista.innerHTML = "<em>No tiene obras registradas</em>";
    }
    document.getElementById("obrasArtistaList").innerHTML = lista.innerHTML;
    document.getElementById(
      "obrasCount"
    ).textContent = `Mostrando ${count} obras`;
  } catch (e) {
    mostrarNotificacion("Error al consultar ficha del artista", "error");
  }
}

// Notificación (puedes mejorarla como prefieras)
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
      '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm-5-9h10v2H7z"/>';
  }
  notificationMessage.textContent = mensaje;
  setTimeout(() => {
    notification.classList.remove("show");
  }, 4000);
}
