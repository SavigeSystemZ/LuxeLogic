#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_ROOT="${REPO_ROOT}/TEMPLATE"

export AIAAST_TEMPLATE_ROOT="${TEMPLATE_ROOT}"

exec python3 - "$@" <<'PY'
from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Run opportunistic live external-host smoke against supported installed CLIs "
            "using the canonical exported host-bundle flow."
        )
    )
    parser.add_argument("--app-name", default="LiveHostSmoke")
    parser.add_argument("--temp-root", default="/tmp")
    parser.add_argument("--keep", action="store_true")
    parser.add_argument("--timeout-seconds", type=int, default=90)
    return parser.parse_args()


def run_checked(cmd: list[str], *, cwd: Path | None = None) -> subprocess.CompletedProcess[str]:
    result = subprocess.run(cmd, cwd=cwd, text=True, capture_output=True)
    if result.returncode != 0:
        message = (result.stderr or result.stdout).strip()
        raise RuntimeError(f"Command failed ({' '.join(cmd)}): {message}")
    return result


def prepare_external_host_materials(bundle_path: Path, host_root: Path) -> dict[str, object]:
    bundle = json.loads(bundle_path.read_text())
    startup_files = bundle["prompt_payload"]["startup_files"]
    load_sequence = bundle["load_sequence"]
    next_validation = bundle["prompt_payload"].get("validation", [])

    transcript = {
        "schema_version": "1.0.0",
        "kind": "aiaast-live-host-ingestion-transcript",
        "bundle_kind": bundle["kind"],
        "bundle_contract_path": bundle["bundle_contract_path"],
        "prompt_contract_path": bundle["prompt_emission_contract_path"],
        "authority_policy": bundle["authority"]["host_context_policy"],
        "startup_files": startup_files,
        "load_sequence": load_sequence,
        "next_validation": next_validation,
        "loaded_file_count": len(bundle["included_files"]),
    }
    expected = {
        "bundle_kind": bundle["kind"],
        "authority_policy": bundle["authority"]["host_context_policy"],
        "bundle_contract_path": bundle["bundle_contract_path"],
        "prompt_contract_path": bundle["prompt_emission_contract_path"],
        "startup_files": startup_files,
        "includes_project_profile": "_system/PROJECT_PROFILE.md" in load_sequence,
        "includes_where_left_off": "WHERE_LEFT_OFF.md" in load_sequence,
        "next_validation_count": len(next_validation),
    }

    session_prompt_lines = [
        bundle["prompt_text"].rstrip(),
        "",
        "Bundled repo-local file snapshots:",
    ]
    session_prompt_lines.extend(
        f"- `{item['path']}` ({item['line_count']} lines, sha256 `{item['sha256']}`)"
        for item in bundle["included_files"]
    )
    session_prompt_path = host_root / "host-session-prompt.md"
    transcript_path = host_root / "live-host-ingestion-transcript.json"
    eval_prompt_path = host_root / "live-host-eval-prompt.md"
    schema_path = host_root / "live-host-response-schema.json"

    session_prompt_path.write_text("\n".join(session_prompt_lines).rstrip() + "\n")
    transcript_path.write_text(json.dumps(transcript, indent=2) + "\n")

    eval_prompt = "\n".join(
        [
            "You are a live external host validating an exported AIAAST host bundle ingestion result.",
            "Use only the transcript JSON and session prompt below.",
            "Do not use tools or read other files.",
            "Return JSON only with these keys and no extras:",
            "- bundle_kind",
            "- authority_policy",
            "- bundle_contract_path",
            "- prompt_contract_path",
            "- startup_files",
            "- includes_project_profile",
            "- includes_where_left_off",
            "- next_validation_count",
            "",
            "Transcript JSON:",
            transcript_path.read_text().rstrip(),
            "",
            "Session prompt:",
            session_prompt_path.read_text().rstrip(),
        ]
    )
    eval_prompt_path.write_text(eval_prompt.rstrip() + "\n")

    schema = {
        "type": "object",
        "additionalProperties": False,
        "required": [
            "bundle_kind",
            "authority_policy",
            "bundle_contract_path",
            "prompt_contract_path",
            "startup_files",
            "includes_project_profile",
            "includes_where_left_off",
            "next_validation_count",
        ],
        "properties": {
            "bundle_kind": {"type": "string"},
            "authority_policy": {"type": "string"},
            "bundle_contract_path": {"type": "string"},
            "prompt_contract_path": {"type": "string"},
            "startup_files": {"type": "array", "items": {"type": "string"}},
            "includes_project_profile": {"type": "boolean"},
            "includes_where_left_off": {"type": "boolean"},
            "next_validation_count": {"type": "integer"},
        },
    }
    schema_path.write_text(json.dumps(schema, indent=2) + "\n")

    return {
        "expected": expected,
        "session_prompt_path": session_prompt_path,
        "transcript_path": transcript_path,
        "eval_prompt_path": eval_prompt_path,
        "schema_path": schema_path,
    }


