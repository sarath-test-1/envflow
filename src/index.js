const express = require('express');
const app = express();

app.use(express.json());

const ENV = process.env.NODE_ENV || 'development';
const DB_HOST = process.env.DB_HOST || 'localhost';

app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    environment: ENV,
    database: DB_HOST,
    timestamp: new Date().toISOString()
  });
});

app.get('/todos', (req, res) => {
  res.json({
    environment: ENV,
    todos: [
      { id: 1, title: 'Learn deployment strategies', done: true },
      { id: 2, title: 'Master multi-environment setup', done: false }
    ]
  });
});

module.exports = app;

if (require.main === module) {
  const PORT = process.env.PORT || 3000;
  app.listen(PORT, () => {
    console.log(`[${ENV}] Server running on port ${PORT}`);
    console.log(`[${ENV}] Database host: ${DB_HOST}`);
  });
}
