# Generate Commit Message

Generate a conventional commit message for the current staged (or unstaged) changes.

**Do this now:**
1. Inspect the changes (e.g. `git diff --staged` or `git diff`). If nothing is specified, assume staged changes.
2. Propose a commit message in conventional format: `<type>(<scope>): <short description>` with optional body.
3. **Types**: feat, fix, refactor, docs, test, style, perf, chore.
4. **Scopes** (from this repo): gui, lib, cli, database, tools, docs, tests, installer, container.
5. Short description: imperative, lowercase, no period. One logical change per commit.

Example: `feat(gui): add network list filter by encryption type`

Reference: **etherweave-commit-messages** skill, AGENTS.md.
