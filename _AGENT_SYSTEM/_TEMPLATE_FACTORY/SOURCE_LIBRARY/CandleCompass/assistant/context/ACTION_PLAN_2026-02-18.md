# Action Plan: Next Steps for Candle Compass (2026-02-18)

## Executive Summary

**System Status:** ✅ **FULLY OPERATIONAL**

The Candle Compass application is healthy and operational. All core systems are functioning correctly. The "issues" identified are:
1. **Expected authorization errors** (security feature working correctly)
2. **Optional API keys missing** (non-critical, degraded mode works)
3. **Runtime artifacts** (normal operation, may need .gitignore updates)

## Immediate Action Items

### 1. Phase 13 Follow-up: Arbitrage Risk Models ⚠️ HIGH PRIORITY

**Current State:**
- ✅ Settings panel exists with fee/slippage/min-profit controls
- ✅ UI integration complete
- ⚠️ Backend risk calculations needed

**Tasks:**
- [ ] Add depth/liquidity risk model to `app/src/strategies/arbitrage_spatial.py`
- [ ] Add transfer-time risk model to `app/src/strategies/arbitrage_triangular.py`
- [ ] Wire Settings preferences into risk calculations
- [ ] Add risk-adjusted profit calculations
- [ ] Update arbitrage opportunity filtering to use risk-adjusted thresholds

**Files to Modify:**
- `app/src/strategies/arbitrage_spatial.py`
- `app/src/strategies/arbitrage_triangular.py`
- `app/scripts/run_arbitrage_scan.py`
- `app/ui-next/src/lib/arbitrageAssumptions.ts` (verify Settings integration)

**Estimated Effort:** 4-6 hours

### 2. Strategy Lab Runtime Binding ⚠️ HIGH PRIORITY

**Current State:**
- ✅ Templates persist to `runs/latest/strategy_lab_templates.json`
- ✅ Template validation exists
- ⚠️ Runtime activation path missing

**Tasks:**
- [ ] Add runtime activation flag to `runs/latest/strategy_lab_runtime.json`
- [ ] Wire Strategy Lab activation into `app/src/execution/orchestrator.py`
- [ ] Add Strategy Lab override mode to `app/scripts/run_orchestrator.py`
- [ ] Update UI to show activation status
- [ ] Add activation/deactivation controls in Strategy Lab widget

**Files to Modify:**
- `app/src/execution/orchestrator.py`
- `app/scripts/run_orchestrator.py`
- `app/ui-next/src/components/widgets/StrategyLaboratory.tsx`
- `app/ui-next/src/app/api/candle_compass/route.ts` (add activation endpoint)

**Estimated Effort:** 3-4 hours

### 3. Documentation Updates ✅ MEDIUM PRIORITY

**Current State:**
- ✅ Comprehensive documentation exists
- ⚠️ Runtime authorization behavior needs clarification
- ⚠️ API key optionality needs documentation

**Tasks:**
- [ ] Add runtime authorization error explanation to `assistant/resources/docs/APP_USER_GUIDE.md`
- [ ] Add API key configuration checklist (required vs optional)
- [ ] Document expected vs actual error behavior
- [ ] Add troubleshooting section for authorization errors

**Files to Modify:**
- `assistant/resources/docs/APP_USER_GUIDE.md`
- `app/ui-next/src/app/help/page.tsx` (add authorization section)

**Estimated Effort:** 1-2 hours

### 4. .gitignore Updates ✅ LOW PRIORITY

**Current State:**
- ⚠️ Runtime PID files and logs showing as untracked
- ✅ Some runtime artifacts intentionally tracked (database, JSON)

**Tasks:**
- [ ] Review `.gitignore` patterns
- [ ] Add `app/runs/*.pid` pattern
- [ ] Add `app/runs/*.log` pattern (or specific log files)
- [ ] Verify `app/runs/latest/*.json` artifacts remain tracked
- [ ] Document which runtime files should/shouldn't be tracked

**Files to Modify:**
- `.gitignore`
- `assistant/resources/docs/REPO_BOUNDARY_AND_BACKUP.md` (documentation)

**Estimated Effort:** 30 minutes

## Short-Term Priorities (Next 1-2 Weeks)

### 5. Production Readiness Checklist

**Tasks:**
- [ ] Document runtime key setup process
- [ ] Add Redis setup guide for production
- [ ] Create production deployment checklist
- [ ] Add environment variable documentation
- [ ] Add secrets management guide

**Files to Create/Modify:**
- `assistant/resources/docs/PRODUCTION_DEPLOYMENT.md` (new)
- `assistant/resources/docs/OPS_RUNBOOK.md` (update)
- `.env.example` (verify completeness)

