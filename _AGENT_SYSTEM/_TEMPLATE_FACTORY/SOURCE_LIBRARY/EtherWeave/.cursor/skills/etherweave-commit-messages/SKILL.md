---
name: etherweave-commit-messages
description: Generates conventional commit messages for Etherweave. Use when the user asks for a commit message, before committing, or when reviewing staged changes.
---

# Etherweave Commit Messages

## Format

Use conventional commits. Scope from project structure: gui, lib, cli, database, tools, docs, tests.

```
<type>(<scope>): <short description>

[optional body]
[optional footer: fixes #n, breaking change]
```

## Types

- **feat** — New feature or capability
- **fix** — Bug fix
- **refactor** — Code change with no behavior change
- **docs** — Documentation only
- **test** — Tests only
- **style** — Formatting, no logic change
- **perf** — Performance improvement
- **chore** — Build, tooling, deps

## Scopes (examples)

- gui, lib, cli, database, tools, docs, tests, installer, container

## Examples

**Feature:**
```
feat(gui): add network list filter by encryption type
```

**Fix:**
```
fix(lib): validate BSSID format in ValidationLayer before scan
```

**Refactor:**
```
refactor(gui): move scan worker to QThread subclass
```

## Rules

- One logical change per commit; cohesive and self-contained.
- Short description imperative, lowercase, no period at end.
- Body optional; use for why/what when helpful.

Reference: AGENTS.md (commit quality), PROJECT_RULES.md.
