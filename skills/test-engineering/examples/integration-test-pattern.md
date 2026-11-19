# Integration Test Patterns (Database & HTTP API)

Examples demonstrating integration tests testing boundary contracts with ephemeral databases and HTTP servers.

---

## TypeScript (Supertest & Fastify / Express)

```typescript
import { describe, it, expect, beforeAll, afterAll, beforeEach } from 'vitest';
import request from 'supertest';
import { createServer } from '../server';
import { db } from '../database';

describe('POST /api/v1/orders (Integration)', () => {
  let app: any;

  beforeAll(async () => {
    app = await createServer();
    await db.migrate.latest();
  });

  afterAll(async () => {
    await db.destroy();
  });

  beforeEach(async () => {
    // Truncate tables between tests for isolation
    await db('orders').truncate();
  });

  it('creates an order and returns 201 Created with persisted record', async () => {
    const payload = {
      productId: 'prod_123',
      quantity: 2,
      currency: 'USD'
    };

    const response = await request(app.callback())
      .post('/api/v1/orders')
      .set('Authorization', 'Bearer valid-test-token')
      .send(payload);

    expect(response.status).toBe(201);
    expect(response.body).toMatchObject({
      id: expect.any(String),
      productId: 'prod_123',
      quantity: 2,
      status: 'PENDING'
    });

    // Verify database side-effect
    const dbRecord = await db('orders').where({ id: response.body.id }).first();
    expect(dbRecord).toBeDefined();
    expect(dbRecord.quantity).toBe(2);
  });
});
```
