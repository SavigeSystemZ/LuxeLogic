# Subagent Protocol

This protocol defines how subagents are invoked, what they can do, and how outputs
are handed back to the primary agent.

## Purpose
- Speed up work by delegating focused tasks to role-specific subagents.
- Keep outputs reviewable, safe, and aligned with repo rules.

## Safety Rules (Binding)
- Authorized/lab use only.
- No automated exploitation or traffic disruption.
- If a task requests restricted actions, respond with disabled stubs and a compliance note.

## Input Package
Each subagent receives:
- Role prompt (from `prompts/subagents/`).
- Task description (text or file).
- Optional context files (repo paths).

## Output Format (Required)
1) Summary
2) Findings
3) Proposed Changes (file paths + rationale)
4) Tests/Verification
5) Risks + Rollback
6) Open Questions (if any)

If a patch is proposed, include a `PATCH:` block at the end.

## Handoff Artifacts
- Input: `contexts/subagents/<run_id>/<agent>/input.md`
- Output: `contexts/subagents/<run_id>/<agent>/output.md`
- Context file list: `contexts/subagents/<run_id>/context_files.txt`
- Logs: `logs/subagents/<timestamp>_<agent>.md`

## Supervisor Usage (Ollama CLI)
- List models:
  - `python tools/subagent_supervisor.py list-models`
- Run a subagent:
  - `python tools/subagent_supervisor.py run --agent wireless_capture --task-file tasks/capture.md --context docs/SESSION_STATE.md`

## Fallback Mode
If Ollama is unavailable or the run fails, the supervisor writes a manual prompt
file and exits with a non-zero code. Manual invocation can then be performed
with any local model.

## Model Selection (Default Order)
1) `deepseek-coder:33b`
2) `codellama:34b-instruct`
3) `codellama:34b`
4) `codellama:13b-instruct`

Install a missing model with:
- `ollama pull deepseek-coder:33b`
