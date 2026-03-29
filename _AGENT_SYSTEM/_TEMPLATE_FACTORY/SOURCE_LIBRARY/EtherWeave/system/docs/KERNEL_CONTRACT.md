# CODEX + CURSOR KERNEL CONTRACT — World-Class Implementation Mode

This contract defines how work is executed in this repo so changes are **correct, verified, safe, reviewable, and shippable**.

## Mission
Deliver code that works on first run (verified), is modular/scalable/maintainable, secure-by-default, and performant for intended usage.

## Non-negotiables
- Verification-first: a Step is not “done” until applicable checks pass.
- Verifiable execution: break work into **verifiable units**; keep diffs focused and reviewable.
- Safety: do not commit secrets; do not weaken security controls; do not log sensitive data.
- Defensive posture: the default branch is a defensive/authorized assessment platform. High-risk capabilities are quarantined by default.

## Work Breakdown Structure (WBS)
All work is structured as:
**Milestone(s) → Phase(s) → Step(s) → Step Part(s)**

Definitions:
- **Milestone**: a major deliverable producing user-visible value.
- **Phase**: a cohesive chunk of a milestone (design, implementation, tests, hardening, docs, release).
- **Step**: the smallest unit that can be implemented **and verified** in one sitting.
- **Step Part**: subdivision of a Step when size/context/tool limits are exceeded.

WBS rules:
1) Every job declares scope: Milestone → Phase → Step (→ Step Parts if needed).
2) If a Step is large/risky, split into multiple Steps.
3) If a Step risks exceeding context/tool limits, split into Step Parts and complete sequentially.
4) Multiple Steps/Phases may be completed in one run only if clearly within limits; still report each distinctly.

## Per-job execution loop (always)
1) Outcome: restate “done” in one sentence.
2) Scope: list WBS scope explicitly.
3) Plan: files touched + design choices + acceptance criteria.
4) Implement: minimal focused diffs with clean separation of concerns.
5) Verify: run checks; if you cannot run them, provide exact commands to run.
6) Report: what changed, where, why; verification commands; next steps.

## Definition of Done (DoD)
A Step is done only when:
- It builds/runs (or imports) as applicable.
- Verification gates pass (tests/lint/typecheck/build/smoke as applicable).
- Expected failure modes are handled.
- Observability is added where relevant (structured logs/metrics) without leaking sensitive data.
- Docs/templates are updated where needed.
- No unrelated code was modified.

## Best-option selection
Choose the most robust and modern approach that fits constraints:
- Prefer standard libraries + proven patterns.
- Avoid deprecated/legacy patterns.
- If multiple valid options exist: present 2–3 options with tradeoffs; pick the best default.

## Debug/Repair is first-class
If anything fails (crash/wrong output/UI regression/perf regression):
- Stop feature work.
- Follow the Debug/Repair Playbook: `docs/DEBUG_REPAIR_PLAYBOOK.md`.
- Do not proceed until verification passes OR the issue is explicitly tracked as a Known Issue.

## Phase checkpoint protocol (PCP)
At the end of every Phase:
**Verify → Commit → Push/Sync → Protected Snapshot Backup → Context Pack**

Protocol: `docs/PHASE_CHECKPOINT_PROTOCOL.md`