def parse_json_file(path: Path) -> dict[str, object]:
    return json.loads(path.read_text())


def validate_response(response: dict[str, object], expected: dict[str, object]) -> tuple[bool, str]:
    if response != expected:
        return False, f"response mismatch expected={json.dumps(expected, sort_keys=True)} actual={json.dumps(response, sort_keys=True)}"
    return True, ""


def strip_markdown_fences(text: str) -> str:
    stripped = text.strip()
    if stripped.startswith("```"):
        lines = stripped.splitlines()
        if lines and lines[0].startswith("```"):
            lines = lines[1:]
        if lines and lines[-1].strip() == "```":
            lines = lines[:-1]
        stripped = "\n".join(lines).strip()
    return stripped


def run_codex(host_root: Path, eval_prompt_path: Path, schema_path: Path, timeout_seconds: int) -> tuple[bool, str]:
    if shutil.which("codex") is None:
        return False, "missing:codex"

    response_path = host_root / "codex-live-host-response.json"
    transcript_path = host_root / "codex-live-host-transcript.txt"
    cmd = [
        "codex",
        "exec",
        "--ephemeral",
        "-s",
        "read-only",
        "--skip-git-repo-check",
        "-C",
        str(host_root),
        "--color",
        "never",
        "--output-schema",
        str(schema_path),
        "-o",
        str(response_path),
        "-",
    ]
    try:
        with eval_prompt_path.open("r", encoding="utf-8") as handle:
            result = subprocess.run(
                cmd,
                cwd=host_root,
                stdin=handle,
                text=True,
                capture_output=True,
                timeout=timeout_seconds,
            )
    except subprocess.TimeoutExpired:
        return False, "timeout:codex"

    transcript_path.write_text((result.stdout or "") + (result.stderr or ""))
    if result.returncode != 0:
        return False, f"error:codex:{(result.stderr or result.stdout).strip()}"
    if not response_path.is_file():
        return False, "error:codex:missing-response-file"
    try:
        payload = parse_json_file(response_path)
    except Exception as exc:  # noqa: BLE001
        return False, f"error:codex:invalid-json:{exc}"
    return True, json.dumps(payload)


def run_cursor_agent(host_root: Path, eval_prompt_path: Path, timeout_seconds: int) -> tuple[bool, str]:
    if shutil.which("cursor") is None:
        return False, "missing:cursor"

    prompt_text = eval_prompt_path.read_text()
    wrapper_path = host_root / "cursor-live-host-wrapper.json"
    transcript_path = host_root / "cursor-live-host-response.json"
    cmd = [
        "cursor",
        "agent",
        "--print",
        "--output-format",
        "json",
        "--mode",
        "ask",
        "--trust",
        "--workspace",
        str(host_root),
        prompt_text,
    ]
    try:
        result = subprocess.run(
            cmd,
            cwd=host_root,
            text=True,
            capture_output=True,
            timeout=timeout_seconds,
        )
    except subprocess.TimeoutExpired:
        return False, "timeout:cursor"

    wrapper_path.write_text((result.stdout or "") + (result.stderr or ""))
    if result.returncode != 0:
        return False, f"error:cursor:{(result.stderr or result.stdout).strip()}"
    try:
        wrapper = json.loads(result.stdout)
        payload = json.loads(strip_markdown_fences(str(wrapper["result"])))
    except Exception as exc:  # noqa: BLE001
        return False, f"error:cursor:invalid-json:{exc}"
    transcript_path.write_text(json.dumps(payload, indent=2) + "\n")
    return True, json.dumps(payload)


