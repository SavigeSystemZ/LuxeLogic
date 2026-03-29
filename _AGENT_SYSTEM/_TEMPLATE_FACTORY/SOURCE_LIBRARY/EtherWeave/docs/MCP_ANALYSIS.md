# MCP Analysis — Etherweave

Analysis of candidate MCP servers for the Etherweave workspace: what to use now, what to add when you add mobile/web, and what to skip. Aligned with current stack (PyQt6 desktop, SQLite, Semgrep/Socket/Ref/Sentry) and roadmap (mobile app later, web-based version later).

---

## Summary table

| MCP | Verdict | When / Why |
|-----|---------|------------|
| **Bitrise** | Add later | When you start the mobile app (mobile CI/CD). |
| **Browserbase** | Skip | Overlaps with cursor-ide-browser / cursor-browser-extension; add only if you need cloud headless at scale. |
| **Browser Use** | Add when used | Only if you adopt the browser-use Python library in code. |
| **CodeSherlock** | Skip | Overlaps with Semgrep; Semgrep is mandated first. |
| **Corridor** | Skip | Overlaps with Semgrep for security guardrails; adds complexity. |
| **DBHub** | Add later | When you add a non-SQLite DB (e.g. Postgres for web backend). |
| **Firecrawl** | Maybe later | Web scrape/search for research; not critical for desktop app now. |
| **Fluid Attacks** | Skip | Redundant with Semgrep unless you standardize on Fluid Attacks. |
| **Harness** | Add later | When you standardize CI/CD on Harness (GitHub Actions is enough for now). |
| **Jam** | **Use** | Screen recorder + auto context for bugs/docs; low friction, no conflict. |
| **Playwright** | Add later | When you have a web app and need E2E test authoring. |
| **Replicate** | Maybe later | When you add ML/AI model calls (e.g. traffic analysis). |
| **Sentry** | **Use** | Already configured; keep for errors/monitoring. |
| **Vale** | **Use** | Doc/markdown style and grammar; improves README/docs. |
| **Zapier** | Maybe later | Integrations (Slack, Notion, etc.); not core to dev workflow. |
| **You.com** | Skip | Overlaps with Ref + Context7; one search/doc stack is enough. |
| **Vault** | Add later | When you adopt HashiCorp Vault for secrets (e.g. team/cloud). |

---

## Per-MCP analysis

### Use now

- **Sentry** — Already in `.cursor/mcp.json`. Error tracking and performance context; no conflict. Keep.
- **Jam** — Screen recorder with auto context for debugging and docs. Complements existing tools; no overlap with Semgrep/Socket/Ref. **Recommendation:** Add to workspace MCP config.
- **Vale** — Style and grammar linting for docs (Markdown, README, etc.). Improves documentation quality; no conflict. **Recommendation:** Add when you want doc linting in the agent loop.

### Add when you start the mobile app

- **Bitrise** — Mobile CI/CD and build management. Fits when you have an iOS/Android or cross-platform mobile app. Not needed for current desktop-only repo. Add when you create the mobile app project or monorepo mobile target.

### Add when you have a web-based version

- **Playwright** — E2E browser testing. Fits when you have a web UI; use Playwright MCP to author and maintain E2E tests. You already have `.tdad` Playwright references; the MCP helps the agent work with those tests. Add when the web app exists and E2E is in scope.
- **Browser Use** — Only if you use the [browser-use](https://github.com/browser-use/browser-use) Python library in your codebase. The MCP exposes that library’s docs. Skip until you adopt the library (e.g. for web automation in a future web/mobile flow).

### Add when you change backend or secrets

- **DBHub** — Universal DB connector (MySQL, PostgreSQL, SQL Server). Current app uses SQLite only. Add when you introduce a non-SQLite DB (e.g. Postgres for a web backend or multi-user deployment).
- **Vault** — HashiCorp Vault for secrets. You currently use SudoCache + env and no Vault. Add when you move to Vault for team or cloud deployments (do not store Vault tokens in repo).

### Add later if you standardize on them

- **Harness** — CI/CD and software delivery. You have GitHub Actions (e.g. `.github/`). Add Harness MCP only if you migrate or add Harness as the primary CI/CD platform.
- **Firecrawl** — Web crawling/scraping API for AI. Useful for research or scraping targets within authorization. Low priority for current desktop feature set; consider when you need structured web data in the agent.
- **Replicate** — Run AI/ML models via cloud API. Consider when you add features that call external models (e.g. traffic or vulnerability prediction). Not required for current scope.
- **Zapier** — Workflow automation across apps. Useful for “Etherweave → Slack/Notion/etc.” once the product is stable. Optional; add when you need those integrations.

### Skip (overlap or redundancy)

- **Browserbase** — Headless browser sessions in the cloud. You already have cursor-ide-browser and cursor-browser-extension for in-IDE browser automation. Adding Browserbase would duplicate capability unless you need cloud headless at scale (e.g. many parallel sessions). Skip for now.
- **CodeSherlock** — AI code analysis for security, quality, compliance. Semgrep is already the mandated first choice for security (see `.cursor/rules/semgrep.mdc`). Socket covers dependency/supply-chain. CodeSherlock overlaps with both. Skip to avoid duplication and conflicting guidance.
- **Corridor** — Security guardrails to reduce vulnerabilities. Semgrep already provides security scanning and rule-based guardrails. Adding Corridor would be a second policy layer. Skip unless you later decide to standardize on Corridor instead of or in addition to Semgrep.
- **Fluid Attacks** — Security vulnerability scanning. Semgrep covers code security; Socket covers deps. Fluid Attacks would be a third scanner. Skip unless you have a subscription and plan to consolidate on it.
- **You.com** — AI-powered web search. You have Ref (token-efficient doc search) and Context7 (up-to-date docs). Adding You.com would triple search/doc-style tools without clear gain for this repo. Skip; use Ref + Context7.

---

## Recommended next steps

1. **Add now (no new keys):** Jam, Vale — both useful and non-overlapping.
2. **Leave for later:** Bitrise (mobile), Playwright (web E2E), DBHub (non-SQLite), Vault (secrets), Harness (CI), Firecrawl, Replicate, Zapier — add when the corresponding feature or infra exists.
3. **Do not add:** Browserbase, Browser Use (until library is used), CodeSherlock, Corridor, Fluid Attacks, You.com — overlap or redundancy with current MCPs and rules.

If you want, we can add **Jam** and **Vale** to `.cursor/mcp.json` next (and document them in `docs/MCP_SETUP.md`). Bitrise, Playwright, DBHub, and Vault can be added to the “Optional / add later” section of `MCP_SETUP.md` with one-line triggers (e.g. “Add Bitrise when starting mobile app”).
