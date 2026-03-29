# Session Start

Start a new Cursor session with full context loaded and readiness confirmed.

**Do this now:**
1. Run `/load-context` (or load master architectural systems per `docs/AI_CONTEXT_INDEX.md`).
2. Confirm `docs/CURSOR_NEXUS.md` is available (Skills, Commands, Subagents, Rules).
3. Confirm Rules are loaded (Cursor Settings → Rules; project rules listed).
4. State briefly: "Session ready. Rules, Skills, Commands, Subagents available. Use `/` for commands, `docs/CURSOR_NEXUS.md` for when to use skills/subagents."
5. If session logging is active, append "Session started; context loaded." to the session log.

**Quick reference:**
- Commands: Type `/` in chat (e.g. /code-review, /verify, /checkpoint).
- Skills: Apply when task matches (see `docs/CURSOR_NEXUS.md`).
- Subagents: Invoke via "use X subagent" or delegation.
- Rules: Applied automatically; see `.cursor/rules/README.md`.
