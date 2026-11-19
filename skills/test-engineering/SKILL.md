---
name: test-engineering
description: >-
  Professional test-driven development (TDD), unit, integration, and end-to-end testing practices.
  Covers AAA pattern (Arrange-Act-Assert), test boundary selection, mocking strategies, and test coverage verification.
  Activate when writing tests, refactoring test suites, debugging failing tests, or implementing TDD.
---

# Test Engineering & TDD

This skill guides the creation of reliable, maintainable, and deterministic automated test suites across unit, integration, and end-to-end levels.

## Core Testing Principles

1. **AAA Pattern**: Every test must be structured into three distinct phases:
   - **Arrange**: Set up inputs, mocks, and test fixtures.
   - **Act**: Invoke the single method or endpoint under test.
   - **Assert**: Verify expected return values, state mutations, and emitted side effects.
2. **Deterministic & Isolated**: Tests must not rely on shared global state, execution order, or live external networks. Each test must leave the system in a clean state.
3. **Behavior Over Implementation**: Test what the code achieves (contracts and observable outcomes), not private internal implementation details.
4. **Fast Feedback**: Unit tests must execute in milliseconds. Slower network/database interactions belong in integration suites.

---

## Test-Driven Development (TDD) Workflow

When building new features or fixing bugs using TDD, follow the strict cycle detailed in [TDD Workflow](./references/tdd-workflow.md):

```
1. RED: Write a failing test specifying the desired behavior.
   ↓
2. GREEN: Write the minimal production code to pass the test.
   ↓
3. REFACTOR: Clean up code and test structure while keeping tests green.
```

---

## Choosing Test Boundaries & Types

| Test Type | Scope | Dependencies | Speed |
| :--- | :--- | :--- | :--- |
| **Unit** | Individual function, class, or domain entity | All I/O, DB, and network dependencies are mocked/faked | Extremely fast (< 10ms) |
| **Integration** | Interaction between module and DB/cache/filesystem | Real local containers (e.g. Testcontainers, SQLite, Redis) | Moderate (100ms - 2s) |
| **End-to-End** | Full application stack from HTTP API / UI | Staging/sandbox environment with real or mocked third parties | Slower (seconds) |

For guidance on test doubles (mocks vs stubs vs fakes), see [Test Patterns](./references/test-patterns.md).

---

## Reference Examples

- [Unit Test Pattern (TypeScript & Python)](./examples/unit-test-pattern.md)
- [Integration Test Pattern (Database & HTTP)](./examples/integration-test-pattern.md)

---

## Verification & Execution Checklist

Before concluding any test task:
1. Run the test suite: verify that tests pass consistently (not flaky).
2. Negative testing: Verify that bad input throws expected domain exceptions or returns proper HTTP error codes.
3. Boundary testing: Test 0, 1, max boundary limits, empty collections, and null/undefined values.
