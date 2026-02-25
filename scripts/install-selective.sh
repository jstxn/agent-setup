#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage:
  install-selective.sh --target codex|claude|all [--dest-codex <path>] [--dest-claude <path>] [--dry-run|--apply] [--backup]
USAGE
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

TARGET=""
DEST_CODEX="$HOME/.codex"
DEST_CLAUDE="$HOME/.claude"
DRY_RUN=1
BACKUP=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="$2"
      shift 2
      ;;
    --dest-codex)
      DEST_CODEX="$2"
      shift 2
      ;;
    --dest-claude)
      DEST_CLAUDE="$2"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --apply)
      DRY_RUN=0
      shift
      ;;
    --backup)
      BACKUP=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  echo "--target is required" >&2
  exit 1
fi

if [[ "$TARGET" != "codex" && "$TARGET" != "claude" && "$TARGET" != "all" ]]; then
  echo "--target must be codex, claude, or all" >&2
  exit 1
fi

backup_if_needed() {
  local dst="$1"
  if [[ "$BACKUP" -eq 1 && -f "$dst" ]]; then
    cp "$dst" "${dst}.bak.$(date +%Y%m%d%H%M%S)"
  fi
}

copy_file() {
  local src="$1"
  local dst="$2"

  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] cp $src $dst"
    return 0
  fi

  mkdir -p "$(dirname "$dst")"
  backup_if_needed "$dst"
  cp "$src" "$dst"
  echo "installed $dst"
}

if [[ "$TARGET" == "codex" || "$TARGET" == "all" ]]; then
  copy_file "${REPO_ROOT}/codex/AGENTS.md" "${DEST_CODEX}/AGENTS.md"
fi

if [[ "$TARGET" == "claude" || "$TARGET" == "all" ]]; then
  copy_file "${REPO_ROOT}/CLAUDE.md" "${DEST_CLAUDE}/CLAUDE.md"
  while IFS= read -r adapter; do
    copy_file "$adapter" "${DEST_CLAUDE}/agents/$(basename "$adapter")"
  done < <(find "${REPO_ROOT}/subagents/adapters/claude" -type f -name '*.md' | sort)
fi
