const request = require('supertest');
const app = require('./index');

describe('Health check', () => {
  it('GET /health returns ok', async () => {
    const res = await request(app).get('/health');
    expect(res.statusCode).toBe(200);
    expect(res.body.status).toBe('ok');
  });
});

describe('Todos', () => {
  it('GET /todos returns array', async () => {
    const res = await request(app).get('/todos');
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body.todos)).toBe(true);
  });
});
