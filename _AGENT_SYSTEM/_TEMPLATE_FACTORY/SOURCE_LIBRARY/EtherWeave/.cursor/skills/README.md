# Etherweave Cursor Skills

Project-scoped Agent Skills. Cursor discovers skills from `.cursor/skills/` at startup. To see them: **Cursor Settings → Rules → Agent Decides**. You can also type `/` in Agent chat and search by skill name.

| Skill | Purpose |
|------|--------|
| **etherweave-load-context** | Load master prompt and rules in canonical order ("load master architectural systems now!", new session, context reset). |
| **etherweave-code-review** | Review code against PROJECT_RULES, MASTER_AI_REFERENCE, architecture boundaries, and fitness functions. |
| **etherweave-checkpoint** | Run phase checkpoint protocol: verify, commit, backup, update CONTEXT_PACK and WORKLOG. |
| **etherweave-commit-messages** | Generate conventional commit messages (feat/fix/refactor with scope). |
| **etherweave-debug-playbook** | Follow DEBUG_REPAIR_PLAYBOOK when build fails, crash, regression, or test failure. |
| **etherweave-pyqt6-rules** | PyQt6 layout and threading rules (no place(), QThread, thread-safe updates, 10-button rule). |
| **etherweave-verify-gate** | Run tools/verify.sh and secrets scan before push or checkpoint. |
| **cursor-task-scoping** | Scope work into one step per response and clear outcomes (atomic tasks, verb-noun). |

## If a skill doesn’t show in the GUI

- Skill **name** in SKILL.md frontmatter must **match the folder name** (e.g. folder `etherweave-checkpoint`, name `etherweave-checkpoint`).
- Restart Cursor or reload the window so skills are re-discovered.
- Manually invoke: type `/` in Agent chat and search for the skill name.

## Relation to repo docs

- **Load order**: `AGENTS.md`, `docs/AI_CONTEXT_INDEX.md`, `prompts/CURSOR_CONTEXT_GUIDE.md`
- **Review authority**: `PROJECT_RULES.md`, `MASTER_AI_REFERENCE.md`, `docs/ARCHITECTURE_BOUNDARIES.md`, `docs/ARCHITECTURE_FITNESS_FUNCTIONS.md`
- **Checkpoint**: `docs/PHASE_CHECKPOINT_PROTOCOL.md`, `docs/DEBUG_REPAIR_PLAYBOOK.md`

## Commands (separate from skills)

- `/projectsystemprompt` — inject project system prompt (`.cursor/commands/projectsystemprompt.md`)
- `/projectcommand` — show project commands (`.cursor/commands/projectcommand.md`)
