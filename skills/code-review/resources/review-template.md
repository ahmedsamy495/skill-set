# Code Review Output Template

Use this format when presenting code reviews to the developer.

```markdown
# 🔍 Code Review Summary

**Status**: [APPROVED / CHANGES REQUESTED / COMMENT ONLY]
**Files Reviewed**: `src/auth/service.ts`, `src/auth/controller.ts`

---

## 📌 Executive Summary
<!-- Brief 2-3 sentence overview of the change, overall quality, and critical findings. -->

---

## 🚨 Findings by Severity

### [BLOCKER] Title of Critical Finding
- **Location**: `src/auth/service.ts:45-52`
- **Issue**: Direct string interpolation used in database query string introduces SQL injection risk.
- **Recommendation**: Use parameterized queries or Prisma/ORM parameters.
```typescript
// ❌ Problematic
const result = await db.query(`SELECT * FROM users WHERE email = '${email}'`);

// ✅ Recommended Fix
const result = await db.query('SELECT * FROM users WHERE email = $1', [email]);
```

### [WARNING] Title of Architecture or Performance Issue
- **Location**: `src/orders/worker.ts:110`
- **Issue**: Database lookup placed inside a `for` loop leading to N+1 queries.
- **Recommendation**: Batch IDs and fetch all records in a single query prior to the loop.

### [SUGGESTION] Title of Clean Code or Refactoring Improvement
- **Location**: `src/common/utils.ts:18`
- **Issue**: Magic number `86400` used without context.
- **Recommendation**: Extract to `const SECONDS_PER_DAY = 86_400;`.

---

## 🌟 Positive Highlights
- Clean separation of the validation layer using Zod schemas.
- Comprehensive test coverage for the payment failure fallback path.
```
