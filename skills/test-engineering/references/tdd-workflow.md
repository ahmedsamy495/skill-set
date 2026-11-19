# Test-Driven Development (TDD) Guide

TDD is a disciplined design process where test writing drives software architecture.

## The TDD Micro-Cycle

```
┌──────────────────────────────────────┐
│  1. RED: Write a small failing test  │
└──────────────────┬───────────────────┘
                   │
                   ▼
┌──────────────────────────────────────┐
│  2. Run test to verify it FAILS      │  (Verify it fails for the expected reason)
└──────────────────┬───────────────────┘
                   │
                   ▼
┌──────────────────────────────────────┐
│  3. GREEN: Write minimum code to pass│  (No premature optimization)
└──────────────────┬───────────────────┘
                   │
                   ▼
┌──────────────────────────────────────┐
│  4. Run test to verify it PASSES     │
└──────────────────┬───────────────────┘
                   │
                   ▼
┌──────────────────────────────────────┐
│  5. REFACTOR: Clean up design        │  (Extract helpers, rename, remove duplication)
└──────────────────┬───────────────────┘
                   │
                   ▼
         Repeat for next behavior
```

---

## TDD Rules of Thumb

1. **Write the Simplest Test First**: Start with degenerate cases: empty inputs, zero, null, basic happy path.
2. **Never Write Production Code Without a Failing Test**: If you want to add an `if` condition, write a test that requires that `if` condition to turn green.
3. **Verify the Failure Reason**: Always inspect the error message of a failing test before writing code. If it fails due to a syntax error or wrong import, fix the test setup first.
4. **Refactor with Confidence**: The refactoring step is where good architecture happens. Do not skip it! Keep all tests green throughout refactoring.
