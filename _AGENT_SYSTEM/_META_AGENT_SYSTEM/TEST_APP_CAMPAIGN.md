# Test App Campaign

Use this file as the maintainer-side launch sheet for the next real round of
test app builds.

## Objective

- Convert the validated AIAST `1.15.0` plus MOS `0.1.2` source tree into a real
  isolated test-session campaign instead of opening the next phase ad hoc
- Cover the primary blueprint families with a first-wave matrix before broader
  downstream trials
- Keep the next build session focused on runtime implementation inside prepared
  repos, not on deciding which repo shapes to bootstrap or where app-specific
  context should live

## Campaign Pack

- Factory script: `_TEMPLATE_FACTORY/prepare-test-app-campaign.sh`
- Session wrapper: `_TEMPLATE_FACTORY/prepare-test-session.sh`
- Smoke proof: `_TEMPLATE_FACTORY/smoke-test-app-campaign.sh`
- Campaign manifest: `_TEMPLATE_FACTORY/test-app-campaigns/core-matrix.json`
- Current validation state: `smoke-test-app-campaign.sh` passes inside
  `./_TEMPLATE_FACTORY/run-automation-lane.sh` and now validates the isolated
  session wrapper, including moved-path rewrite coverage inside generated repos
  plus the copied mobile bootstrap instruction

## Current execution status

- Session root: `/home/whyte/.MyAppZ/_AI_AGENT_SYSTEM_TESTS/2026-03-26-campaign-01`
- Campaign root:
  `/home/whyte/.MyAppZ/_AI_AGENT_SYSTEM_TESTS/2026-03-26-campaign-01/apps`
- Green proofs:
  - `service-api`
  - `admin-cli`
  - `portal-web`
  - `control-plane`
  - `ops-mobile`
- `ops-mobile`
  - passed `bootstrap/validate-system.sh . --strict`,
    `flutter analyze`, `flutter test`, and `flutter build apk --debug`
- `ops-mobile` APK artifact:
  `/home/whyte/.MyAppZ/_AI_AGENT_SYSTEM_TESTS/2026-03-26-campaign-01/apps/ops-mobile/mobile/flutter/build/app/outputs/flutter-apk/app-debug.apk`

## Core Matrix

1. `AIASTControlPlane`
- Blueprint: `UNIVERSAL_APP_PLATFORM`
- Goal: prove the multi-surface platform path first because it stresses the
  broadest set of generated packaging, ops, mobile, and AI surfaces

2. `AIASTPortalWeb`
- Blueprint: `NEXT_JS_FULLSTACK`
- Goal: prove the fullstack web path with explicit frontend plus API framing

3. `AIASTServiceApi`
- Blueprint: `FASTAPI_API`
- Goal: prove the lean service/API path without multi-surface platform weight

4. `AIASTOpsMobile`
- Blueprint: `FLUTTER_ANDROID_CLIENT`
- Goal: prove the mobile-first path with Android-oriented runtime assumptions

5. `AIASTAdminCli`
- Blueprint: `PYTHON_CLI_TOOL`
- Goal: prove the lean CLI path and its narrower operating surface

## Recommended Order

1. Start any further breadth pass from a new `prepare-test-session.sh` session
2. Open another real downstream repo or app repo only if evidence beyond the
   current five green proofs is needed
3. Revisit automatic Flutter project generation only if future downstream
   repos show the documented bootstrap step is still not enough

## Preparation Command

```bash
./_TEMPLATE_FACTORY/prepare-test-session.sh --session-id 2026-03-26-campaign-01 --campaign core-matrix
```

That command produced the current canonical session under sibling
`_AI_AGENT_SYSTEM_TESTS/`.

Prefer an exec-capable output root under `$HOME/` or another normal writable
filesystem. Avoid `/tmp` on hosts where it may be mounted `noexec`, because the
prepared repos may later need to run Python compiled extensions or local build
tool binaries during real app implementation.

## Exit Criteria

- Each prepared repo initializes cleanly from the current template
- Each selected starter blueprint is applied explicitly and recorded in the
  repo-local operating surfaces
- Each prepared repo passes `bootstrap/validate-system.sh <repo> --strict`
- Each prepared repo passes runtime-foundation and packaging-target checks
- `ops-mobile` additionally passes `flutter analyze`, `flutter test`, and a
  real debug APK build after the documented bootstrap step
- The generated campaign manifest becomes the ledger for which test app is
  built next, which validations passed, and which real downstream gaps justify
  future AIAST or MOS changes
- No app-specific runtime context leaks back into `_AI_AGENT_SYSTEM_TEMPLATE/`
