# AIAST System Review 2026-03-22

Maintainer-only review performed from the completed MOS baseline after the source-boundary hardening follow-through.

## Findings

### 1. Medium: installed MOS repos still start with placeholder continuity surfaces and no seeding path

- Evidence:
  - `MOS_TEMPLATE/bootstrap/init-meta-project.sh` installs files, writes metadata, and regenerates derived outputs, but it does not seed working state or suggest initial meta repo facts.
  - `MOS_TEMPLATE/bootstrap/README.md` lists bootstrap commands and lifecycle helpers, but no `seed` or `suggest` step exists for installed MOS repos.
  - `MOS_TEMPLATE/META_TODO.md`, `MOS_TEMPLATE/META_WHERE_LEFT_OFF.md`, and `MOS_TEMPLATE/meta_system/context/CURRENT_STATUS.md` still ship placeholder or unset continuity state.
- Impact:
  - newly installed system-of-systems repos begin with weak handoff state exactly where continuity should be strongest
  - a MOS-installed repo is more exposed to outage/reset friction than an AIAST-installed app repo, because AIAST already seeds working state while MOS does not
- Recommended action:
  - add MOS equivalents of working-state seeding and initial meta-profile/status suggestion
  - validate the resulting installed continuity surfaces in a clean-room MOS smoke

### 2. Medium: master-repo automation still does not validate maintainer continuity freshness in `_META_AGENT_SYSTEM`

- Evidence:
  - `_TEMPLATE_FACTORY/run-automation-lane.sh` delegates to `_TEMPLATE_FACTORY/validate-master-template.sh` plus optional smokes, but none of those steps inspect `_META_AGENT_SYSTEM/`
  - `_TEMPLATE_FACTORY/validate-master-template.sh` only validates `TEMPLATE/`, factory donor governance, and clean-room app-facing smoke flows
  - the current repo required manual continuity repair after the outage because there was no automated signal that the maintainer packet had drifted behind the real work
- Impact:
  - the master repo can regress into stale maintainer planning or handoff state without any automated warning
  - another interruption could still leave the maintainer packet truthy in some files and stale in others unless humans remember to check it explicitly
- Recommended action:
  - add a maintainer-only continuity validator or scripted checklist for `_META_AGENT_SYSTEM/`
  - keep that check separate from installed-product neutrality rules, but make it part of the normal maintainer handoff workflow

## Open Questions And Assumptions

- This review focused on continuity, bootstrap, and validation surfaces for the system-building workflow rather than every AIAST document or prompt pack.
- It assumes MOS should eventually provide continuity quality at least comparable to AIAST for newly installed repos.

## Recommended Next Actions

1. Implement MOS working-state seeding so installed meta repos do not start from placeholder continuity files.
2. Add a maintainer-only validator or checklist for `_META_AGENT_SYSTEM` freshness and handoff completeness.
3. Re-run both automation lanes plus the new continuity checks after those changes land.

## Change Summary

- Review completed against the current validated baseline after the source-boundary hardening batch.
- The highest-value next work is continuity automation, not more source-boundary repair.

## Resolution Notes

- Finding 1 was addressed in this session by adding `MOS_TEMPLATE/bootstrap/seed-meta-working-state.sh`, wiring it into the MOS install/missing-file path, adding `MOS_TEMPLATE/bootstrap/suggest-meta-baseline.sh`, and extending `_MOS_TEMPLATE_FACTORY/smoke-installed-meta-repo.sh` to prove the seeded and suggested `META_*` surfaces.
- Finding 2 was addressed in this session by adding `_TEMPLATE_FACTORY/validate-meta-workspace.sh`, wrapping it in `_TEMPLATE_FACTORY/run-maintainer-lane.sh`, and validating the current `_META_AGENT_SYSTEM/` continuity packet with that dedicated lane.
