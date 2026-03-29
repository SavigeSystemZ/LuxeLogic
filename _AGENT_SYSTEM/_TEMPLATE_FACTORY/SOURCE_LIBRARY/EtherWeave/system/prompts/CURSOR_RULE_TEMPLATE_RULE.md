# Cursor Rule Template

Use this as a base for .cursor/rules/*.md files.

## Workflow
- Questions → Prereqs → ONE step only.
- Ask targeted questions (only as many as needed).

## Command Set
- "load master architectural systems now!" — run the full load order, log actions, and confirm readiness. If the load risks context overflow, split into step parts and continue on request.

## Context Capacity Safety
- If the context window is at risk, stop before overflow, state the cutoff, and request continuation with the next step part.

## Safety
- Authorized/lab only. No one-click misuse.
- Confirm sensitive actions + Engagement Scope + audit logs.

## Parity
- Keep aligned with AGENTS.md and Codex master prompt.

## Checkpoints
- Update WORKLOG.md, backups, git bundle + hashes, GitHub sync.

## Logging
- Per-session logs under logs/cursor.
