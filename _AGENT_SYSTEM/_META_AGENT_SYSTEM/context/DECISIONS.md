# Decisions

Record durable decisions for the master-repo-only meta-system workspace.

## Entries

- Date: 2026-03-22
  Decision: keep AIAST-maintainer planning, research, handoff state, and future system-design files in `_META_AGENT_SYSTEM/` instead of in installable working files under `TEMPLATE/`
  Reason: installed app repos should inherit neutral app-facing scaffolds, not master-template maintenance context
  Impact: future "system for the system" files should be created here unless they are intentionally part of the installable product
  Follow-up: keep `TEMPLATE/` app-facing and neutral while building the next meta-system layer in this workspace

- Date: 2026-03-22
  Decision: build the Meta Operating System as a separate installable product in `MOS_TEMPLATE/` with its own factory lane in `_MOS_TEMPLATE_FACTORY/` and donor intake in `MOS_SOURCE_LIBRARY/`
  Reason: the system that builds system templates needs installable contracts and validation without contaminating either the app-facing AIAST product or the maintainer-only workspace
  Impact: future installable meta-system changes belong in `MOS_TEMPLATE/`; future maintainer-only design files still belong in `_META_AGENT_SYSTEM/`
  Follow-up: use this workspace for the next user-directed maintainer-only file set and use MOS later to review the existing AIAST system

- Date: 2026-03-22
  Decision: protect both AIAST and MOS install flows with explicit product-root markers, source-root assertions, installed-boundary checks, and negative smoke against using the master repo root as a copy source
  Reason: the main remaining confusion risk was not the directory layout itself but accidental misuse of a broad `--source` path that could copy maintainer-only layers into downstream repos
  Impact: lifecycle commands now reject invalid source roots early, installed repos can prove boundary cleanliness explicitly, and both factory lanes verify that behavior
  Follow-up: keep future installable products on the same guarded source-root pattern instead of relying on conventions alone

- Date: 2026-03-22
  Decision: treat `_META_AGENT_SYSTEM/` as the canonical outage-resume packet for master-repo-only continuity after the MOS foundation milestone
  Reason: installable products must stay neutral, but maintainer work still needs durable goals, tasks, handoff state, and next-step context that survive outages or chat resets
  Impact: active maintainer planning and session continuity now belong in `_META_AGENT_SYSTEM/PLAN.md`, `_META_AGENT_SYSTEM/TODO.md`, `_META_AGENT_SYSTEM/WHERE_LEFT_OFF.md`, and `_META_AGENT_SYSTEM/context/` instead of being reconstructed from chat history
  Follow-up: when the next review or implementation slice starts, update this workspace first and keep new maintainer-only artifacts here unless they are intentionally part of an installable product

- Date: 2026-03-22
  Decision: seed installed MOS continuity surfaces during install and missing-file repair instead of leaving installed repos on placeholder `META_*` defaults
  Reason: a system intended to build future systems should not begin from weaker continuity than the app-facing AIAST product it helps create
  Impact: installed MOS repos now receive an initial baseline in `META_PLAN.md`, `META_TODO.md`, `META_WHERE_LEFT_OFF.md`, `meta_system/context/CURRENT_STATUS.md`, and release-facing state during install flows
  Follow-up: decide whether a separate meta-profile suggestion helper is still needed beyond the new seeding path

- Date: 2026-03-22
  Decision: validate `_META_AGENT_SYSTEM/` freshness with a separate maintainer-only factory check instead of folding that requirement into installable product automation
  Reason: maintainer continuity needs executable proof, but installable product lanes should stay focused on installable surfaces rather than fail because of master-repo-only planning state
  Impact: `_TEMPLATE_FACTORY/validate-meta-workspace.sh` is now the continuity check for the maintainer outage-resume packet
  Follow-up: decide whether that check should remain manual or become part of a dedicated maintainer lane

- Date: 2026-03-22
  Decision: add a lightweight repo-shape suggestion helper for installed MOS repos instead of introducing a new meta-profile contract immediately
  Reason: downstream repos need better onboarding guidance now, but a new canonical meta-profile surface would increase contract complexity before real usage proves the right shape
  Impact: `MOS_TEMPLATE/bootstrap/suggest-meta-baseline.sh` now adds an inferred first focus and next validation command on top of seeded continuity surfaces
  Follow-up: revisit a richer meta-profile contract only if real downstream repos outgrow the lightweight helper

