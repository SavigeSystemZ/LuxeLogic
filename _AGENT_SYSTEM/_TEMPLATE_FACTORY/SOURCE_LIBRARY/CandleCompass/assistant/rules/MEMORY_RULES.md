# Memory Rules (Local)

Use memory to improve continuity, not to block normal delivery.

## Purpose
Persist durable project facts, decisions, and user preferences so future sessions start with accurate context.

## When to Search Memory
Search memory when:
- starting multi-step implementation work,
- making architecture/tooling decisions,
- debugging recurring issues,
- you suspect prior decisions already exist.

## When to Store Memory
Store memory after meaningful work when you add:
- a new architectural decision,
- a reusable workflow/pattern,
- a non-obvious bug diagnosis/fix,
- a stable user preference that affects future implementation.

## What Not to Store
Never store:
- API keys, passwords, tokens, secrets,
- private credentials or connection strings with credentials,
- transient noise (routine command output, trivial edits).

## Memory Types
- `project_info`: durable facts, architecture, tooling constraints
- `implementation`: completed multi-step implementation patterns
- `debug`: root-cause + fix for significant issues
- `user_preference`: stable user style/workflow preferences
- `component`: subsystem ownership, boundaries, interfaces

## Local Tooling
- Search: `python scripts/memory_tool.py search --query "..."`
- Add: `python scripts/memory_tool.py add --title "..." --content "..." --type project_info`
- List: `python scripts/memory_tool.py list`
- Ingest: `python scripts/memory_tool.py ingest --replace`

## Scope Guidance
- Project facts -> `scope=project`
- This-project user preferences -> `scope=user_project`
- Cross-project user preferences -> `scope=user_global`
