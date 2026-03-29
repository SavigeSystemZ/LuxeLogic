# Skill: Evaluation + Red-team Harness

Steps
1) Redaction preflight (hard-fail on secrets).
2) Static checks (injection phrases, unsafe patterns, tool misuse indicators).
3) Optional dynamic adversarial suite.
4) Emit findings with remediation steps.
5) Gate export if severity threshold exceeded.

Outputs
- evaluation_report.json
- evaluation_summary.md
- regression corpuses (good + bad)
