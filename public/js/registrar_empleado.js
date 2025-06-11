// registrar_empleado.js

document.addEventListener('DOMContentLoaded', () => {
  cargarMuseos();
  cargarIdiomas();

  const museoSelect = document.getElementById('id_museo');
  museoSelect.addEventListener('change', () => {
    const idMuseo = museoSelect.value;
    if (idMuseo) {
      cargarEstructuras(idMuseo);
      document.getElementById('id_estructura_org').disabled = false;
    } else {
      limpiarSelect('id_estructura_org');
      document.getElementById('id_estructura_org').disabled = true;
    }
  });

  // Botón para agregar nuevos idiomas
  const btnAgregarIdioma = document.getElementById('btn-agregar-idioma');
  if (btnAgregarIdioma) {
    btnAgregarIdioma.addEventListener('click', () => {
      const div = document.createElement('div');
      div.classList.add('nuevo-idioma');

      div.innerHTML = `
        <input type="text" class="nuevo-idioma-input" name="nuevo_idioma[]" placeholder="Nuevo idioma..." required>
      `;

      document.getElementById('nuevos-idiomas').appendChild(div);
    });
  }
});

async function cargarMuseos() {
  try {
    const res = await fetch('/museos');
    const museos = await res.json();
    const select = document.getElementById('id_museo');
    museos.forEach(m => {
      const option = document.createElement('option');
      option.value = m.id_museo;
      option.textContent = m.nombre;
      select.appendChild(option);
    });
  } catch (err) {
    console.error('Error al cargar museos:', err);
    alert('No se pudieron cargar los museos');
  }
}

async function cargarEstructuras(idMuseo) {
  try {
    const res = await fetch(`/estructuras?id_museo=${idMuseo}`);
    const estructuras = await res.json();
    const select = document.getElementById('id_estructura_org');
    limpiarSelect('id_estructura_org');
    estructuras.forEach(e => {
      const option = document.createElement('option');
      option.value = e.id_estructura_org;
      option.textContent = e.nombre;
      select.appendChild(option);
    });
  } catch (err) {
    console.error('Error al cargar estructuras:', err);
    alert('No se pudieron cargar las unidades organizativas');
  }
}

async function cargarIdiomas() {
  try {
    const res = await fetch('/idiomas');
    const idiomas = await res.json();

    const contenedor = document.getElementById('checkbox-idiomas');
    contenedor.innerHTML = '';

    idiomas.forEach(i => {
      const div = document.createElement('div');
      div.className = 'checkbox-idioma';
      div.innerHTML = `
        <input type="checkbox" id="idioma-${i.id_idioma}" name="idiomas[]" value="${i.id_idioma}">
        <label for="idioma-${i.id_idioma}">${i.lengua}</label>
      `;
      contenedor.appendChild(div);
    });
  } catch (err) {
    console.error('Error al cargar idiomas:', err);
    alert('No se pudieron cargar los idiomas');
  }
}

function limpiarSelect(id) {
  const select = document.getElementById(id);
  while (select.options.length > 1) {
    select.remove(1);
  }
}

document.getElementById('form-empleado').addEventListener('submit', async (e) => {
  e.preventDefault();

  const idiomasSeleccionados = Array.from(document.querySelectorAll('input[name="idiomas[]"]:checked')).map(cb => parseInt(cb.value));
  const nuevosIdiomas = Array.from(document.querySelectorAll('.nuevo-idioma-input'))
    .map(input => input.value.trim().toUpperCase())
    .filter(valor => valor !== '');
  
  const data = {
    doc_identidad: document.getElementById('doc_identidad').value,
    primer_nombre: document.getElementById('primer_nombre').value,
    segundo_nombre: document.getElementById('segundo_nombre').value,
    primer_apellido: document.getElementById('primer_apellido').value,
    segundo_apellido: document.getElementById('segundo_apellido').value,
    fecha_nac: document.getElementById('fecha_nac').value,
    nombre_titulo: document.getElementById('nombre_titulo').value,
    anio_formacion: document.getElementById('anio_formacion').value,
    descripcion_especialidad: document.getElementById('descripcion_especialidad').value,
    idiomas: idiomasSeleccionados,
    nuevos_idiomas: nuevosIdiomas,
    id_museo: parseInt(document.getElementById('id_museo').value),
    id_estructura_org: parseInt(document.getElementById('id_estructura_org').value),
    fecha_inicio: document.getElementById('fecha_inicio').value,
    cargo: document.getElementById('cargo').value
  };

  try {
    const response = await fetch('/registrar-empleado-profesional', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    });

    const result = await response.json();
    document.getElementById('mensaje').textContent = result.mensaje || result.error || 'Registro procesado.';
  } catch (err) {
    console.error('Error al registrar:', err);
    document.getElementById('mensaje').textContent = 'Error al registrar el empleado';
  }
});
