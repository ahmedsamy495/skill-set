# Performance & Resource Efficiency Checklist

Use this checklist during Pass 4 of code review to prevent performance degradation and scalability bottlenecks.

## 1. Database & Persistence
- [ ] **N+1 Query Problem**: Are relationships loaded inside loops without eager loading or batching (`DataLoader`, `.include()`, `select_related()`)?
- [ ] **Index Coverage**: Are `WHERE`, `JOIN`, and `ORDER BY` columns supported by appropriate database indexes?
- [ ] **Pagination**: Are collection endpoints paginated (`limit`/`offset` or cursor-based)? Unbounded queries like `SELECT * FROM orders` will crash in production.
- [ ] **Transaction Scope**: Are transactions kept as short as possible? Avoid placing slow HTTP calls or CPU-intensive tasks inside open database transactions.

## 2. Concurrency & Asynchronous Operations
- [ ] **Thread Blocking**: Are CPU-heavy computations or synchronous I/O operations (`fs.readFileSync`) blocking the event loop or web worker threads?
- [ ] **Concurrent Execution**: Are independent asynchronous calls awaited in parallel using `Promise.all()` or `asyncio.gather()` rather than sequentially?
- [ ] **Race Conditions**: Are shared state updates protected with atomic database operations, transactions with appropriate isolation, or optimistic locking?

## 3. Memory & Resource Management
- [ ] **Memory Leaks**: Are event listeners, intervals (`setInterval`), or WebSocket connections cleaned up on component unmount or connection close?
- [ ] **Streaming vs Buffering**: Are large file uploads/downloads or report exports handled via streams rather than loaded wholly into RAM?
- [ ] **Caching**: Are expensive, frequently-read, rarely-mutated computations or queries cached with reasonable TTLs?