**Estimated Effort:** 2-3 hours

### 6. Schema Validation

**Tasks:**
- [ ] Add pydantic models for all `runs/latest` artifacts
- [ ] Add validation in artifact producers
- [ ] Add contract tests for UI bindings
- [ ] Add schema versioning

**Files to Create/Modify:**
- `app/src/validation/artifact_schemas.py` (new)
- `app/scripts/validate_artifacts.py` (new)
- `app/ui-next/src/lib/artifactContracts.ts` (new)
- Update all artifact producers

**Estimated Effort:** 6-8 hours

## Medium-Term Priorities (Next Month)

### 7. Docker Distribution

**Tasks:**
- [ ] Create Dockerfile for backend
- [ ] Create Dockerfile for UI
- [ ] Create docker-compose.yml
- [ ] Add Docker documentation
- [ ] Add CI/CD for Docker builds

**Files to Create:**
- `Dockerfile.backend`
- `Dockerfile.ui`
- `docker-compose.yml`
- `assistant/resources/docs/DOCKER_DEPLOYMENT.md`

**Estimated Effort:** 4-6 hours

### 8. WebGL Acceleration

**Tasks:**
- [ ] Research WebGL libraries (Pixi.js/Three.js)
- [ ] Implement WebGL CVD rendering
- [ ] Implement WebGL heatmap rendering
- [ ] Add Canvas2D/SVG fallback
- [ ] Performance testing

**Files to Create/Modify:**
- `app/ui-next/src/components/charts/WebGLRenderer.tsx` (new)
- `app/ui-next/src/components/widgets/OrderflowHeatmap.tsx` (update)

**Estimated Effort:** 8-12 hours

## Questions for User Decision

### Priority Selection
**Which should we tackle first?**
1. Phase 13 arbitrage risk models (backend calculations)
2. Strategy Lab runtime binding (activation path)
3. Production readiness (keys, Redis, data continuity)
4. Documentation updates (clarify current behavior)
5. Other (specify)

### Runtime Keys
**Should we:**
- A) Set up runtime control keys now (for testing)
- B) Document the setup process only (for production)
- C) Both (setup + documentation)

### API Keys
**Are missing API keys needed for current workflows?**
- Polygon (stock scanner) - Optional
- Reddit/Google (social sentiment) - Optional
- AI Controller Key - Optional (for `/ai/*` endpoints)
- Others - Optional

**Recommendation:** Proceed without them; document optional setup for enhanced features.

### Testing
**Should we add comprehensive tests for:**
- Runtime authorization error handling
- API key optionality (degraded mode)
- Time Machine validation
- Arbitrage risk calculations
- Strategy Lab activation

**Recommendation:** Yes, add tests as we implement features.

## Recommended Next Steps

### Option A: Feature Development (Recommended)
1. **Phase 13 arbitrage risk models** (4-6 hours)
2. **Strategy Lab runtime binding** (3-4 hours)
3. **Documentation updates** (1-2 hours)

**Total:** ~8-12 hours of focused development

### Option B: Production Readiness
1. **Documentation updates** (1-2 hours)
2. **Production deployment guide** (2-3 hours)
3. **Schema validation** (6-8 hours)

**Total:** ~9-13 hours of infrastructure work

### Option C: Quick Wins
1. **.gitignore updates** (30 minutes)
2. **Documentation updates** (1-2 hours)
3. **Production checklist** (1 hour)

**Total:** ~2.5-3.5 hours of polish

## Validation Checklist

After completing any action items:

- [ ] Run `pytest -q` (should pass 135+ tests)
- [ ] Run `cd app/ui-next && npm run lint` (should pass)
- [ ] Run `cd app/ui-next && npm run build` (should pass)
- [ ] Run `cd app/ui-next && npm run test` (should pass 30+ tests)
- [ ] Run `python app/scripts/ui_smoke_test.py --runs app/runs/latest --strict`
- [ ] Run `python app/scripts/e2e_smoke.py --runs app/runs/latest --strict`
- [ ] Update `assistant/context/WHERE_WE_LEFT_OFF.md`
- [ ] Update `assistant/TODO.md` (mark completed items)
- [ ] Update `assistant/context/CHANGELOG.md` (if significant)

## Notes

- All runtime authorization errors are **expected** when runtime control key is not set
- Missing API keys are **optional** - application works in degraded mode
- Runtime artifacts (PID files, logs) are normal - may need .gitignore updates
- Test validation errors are **expected** - they verify input validation works

---

**Status:** Ready to proceed with user-selected priorities.
