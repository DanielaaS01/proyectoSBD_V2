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
    });
  } catch (err) {
    alert('No se pudieron cargar los museos');
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