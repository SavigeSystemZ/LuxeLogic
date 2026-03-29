# Cursor Rules (Etherweave)

Project rules in `.cursor/rules/` provide persistent context for the AI Agent. Cursor applies them by **Always Apply**, **Apply to Specific Files** (globs), or **Apply Intelligently** (description-based).

## Always-apply rules (every session)

| Rule | Purpose |
|------|--------|
| **cursor-output-and-steps** | Output contract: Questions → Prereqs → Next step; one step default; WBS. |
| **cursor-definition-of-done** | DoD: build, verify, no unrelated changes; per-job loop. |
| **cursor-architecture-boundaries** | Clean Architecture: Domain, Ports, Adapters, GUI; dependency rule. |
| **cursor-design-before-code** | Contracts first; minimal diffs; depend on abstractions. |
| **cursor-debug-repair** | On failure: stop, follow DEBUG_REPAIR_PLAYBOOK, verify before proceeding. |
| **cursor-decision-and-safety** | Backend defaults; ask only for user-facing prefs; authorized use only. |
| **etherweave-security-auth** | ValidationLayer, SudoCache, LootManager; no secrets in code or logs. |
| **etherweave-verification-gate** | Verify (tools/verify.sh) before push/checkpoint; follow playbook on fail. |
| **etherweave-context-load** | When to load master context; load order reference. |
| **etherweave-single-instance-parity** | Single self.db, self.radio_manager; GUI/CLI feature parity. |
| **etherweave-checkpoint-protocol** | Phase checkpoint: verify, commit, push, backup, CONTEXT_PACK. |
| **etherweave-environment-mcp** | When MCPs error: note once, continue with in-repo context; see docs/ENVIRONMENT_AND_MCP_MODEL.md. |
| **cursor-context-documents** | Key context docs to load; reference system/docs/CONTEXT_DOCUMENTS.md and load order. |
| **etherweave-multi-tool-awareness** | Multiple AI tools (Cursor, Codex, Gemini, Claude, Windsurf) take turns; follow shared rules and handoff protocol. See system/docs/MULTI_AGENT_AND_TOOL_AWARENESS.md. |
| **openmemory.mdc** | Memory-first development; search before code. |
| **semgrep.mdc** | Security scan with semgrep MCP when generating code/commands. |
| **etherweave-socket-mcp.mdc** | Use Socket MCP depscore for dependency security when editing requirements/pyproject/package.json. |

## File-specific rules (globs)

| Rule | Applies to | Purpose |
|------|------------|--------|
| **python-standards** | `**/*.py` | Type hints, docstrings, no bare except, logging. |
| **etherweave-pyqt6** | `**/gui/**/*.py`, `etherweave/gui/**/*.py` | Layouts only, QThread, thread-safe updates, 10-button rule. |

## Other rules (legacy / reference)

- **wraiths-etherweave.rules.md** — Mirrors AGENTS.md; load order, output contract, checkpoints, subagents. Keep aligned with AGENTS.md.

## Best practices (from Cursor docs)

- Keep rules under 500 lines; split into composable rules.
- Provide concrete examples; reference files instead of copying.
- Use `.mdc` with frontmatter (`description`, `globs`, `alwaysApply`) for control.

## Coherence (no conflicts)

- Rules are complementary: output-and-steps (format), definition-of-done (when done), architecture-boundaries (layers), design-before-code (contracts first), debug-repair (on failure), decision-and-safety (defaults + auth), etherweave-* (app-specific). No rule contradicts another; apply all that match.
- If a rule and a skill overlap (e.g. checkpoint), they are aligned: rules are always-on context; skills add procedure. Use both; do not duplicate rule content in skills.
- **Nexus**: `docs/CURSOR_NEXUS.md` — when to use skills, commands, subagents, rules.

## Related

- **AGENTS.md** — Load order and agent contract.
- **docs/CURSOR_NEXUS.md** — Skills, Commands, Subagents, Rules (single reference).
- **.cursor/skills/** — Agent skills (load-context, code-review, checkpoint, etc.).
- **.cursor/agents/** — Subagents (code-reviewer, debugger, gui-ux, etc.).
- **.cursor/commands/** — Slash commands (/code-review, /verify, etc.).
