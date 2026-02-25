#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

DEST_CODEX="${TMP_DIR}/codex"
DEST_CLAUDE="${TMP_DIR}/claude"

"${ROOT}/scripts/install-selective.sh" --target all --dest-codex "$DEST_CODEX" --dest-claude "$DEST_CLAUDE" --dry-run

if [[ -e "${DEST_CODEX}/AGENTS.md" || -e "${DEST_CLAUDE}/CLAUDE.md" ]]; then
  echo "dry-run wrote files unexpectedly" >&2
  exit 1
fi

"${ROOT}/scripts/install-selective.sh" --target all --dest-codex "$DEST_CODEX" --dest-claude "$DEST_CLAUDE" --apply --backup

[[ -f "${DEST_CODEX}/AGENTS.md" ]]
[[ -f "${DEST_CLAUDE}/CLAUDE.md" ]]
[[ -f "${DEST_CLAUDE}/agents/researcher.md" ]]
[[ -f "${DEST_CLAUDE}/agents/reviewer.md" ]]
[[ -f "${DEST_CLAUDE}/agents/pr-writer.md" ]]

"${ROOT}/scripts/install-selective.sh" --target codex --dest-codex "$DEST_CODEX" --apply --backup
BACKUPS=$(find "$DEST_CODEX" -type f -name '*.bak.*' | wc -l | tr -d ' ')
[[ "$BACKUPS" -gt 0 ]]

echo "test-install-selective passed"
