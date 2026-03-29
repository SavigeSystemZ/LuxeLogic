# Ledger Loop — FIXME / TODO Index

**Purpose:** Index of inline `TODO`/`FIXME` markers and unresolved tracked follow-ups.

---

## How this index is maintained

- `TODO.md` is the authoritative backlog with priorities and checkboxes.
- This file tracks inline marker usage and links to the active unresolved work.
- Suggested scan command:
  - `rg -n --hidden --glob '!node_modules/**' --glob '!.git/**' --glob '!dist/**' --glob '!dist-electron/**' --glob '!client/dist/**' --glob '!release/**' '(TODO:|FIXME:|XXX|HACK)'`

---

## Inline markers snapshot (2026-03-04)

| Scope | Result | Notes |
|------|--------|-------|
| `src/`, `client/`, `scripts/`, `electron/` | No active inline TODO/FIXME/HACK markers | Current technical debt is tracked in `TODO.md` instead of inline comments. |
| Docs/system files | Marker text exists in meta docs and index references | Expected (documentation only). |

---

## Active unresolved items (from TODO.md)

- H.7 Cross-desktop QA (GNOME/KDE/XFCE) pending environment signoff runs (`npm run ops:h7:desktop-qa`) and manual evidence completion in `docs/CROSS_DESKTOP_QA_LOG.md`.
- H.12 Host privileged execution pass (interactive sudo install + verify-install validation).
- H.14 MCP runtime reload verification (session restart and MCP resources/templates enumeration; latest in-session tool checks still returned `resources=[]`, `resourceTemplates=[]`).

---

## Related references

- `TODO.md` (canonical backlog)
- `AGENT_CONTEXT.md` Section 7 and 8.3
- `_system/WHERELEFTOFF.md`
