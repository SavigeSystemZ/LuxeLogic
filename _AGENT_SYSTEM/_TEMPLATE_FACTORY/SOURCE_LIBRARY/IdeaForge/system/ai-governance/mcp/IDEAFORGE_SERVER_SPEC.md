# IdeaForge MCP Server Spec (Design Only)

Goal: expose IdeaForge capabilities to external AI hosts (Claude Code, IDEs, agents) via MCP Tools/Resources/Prompts.

Principle: **read-only by default**. Any write/mutate tools are explicit and can be disabled per workspace policy.

## 1) Resources (read-only)
- idea://{ideaId}
  - Returns idea metadata + latest summary.
- artifact://{artifactId}@{version}
  - Returns exact immutable artifact content.
- export://{exportId}
  - Returns export manifest + redaction/eval summaries.

## 2) Tools (callable)
### 2.1 Read-only baseline toolset (recommended default)
- ideaforge.listIdeas(filter?)
- ideaforge.getIdea(ideaId)
- ideaforge.listArtifacts(ideaId)
- ideaforge.getArtifact(artifactId, version?)
- ideaforge.searchIdeas(query, mode=keyword|semantic*)
- ideaforge.getRun(runId)
- ideaforge.getEvalReport(evalRunId)

### 2.2 Mutating tools (optional, gated)
- ideaforge.createIdea(payload)
- ideaforge.updateIdea(ideaId, patch)
- ideaforge.createArtifact(ideaId, type, content)  # typically internal use
- ideaforge.runRecipe(ideaId, recipeId, params)
- ideaforge.exportBundle(ideaId, selectionPolicy=approved|latest, gates=on|off)
- ideaforge.approveArtifact(artifactId, version, notes)

Policy requirements:
- Mutating tools require explicit enablement per workspace.
- For any tool that triggers export or writes artifacts:
  - enforce redaction preflight
  - enforce evaluation gates (if enabled)
  - record audit events

## 3) Prompts (reusable templates)
- prompt://blueprint.generate
- prompt://milestones.generate
- prompt://promptpacks.generate
- prompt://threatmodel.generate
Each prompt references IdeaForge canonical docs and uses strict delimiters.

## 4) AuthZ + scopes (recommended)
Use progressive scope model:
- baseline: ideaforge:read
- elevation: ideaforge:write, ideaforge:export, ideaforge:admin

## 5) Security notes
- Treat all host requests as untrusted inputs.
- Never pass through tokens to upstream services.
- Always record correlation IDs for requests and scope elevations.
