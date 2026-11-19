# Conventional Commits Reference

Standardized commit format for clear history, automated changelog generation, and semantic versioning.

## Allowed Commit Types

| Type | Intent | Triggers SemVer |
| :--- | :--- | :--- |
| `feat` | Introduces a new feature or capability | MINOR (`0.X.0`) |
| `fix` | Patches a bug or unintended behavior | PATCH (`0.0.X`) |
| `refactor` | Code restructuring without changing behavior or fixing bugs | PATCH / None |
| `perf` | Code change specifically aimed at improving performance | PATCH |
| `test` | Adding missing tests or correcting existing tests | None |
| `docs` | Documentation changes only | None |
| `style` | Formatting, white-space, semicolon fixes (no logic change) | None |
| `build` | Changes to build system, toolchains, or external dependencies | None |
| `ci` | Changes to CI/CD configuration files and scripts | None |
| `chore` | Routine maintenance tasks, auxiliary tools | None |

---

## Breaking Changes

Any commit that introduces breaking changes MUST indicate this in one of two ways:
1. Append an exclamation mark (`!`) before the colon:
   ```text
   feat(auth)!: replace cookie sessions with bearer JWT tokens
   ```
2. Include a `BREAKING CHANGE:` footer:
   ```text
   feat(api): migrate user endpoint response schema

   BREAKING CHANGE: The `name` field has been split into `firstName` and `lastName`.
   ```
*Triggers SemVer **MAJOR** (`X.0.0`).*

---

## Good vs Bad Examples

### Good Examples
- `feat(cart): add promotional discount code validation`
- `fix(order): prevent race condition during inventory checkout`
- `refactor(db): extract connection pooling into database module`
- `perf(query): add composite index on (tenant_id, created_at)`
- `docs(readme): add docker compose local setup guide`

### Bad Examples (Avoid)
- ❌ `Fixed bug` *(unclear scope and missing conventional prefix)*
- ❌ `feat: wip` *(work in progress should not be committed to shared branch)*
- ❌ `added tests and updated styles and fixed logic error` *(not atomic; split into 3 commits)*
- ❌ `fix: user cannot login.` *(trailing period and past tense)*
