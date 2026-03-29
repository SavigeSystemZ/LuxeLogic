---
name: cursor-decision-helper
description: Helps decide when to use a skill, command, subagent, or rule. Use when uncertain which Cursor asset to apply, or when the user asks how to accomplish a task in Cursor.
---

# Cursor Decision Helper

When the user asks how to do something or you're uncertain which asset to use, refer to `docs/CURSOR_NEXUS.md` and apply this decision tree:

## Decision Tree

**Need a checklist or step-by-step procedure?**
- → Use the matching **skill** (e.g. code-review → etherweave-code-review; checkpoint → etherweave-checkpoint; verify → etherweave-verify-gate).
- Or user can run the **command** (e.g. /code-review, /checkpoint, /verify).

**Need a focused review or fix in isolation?**
- → Invoke a **subagent** (e.g. etherweave-debugger for failures; etherweave-code-reviewer for reviews; etherweave-gui-ux for UI work).

**Need persistent behavior every session?**
- → That behavior should be in **rules** (already in `.cursor/rules/`). Do not duplicate rule content in skills/commands; reference the rule or doc instead.

**User wants to run something manually?**
- → Suggest the **command** (e.g. /code-review, /verify, /load-context). Commands are user-invoked via `/` in chat.

**Conflict or uncertainty?**
- → Rules take precedence for always-on behavior. Skills and commands add on top; subagents run in isolated context. Keep rules and skills aligned (e.g. checkpoint protocol in both rules and etherweave-checkpoint skill) so behavior is consistent.

## Quick Reference

- **Nexus**: `docs/CURSOR_NEXUS.md` — single reference for all assets.
- **Skills**: `.cursor/skills/` — apply when task matches.
- **Commands**: `.cursor/commands/` — user types `/` in chat.
- **Subagents**: `.cursor/agents/` — invoke via "use X subagent".
- **Rules**: `.cursor/rules/` — applied automatically.
