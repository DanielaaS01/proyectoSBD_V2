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
    const result = await pool.query("SELECT * FROM obtener_museos()");
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando museos:", err);
    res.status(500).send("Error al obtener museos");
  }
});

// 5. Ruta: Obtener estructuras organizacional por museo
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
    const result = await pool.query("SELECT * FROM obtener_idiomas()");
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

// Ruta: Obtener salas de exposición
app.get("/salas", async (req, res) => {
  const { id_museo, id_estructura_fis } = req.query;
  if (!id_museo || !id_estructura_fis) {
    return res
      .status(400)
      .json({ error: "Faltan id_museo o id_estructura_fis en la petición" });
  }
  try {
    const result = await pool.query(
      `SELECT id_sala, nombre
         FROM SALAS_EXP
        WHERE id_museo = $1
          AND id_estructura_fis = $2
     ORDER BY id_sala`,
      [id_museo, id_estructura_fis]
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando salas:", err);
    res.status(500).json({ error: "Error al obtener salas" });
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

// 13. Ruta: Registrar resumen histórico del museo
app.post("/registrar-resumen-historico", async (req, res) => {
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

// 14. Ruta: Listar obras usando SOLO la función almacenada
app.get("/obras", async (req, res) => {
  const museo = req.query.museo ? parseInt(req.query.museo, 10) : null;
  const tipo = req.query.tipo || null;
  try {
    const result = await pool.query("SELECT * FROM obtener_obras($1, $2)", [
      museo,
      tipo,
    ]);
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando obras:", err);
    res.status(500).json({ error: "Error al obtener obras" });
  }
});

// 15. Ruta: Detalle de obra usando SOLO la función almacenada
app.get("/obras/:id", async (req, res) => {
  const idObra = parseInt(req.params.id, 10);
  if (isNaN(idObra)) {
    return res.status(400).json({ error: "ID de obra inválido" });
  }
  try {
    const result = await pool.query("SELECT * FROM obtener_detalle_obra($1)", [
      idObra,
    ]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Obra no encontrada" });
    }
    res.json(result.rows[0]);
  } catch (err) {
    console.error("Error consultando detalle de obra:", err);
    res.status(500).json({ error: "Error al obtener detalle de obra" });
  }
});

// 16. Ruta: Probar conexión a la base de datos
app.get("/probar-bd", async (req, res) => {
  try {
    const resultado = await pool.query("SELECT NOW()");
    res.send(
      `Conexión exitosa a PostgreSQL. Hora actual: ${resultado.rows[0].now}`
    );
  } catch (error) {
    console.error("Error al conectar a la base de datos:", error);
    res.status(500).send("Error al conectar a la base de datos.");
  }
});

// Obtener artistas
app.get("/artistas", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM obtener_artistas()");
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando artistas:", err);
    res.status(500).send("Error al obtener artistas");
  }
});

// Ficha de artista (consulta por nombre_artistico)
app.get("/ficha-artista", async (req, res) => {
  const id_artista = req.query.id_artista;
  if (!id_artista) return res.status(400).send("Falta el parámetro id_artista");
  try {
    const result = await pool.query("SELECT * FROM ficha_artista($1)", [
      id_artista,
    ]);
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando ficha artista:", err);
    res.status(500).send("Error al obtener ficha del artista");
  }
});

// Obtener colecciones por museo
app.get("/colecciones", async (req, res) => {
  const museoId = req.query.museoId;
  if (!museoId) {
    return res.status(400).json({ error: "Falta el parámetro museoId" });
  }
  try {
    const result = await pool.query(
      `SELECT * FROM obtener_colecciones_por_museo($1)`,
      [museoId]
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando colecciones:", err.message);
    res.status(500).json({ error: "Error al obtener colecciones" });
  }
});

// Obtener empleados profesionales (responsables)
app.get("/empleados_profesionales", async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT * FROM obtener_empleados_profesionales()`,
      []
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando empleados profesionales:", err.message);
    res.status(500).json({ error: "Error al obtener empleados profesionales" });
  }
});

//Insertar Pintura y vincular artista (existente o nuevo)
app.post("/pintura", async (req, res) => {
  const {
    nombre,
    dimension,
    estilos,
    caract_mat_tec,
    periodo,
    id_museo,
    id_estructura_fis,
    id_sala,
    id_artista,
    artistaNew,
  } = req.body;

  // Preparamos los parámetros para la función SQL
  const params = [
    nombre,
    dimension,
    estilos,
    caract_mat_tec,
    periodo,
    id_museo,
    id_estructura_fis,
    id_sala,
    id_artista || null,
    artistaNew?.nombre || null,
    artistaNew?.apellido || null,
    artistaNew?.nombre_artistico || null,
    artistaNew?.fecha_nac || null,
    artistaNew?.fecha_def || null,
    artistaNew?.caract_est_tec || null,
  ];

  try {
    // Llamada al procedimiento en PostgreSQL
    const { rows } = await pool.query(
      `SELECT * FROM insertar_pintura_con_artista(
         $1,  $2,  $3,  $4,  $5,
         $6,  $7,  $8,  $9, $10,
        $11, $12, $13, $14, $15
       )`,
      params
    );

    const result = rows[0]; // { id_obra, id_artista }
    res.json({
      mensaje: "Pintura registrada y vinculada exitosamente",
      id_obra: result.id_obra,
      id_artista: result.id_artista,
    });
  } catch (err) {
    console.error("Error al insertar pintura:", err);
    res.status(500).json({ error: err.message });
  }
});

//Insertar Escultura y vincular artista (existente o nuevo)
app.post("/escultura", async (req, res) => {
  const {
    nombre,
    dimension,
    estilos,
    caract_mat_tec,
    periodo,
    id_museo,
    id_estructura_fis,
    id_sala,
    id_artista,
    artistaNew,
  } = req.body;

  // Preparamos los parámetros para la función SQL
  const params = [
    nombre,
    dimension,
    estilos,
    caract_mat_tec,
    periodo,
    id_museo,
    id_estructura_fis,
    id_sala,
    id_artista || null,
    artistaNew?.nombre || null,
    artistaNew?.apellido || null,
    artistaNew?.nombre_artistico || null,
    artistaNew?.fecha_nac || null,
    artistaNew?.fecha_def || null,
    artistaNew?.caract_est_tec || null,
  ];

  try {
    // Llamada al procedimiento en PostgreSQL
    const { rows } = await pool.query(
      `SELECT * FROM insertar_escultura_con_artista(
         $1,  $2,  $3,  $4,  $5,
         $6,  $7,  $8,  $9, $10,
        $11, $12, $13, $14, $15
       )`,
      params
    );

    const result = rows[0]; // { id_obra, id_artista }
    res.json({
      mensaje: "Escultura registrada y vinculada exitosamente",
      id_obra: result.id_obra,
      id_artista: result.id_artista,
    });
  } catch (err) {
    console.error("Error al insertar escultura:", err);
    res.status(500).json({ error: err.message });
  }
});

//insertar resumen historico del museo
app.post("/registrar-resumen-historico", async (req, res) => {
  const { id_museo, anio, hechos } = req.body;
  try {
    await db.none("CALL registrar_resumen_historico_museo($1, $2, $3)", [
      id_museo,
      anio,
      hechos,
    ]);
    res.json({ mensaje: "Resumen registrado correctamente" });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// ...existing code...

// Ruta: Obtener registros de movilidad de una obra
app.get("/obras/:id/movilidad", async (req, res) => {
  const idObra = parseInt(req.params.id, 10);
  if (isNaN(idObra)) {
    return res.status(400).json({ error: "ID de obra inválido" });
  }
  try {
    const result = await pool.query(
      "SELECT * FROM obtener_movilidad_obra($1)",
      [idObra]
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando movilidad de la obra:", err);
    res.status(500).json({ error: "Error al obtener registros de movilidad" });
  }
});
// ...existing code...

// ...existing code...

// Ruta: Itinerario de obras destacadas por museo
app.get("/itinerario/obras-destacadas", async (req, res) => {
  const idMuseo = parseInt(req.query.id_museo, 10);
  if (isNaN(idMuseo)) {
    return res.status(400).json({ error: "Parámetro id_museo inválido" });
  }
  try {
    const result = await pool.query(
      "SELECT * FROM generar_itinerario_obras_destacadas($1)",
      [idMuseo]
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando itinerario de obras destacadas:", err);
    res.status(500).json({ error: "Error al obtener itinerario de obras destacadas" });
  }
});

// Ruta: Itinerario de colecciones por museo
app.get("/itinerario/colecciones", async (req, res) => {
  const idMuseo = parseInt(req.query.id_museo, 10);
  if (isNaN(idMuseo)) {
    return res.status(400).json({ error: "Parámetro id_museo inválido" });
  }
  try {
    const result = await pool.query(
      "SELECT * FROM generar_itinerario_colecciones($1)",
      [idMuseo]
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error consultando itinerario de colecciones:", err);
    res.status(500).json({ error: "Error al obtener itinerario de colecciones" });
  }
});

// ...existing code...

//  Iniciar servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en: http://localhost:${PORT}`);
});
