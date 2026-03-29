# TODO — Next Phases

## Phase 1 (stabilization)
- [x] Restore API-route test pass for large idea payloads.
- [x] Resolve existing TypeScript drift between `lib/types.ts`, `lib/repositories.ts`, and API routes.
- [x] Resolve dashboard typing regressions in `components/dashboard.tsx`.
- [x] Restore green gate: `tsc --noEmit` + `eslint . --max-warnings=0`.

## Phase 2 (database architecture hardening)
- [ ] Migrate runtime persistence from SQLite to PostgreSQL peer-auth (`ideaforge_prod`).
- [x] Add one-time setup script: `scripts/setup_db.sh`.
- [x] Wire installer to run DB setup automatically.
- [x] Add ownership remediation for legacy DB owner mismatch.

## Phase 3 (operational separation)
- [ ] Keep lane-separated branches active (`main`, `system-files`, `backup-ops`).
- [ ] Add PR template checklist requiring lane declaration.
- [ ] Add CI lane checks for docs-only vs runtime-only change scopes.

## Phase 4 (desktop launch quality)
- [ ] Add explicit desktop launcher verification scripts (`check` + `verify`).
- [ ] Capture latest launcher verification log in `WHERE_LEFT_OFF.md`.

## Immediate command set
- `./node_modules/.bin/vitest run tests/api-routes.test.ts`
- `./node_modules/.bin/tsc --noEmit --incremental false`
- `./node_modules/.bin/eslint . --max-warnings=0`
