# Load rules (alias)

Load **Cursor rules and nexus** so the agent applies the right Skills, Commands, Subagents, and Rules.

Do this now:
1. Read `docs/CURSOR_NEXUS.md` (single reference for when to use Skills, Commands, Subagents, Rules).
2. Be aware of `.cursor/rules/` — always-apply and file-scoped rules (see `.cursor/rules/README.md`).
3. State briefly: "Rules and nexus loaded; Skills/Commands/Subagents/Rules available. Use `/` for commands."

To load full context (master prompt + all system files), use `/load-context` or `/ctx`.
