# Risk Register

Use this file for active delivery, quality, security, release, and operational risk.

## Entry format

- Risk:
- Severity:
- Area:
- Why it matters:
- Mitigation:
- Trigger to revisit:
- Owner:

## Active risks

- Risk: Validation baseline is still partially inferred or unproven
  Severity: Medium
  Area: validation / onboarding
  Why it matters: The repo-local confidence model still depends on confirming format or lint, typecheck, integration tests, and additional inferred lanes against real commands instead of inference alone.
  Mitigation: Run the smallest real repo-local validation lane, replace fallback lines in `TEST_STRATEGY.md`, and record exact passing evidence in `_system/context/CURRENT_STATUS.md`.
  Trigger to revisit: After the first successful repo-local validation run, when toolchain assumptions change, or before any release-readiness claim.
  Owner: current maintainer or active agent

- Risk: Generated delivery surfaces may not match the repo's real packaging and install needs yet
  Severity: Medium
  Area: packaging / install
  Why it matters: ops/, packaging/, mobile/, ai/ are present or inferred, but they still need repo-local review and proof before any distribution or deployment claim is trustworthy.
  Mitigation: Review generated runtime surfaces, confirm packaging targets and installer commands in `_system/PROJECT_PROFILE.md`, and run the first relevant build, install, or smoke proof.
  Trigger to revisit: Before packaging work, before distribution, or after changing deployment targets.
  Owner: current maintainer or active agent

- Risk: Security and compliance posture is not yet repo-specific
  Severity: High
  Area: security / compliance
  Why it matters: The operating system can point to baseline checks, but safety / compliance, security, secret handling, and related security fields are still unset or too generic for confident release or exposure decisions.
  Mitigation: Fill the security and compliance section in `_system/PROJECT_PROFILE.md`, confirm secret-handling and data-classification rules, and keep `bootstrap/scan-security.sh` in the real validation path.
  Trigger to revisit: Before using real secrets, before external exposure, before production-like data handling, or before release readiness.
  Owner: current maintainer or active agent

- Risk: Selected starter blueprint is not yet proven end to end
  Severity: High
  Area: architecture / scope
  Why it matters: `FASTAPI_API` assumes auth model, persistence boundary, migration discipline, background work, and deployment shape, but the repo has not yet proven the first slice across app/, tests/, pyproject.toml       project metadata and dependencies, uv.lock              lock file (or requirements.txt).
  Mitigation: Keep the first milestone narrow, align `PRODUCT_BRIEF.md`, `PLAN.md`, `TEST_STRATEGY.md`, and runtime code around the selected blueprint, and prove Unit tests: `PYTHONPATH=. pytest -q` | Build check: `python3 -m compileall app` | Lint: `ruff check .` (if configured) | Format: `ruff format .` (if configured) | Typecheck: `mypy app/` (if configured) | Dev server: `uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload`.
  Trigger to revisit: After the first blueprint-aligned vertical slice passes, if one surface forces a contract change, or if product scope starts fighting the chosen blueprint.
  Owner: current maintainer or active agent

## Watch list

- Replace or remove these seeded first-pass risks once repo-local validation evidence and project-specific profile truth exist.
- Add or tighten operational risk entries as soon as ports, background services, deployment topology, or release policy become concrete.

## Usage rules

- Keep this focused on real risk, not generic worry.
- Cross-link material unresolved issues from `FIXME.md`.
