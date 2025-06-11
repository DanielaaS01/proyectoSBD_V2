const { Pool } = require('pg');

// Configura tus datos de conexión aquí 👇
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'py2',
  password: '1234',
  port: 5432, // Puerto por defecto de PostgreSQL
});

// Exportamos la conexión para usarla en otros archivos
module.exports = pool;