# Security Check

Check the current or specified code for security and validation compliance.

**Do this now:**
1. Identify the code in scope (current file, selection, or user-specified path).
2. Check: **ValidationLayer** — All user-facing and external input validated before processing. **SudoCache** — Sudo used via SudoCache only; no stored passwords. **LootManager** — Handshakes, passwords, credentials stored encrypted; no plain text. **Parameterized queries** — No string concatenation for user input in SQL. **Authorization** — Privileged ops gated by auth/sudo cache; no silent privilege escalation. **Secrets** — No hardcoded secrets, API keys, or credentials; no logging of sensitive data.
3. Report findings: Critical (must fix), Suggestion (should fix), Nice to have. Cite file:line and suggest fixes.
4. Recommend a lightweight secrets scan before push if available.
5. **When in Cursor**: Use **Semgrep MCP** (security_check / semgrep_scan) for code and command security scanning when available. See docs/MCP_SETUP.md and .cursor/rules/semgrep.mdc.

Reference: **etherweave-security** subagent, `.cursor/rules/etherweave-security-auth.mdc`, PROJECT_RULES.md, docs/MCP_SETUP.md.
