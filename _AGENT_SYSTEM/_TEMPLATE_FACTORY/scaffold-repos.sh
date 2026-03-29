#!/usr/bin/env bash
# Factory-only asset. Do not install this file into application repos.
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_ROOT="${SCRIPT_DIR}/../TEMPLATE"
MYAPPZ_ROOT="$(cd -- "${SCRIPT_DIR}/../.." && pwd)"
BACKUP_ROOT="${MYAPPZ_ROOT}/_backups/pre-scaffold"

# shellcheck source=TEMPLATE/bootstrap/lib/aiaast-lib.sh
source "${TEMPLATE_ROOT}/bootstrap/lib/aiaast-lib.sh"
aiaast_assert_template_root "${TEMPLATE_ROOT}"

usage() {
  cat <<'EOF'
Usage: scaffold-repos.sh <repo-name|--all|--list> [--strict] [--dry-run] [--replace]

Install the AI agent operating system into application repos.

Options:
  --list       Show all repos and their scaffolding status
  --all        Scaffold to all eligible application repos
  --strict     Fail if app name is still blank after install
  --dry-run    Show what would happen without making changes
  --replace    Back up and replace conflicting legacy agent files

Examples:
  scaffold-repos.sh --list
  scaffold-repos.sh WRAITHS --strict
  scaffold-repos.sh --all --replace --strict
  scaffold-repos.sh CandleCompass --replace --dry-run
EOF
}

REPO_NAME=""
SCAFFOLD_ALL=0
LIST_ONLY=0
STRICT=0
DRY_RUN=0
REPLACE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --list)
      LIST_ONLY=1
      shift
      ;;
    --all)
      SCAFFOLD_ALL=1
      shift
      ;;
    --strict)
      STRICT=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --replace)
      REPLACE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      if [[ -z "${REPO_NAME}" ]]; then
        REPO_NAME="$1"
        shift
      else
        echo "Unexpected argument: $1" >&2
        exit 1
      fi
      ;;
  esac
done

if [[ ${LIST_ONLY} -eq 0 && ${SCAFFOLD_ALL} -eq 0 && -z "${REPO_NAME}" ]]; then
  usage
  exit 1
fi

# Directories to skip when scanning for repos
skip_dirs=(
  "_AI_AGENT_SYSTEM_TEMPLATE"
  "_AI_AGENT_SYSTEM_TESTS"
  "_backups"
  "containers"
  "runs"
)

is_skip_dir() {
  local name="$1"
  for skip in "${skip_dirs[@]}"; do
    if [[ "${name}" == "${skip}" ]]; then
      return 0
    fi
  done
  return 1
}

# Known legacy agent files that may conflict with the new template
legacy_agent_files=(
  "AGENTS.md"
  "AGENTS.override.md"
  "CLAUDE.md"
  "CODEX.md"
  "GEMINI.md"
  "WINDSURF.md"
  ".cursorrules"
  ".windsurfrules"
  ".github/copilot-instructions.md"
  ".cursor/mcp.json"
  "TODO.md"
  "FIXME.md"
  "WHERE_LEFT_OFF.md"
  "CHANGELOG.md"
  "PLAN.md"
  "PRODUCT_BRIEF.md"
  "ROADMAP.md"
  "DESIGN_NOTES.md"
  "ARCHITECTURE_NOTES.md"
  "RESEARCH_NOTES.md"
  "TEST_STRATEGY.md"
  "RISK_REGISTER.md"
  "RELEASE_NOTES.md"
  "PROJECT_RULES.md"
  "CURSOR_SYSTEM_PROMPT.md"
  "CURSOR_USER_RULE.md"
  "CURSOR_CONTEXT_URLS.txt"
  "AGENT_CONTEXT.md"
  "AI_AGENT_COORDINATION.md"
  "PROMPT_PACK_GEMINI.md"
)

