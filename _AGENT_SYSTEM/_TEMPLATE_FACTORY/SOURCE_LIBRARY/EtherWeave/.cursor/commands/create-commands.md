# Create Commands

Use this when you want to add a new Cursor slash command for this project.

## How Cursor commands work

- **Location**: `.cursor/commands/` (project) or `~/.cursor/commands/` (global).
- **Format**: Plain Markdown (`.md`). The **filename** (without .md) becomes the command name (e.g. `code-review.md` → `/code-review`).
- **Content**: The instruction/prompt sent to the agent when the user runs the command. Write clear, actionable steps.
- **Discovery**: Commands appear when the user types `/` in the Agent chat input.

## Steps to create a command

1. Create a new file: `.cursor/commands/<command-name>.md`. Use lowercase and hyphens (e.g. `my-workflow.md`).
2. Write a short title (first line, e.g. `# My Workflow`) and the instruction body in plain Markdown. Be specific: what should the agent do when this command is run?
3. Optionally reference skills, rules, or docs (e.g. "Use the etherweave-X skill", "See PROJECT_RULES.md").
4. List the new command in `.cursor/commands/README.md` so others know it exists.

## Example

**File**: `.cursor/commands/quick-verify.md`

```markdown
# Quick Verify

Run verification and report results.

Do this now:
1. Run `tools/verify.sh`. If missing, run `python tools/fitness_check.py` or pytest.
2. Paste the exact command and output.
3. If fail, suggest one fix and stop.
```

Result: User types `/quick-verify` in chat → agent receives the above as context and runs verification.

Reference: [Cursor Docs – Commands](https://cursor.com/docs/context/commands).