def classify_soft_skip(reason: str) -> bool:
    lowered = reason.lower()
    return any(
        token in lowered
        for token in (
            "missing:",
            "timeout:",
            "login",
            "auth",
            "api key",
            "unauthorized",
            "not signed in",
            "rate limit",
            "quota",
            "billing",
            "forbidden",
        )
    )


args = parse_args()
template_root = Path(os.environ["AIAAST_TEMPLATE_ROOT"]).resolve()
temp_root = Path(args.temp_root).resolve()
temp_root.mkdir(parents=True, exist_ok=True)

tmp_repo = Path(tempfile.mkdtemp(prefix="aiaast-live-host-repo.", dir=temp_root))
tmp_host = Path(tempfile.mkdtemp(prefix="aiaast-live-host-host.", dir=temp_root))

def cleanup() -> None:
    if args.keep:
        print(f"Preserved temp repo: {tmp_repo}", file=sys.stderr)
        print(f"Preserved host workspace: {tmp_host}", file=sys.stderr)
    else:
        shutil.rmtree(tmp_repo, ignore_errors=True)
        shutil.rmtree(tmp_host, ignore_errors=True)


print(f"Temp repo: {tmp_repo}")
print(f"Host workspace: {tmp_host}")

try:
    run_checked(
        ["bash", str(template_root / "bootstrap" / "init-project.sh"), str(tmp_repo), "--app-name", args.app_name, "--strict"]
    )
    run_checked(["bash", str(tmp_repo / "bootstrap" / "check-host-bundle.sh"), str(tmp_repo)])

    bundle_path = tmp_host / "aiaast-host-bundle.json"
    run_checked(
        [
            "bash",
            str(tmp_repo / "bootstrap" / "emit-host-bundle.sh"),
            str(tmp_repo),
            "--task",
            "Live external host CLI smoke",
            "--scope",
            "Factory-side verification of actual external host consumption",
            "--read",
            "_system/PROJECT_PROFILE.md",
            "--read",
            "WHERE_LEFT_OFF.md",
            "--constraint",
            "Keep repo-local truth authoritative.",
            "--validation",
            "bootstrap/validate-system.sh <repo> --strict",
            "--deliverable",
            "Summarize startup files, authority, and next validation.",
            "--output",
            str(bundle_path),
        ]
    )

    materials = prepare_external_host_materials(bundle_path, tmp_host)
    expected = materials["expected"]
    eval_prompt_path = Path(materials["eval_prompt_path"])
    schema_path = Path(materials["schema_path"])

    host_runners = {
        "codex": lambda: run_codex(tmp_host, eval_prompt_path, schema_path, args.timeout_seconds),
        "cursor_agent": lambda: run_cursor_agent(tmp_host, eval_prompt_path, args.timeout_seconds),
    }

    successes: list[str] = []
    soft_skips: list[str] = []
    hard_failures: list[str] = []

    for host_name, runner in host_runners.items():
        ok, payload_or_reason = runner()
        if not ok:
            if classify_soft_skip(payload_or_reason):
                soft_skips.append(f"{host_name}:{payload_or_reason}")
                continue
            hard_failures.append(f"{host_name}:{payload_or_reason}")
            continue

        payload = json.loads(payload_or_reason)
        valid, reason = validate_response(payload, expected)
        if not valid:
            hard_failures.append(f"{host_name}:{reason}")
            continue
        successes.append(host_name)

    if hard_failures:
        print("live_host_cli_smoke_failed")
        for issue in hard_failures:
            print(f"- {issue}")
        raise SystemExit(1)

    if successes:
        if soft_skips:
            print(f"live_host_cli_smoke_partial skipped={' ; '.join(soft_skips)}")
        print(f"live_host_cli_smoke_ok hosts={','.join(successes)} app_name={args.app_name}")
        raise SystemExit(0)

    reason = "no-usable-live-host-cli"
    detail = "; ".join(soft_skips) if soft_skips else "no-supported-live-host-cli-detected"
    print(f"live_host_cli_smoke_skipped reason={reason} detail={detail}")
    raise SystemExit(0)
finally:
    cleanup()
PY
