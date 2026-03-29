# Plan

Use this file for the current plan of the master-repo-only meta-system
workspace.

## Objective

- Current target outcome: enhance AIAST agent effectiveness through formalized
  handoff governance, evidence quality validation, and working-file staleness
  detection on the hardened `1.14.0` baseline
- Why it matters now: the 1.14.0 downstream hardening pass proved the template
  across 18 repos and 3 runtime test apps, exposing that the handoff quality
  gap is the highest-leverage remaining improvement — bad handoffs waste agent
  context window on state reconstruction instead of productive work
- Forcing function: leave the repo ready for a 1.15.0 version bump with the
  new governance and validation surfaces, and keep future work gated behind
  real downstream evidence

## Success criteria

- `PLAN.md`, `TODO.md`, `WHERE_LEFT_OFF.md`, `COMPLETION_SHEET.md`,
  `TEST_APP_CAMPAIGN.md`, and `context/` all describe the same current reality
- The current AIAST baseline explicitly includes the 1.14.0 downstream
  hardening, shell quoting fix, and the new Phase 12 handoff governance and
  validation enhancements
- The new handoff validation scripts pass on the template source tree
- System-doctor integrates all new checks (16 total)
- The maintainer lane and AIAST automation lane pass on the current source tree

## Current baseline

- AIAST `1.14.0` with 18/18 downstream repos passing `--strict` validation
- Shell quoting fix (shlex.quote) in 4 Python-inline bootstrap scripts
- 3 test apps with full runtime proofs (service-api, portal-web, admin-cli)
- 5 fresh installs and 13 updated downstream repos
- Both factory lanes green (2026-03-28)
- Phase 12 additions:
  - `_system/HANDOFF_PROTOCOL.md` — formalized handoff quality requirements
  - `bootstrap/check-evidence-quality.sh` — scan handoff files for ungrounded claims
  - `bootstrap/check-working-file-staleness.sh` — detect stale working files
  - `bootstrap/check-bootstrap-permissions.sh` — validate script permissions
  - Enhanced `WHERE_LEFT_OFF.md` template with required fields and guidance
  - Enhanced `TODO.md` template with priority signals
  - System-doctor integration (3 new checks, 16 total)
  - 3 bootstrap permission fixes (apply-starter-blueprint.sh,
    check-host-bundle.sh, emit-host-bundle.sh)

## Next execution slice

1. Version bump to `1.15.0` to capture the handoff governance and validation
   enhancements
2. Regenerate host adapters and downstream-facing surfaces
3. Run full factory validation (both lanes)
4. Hold further AIAST or MOS product changes behind real downstream evidence
5. Use `_TEMPLATE_FACTORY/prepare-test-session.sh` for the next external
   proof session if needed
