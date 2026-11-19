# Test Doubles & Patterns Reference

Understand the difference between test doubles to keep tests fast, readable, and decoupled.

## Test Doubles Glossary

| Double Type | Definition | Best Used When |
| :--- | :--- | :--- |
| **Dummy** | Objects passed around but never actually used (e.g. filler parameter). | Satisfying parameter lists where the value is irrelevant. |
| **Stub** | Provides canned answers to calls made during the test. | Supplying predefined inputs (e.g. stubbing a weather API to return 20°C). |
| **Spy** | Records information about how it was called (arguments, call count). | Verifying that an event was dispatched or an audit log was triggered. |
| **Mock** | Pre-programmed with expectations about calls it should receive; verifies protocol. | Strict contract verification where order or exact interaction matters. |
| **Fake** | Working implementation with shortcuts (e.g. in-memory repository). | Replacing slow databases or message brokers in unit/integration tests. |

---

## Best Practices for Mocking

1. **Don't Mock What You Don't Own**: Avoid mocking 3rd-party libraries directly. Create an adapter interface around the third-party client and mock your own adapter.
2. **Favor Fakes Over Over-Mocking**: An in-memory repository (e.g. `Map<string, User>`) is often much simpler, cleaner, and less brittle than configuring 10 separate mock return promises.
3. **Avoid Asserting on Internal Mocks**: Assert on observable state and outputs rather than checking that a private method was called 3 times.