- Date: 2026-03-22
  Decision: wrap the maintainer continuity validator in a dedicated maintainer lane instead of keeping it as a standalone manual check only
  Reason: the validator became useful enough to deserve a named workflow, but it still should not be folded into installable product automation
  Impact: `_TEMPLATE_FACTORY/run-maintainer-lane.sh` is now the maintainer-only continuity lane
  Follow-up: keep using the dedicated lane for maintainer handoff and decide later whether it should grow additional checks

- Date: 2026-03-22
  Decision: make AIAST init, additive install, and update share the same safe onboarding refresh path instead of leaving additive lifecycle flows less capable than fresh install
  Reason: installed app repos need lifecycle parity so missing-file recovery and upgrades restore usable working state and generated runtime scaffolds, not just raw template files
  Impact: `init-project.sh`, `install-missing-files.sh`, and `update-template.sh` now all backfill missing runtime foundations, re-run safe profile inference, reseed working-state defaults, and record the latest structural validation pass
  Follow-up: choose the next broader non-lifecycle app-builder-system slice now that lifecycle parity is no longer a gap

- Date: 2026-03-22
  Decision: make AIAST working-state seeding and identity recovery exact-line and fallback-safe instead of relying on brittle prefix replacements
  Reason: the earlier seeding logic had drifted behind the current installable working-file templates and a blank app-name line could accidentally consume the next profile field label
  Impact: `bootstrap/seed-working-state.sh` is now idempotent against the current template files, profile extraction no longer swallows the next field, and deleted app identity now falls back to the repo basename when no stronger repo-local truth survives
  Follow-up: keep future installable working-file edits aligned with the seeding rules whenever those templates change

- Date: 2026-03-22
  Decision: bring MOS additive recovery and strict lifecycle validation closer to the AIAST lifecycle baseline instead of leaving installed meta-system repos on weaker repair semantics
  Reason: MOS is the system that builds future systems, so its direct missing-file recovery path should regenerate its derived surfaces and its strict lifecycle flows should leave behind explicit validation evidence in installed continuity files
  Impact: `install-meta-missing-files.sh` now regenerates derived MOS outputs and supports strict recovery validation, while strict MOS init and update flows now record the latest successful validation in installed continuity files
  Follow-up: choose the next broader non-lifecycle app-builder-system slice now that both installable products have closed their immediate lifecycle-parity gaps

- Date: 2026-03-22
  Decision: seed `TEST_STRATEGY.md` from inferred validation commands during AIAST onboarding instead of leaving the validation-confidence surface fully manual after profile inference
  Reason: `_system/PROJECT_PROFILE.md` already carried first-pass validation commands, but installed repos still forced agents to reconstruct the repo-local confidence model from a blank `TEST_STRATEGY.md`
  Impact: `bootstrap/seed-test-strategy.sh` now fills first-pass confidence expectations and validation lanes, the shared onboarding refresh path uses it during init, additive recovery, and update, and clean-room smoke proves deleted `TEST_STRATEGY.md` is restored and seeded during additive recovery
  Follow-up: decide whether `RISK_REGISTER.md` should receive a similarly bounded first-pass seed next

- Date: 2026-03-22
  Decision: seed `RISK_REGISTER.md` from inferred profile and confidence signals during AIAST onboarding instead of leaving the risk surface fully manual after validation-strategy seeding
  Reason: installed repos still had to invent an initial risk picture from a blank `RISK_REGISTER.md` even though the profile, validation strategy, and lifecycle state already exposed enough source-bound truth to seed a bounded first pass
  Impact: `bootstrap/seed-risk-register.sh` now fills first-pass onboarding, packaging, and security risk entries, the shared onboarding refresh path uses it during init, additive recovery, and update, and clean-room smoke proves deleted `RISK_REGISTER.md` is restored and seeded during additive recovery
  Follow-up: only add more onboarding seeding if real downstream repos expose repeated manual debt that is specific enough to codify safely

- Date: 2026-03-25
  Decision: treat AIAST `1.13.0` greenfield bootstrap plus MOS `0.1.1` lifecycle parity as the current validated maintainer baseline and drive the next product slice from downstream usage rather than more speculative source-template expansion
  Reason: the maintainer packet had drifted behind the shipped AIAST version, and the March 23 work already covered the obvious bootstrap-product gaps without proving a new concrete follow-up need
  Impact: `_META_AGENT_SYSTEM/` now records the true March 25 validated state, and the next AIAST change should be justified by real downstream friction such as blueprint-surface drift or repeated onboarding debt
  Follow-up: run one real downstream greenfield pilot and only add post-blueprint validation or more onboarding seeding if that pilot exposes a specific repeated gap

