# Multi-Agent and Multi-Tool Awareness

Etherweave is designed, built, and configured by **multiple AI coding tools that take turns**. The system must be tool-agnostic so any of them can continue work correctly and leave a clean handoff for the next.

---

## 1. Tools in the loop

The following (and other compatible AI coding assistants) may operate on this repo in sequence:

- **Cursor** (IDE + agent)
- **Codex** (e.g. GPT-5.2-Codex or equivalent)
- **Gemini** (Google)
- **Claude** (Anthropic)
- **Windsurf** (IDE + agent)
- **Other** — Any assistant that follows the same load order, checkpoint protocol, and output contract

Operators may switch tools between sessions or mid-workflow. **No single tool owns the repo**; governance and context live in the repo so the next tool can pick up without assuming a specific environment.

---

## 2. Rules that apply to all tools

Regardless of which tool is active, the following are **binding**:

| Area | Source | Rule |
|------|--------|------|
| **Load order** | AGENTS.md | Load context in the documented sequence (system/prompts, system/docs, PROJECT_RULES, etc.). |
| **Output contract** | AGENTS.md | Every response: questions → prerequisites → next step (one step default). |
| **Verification** | AGENTS.md, PROJECT_RULES | Before push/checkpoint: run `tools/verify.sh`; on failure follow DEBUG_REPAIR_PLAYBOOK. |
| **Checkpoints** | PHASE_CHECKPOINT_PROTOCOL | On major change or milestone: update WORKLOG, backup, sync, update CONTEXT_PACK and WHERE_WE_LEFT_OFF. |
| **Safety** | PROJECT_RULES, MASTER_SYSTEM_PROMPT | Authorized use only; no one-click misuse; privileged ops gated; no hardcoded secrets. |
| **Architecture** | ARCHITECTURE_BOUNDARIES, fitness | GUI no subprocess; lib no Qt; single instances (db, radio_manager); feature parity GUI ↔ CLI. |
| **Database & install** | DATABASE_AND_INSTALL_ARCHITECTURE | Distribution-first; no hardcoded users; user data dir; setup_data. |

Tool-specific assets (e.g. Cursor’s `.cursor/` skills, commands, subagents) extend behavior for that environment but **must not contradict** these rules. When in doubt, AGENTS.md and PROJECT_RULES.md win.

---

## 3. Taking turns and handoff

Because tools take turns:

1. **Assume you are not the only tool.** Do not rely on tool-specific state (e.g. only Cursor’s chat history) for “what we decided.” Persist decisions and next steps in **repo docs**: WHERE_WE_LEFT_OFF.md, SESSION_STATE.md, CONTEXT_PACK.md, TODO.md, WORKLOG.md.
2. **On session start or when continuing:** Load the load order (AGENTS.md), then read WHERE_WE_LEFT_OFF and NEXT_STEPS_AND_MILESTONES (or TODO) so you know current state and suggested next step.
3. **Before ending your turn (or when stopping after a meaningful change):** Update handoff docs so the next tool can continue without your in-session context:
   - **WHERE_WE_LEFT_OFF.md** — Current state, recent work, open items, suggested next step(s).
   - **SESSION_STATE.md** — Add an entry: timestamp, which tool/session, what was done, what’s next.
   - **CONTEXT_PACK.md** — If you shipped something or ran verification, add a session update line.
   - **TODO.md** — If you completed or added tasks, tick or add items.
4. **Run verification** before handoff when you changed code: `./tools/verify.sh`. If it fails, fix or record in docs/KNOWN_ISSUES.md and note in handoff.
5. **Commit and push** when appropriate (per checkpoint protocol), so the next tool has the latest tree.

---

## 4. Tool-specific vs shared

| Shared (all tools) | Tool-specific (optional) |
|--------------------|--------------------------|
| AGENTS.md, PROJECT_RULES.md, MASTER_AI_REFERENCE.md | Cursor: .cursor/rules, .cursor/skills, .cursor/commands, .cursor/agents |
| system/prompts, system/docs | Codex: session/logs in logs/codex/ |
| Load order, checkpoint protocol, verify gate | Cursor: logs/cursor/, MCP config in .cursor/mcp.json |
| WHERE_WE_LEFT_OFF, SESSION_STATE, CONTEXT_PACK, TODO, WORKLOG | IDE-specific settings (.vscode, etc.) |
| docs/CODING_SYSTEM_INDEX.md, docs/NEXT_STEPS_AND_MILESTONES.md | |

Tool-specific paths are for convenience and must stay aligned with shared rules (e.g. .cursor/rules must not contradict AGENTS.md).

---

## 5. Parity and alignment

- **Codex ↔ Cursor** — Keep AGENTS.md and `.cursor/rules` semantically aligned (already required in AGENTS.md).
- **All tools** — When you change shared governance (AGENTS.md, PROJECT_RULES, load order, checkpoint or verify steps), consider whether another tool’s docs or prompts need the same update (e.g. if a new doc is added to load order, list it in AI_CONTEXT_INDEX and CONTEXT_DOCUMENTS so any tool that loads by that order sees it).

---

## 6. References

- **AGENTS.md** — Load order, output contract, checkpoints, verification, session logging.
- **docs/CODING_SYSTEM_INDEX.md** — Single index for “how we do things” (load order, separation, branches, verify, launch).
- **docs/WHERE_WE_LEFT_OFF.md** — Current state and next steps; update on handoff.
- **system/docs/PHASE_CHECKPOINT_PROTOCOL.md** — When and how to checkpoint.
- **system/docs/DEBUG_REPAIR_PLAYBOOK.md** — What to do when verification or build fails.
