#!/usr/bin/env bash

mos_is_stateful_path() {
  case "$1" in
    "META_PLAN.md"|\
    "META_TODO.md"|\
    "META_FIXME.md"|\
    "META_WHERE_LEFT_OFF.md"|\
    "META_CHANGELOG.md"|\
    "META_RELEASE_NOTES.md"|\
    "meta_system/context/CURRENT_STATUS.md"|\
    "meta_system/context/DECISIONS.md"|\
    "meta_system/context/OPEN_QUESTIONS.md")
      return 0
      ;;
  esac

  return 1
}

mos_is_generated_path() {
  case "$1" in
    "meta_system/META_SYSTEM_REGISTRY.json"|\
    "meta_system/meta-operating-profile.json"|\
    "meta_system/instruction-precedence.json"|\
    "meta_system/mos-capabilities.json"|\
    "meta_system/host-adapters/META_"*|\
    "meta_system/host-adapters/"*.rules)
      return 0
      ;;
  esac

  return 1
}

mos_is_local_config_path() {
  case "$1" in
    "meta_system/.template-install.json"|\
    "README.md"|\
    "AI_META_SYSTEM_README.md")
      return 0
      ;;
  esac

  return 1
}

mos_is_manifest_excluded_path() {
  local rel="$1"

  if mos_is_stateful_path "${rel}" || mos_is_generated_path "${rel}" || mos_is_local_config_path "${rel}"; then
    return 0
  fi

  case "${rel}" in
    *.swp)
      return 0
      ;;
  esac

  return 1
}

mos_template_version() {
  local root="$1"
  local version_file="${root}/meta_system/.template-version"

  if [[ -f "${version_file}" ]]; then
    tr -d '\n' < "${version_file}"
    return 0
  fi

  echo "unknown"
}

mos_assert_template_root() {
  local root="$1"
  local marker="${root}/.installable-product-root"

  if [[ ! -f "${marker}" ]]; then
    echo "Source is not a MOS installable product root: ${root}" >&2
    echo "Expected marker: ${marker}" >&2
    return 1
  fi

  if ! grep -Fxq 'product=MOS' "${marker}"; then
    echo "Source marker does not identify a MOS product root: ${marker}" >&2
    return 1
  fi

  local rel
  for rel in "META_AGENTS.md" "meta_system/.template-version" "bootstrap/init-meta-project.sh"; do
    if [[ ! -e "${root}/${rel}" ]]; then
      echo "Source is missing required MOS template file: ${rel}" >&2
      return 1
    fi
  done

  if [[ "$(mos_detect_repo_mode "${root}")" != "template" ]]; then
    echo "Refusing source that is not in template-source mode: ${root}" >&2
    echo "Only the canonical MOS template root should be used as a lifecycle source." >&2
    return 1
  fi

  for rel in "_META_AGENT_SYSTEM" "_MOS_TEMPLATE_FACTORY" "MOS_SOURCE_LIBRARY" "TEMPLATE" "_TEMPLATE_FACTORY"; do
    if [[ -e "${root}/${rel}" ]]; then
      echo "Refusing source that contains maintainer-only or foreign product layers: ${root}/${rel}" >&2
      echo "Point MOS install/update flows at the canonical template root in template-source mode, usually .../MOS_TEMPLATE" >&2
      return 1
    fi
  done
}

mos_install_metadata_path() {
  local repo_root="$1"
  printf '%s\n' "${repo_root}/meta_system/.template-install.json"
}

mos_install_metadata_value() {
  local repo_root="$1"
  local key="$2"
  local metadata_path
  metadata_path="$(mos_install_metadata_path "${repo_root}")"

  if [[ ! -f "${metadata_path}" ]]; then
    return 0
  fi

  python3 - <<'PY' "${metadata_path}" "${key}"
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
key = sys.argv[2]
try:
    data = json.loads(path.read_text())
except Exception:
    raise SystemExit(0)

value = data.get(key)
if value is not None:
    print(value)
PY
}

mos_detect_repo_mode() {
  local repo_root="$1"
  local install_mode
  local last_event

  install_mode="$(mos_install_metadata_value "${repo_root}" "install_mode")"
  last_event="$(mos_install_metadata_value "${repo_root}" "last_event")"

  if [[ "${install_mode}" == "template-placeholder" || "${last_event}" == "template-source" ]]; then
    printf '%s\n' "template"
  else
    printf '%s\n' "installed"
  fi
}