- Date: 2026-03-25
  Decision: fix placeholder validation by ignoring `## Entry format` and `## Entry template` schema sections instead of auto-seeding more files after the first downstream pilot
  Reason: the AtlasPilot pilot showed that the immediate problem was false-positive placeholder detection in schema/example sections, not missing blueprint projection or a proven need for more automation
  Impact: AIAST `1.13.1` now keeps `check-placeholders.sh` focused on real unresolved repo-owned blanks, the clean-room blueprint smoke proves that behavior, and the next seeding decision is deferred until another downstream repo shows repeated manual debt in genuinely user-owned fields
  Follow-up: use the next downstream repo or real app repo to decide whether the remaining `PROJECT_PROFILE.md` and continuity blanks should stay manual or justify one more narrow seeding slice

- Date: 2026-03-25
  Decision: do not add another onboarding or continuity-seeding slice after the second downstream pilot
  Reason: the SentinelOps pilot showed that, after a truthful `PROJECT_PROFILE.md` fill and explicit `FLUTTER_ANDROID_CLIENT` selection, placeholder hits collapse to five live-state fields in `_system/context/CURRENT_STATUS.md`; those fields describe active operating reality rather than safe bootstrap defaults
  Impact: future continuity-seeding work still requires evidence from a real downstream repo or app repo instead of more synthetic expansion, and the next AIAST follow-up should not be another seeding slice unless live-repo usage proves it
  Follow-up: revisit `CURRENT_STATUS.md` seeding only if repeated real-repo usage shows the same manual debt can be filled truthfully from durable repo-local evidence

- Date: 2026-03-25
  Decision: fix starter-blueprint recommendation truthfulness after the second downstream pilot instead of leaving clearly filled Android/Flutter repos in low-confidence manual review
  Reason: the SentinelOps pilot showed that the recommender still relied on substring keyword matching and underweighted truthful greenfield profile signals, which let terms like `client` leak toward CLI scoring and kept a concrete mobile-first repo from recommending `FLUTTER_ANDROID_CLIENT`
  Impact: AIAST `1.13.2` now uses boundary-aware keyword matching plus stronger Flutter/Android profile scoring, `_TEMPLATE_FACTORY/smoke-blueprint-recommendation.sh` proves the mobile-first case, and the current validated baseline moves to `1.13.2`
  Follow-up: revisit blueprint recommendation weighting for other app shapes only if future downstream repos expose similarly repeated truthfulness gaps

- Date: 2026-03-25
  Decision: add `_META_AGENT_SYSTEM/COMPLETION_SHEET.md` as a required maintainer continuity surface and use it as the one-stop finish-line tracker
  Reason: `PLAN.md`, `TODO.md`, and `WHERE_LEFT_OFF.md` held the truth, but they no longer gave maintainers or the user a single glanceable view of what is left, what is deferred, what is optional polish, and which testing phases remain
  Impact: the meta workspace now has a canonical completion sheet, `_TEMPLATE_FACTORY/validate-meta-workspace.sh` treats it as part of the required continuity packet, and future sessions should update it before opening new speculative work
  Follow-up: keep `COMPLETION_SHEET.md` aligned with the rest of the continuity packet after each meaningful maintainer session

- Date: 2026-03-25
  Decision: harden `update-template.sh` truthfulness after the first post-`1.13.2` mature-repo proof instead of treating stale-validator upgrade success as acceptable
  Reason: the PromptMage-class proof showed that additive updates could preserve stale target validators, stale version state, and machine-local source-template paths while still reporting success under target-side validation
  Impact: AIAST `1.13.3` now refreshes upgrade-critical version and contract manifests during update, strict updates validate against the canonical source validator chain, installed lifecycle metadata stores a neutral template-source label, and `_TEMPLATE_FACTORY/smoke-update-template.sh` proves additive warning, strict failure, and refresh-managed recovery
  Follow-up: only broaden forced-refresh behavior beyond the current metadata and manifest set if future downstream repos show more upgrade drift than canonical validation plus explicit `--refresh-managed` can handle

- Date: 2026-03-25
  Decision: treat the newly available Flatpak builder smoke as a real product gate and fix the shipped packaging manifest instead of preserving it as an optional environment-only check
  Reason: once the Flatpak runtime was installed locally, `packaging_builder_smoke` no longer skipped and exposed a real defect in the shipped Flatpak manifest: a manifest stored under `packaging/` was still using `"path": "."`, which hid repo-root build artifacts like `dist/<app>` from `flatpak-builder`
  Impact: AIAST `1.13.4` now roots the shipped Flatpak manifest source dir at `..`, the packaging docs explain that contract explicitly, and the current AIAST automation lane now proves `packaging_builder_smoke_ok` instead of a clean skip
  Follow-up: only add more packaging-specific validation if another real builder path exposes a concrete shipped defect

