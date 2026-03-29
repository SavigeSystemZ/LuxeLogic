# TODO

## Current Priority

- [x] Ship AIAST 1.14.0 comprehensive enhancement pass (M1-M9)
- [x] Fix post-release consistency (path category, managed files, KEY.md, indexes)
- [x] Run factory lanes for 1.14.0
- [x] Deploy 1.14.0 to all 18 downstream repos
- [x] Fix 4 downstream repos with pre-existing issues
- [x] Build real app code in 3 test repos and run full runtime proofs
- [x] Fix shell quoting bug in Python-inline scripts (shlex.quote)
- [x] Refresh 8 additional downstream repos
- [x] All 18 downstream repos pass validate-system.sh --strict
- [x] Commit template source changes (quoting fix + review notes)
- [x] Formalize handoff governance (HANDOFF_PROTOCOL.md)
- [x] Add evidence quality validation (check-evidence-quality.sh)
- [x] Add working-file staleness detection (check-working-file-staleness.sh)
- [x] Add bootstrap permissions checker (check-bootstrap-permissions.sh)
- [x] Enhance WHERE_LEFT_OFF.md and TODO.md templates
- [x] Integrate new checks into system-doctor (16 total)
- [x] Version bump to 1.16.0 and 1.16.0 with all version surfaces updated
- [x] Confirm automation lane passes on 1.16.0
- [ ] Commit and push 1.16.0
- [ ] Hold further product changes unless downstream evidence shows a gap

## Ready Queue

- [ ] Optionally refresh downstream repos to 1.16.0 with
  `update-template.sh --refresh-managed`
- [ ] EtherWeave: user needs `sudo chown` on root-owned app files
- [ ] Keep using `COMPLETION_SHEET.md` as the primary finish-line reference
  before opening any new speculative work
- [ ] Revisit automatic Flutter project generation only if future downstream
  evidence shows the documented bootstrap step is not enough

## Completed This Session

- [x] Committed 1.14.0 shell quoting fix and downstream hardening (98193a8)
- [x] Pushed to origin/main
- [x] Ran comprehensive system audit (10 areas, 50+ findings)
- [x] Built HANDOFF_PROTOCOL.md with required fields, evidence standard,
  anti-patterns
- [x] Built check-evidence-quality.sh (ungrounded claim detection)
- [x] Built check-working-file-staleness.sh (git timestamp + cross-check)
- [x] Built check-bootstrap-permissions.sh (with --fix mode)
- [x] Found and fixed 3 real permission issues in bootstrap scripts
- [x] Enhanced WHERE_LEFT_OFF.md template (required fields, examples)
- [x] Enhanced TODO.md template (priority signals, Completed section)
- [x] Updated EXECUTION_PROTOCOL.md, VALIDATION_GATES.md,
  HALLUCINATION_DEFENSE_PROTOCOL.md, CONTEXT_INDEX.md, LOAD_ORDER.md
- [x] Integrated 3 new checks into system-doctor.sh (16 total)
- [x] Bumped version to 1.16.0 across all version surfaces
- [x] Regenerated SYSTEM_REGISTRY.json, KEY.md, INTEGRITY_MANIFEST.sha256
- [x] system-doctor.sh --strict → system_doctor_ok (16/16)
- [x] run-maintainer-lane.sh → maintainer_lane_ok
- [x] Updated meta workspace: PLAN.md, WHERE_LEFT_OFF.md, CURRENT_STATUS.md,
  COMPLETION_SHEET.md, TODO.md
