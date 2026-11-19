# Pull Request Template

Use this markdown template when preparing pull request descriptions for GitHub, GitLab, or Bitbucket.

```markdown
## Overview
<!-- Provide a 1-2 sentence high-level summary of what problem this PR solves or what capability it introduces. -->

Closes #<!-- Issue Number -->

## Key Changes
- **Area / Module**: Brief description of change.
- **Area / Module**: Brief description of change.
- **Area / Module**: Brief description of change.

## Type of Change
- [ ] 🐛 Bug fix (non-breaking change fixing an issue)
- [ ] ✨ New feature (non-breaking change adding functionality)
- [ ] 💥 Breaking change (fix or feature causing existing functionality to break)
- [ ] ♻️ Refactoring (no functional changes, code cleanup)
- [ ] ⚡ Performance improvement
- [ ] 📝 Documentation update
- [ ] 🧪 Test coverage improvement

## Verification & Testing
<!-- Describe step-by-step how a reviewer can test these changes locally. -->
1. Run database migration: `npm run db:migrate` (if applicable)
2. Run test suite: `npm test`
3. Manual verification steps:
   - Navigate to `/checkout`
   - Apply discount code `SUMMER2026`
   - Verify final price calculation displays a 20% deduction

## Checklist
- [ ] My code adheres to the project's style guidelines.
- [ ] I have performed a self-review of my own code.
- [ ] I have added tests that prove my fix is effective or that my feature works.
- [ ] All new and existing automated tests pass.
- [ ] No sensitive credentials, tokens, or debug logs were committed.
```
