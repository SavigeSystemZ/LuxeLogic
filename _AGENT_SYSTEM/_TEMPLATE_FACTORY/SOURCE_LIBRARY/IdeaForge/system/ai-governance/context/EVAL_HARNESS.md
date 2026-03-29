# Evaluation + Red-team Harness (vNext)

Objective: detect common LLM-app risks before exporting or using artifacts with agentic coding tools.

## Risk categories (aligned with OWASP LLM Top 10 themes)
- Prompt injection (direct/indirect)
- Sensitive information disclosure
- Excessive agency (tool misuse)
- Insecure output handling
- Supply chain risks (templates/plugins)
- Unbounded consumption (runaway loops)

## MVP eval design
1) Static checks:
   - secret patterns
   - injection phrases (e.g., "ignore previous instructions")
   - suspicious tool permissions
2) Optional dynamic checks:
   - adversarial prompt suite against a chosen model
3) Findings and gates:
   - severity low/med/high/critical
   - block export above threshold (configurable)

## Stored outputs
- evaluation_report.json
- evaluation_summary.md
- evidence.md (minimal + sanitized)

## Validation
- "known-bad" corpus triggers expected findings
- "known-good" corpus stays clean
