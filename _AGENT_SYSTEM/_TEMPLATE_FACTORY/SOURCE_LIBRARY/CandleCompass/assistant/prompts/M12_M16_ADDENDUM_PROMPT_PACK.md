# UIA Addendum Prompt Pack (M12-M16)

Canonical references:
- `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT.md`
- `assistant/resources/docs/CANDLE_COMPASS_EXPANSION_UIA_BLUEPRINT_ADDENDUM.md`
- `assistant/MASTER_SYSTEM_PROMPT.md`
- `assistant/resources/docs/QUALITY_GATES.md`
- `assistant/resources/docs/REPO_BOUNDARY_AND_BACKUP.md`

Purpose:
- Provide a standardized multi-tool prompt structure for addendum milestones:
  - M12 Navigation & Menu System
  - M13 Theme & Skin Manager
  - M14 Beginner Mode & Guided Tour
  - M15 Branch & Artifact Management
  - M16 Multi-Tool Prompt Pack Extension

Current concrete prompt-pack outputs layered on top of this template:
- `assistant/prompts/M1_DASHBOARD_FRAMEWORK_PROMPT_PACK.md`
- `assistant/prompts/M17_M23_EXPANSION_PROMPT_PACK.md`

## Standard Prompt Structure (Use For Every Tool)

1. Context
   - Name the milestone (`M12`..`M16`)
   - Cite canonical docs
   - State target surface (`main` runtime code vs `assistant/` design artifacts)
2. Task
   - exact functionality
   - exact file paths to create/modify
3. Constraints
   - style/system constraints
   - accessibility/security/risk constraints if applicable
   - branch-awareness constraints (do not touch backup branch artifacts directly)
4. Deliverables
   - files changed
   - tests/docs updates
5. Verification
   - lint/test/build/manual checks
   - milestone-specific done-criteria checks

## Branch-Awareness Language (Reusable Snippet)

Use this in all tool prompts:

"Target branch/surface:
- Runtime product code changes belong on `main` (current working branch).
- Prompt packs, templates, and design-only artifacts belong in the design/tools surface (`assistant/` in this repo).
- Do not modify backup branch content directly; backup updates happen through the documented backup/sync workflow."

## Tool Variants (Template Guidance)

### Cursor Variant
- Usually works best with explicit step list + file paths + acceptance criteria.
- Ask for implementation plus verification commands and brief change summary.

### Codex Variant
- Prefer concise imperative instructions.
- If needed, request code-only output for specific files.
- Call out type-safety, compileability, and exact imports.

### Gemini Variant
- Good for broader reasoning + phased output.
- Ask for implementation, validation steps, and assumptions called out clearly.

### Windsurf / Windsor Variant
- Use direct implementation language with scoped tasks.
- Include branch/surface reminder and explicit "do not touch unrelated files."
- Ask for exact file diffs or a list of touched files + validation.

### Claude Variant
- Works well with structured requirements + safety/constraints.
- Include explicit localStorage keys/contracts, accessibility requirements, and rollback notes where applicable.

## Milestone-Specific Notes

### M12 Navigation & Menu System
- Emphasize keyboard navigation and ARIA attributes.
- Include desktop/mobile validation.

### M13 Theme & Skin Manager
- Emphasize CSS variable/Tailwind token integration.
- Require upload safety constraints for custom backgrounds.

### M14 Beginner Mode & Guided Tour
- Require non-disruptive onboarding flows.
- Persist simplified-mode preference.

### M15 Branch & Artifact Management
- This is mostly `assistant/` docs/scripts/CI workflow work.
- Require safeguards against accidental direct edits to `backup`.

### M16 Multi-Tool Prompt Pack Extension
- Deliverable is prompt-pack content/templates, not runtime code.
- Ensure all tools (Cursor, Codex, Gemini, Windsurf/Windsor, Claude) are covered.
