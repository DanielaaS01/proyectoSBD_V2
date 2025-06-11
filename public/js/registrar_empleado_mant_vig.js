// public/js/registrar_empleado_mant_vig.js

document.addEventListener('DOMContentLoaded', () => {
  const formulario = document.getElementById('form-mant-vig');

  formulario.addEventListener('submit', async (e) => {
    e.preventDefault();

    const nombre = document.getElementById('nombre').value.trim();
    const apellido = document.getElementById('apellido').value.trim();
    const doc_identidad = document.getElementById('doc_identidad').value.trim();
    const tipo = document.getElementById('tipo').value;

    const datos = {
      nombre,
      apellido,
      doc_identidad,
      tipo
    };

    try {
      const respuesta = await fetch('/registrar-empleado-mant-vig', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(datos)
      });

      const resultado = await respuesta.json();
      const mensajeDiv = document.getElementById('mensaje');
      mensajeDiv.textContent = resultado.mensaje || resultado.error || 'Operación completada.';
      mensajeDiv.style.color = resultado.mensaje ? 'green' : 'red';
    } catch (error) {
      console.error('Error en el registro:', error);
      const mensajeDiv = document.getElementById('mensaje');
      mensajeDiv.textContent = 'Error al registrar el empleado';
      mensajeDiv.style.color = 'red';
    }
  });
});
