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

// Insertar Pintura
// Insertar Pintura + vincular al artista existente o nuevo
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
    // En tu payload cliente: o bien envías id_artista, o bien un objeto `artistaNew`
    id_artista,
    artistaNew,
  } = req.body;

  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    // 1) Si viene artistaNew, lo insertamos y recuperamos su id
    let aid = id_artista;
    if (!aid && artistaNew) {
      const artRes = await client.query(
        `INSERT INTO ARTISTAS(
            caract_est_tec, nombre, apellido,
            nombre_artistico, fecha_nac, fecha_def
         ) VALUES($1,$2,$3,$4,$5,$6)
         RETURNING id_artista`,
        [
          artistaNew.caract_est_tec,
          artistaNew.nombre,
          artistaNew.apellido,
          artistaNew.nombre_artistico,
          artistaNew.fecha_nac,
          artistaNew.fecha_def,
        ]
      );
      aid = artRes.rows[0].id_artista;
    }

    // 2) Insertar la obra y recuperar su id_obra
    //    Aquí uso INSERT directo en lugar de CALL para poder RETURNING
    const obraRes = await client.query(
      `INSERT INTO OBRAS(
          nombre, dimension, tipo,
          estilos, caract_mat_tec,
          id_sala, id_estructura_fis,
          id_museo, periodo
        ) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9)
        RETURNING id_obra`,
      [
        nombre,
        dimension,
        "P", // 'P' para pintura
        estilos,
        caract_mat_tec,
        id_sala,
        id_estructura_fis,
        id_museo,
        periodo,
      ]
    );
    const oid = obraRes.rows[0].id_obra;

    // 3) Vincular en la tabla puente
    await client.query(
      `INSERT INTO OBRAS_ARTISTAS(id_obra, id_artista)
         VALUES($1,$2)`,
      [oid, aid]
    );

    await client.query("COMMIT");
    res.json({
      mensaje: "Pintura registrada y vinculada al artista exitosamente",
      id_obra: oid,
      id_artista: aid,
    });
  } catch (err) {
    await client.query("ROLLBACK");
    console.error("Error insertando pintura+artista:", err);
    res.status(500).json({ error: err.message });
  } finally {
    client.release();
  }
});

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

  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    let aid = id_artista;
    if (!aid && artistaNew) {
      const artRes = await client.query(
        `INSERT INTO ARTISTAS(
            caract_est_tec, nombre, apellido,
            nombre_artistico, fecha_nac, fecha_def
         ) VALUES($1,$2,$3,$4,$5,$6)
         RETURNING id_artista`,
        [
          artistaNew.caract_est_tec,
          artistaNew.nombre,
          artistaNew.apellido,
          artistaNew.nombre_artistico,
          artistaNew.fecha_nac,
          artistaNew.fecha_def,
        ]
      );
      aid = artRes.rows[0].id_artista;
    }

    const obraRes = await client.query(
      `INSERT INTO OBRAS(
          nombre, dimension, tipo,
          estilos, caract_mat_tec,
          id_sala, id_estructura_fis,
          id_museo, periodo
        ) VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9)
        RETURNING id_obra`,
      [
        nombre,
        dimension,
        "E", // 'E' para escultura
        estilos,
        caract_mat_tec,
        id_sala,
        id_estructura_fis,
        id_museo,
        periodo,
      ]
    );
    const oid = obraRes.rows[0].id_obra;

    await client.query(
      `INSERT INTO OBRAS_ARTISTAS(id_obra, id_artista)
         VALUES($1,$2)`,
      [oid, aid]
    );

    await client.query("COMMIT");
    res.json({
      mensaje: "Escultura registrada y vinculada al artista exitosamente",
      id_obra: oid,
      id_artista: aid,
    });
  } catch (err) {
    await client.query("ROLLBACK");
    console.error("Error insertando escultura+artista:", err);
    res.status(500).json({ error: err.message });
  } finally {
    client.release();
  }
});

//  Iniciar servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en: http://localhost:${PORT}`);
});