mos_resolve_repo_mode() {
  local repo_root="$1"
  local requested_mode="${2:-auto}"

  case "${requested_mode}" in
    auto)
      mos_detect_repo_mode "${repo_root}"
      ;;
    template|installed)
      printf '%s\n' "${requested_mode}"
      ;;
    *)
      echo "Unsupported repo mode: ${requested_mode}" >&2
      return 1
      ;;
  esac
}

mos_detect_system_readme_path() {
  local repo_root="$1"
  local value
  value="$(mos_install_metadata_value "${repo_root}" "system_readme_path")"

  if [[ -n "${value}" ]]; then
    printf '%s\n' "${value}"
    return 0
  fi

  if [[ -f "${repo_root}/AI_META_SYSTEM_README.md" ]]; then
    echo "AI_META_SYSTEM_README.md"
  else
    echo "README.md"
  fi
}

mos_write_install_metadata() {
  local repo_root="$1"
  local source_template="$2"
  local source_version="$3"
  local install_mode="$4"
  local system_readme_path="$5"
  local event="$6"

  local metadata_path
  metadata_path="$(mos_install_metadata_path "${repo_root}")"

  python3 - <<'PY' "${metadata_path}" "${source_template}" "${source_version}" "${install_mode}" "${system_readme_path}" "${event}"
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

path = Path(sys.argv[1])
source_template = sys.argv[2]
source_version = sys.argv[3]
install_mode = sys.argv[4]
system_readme_path = sys.argv[5]
event = sys.argv[6]
now = datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")

data = {}
if path.exists():
    try:
        data = json.loads(path.read_text())
    except Exception:
        data = {}

installed_at = data.get("installed_at")
if not installed_at or installed_at == "UNSET":
    installed_at = now

data.update(
    {
        "template_name": "MOS",
        "template_version": source_version,
        "source_template": source_template,
        "install_mode": install_mode,
        "system_readme_path": system_readme_path,
        "installed_at": installed_at,
        "updated_at": now,
        "last_event": event,
    }
)

path.parent.mkdir(parents=True, exist_ok=True)
path.write_text(json.dumps(data, indent=2) + "\n")
PY
}

mos_resolve_system_name() {
  local repo_root="$1"
  basename -- "${repo_root}"
}

mos_refresh_onboarding_baseline() {
  local script_dir="$1"
  local repo_root="$2"
  local system_name="${3:-}"

  if [[ -z "${system_name}" ]]; then
    system_name="$(mos_resolve_system_name "${repo_root}")"
  fi

  bash "${script_dir}/seed-meta-working-state.sh" "${repo_root}" --system-name "${system_name}"
  bash "${script_dir}/suggest-meta-baseline.sh" "${repo_root}" --write
}

mos_refresh_generated_surfaces() {
  local script_dir="$1"
  local repo_root="$2"

  bash "${script_dir}/generate-meta-host-adapters.sh" "${repo_root}" --write >/dev/null
  bash "${script_dir}/generate-meta-system-registry.sh" "${repo_root}" --write >/dev/null
  bash "${script_dir}/generate-meta-operating-profile.sh" "${repo_root}" --write >/dev/null
}

mos_record_validation_success() {
  local repo_root="$1"
  local validation_command="$2"
  local validation_scope="$3"

  python3 - <<'PY' "${repo_root}" "${validation_command}" "${validation_scope}"
from pathlib import Path
import re
import sys

repo = Path(sys.argv[1]).resolve()
command = sys.argv[2]
scope = sys.argv[3]

status_path = repo / "meta_system" / "context" / "CURRENT_STATUS.md"
where_path = repo / "META_WHERE_LEFT_OFF.md"

status_text = status_path.read_text()
status_text = re.sub(
    r"^- Latest known passing validation:.*$",
    f"- Latest known passing validation: {command} -> pass",
    status_text,
    count=1,
    flags=re.MULTILINE,
)
status_text = re.sub(
    r"^- Latest known failing validation:.*$",
    "- Latest known failing validation: none recorded",
    status_text,
    count=1,
    flags=re.MULTILINE,
)
status_text = re.sub(
    r"^- Current confidence level:.*$",
    "- Current confidence level: structurally validated after lifecycle refresh",
    status_text,
    count=1,
    flags=re.MULTILINE,
)
status_path.write_text(status_text)

where_text = where_path.read_text()
where_text = re.sub(
    r"^- Latest validation run:.*$",
    f"- Latest validation run: {command} -> pass ({scope})",
    where_text,
    count=1,
    flags=re.MULTILINE,
)
where_text = re.sub(
    r"^- Resume confidence:.*$",
    "- Resume confidence: medium after structural validation; raise once repo-local milestones are recorded",
    where_text,
    count=1,
    flags=re.MULTILINE,
)
where_path.write_text(where_text)
PY
}
