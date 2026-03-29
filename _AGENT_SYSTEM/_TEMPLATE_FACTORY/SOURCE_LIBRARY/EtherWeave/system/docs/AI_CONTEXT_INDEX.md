# AI Context Index (Etherweave)

Use this file as the first stop when a coding agent or IDE assistant loads the repo.
It points to the authoritative prompts, rules, protocols, and subagent assets that
must be applied for consistent behavior across Codex, Cursor, and Copilot.

## Required Load Order (binding)

System assets under system/; see system/README.md. Application code at repo root.

1) system/prompts/MASTER_SYSTEM_PROMPT_ETHERWEAVE.md
2) system/docs/KERNEL_CONTRACT.md
3) system/docs/DEBUG_REPAIR_PLAYBOOK.md
4) system/docs/PHASE_CHECKPOINT_PROTOCOL.md
5) PROJECT_RULES.md
6) MASTER_AI_REFERENCE.md
7) CHATGPT_COMPLETE_APPLICATION_GUIDE.md
8) system/docs/CONTEXT_GUIDE.md
9) system/docs/CHANGELOG_REFAC.md
10) system/docs/ARCHITECTURE_BOUNDARIES.md
11) system/docs/ARCHITECTURE_FITNESS_FUNCTIONS.md
12) system/prompts/CURSOR_CONTEXT_GUIDE.md
13) system/docs/CURSOR_NEXUS.md (Skills, Commands, Subagents, Rules — when to use each)
14) CURSOR_SYSTEM_PROMPT.md
15) system/docs/SUBAGENT_PROTOCOL.md
16) system/docs/SUBAGENT_REGISTRY.md
17) docs/SESSION_STATE.md
18) system/docs/ENVIRONMENT_AND_MCP_MODEL.md

(Full load order and operator command: see AGENTS.md. Single-page “how we do things”: docs/CODING_SYSTEM_INDEX.md.)

## Cursor Skills, Commands, Subagents, Rules
- **Nexus (single reference)**: system/docs/CURSOR_NEXUS.md — when to use skills, commands, subagents, rules.
- **Skills**: .cursor/skills/ (etherweave-load-context, etherweave-code-review, etherweave-checkpoint, etc.). Apply when task matches or invoke via /skill-name.
- **Commands**: .cursor/commands/ (load-context, code-review, checkpoint, verify, etc.). User types / in chat and selects command.
- **Subagents**: .cursor/agents/ (etherweave-code-reviewer, etherweave-debugger, etc.). Invoke via "use X subagent" or delegation.
- **Rules**: .cursor/rules/ (always-apply and file-scoped). See .cursor/rules/README.md.
- When in Cursor, use the nexus so skills/commands/subagents/rules are applied automatically and persistently.
- **Setup**: docs/CURSOR_SETUP.md — recommended extensions, settings, conflicts to avoid.
- **Context checklist**: system/docs/CONTEXT_DOCUMENTS.md — key docs to load; do not add them to .cursorignore.
- **MCP**: docs/MCP_SETUP.md — configured servers. When MCPs error: system/docs/ENVIRONMENT_AND_MCP_MODEL.md (note once, continue with in-repo context). Troubleshooting: docs/MCP_TROUBLESHOOTING.md. Later installs: docs/MCP_LATER_INSTALLS.md.

## Subagent System (quick map)
- Protocol: system/docs/SUBAGENT_PROTOCOL.md
- Registry: system/docs/SUBAGENT_REGISTRY.md
- Prompts: system/prompts/subagents/
- Cursor subagents: .cursor/agents/ (see system/docs/SUBAGENT_REGISTRY.md)
- Supervisor: tools/subagent_supervisor.py
- Artifacts: contexts/subagents/ (inputs/outputs)
- Logs: logs/subagents/

## Multi-tool awareness
- **Multiple AI coding tools** (Cursor, Codex, Gemini, Claude, Windsurf, etc.) may configure, build, and design this app **in turn**. Shared rules and handoff protocol: **system/docs/MULTI_AGENT_AND_TOOL_AWARENESS.md**. When your turn ends, update WHERE_WE_LEFT_OFF, SESSION_STATE, CONTEXT_PACK so the next tool can continue.

## Session Continuity
- Session log: logs/codex/ or logs/cursor/
- Where-we-left-off: docs/WHERE_WE_LEFT_OFF.md — current state, recent work, next steps.
- Session state: docs/SESSION_STATE.md
- Context pack: docs/CONTEXT_PACK.md
- Coding system index: docs/CODING_SYSTEM_INDEX.md — load order, separation, branches, launch, multi-tool.

## App vs system files
- **docs/APP_VS_SYSTEM_FILES.md** — App payload (installer/distribution) vs model/cursor system files (design, coding, agent behavior). Installer uses only app files; app runs without system files. Build app-only bundle: `scripts/build_app_bundle.sh`.

## Environment & platform
- **Environment and MCP model**: system/docs/ENVIRONMENT_AND_MCP_MODEL.md — Single source for environment vs MCP, workspace vs user-level MCPs (OpenMemory, Context7, OpenAI docs), agent behavior when MCPs error (note once, continue with in-repo context), bootstrap checklist.
- **KDE / keyring**: docs/KDE_KEYRING_AND_ENVIRONMENT.md — Cursor "OS keyring not available" on KDE; KWallet, DBUS, launching from project dir. Helper: `scripts/ensure_kde_env.sh`.
- **Frameworks & launch**: docs/FRAMEWORK_AND_LAUNCH.md — PyQt6 vs FastAPI, what to run (GUI / Pro API / CLI), run-from-anywhere launcher, testing Pro API.

## User docs & diagnostics
- **docs/APPLICATION_USER_GUIDE.md** — How to use the application (GUI, Web UI, CLI): launch, tabs, workflows, settings, shortcuts, safety.
- **docs/LOGGING_AND_DIAGNOSTICS.md** — Where log files are written; how to use them as context to fix errors and test failures.

## Safety Baseline
- Authorized/lab use only.
- No automated exploitation, credential attacks, or traffic disruption.
- Privileged Ops requires sudo cache + explicit confirmation.
