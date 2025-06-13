// server.js

// 1. Importar módulos
const express = require("express");
const path = require("path");
const bodyParser = require("body-parser");
const pool = require("./db/conexion"); // 👈 Asegúrate de que esta ruta sea correcta

// 2. Crear la aplicación Express
const app = express();
const PORT = 3000;

// 3. Middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, "public")));

// 4. Ruta: Obtener museos
app.get("/museos", async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT * FROM obtener_museos()"
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando museos:", err);
    res.status(500).send("Error al obtener museos");
  }
});

// 5. Ruta: Obtener estructuras por museo
app.get("/estructuras", async (req, res) => {
  const idMuseo = req.query.id_museo;
  if (!idMuseo) return res.status(400).send("Falta el parámetro id_museo");

  try {
    const result = await pool.query(
      "SELECT * FROM obtener_estructuras_org_por_museo($1)",
      [idMuseo]
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando estructuras:", err);
    res.status(500).send("Error al obtener estructuras");
  }
});

// 6. Ruta: Obtener idiomas
app.get("/idiomas", async (req, res) => {
  try {
    const result = await pool.query(
      "SELECT * FROM obtener_idiomas()"
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando idiomas:", err);
    res.status(500).send("Error al obtener idiomas");
  }
});

// 7. Ruta: Registrar empleado profesional
app.post("/registrar-empleado-profesional", async (req, res) => {
  const {
    doc_identidad,
    primer_nombre,
    segundo_nombre,
    primer_apellido,
    segundo_apellido,
    fecha_nac,
    nombre_titulo,
    anio_formacion,
    descripcion_especialidad,
    idiomas,
    nuevos_idiomas = [],
    id_museo,
    id_estructura_org,
    fecha_inicio,
    cargo,
  } = req.body;

  if (
    (!idiomas || idiomas.length === 0) &&
    (!nuevos_idiomas || nuevos_idiomas.length === 0)
  ) {
    return res
      .status(400)
      .json({ error: "Debe seleccionar o ingresar al menos un idioma" });
  }

  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    // 1. Insertar nuevos idiomas si los hay
    let nuevosIdiomasIds = [];
    if (nuevos_idiomas.length > 0) {
      const resultado = await client.query(
        "SELECT insertar_nuevos_idiomas($1::VARCHAR[]) AS ids",
        [nuevos_idiomas]
      );
      nuevosIdiomasIds = resultado.rows[0].ids;
    }

    const todosIdiomas = [...idiomas, ...nuevosIdiomasIds];
    console.log("IDIOMAS A ENVIAR:", todosIdiomas);
    // 2. Llamar al procedimiento almacenado
    await client.query(
      `CALL registrar_empleado_profesional(
        $1, $2, $3, $4, $5, $6,
        $7, $8, $9, $10,
        $11, $12, $13, $14
      )`,
      [
        doc_identidad,
        primer_nombre,
        segundo_nombre,
        primer_apellido,
        segundo_apellido,
        fecha_nac,
        id_museo,
        id_estructura_org,
        fecha_inicio,
        cargo,
        nombre_titulo,
        anio_formacion,
        descripcion_especialidad,
        todosIdiomas,
      ]
    );

    await client.query("COMMIT");
    res.json({ mensaje: "Empleado registrado exitosamente" });
  } catch (err) {
    await client.query("ROLLBACK");
    console.error("Error al registrar empleado:", err.message);
    res.status(500).json({ error: err.message });
  } finally {
    client.release();
  }
});

// 8. Ruta: Registrar empleado de mantenimiento o vigilancia
app.post("/registrar-empleado-mant-vig", async (req, res) => {
  const { nombre, apellido, doc_identidad, tipo } = req.body;

  const client = await pool.connect();

  try {
    await client.query("BEGIN");

    await client.query(
      `
      CALL registrar_empleado_mantenimiento_vigilancia($1, $2, $3, $4)
    `,
      [nombre, apellido, doc_identidad, tipo]
    );

    await client.query("COMMIT");
    res.json({ mensaje: "Empleado registrado exitosamente" });
  } catch (err) {
    await client.query("ROLLBACK");
    console.error(
      "Error al registrar empleado de mantenimiento/vigilancia:",
      err.message
    );
    res.status(500).json({ error: err.message });
  } finally {
    client.release();
  }
});

// 9. Ruta: Obtener estructuras físicas por museo (para asignaciones)
app.get("/estructuras-fisicas", async (req, res) => {
  const idMuseo = req.query.id_museo;
  if (!idMuseo) return res.status(400).send("Falta el parámetro id_museo");

  try {
    const result = await pool.query(
      "SELECT * FROM obtener_estructuras_fisicas_por_museo($1)",
      [idMuseo]
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando estructuras físicas:", err);
    res.status(500).send("Error al obtener estructuras físicas");
  }
});

// 10. Ruta: Obtener empleados por tipo (mantenimiento o vigilancia)
app.get("/empleados-mant-vig", async (req, res) => {
  const tipoRaw = req.query.tipo?.toLowerCase();

  let tipoCodigo;
  if (tipoRaw === "mantenimiento") tipoCodigo = "M";
  else if (tipoRaw === "vigilancia") tipoCodigo = "V";
  else return res.status(400).json({ error: "Tipo inválido" });

  try {
    const result = await pool.query(
      "SELECT * FROM obtener_empleados_mant_vig_por_tipo($1)",
      [tipoCodigo]
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando empleados:", err);
    res.status(500).json({ error: "Error al obtener empleados" });
  }
});


// 11. Ruta: Insertar asignación mensual
app.post("/asignar-empleado", async (req, res) => {
  const { id_museo, id_estructura_fis, id_mant_vig, fecha, turno } = req.body;

  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    await client.query(`CALL asignar_empleado($1, $2, $3, $4, $5)`, [
      id_mant_vig,
      id_museo,
      id_estructura_fis,
      fecha,
      turno,
    ]);

    await client.query("COMMIT");
    res.json({ mensaje: "Asignación realizada con éxito" });
  } catch (err) {
    await client.query("ROLLBACK");
    console.error("Error al asignar empleado:", err.message);
    res.status(500).json({ error: err.message });
  } finally {
    client.release();
  }
});

// 12. Ruta: Obtener asignaciones activas por empleado
app.get("/asignaciones-empleado", async (req, res) => {
  const idMantVig = parseInt(req.query.id_mant_vig);

  if (isNaN(idMantVig)) {
    return res.status(400).json({ error: "ID inválido" });
  }

  try {
    const result = await pool.query(
      "SELECT * FROM obtener_asignaciones_empleado($1)",
      [idMantVig]
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error al consultar asignaciones del empleado:", err.message);
    res.status(500).json({ error: "Error al obtener asignaciones" });
  }
});

// 13. Ruta: Registrar resumen histórico
app.post("/registrar-resumen-historico", async (req, res) => {
  console.log("Datos recibidos:", req.body); // <-- Agrega esto
  const { id_museo, anio, hechos } = req.body;
  const client = await pool.connect();
  try {
    await client.query(
      "INSERT INTO resumenes_historicos (id_museo, anio, hechos) VALUES ($1, $2, $3)",
      [id_museo, anio, hechos]
    );
    res.json({ mensaje: "Resumen histórico registrado exitosamente" });
  } catch (err) {
    console.error("Error al registrar resumen histórico:", err.message);
    res.status(500).json({ error: "Error al registrar resumen histórico" });
  } finally {
    client.release();
  }
});

//  Iniciar servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en: http://localhost:${PORT}`);
});
