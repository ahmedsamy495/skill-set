---
name: code-review
description: >-
  Comprehensive code review and architectural evaluation framework. Guides the agent
  through reviewing diffs, auditing security vulnerabilities (OWASP Top 10), checking
  SOLID/clean architecture principles, identifying performance bottlenecks, and writing structured, actionable feedback.
  Activate when asked to review code, PRs, diffs, or evaluate architecture.
---

# Code Review & Architecture Evaluation

This skill provides a structured, 4-pass methodology for reviewing code changes to ensure correctness, security, architectural integrity, and maintainability.

## The 4-Pass Review Methodology

When reviewing code or a pull request diff, evaluate the changes across four distinct lenses:

```
Pass 1: Correctness & Functional Logic
   ↓
Pass 2: Security & Vulnerabilities (OWASP)
   ↓
Pass 3: Architecture & Clean Design
   ↓
Pass 4: Performance & Resource Efficiency
```

---

### Pass 1: Correctness & Functional Logic
- **Requirements Match**: Does the implementation solve the stated problem without unintended side effects?
- **Edge Cases**: Are null/undefined values, empty arrays/collections, zero/negative bounds, and network failures handled?
- **State Invariants**: Are state transitions valid? Can an entity end up in an inconsistent or partially updated state?
- **Error Handling**: Are errors caught at appropriate boundaries and translated to meaningful messages, or swallowed silently?

---

### Pass 2: Security & Vulnerability Audit
Consult the [Security Checklist](./references/security-checklist.md):
- **Input Sanitization**: Are inputs validated and sanitized before passing to queries, commands, or UI rendering?
- **Injection Risks**: SQL, NoSQL, OS command injection, or path traversal vulnerabilities.
- **Authentication & Authorization**: Is every new or modified endpoint/action protected by appropriate role/permission checks?
- **Secret Leaks**: Ensure no hardcoded API keys, private credentials, or secrets are present in code or commit history.

---

### Pass 3: Architecture & Clean Code
Consult the [Architecture Checklist](./references/architecture-checklist.md):
- **Single Responsibility Principle (SRP)**: Does each function, class, and module have one clear reason to change?
- **Coupling & Cohesion**: Is business logic cleanly separated from framework/transport/presentation layers?
- **DRY vs YAGNI**: Is duplication eliminated where appropriate, without over-engineering for speculative future requirements?
- **API & Interface Stability**: Are public function signatures, response models, or schemas backwards-compatible?

---

### Pass 4: Performance & Scalability
Consult the [Performance Checklist](./references/performance-checklist.md):
- **Database Access**: Are queries prone to N+1 problems? Are query fields indexed appropriately?
- **Resource Cleanup**: Are file handles, database connections, and event listeners properly disposed?
- **Async & Non-blocking**: Are blocking operations avoided on the main event loop or HTTP request threads?
- **Memory Footprint**: Are large datasets streamed or paginated rather than buffered entirely in memory?

---

## Writing the Review Output

Present the review using the standardized [Review Template](./resources/review-template.md).

### Severity Levels
Every observation must be tagged with an explicit severity level:
- **`[BLOCKER]`**: Severe bug, security vulnerability, data loss risk, or broken build. Must be addressed before merge.
- **`[WARNING]`**: Architecture violation, performance concern, or missing test case. Strongly recommended to fix.
- **`[SUGGESTION]`**: Clean code improvement, readability enhancement, or naming recommendation.
- **`[NICE-TO-HAVE]`**: Minor polish or stylistic preference.
