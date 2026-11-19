# Project Skills Library

A curated, modular collection of Antigravity skills designed to assist across all your software projects.

## What are Skills?

In Antigravity, **Skills** are modular packages of knowledge, runbooks, and procedures that teach the agent how to execute multi-step workflows with precision. Skills leverage **progressive disclosure**: the agent only loads a skill's full instructions and reference material when it is activated, keeping your context window lean and focused.

---

## Included Skills Catalog

| Skill | Directory | Description & Triggers |
| :--- | :--- | :--- |
| **Git & Release Workflow** | [`skills/git-workflow/`](./skills/git-workflow/) | Conventional Commits, branch naming, atomic staging, PR templates, and semantic release changelog generation. |
| **Code Review & Architecture** | [`skills/code-review/`](./skills/code-review/) | 4-pass code review framework, security audit (OWASP), clean architecture / SOLID checks, and actionable review feedback. |
| **Test Engineering** | [`skills/test-engineering/`](./skills/test-engineering/) | Test-driven development (TDD), Arrange-Act-Assert (AAA), mocking strategies, edge-case coverage, and test runner integration. |
| **API Design** | [`skills/api-design/`](./skills/api-design/) | RESTful endpoint design, RFC 7807 problem details, pagination/filtering standards, and OpenAPI 3.1 schema scaffolding. |
| **Frontend Architecture** | [`skills/frontend-architecture/`](./skills/frontend-architecture/) | Component decomposition, state categorization (server vs UI vs URL state), accessibility (a11y), and UI performance. |

---

## How to Use These Skills in Any Project

Antigravity automatically discovers skills located in a project's `.agents/skills/` folder (or parent directories up to the Git root).

### Quick Install with PowerShell

Use the included [`scripts/install-to-project.ps1`](./scripts/install-to-project.ps1) script to copy or link skills to any project:

```powershell
# Install a specific skill to your target project:
.\scripts\install-to-project.ps1 -SkillName "git-workflow" -TargetProject "C:\path\to\my-app"

# Install all skills into your target project:
.\scripts\install-to-project.ps1 -All -TargetProject "C:\path\to\my-app"

# Create symbolic links instead of copying (updates stay in sync):
.\scripts\install-to-project.ps1 -All -TargetProject "C:\path\to\my-app" -Symlink
```

### Manual Installation

To manually install a skill into any repository:
1. Navigate to your project root.
2. Create the directory `.agents/skills/<skill-name>/`
3. Copy the contents of `skills/<skill-name>/` from this repository into `.agents/skills/<skill-name>/`.
4. Antigravity will automatically detect the skill and activate it whenever your tasks match its description!

---

## Skill Anatomy

Each skill follows the official Antigravity specification:

```text
skills/<skill-name>/
├── SKILL.md            # Required: YAML frontmatter (name, description) + step-by-step instructions
├── references/         # Optional: Deep guides and checklists loaded only when needed
├── resources/          # Optional: Reusable boilerplates, templates, and schemas
└── scripts/            # Optional: Automated helper scripts and utilities
```