- Date: 2026-03-25
  Decision: close MOS markdown lint debt with a generator fix plus a repo-local lint policy instead of treating `markdownlint_unavailable` as the enduring steady state
  Reason: once `markdownlint-cli2` was installed locally, the MOS lane exposed two real issues: generated host adapters were missing required blank lines around headings and lists, and the prose-heavy MOS docs were being judged against an 80-column `MD013` rule that did not match the repo's documentation style
  Impact: MOS `0.1.2` now emits lint-clean generated host adapters, ships a repo-local `.markdownlint-cli2.jsonc` that disables `MD013`, and the current MOS automation lane proves markdown lint passes with the tool active
  Follow-up: only tighten MOS Markdown policy further if real downstream MOS repos show a better house style or another structural lint defect

- Date: 2026-03-25
  Decision: add exhaustive installable and maintainer-side `KEY.md` surfaces instead of relying only on shorter discovery indexes
  Reason: by the time the test-app campaign phase started, the system had enough managed surfaces that maintainers and downstream agents needed one explicit file-by-file map showing what every file is for and when to use it
  Impact: AIAST `1.13.5` now ships `_system/KEY.md` plus `bootstrap/generate-system-key.sh`, the meta workspace now has `_META_AGENT_SYSTEM/KEY.md`, and both validation layers treat those key surfaces as required continuity inputs
  Follow-up: keep the key surfaces exhaustive but still preserve `_system/CONTEXT_INDEX.md` and `_system/LOAD_ORDER.md` as the faster first-pass read path

- Date: 2026-03-25
  Decision: use the first real API, CLI, and web app proofs to harden strict version checks and downstream Python guidance instead of opening a broader speculative slice
  Reason: the `service-api` proof exposed a real Python packaging gotcha in scaffolded repos with multiple top-level foundation directories, the source template still allowed `_system/instruction-precedence.json` to carry a stale version silently, and `/tmp` on this host blocked compiled Python wheels during real campaign work
  Impact: AIAST `1.13.6` now makes strict validation check `_system/instruction-precedence.json.template_version`, the FastAPI and Python CLI starter-blueprint docs now instruct agents to use `src/` layouts or explicit package discovery, and the campaign guidance now prefers exec-capable output roots under `$HOME/`
  Follow-up: only broaden template rules again if the remaining `control-plane` or future mobile proofs expose another concrete systemic defect

- Date: 2026-03-26
  Decision: use sibling `_AI_AGENT_SYSTEM_TESTS/` sessions plus `_TEMPLATE_FACTORY/prepare-test-session.sh` as the canonical downstream proof root instead of leaving campaign repos under ad hoc home paths or inside the source repo
  Reason: downstream app proofs need an exec-capable sandbox that stays outside `_AI_AGENT_SYSTEM_TEMPLATE/`, keeps app-specific runtime context removable, and matches the existing factory convention that already skips `_AI_AGENT_SYSTEM_TESTS` during broad repo scans
  Impact: future scripted proof sessions now start from `prepare-test-session.sh`, `smoke-test-app-campaign.sh` proves the session layout explicitly, the March 26 canonical session lives under `_AI_AGENT_SYSTEM_TESTS/2026-03-26-campaign-01`, and the current breadth baseline now includes a green `control-plane` proof without contaminating source-repo working state
  Follow-up: only add more sandbox orchestration or cleanup automation if future proof sessions expose another repeated friction point

- Date: 2026-03-26
  Decision: keep the copied Flutter runtime foundation minimal, but explicitly tell agents to run `flutter create --platforms=android .` before expecting full mobile validation and build commands to work
  Reason: the real `ops-mobile` downstream proof showed that the installable mobile scaffold intentionally ships as a lightweight foundation rather than a fully generated Flutter project, so agents need one truthful documented bootstrap step before `flutter analyze`, `flutter test`, or APK builds are possible
  Impact: AIAST `1.13.7` updates the mobile blueprint and runtime mobile docs, `smoke-test-app-campaign.sh` now checks that installed repos receive that guidance, and the canonical `ops-mobile` proof is green through analyze, test, strict validation, and debug APK build
  Follow-up: only automate Flutter project generation inside lifecycle flows if future downstream evidence proves the documented bootstrap step is still insufficient and toolchain availability can be assumed safely
