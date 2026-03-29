# Golden Example Repo Scorecard

Factory-only artifact. This scorecard helps maintainers decide which repos should inform the neutral golden-example pack.

- Generated at: `2026-03-29T18:48:29Z`
- Scan root: `/home/whyte/.MyAppZ`
- Repos scored: `22`

## Scoring inputs

- git presence
- non-generated file count
- test-directory count
- context-file coverage
- docs-directory count
- installed AIAST surface coverage
- runtime-surface breadth
- packaging/install surface breadth
- working-file evidence coverage
- `_system/PROJECT_PROFILE.md` completion ratio when present

## Ranked repos

| Repo | Score | Files | Tests | Context | Profile | Signals |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| LedgerLoop | 114.9 | 677 | 1 | 9 | 100% | strong-context, filled-profile, docs-heavy, packaging-ready, multi-surface, full-aiaast |
| Immortality | 112.0 | 1055 | 1 | 9 | 100% | strong-context, filled-profile, docs-heavy, packaging-ready, full-aiaast |
| TraceForge | 110.5 | 1251 | 2 | 9 | 100% | strong-context, filled-profile, docs-heavy, packaging-ready, full-aiaast |
| CandleCompass | 109.0 | 1791 | 1 | 9 | 100% | strong-context, filled-profile, packaging-ready, multi-surface, full-aiaast |
| Vetraxis | 109.0 | 1470 | 2 | 9 | 100% | strong-context, filled-profile, packaging-ready, multi-surface, full-aiaast |
| EtherWeave | 103.5 | 1776 | 2 | 9 | 0% | strong-context, docs-heavy, packaging-ready, full-aiaast |
| HQIQ | 101.6 | 544 | 5 | 9 | 40% | strong-context, deep-tests, packaging-ready, full-aiaast |
| ShadowCall | 101.0 | 725 | 1 | 9 | 100% | strong-context, filled-profile, packaging-ready, full-aiaast |
| Orignym | 93.7 | 526 | 1 | 9 | 40% | strong-context, packaging-ready, full-aiaast |
| PromptMage | 89.4 | 576 | 0 | 9 | 0% | strong-context, packaging-ready, multi-surface, full-aiaast |
| IdeaForge | 86.0 | 458 | 1 | 9 | 0% | strong-context, packaging-ready, full-aiaast |
| FlipHole | 84.0 | 421 | 0 | 9 | 0% | strong-context, packaging-ready, multi-surface, full-aiaast |
| AgentZero | 66.7 | 409 | 0 | 9 | 0% | strong-context, packaging-ready, full-aiaast |
| SecuritySentinel | 66.4 | 397 | 0 | 9 | 0% | strong-context, packaging-ready, full-aiaast |
| AegisSwarm | 65.8 | 371 | 0 | 9 | 0% | strong-context, packaging-ready, full-aiaast |
| NeuroNest | 65.8 | 371 | 0 | 9 | 0% | strong-context, packaging-ready, full-aiaast |
| VERITAS (dating app...) | 65.8 | 371 | 0 | 9 | 0% | strong-context, packaging-ready, full-aiaast |
| WRAITHS | 65.8 | 371 | 0 | 9 | 0% | strong-context, packaging-ready, full-aiaast |
| AwayMode | 65.7 | 368 | 0 | 9 | 0% | strong-context, packaging-ready, full-aiaast |
| LuxeLogic | 43.5 | 817 | 0 | 0 | 0% | docs-heavy |
| ContextCore | 0.0 | 0 | 0 | 0 | 0% | emerging |
| WraithsCast | 0.0 | 0 | 0 | 0 | 0% | emerging |

## Reading rule

A high score does not automatically make a repo the one golden source. Selection stays curated per pattern so one app does not become the accidental default for every future repo.
