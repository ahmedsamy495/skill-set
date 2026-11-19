# REST Standards & HTTP Status Codes

Quick reference for selecting correct HTTP methods and status codes.

## HTTP Methods Matrix

| Method | Idempotent | Safe | Typical Success Code | Request Body |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | Yes | Yes | `200 OK` | No |
| `POST` | No | No | `201 Created` / `202 Accepted` | Yes |
| `PUT` | Yes | No | `200 OK` / `204 No Content` | Yes |
| `PATCH` | No (by spec, usually made idempotent) | No | `200 OK` | Yes |
| `DELETE` | Yes | No | `204 No Content` / `200 OK` | No |

---

## Status Codes Guide

### 2xx Success
- `200 OK`: Request succeeded. Returned with a payload for `GET`, `PUT`, or `PATCH`.
- `201 Created`: New resource created. Include a `Location` header pointing to the new resource.
- `202 Accepted`: Request accepted for asynchronous processing (e.g. background job started).
- `204 No Content`: Action succeeded, but there is no body to return (common for `DELETE`).

### 4xx Client Errors
- `400 Bad Request`: Generic client error or malformed JSON syntax.
- `401 Unauthorized`: Authentication missing or invalid (token expired, bad signature).
- `403 Forbidden`: Authenticated, but user lacks permissions for this resource.
- `404 Not Found`: Target resource does not exist.
- `409 Conflict`: Conflict with current state (e.g. unique constraint violation, duplicate email).
- `422 Unprocessable Content`: Syntax is valid, but semantic validation failed (e.g. age must be > 18).
- `429 Too Many Requests`: Rate limit exceeded. Include `Retry-After` header.

### 5xx Server Errors
- `500 Internal Server Error`: Unhandled server exception. Never expose internal stack traces to the client.
- `502 Bad Gateway`: Downstream service or upstream proxy failure.
- `503 Service Unavailable`: Server overloaded or undergoing maintenance.
- `504 Gateway Timeout`: Downstream dependency timed out.
