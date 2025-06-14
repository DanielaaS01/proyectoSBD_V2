let museosFundacion = {};

// Llenar museos dinámicamente
document.addEventListener('DOMContentLoaded', async () => {
  const select = document.getElementById('id_museo');
  try {
    const res = await fetch('/museos');
    const museos = await res.json();
    museos.forEach(m => {
      const option = document.createElement('option');
      option.value = m.id_museo;
      option.textContent = m.nombre;
      select.appendChild(option);
      // Guardar año de fundación (extraer año de fecha_fundacion)
      if (m.fecha_fundacion) {
        museosFundacion[m.id_museo] = new Date(m.fecha_fundacion).getFullYear();
      }
    });
  } catch (err) {
    alert('No se pudieron cargar los museos');
  }
});

// Cambiar el año mínimo cuando se seleccione un museo
document.getElementById('id_museo').addEventListener('change', function () {
  const anioInput = document.getElementById('anio');
  const idMuseo = this.value;
  if (museosFundacion[idMuseo]) {
    anioInput.min = museosFundacion[idMuseo];
    // Opcional: limpiar el valor si es menor al nuevo mínimo
    if (anioInput.value && anioInput.value < museosFundacion[idMuseo]) {
      anioInput.value = '';
    }
  } else {
    anioInput.min = 1800; // valor por defecto
  }
});

// Enviar formulario
document.getElementById('form-resumen-historico').addEventListener('submit', async (e) => {
  e.preventDefault();
  const id_museo = document.getElementById('id_museo').value;
  const anio = document.getElementById('anio').value;
  const hechos = document.getElementById('hechos').value;
  const mensaje = document.getElementById('mensaje');
  try {
    const res = await fetch('/registrar-resumen-historico', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ id_museo, anio, hechos })
    });
    const result = await res.json();
    if (res.ok) {
      mensaje.textContent = result.mensaje || 'Resumen registrado';
      mensaje.style.color = 'green';
      e.target.reset();
    } else {
      mensaje.textContent = result.error || 'Error al registrar';
      mensaje.style.color = 'red';
    }
  } catch (err) {
    mensaje.textContent = 'Error de red';
    mensaje.style.color = 'red';
  }
});