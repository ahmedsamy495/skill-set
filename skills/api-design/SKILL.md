---
name: api-design
description: >-
  Production-grade RESTful and API endpoint design guidelines. Standardizes URI structure,
  HTTP verbs and status codes, query pagination, idempotency, error payload schemas (RFC 7807),
  and OpenAPI specification authoring. Activate when designing new API endpoints, writing OpenAPI specs, or refactoring API contracts.
---

# API Design & Contract Standards

This skill provides comprehensive rules for designing intuitive, scalable, backward-compatible, and standardized REST APIs.

## Core Design Principles

1. **Resource-Oriented URIs**: Use plural nouns (`/api/v1/users`, `/api/v1/orders`), never verbs (`/api/v1/getUsers`, `/api/v1/createOrder`).
2. **Standard HTTP Verbs**:
   - `GET`: Safe & idempotent. Read resource(s).
   - `POST`: Non-idempotent. Create a subordinate resource or trigger a process.
   - `PUT`: Idempotent. Replace entire resource state.
   - `PATCH`: Partially update resource fields.
   - `DELETE`: Idempotent. Remove resource.
3. **Consistent Error Format**: All 4xx and 5xx responses must adhere to [RFC 7807 Problem Details](./references/error-handling-standards.md).
4. **Idempotency Keys**: Use `Idempotency-Key` headers for critical mutation endpoints (payments, transfers) to avoid duplicate actions upon network retries.
5. **Schema-First Design**: Define endpoints and data contracts using OpenAPI 3.1 before writing implementation code. See [OpenAPI 3.1 Template](./resources/openapi-template.yaml).

---

## URL & Endpoint Conventions

- **Nesting Hierarchy**: Limit nesting to 2 levels.
  - Good: `GET /api/v1/users/:userId/orders`
  - Avoid: `GET /api/v1/users/:userId/orders/:orderId/items/:itemId/taxes` (instead use: `GET /api/v1/items/:itemId/taxes`)
- **Casing**:
  - URI paths: `kebab-case` (`/api/v1/order-items`)
  - Query parameters: `camelCase` or `snake_case` (must be consistent across the API; prefer `camelCase`)
  - JSON Request/Response bodies: `camelCase`

---

## Filtering, Sorting, and Pagination

### Pagination
Collection endpoints must always be paginated:
```
GET /api/v1/products?limit=20&cursor=eyJpZCI6MTAwfQ==
```
Response structure:
```json
{
  "data": [...],
  "pagination": {
    "limit": 20,
    "hasMore": true,
    "nextCursor": "eyJpZCI6MTIwfQ=="
  }
}
```

### Sorting
Use a `sortBy` or `sort` parameter:
```
GET /api/v1/products?sort=-createdAt,price
```
*(Prefix `-` indicates descending order).*

---

## Reference Documentation
- [REST Standards & Status Codes](./references/rest-standards.md)
- [RFC 7807 Error Handling Standards](./references/error-handling-standards.md)
- [OpenAPI Boilerplate Template](./resources/openapi-template.yaml)
