---
name: git-workflow
description: >-
  Standardizes Git operations across projects, including Conventional Commits,
  branch naming conventions, atomic commits, pull request generation, and semantic release changelog creation.
  Activate when writing commits, creating branches, preparing pull requests, or updating release notes.
---

# Git & Release Workflow

This skill enforces high-quality, traceable, and standardized Git practices across all repositories.

## Quick Reference Workflows

### 1. Branch Creation
Always branch from the main integration branch (`main` or `develop`):
- Format: `<type>/<issue-id-or-short-slug>`
- Types: `feat/`, `fix/`, `refactor/`, `chore/`, `docs/`, `test/`
- Examples:
  - `feat/user-authentication`
  - `fix/jwt-expiration-handling`
  - `refactor/extract-pricing-calculator`

```bash
git checkout main
git pull --ff-only
git checkout -b feat/add-payment-webhook
```

---

### 2. Crafting Commits (Conventional Commits)

All commit messages must adhere to the [Conventional Commits](./references/conventional-commits.md) standard.

#### Message Structure
```text
<type>(<optional scope>): <short summary in imperative mood>

[optional body explaining WHY and WHAT, not HOW]

[optional footer(s): BREAKING CHANGE, Closes #123]
```

#### Commit Rules
1. **Atomic Commits**: Stage and commit related changes together. Avoid mixing refactoring, feature work, and formatting in a single commit.
2. **Imperative Mood**: Use "add", "fix", "refactor", not "added", "fixes", "refactored".
3. **No Trailing Period**: Keep the header concise (<= 72 chars).
4. **Inspect Before Committing**:
   ```bash
   git diff --staged
   ```

---

### 3. Pull Request Generation

When preparing a Pull Request:
1. Ensure the branch is clean, rebased, and all local tests pass.
2. Draft the PR description using the [Pull Request Template](./references/pr-template.md).
3. Include:
   - Concise summary of the problem and resolution.
   - Bulleted list of key changes.
   - Step-by-step instructions for testing and verification.
   - Screenshot / API response diff if applicable.

---

### 4. Release & Changelog Generation

To generate release notes or changelogs from conventional commits between tags:
- Run the changelog generation script:
  [generate-changelog.ps1](./scripts/generate-changelog.ps1)

```powershell
.\scripts\generate-changelog.ps1 -FromTag "v1.2.0" -ToTag "HEAD"
```

## Validation & Verification

Before concluding any Git workflow:
1. `git status` - Confirm no unintended files or secrets (`.env`, credentials) are staged.
2. `git log -1` - Verify the commit message formatting conforms to Conventional Commits.
3. Confirm branch is pushed: `git push -u origin <branch-name>`.