get_repo_status() {
  local repo_path="$1"
  local has_agents=0
  local has_system=0
  local has_legacy=0
  local conflicts=0

  [[ -f "${repo_path}/AGENTS.md" ]] && has_agents=1
  [[ -d "${repo_path}/_system" ]] && has_system=1

  # Check for legacy files that would conflict
  for lf in "${legacy_agent_files[@]}"; do
    if [[ -e "${repo_path}/${lf}" ]]; then
      has_legacy=1
      break
    fi
  done

  # Check for template file conflicts
  local template_files
  mapfile -t template_files < <(cd "${TEMPLATE_ROOT}" && find . -type f | sort)
  for rel in "${template_files[@]}"; do
    rel="${rel#./}"
    if [[ "${rel}" == "README.md" ]]; then
      continue  # README is handled specially
    fi
    if [[ -e "${repo_path}/${rel}" ]]; then
      conflicts=$((conflicts + 1))
    fi
  done

  if [[ ${has_agents} -eq 1 && ${has_system} -eq 1 && ${conflicts} -gt 50 ]]; then
    echo "installed"
  elif [[ ${has_legacy} -eq 1 || ${conflicts} -gt 0 ]]; then
    echo "legacy:${conflicts}"
  else
    echo "clean"
  fi
}

list_repos() {
  echo "Application repos under ${MYAPPZ_ROOT}:"
  echo ""
  printf "  %-30s %s\n" "REPO" "STATUS"
  printf "  %-30s %s\n" "----" "------"

  for entry in "${MYAPPZ_ROOT}"/*/; do
    [[ ! -d "${entry}" ]] && continue
    local name
    name="$(basename -- "${entry}")"
    is_skip_dir "${name}" && continue

    local status
    status="$(get_repo_status "${entry}")"
    case "${status}" in
      clean)
        printf "  %-30s %s\n" "${name}" "ready (no conflicts)"
        ;;
      installed)
        printf "  %-30s %s\n" "${name}" "already installed"
        ;;
      legacy:*)
        local count="${status#legacy:}"
        printf "  %-30s %s\n" "${name}" "has ${count} conflicting files (use --replace)"
        ;;
    esac
  done
  echo ""
}

backup_conflicts() {
  local repo_path="$1"
  local repo_name="$2"
  local timestamp
  timestamp="$(date +%Y%m%d_%H%M%S)"
  local backup_dir="${BACKUP_ROOT}/${repo_name}_${timestamp}"

  local template_files
  mapfile -t template_files < <(cd "${TEMPLATE_ROOT}" && find . -type f | sort)

  local backed_up=0

  if [[ -L "${backup_dir}" ]]; then
    echo "Refusing to write to symlinked backup path: ${backup_dir}" >&2
    exit 1
  fi

  for rel in "${template_files[@]}"; do
    rel="${rel#./}"
    if [[ "${rel}" == "README.md" ]]; then
      continue
    fi
    if [[ -e "${repo_path}/${rel}" ]]; then
      local dest_dir
      dest_dir="$(dirname "${backup_dir}/${rel}")"
      mkdir -p "${dest_dir}"
      cp -p "${repo_path}/${rel}" "${backup_dir}/${rel}"
      rm -f "${repo_path}/${rel}"
      backed_up=$((backed_up + 1))
    fi
  done

  # Also back up known legacy files that aren't in the template
  local extra_legacy=(
    "AGENTS.override.md"
    "PROJECT_RULES.md"
    "CURSOR_SYSTEM_PROMPT.md"
    "CURSOR_USER_RULE.md"
    "CURSOR_CONTEXT_URLS.txt"
    "AGENT_CONTEXT.md"
    "AI_AGENT_COORDINATION.md"
    "PROMPT_PACK_GEMINI.md"
  )
  for lf in "${extra_legacy[@]}"; do
    if [[ -e "${repo_path}/${lf}" ]]; then
      mkdir -p "${backup_dir}"
      cp -p "${repo_path}/${lf}" "${backup_dir}/${lf}"
      rm -f "${repo_path}/${lf}"
      backed_up=$((backed_up + 1))
    fi
  done

  # Back up old _system/ and old .cursor/ dirs if they exist
  for old_dir in "_system" ".cursor" "system" "assistant"; do
    if [[ -d "${repo_path}/${old_dir}" ]]; then
      mkdir -p "${backup_dir}"
      cp -rp "${repo_path}/${old_dir}" "${backup_dir}/${old_dir}"
      rm -rf "${repo_path}/${old_dir}"
      backed_up=$((backed_up + 1))
    fi
  done

  if [[ ${backed_up} -gt 0 ]]; then
    echo "${backup_dir}"
  fi
}

scaffold_repo() {
  local repo_path="$1"
  local repo_name
  repo_name="$(basename -- "${repo_path}")"

  local status
  status="$(get_repo_status "${repo_path}")"

  case "${status}" in
    installed)
      echo "Skipping ${repo_name}: already has the full agent system installed."
      echo "  Use TEMPLATE/bootstrap/install-missing-files.sh to add newly introduced files."
      return 0
      ;;
    legacy:*)
      if [[ ${REPLACE} -eq 0 ]]; then
        local count="${status#legacy:}"
        echo "Skipping ${repo_name}: has ${count} conflicting files."
        echo "  Use --replace to back up existing files and install the new system."
        return 0
      fi
      if [[ ${DRY_RUN} -eq 1 ]]; then
        echo "Dry run: would back up conflicting files in ${repo_name} and install the new system"
        return 0
      fi
      echo "Backing up conflicting files in ${repo_name}..."
      backup_dir=$(backup_conflicts "${repo_path}" "${repo_name}")
      echo "Backup created at ${backup_dir}"
      ;;
    clean)
      backup_dir=""
      if [[ ${DRY_RUN} -eq 1 ]]; then
        echo "Dry run: would install agent system into ${repo_name}"
        return 0
      fi
      ;;
  esac

  echo "Scaffolding ${repo_name}..."

  local strict_flag=""
  [[ ${STRICT} -eq 1 ]] && strict_flag="--strict"

  bash "${TEMPLATE_ROOT}/bootstrap/init-project.sh" "${repo_path}" --app-name "${repo_name}" ${strict_flag}

  # --- Vision Preservation: Migrate Legacy Context ---
  if [[ -n "${backup_dir}" && -d "${backup_dir}" ]]; then
    echo "Preserving vision from legacy files..."
    
    vision_files=("TODO.md" "PLAN.md" "PRODUCT_BRIEF.md" "WHERE_LEFT_OFF.md" "CHANGELOG.md" "DESIGN_NOTES.md" "ARCHITECTURE_NOTES.md" "RESEARCH_NOTES.md" "FIXME.md")
    
    for vf in "${vision_files[@]}"; do
      if [[ -f "${backup_dir}/${vf}" ]]; then
        # Check if the new file exists and is not empty
        if [[ -f "${repo_path}/${vf}" ]]; then
          echo -e "\n\n---\n\n## Legacy ${vf} (Preserved during system upgrade)\n" >> "${repo_path}/${vf}"
          cat "${backup_dir}/${vf}" >> "${repo_path}/${vf}"
          echo "  - Migrated legacy context from ${vf}"
        fi
      fi
    done

    # Also migrate custom context surfaces if they existed in _system/context
    if [[ -d "${backup_dir}/_system/context" ]]; then
      cp -n "${backup_dir}/_system/context/"*.md "${repo_path}/_system/context/" 2>/dev/null || true
      echo "  - Migrated custom context surfaces from _system/context/"
    fi
  fi

  echo "Done: ${repo_name}"
  echo ""
}

if [[ ${LIST_ONLY} -eq 1 ]]; then
  list_repos
  exit 0
fi

if [[ ${SCAFFOLD_ALL} -eq 1 ]]; then
  echo "Scaffolding all eligible repos..."
  echo ""
  for entry in "${MYAPPZ_ROOT}"/*/; do
    [[ ! -d "${entry}" ]] && continue
    local_name="$(basename -- "${entry}")"
    is_skip_dir "${local_name}" && continue
    scaffold_repo "${entry}"
  done
  echo "All repos processed."
else
  target="${MYAPPZ_ROOT}/${REPO_NAME}"
  if [[ ! -d "${target}" ]]; then
    echo "Repo not found: ${target}" >&2
    echo "Available repos:"
    for entry in "${MYAPPZ_ROOT}"/*/; do
      [[ ! -d "${entry}" ]] && continue
      local_name="$(basename -- "${entry}")"
      is_skip_dir "${local_name}" && continue
      echo "  ${local_name}"
    done
    exit 1
  fi
  scaffold_repo "${target}"
fi
