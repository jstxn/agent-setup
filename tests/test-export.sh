#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

SRC="${TMP_DIR}/src"
OUT="${TMP_DIR}/out"
MAP="${TMP_DIR}/map.yaml"
BAD_TERM="$(printf 'up%s' 'wage')"
BAD_USER_SEGMENT="$(printf 'just%s' 'en')"

mkdir -p "${SRC}/.codex" "${SRC}/.claude/agents"

cat > "${SRC}/AGENTS.md" <<DOC
name: ${BAD_TERM}
path: /Users/${BAD_USER_SEGMENT}/Development/${BAD_TERM}
DOC

cat > "${SRC}/.codex/AGENTS.md" <<DOC
overlay for ${BAD_TERM}
DOC

cat > "${SRC}/.claude/CLAUDE.md" <<'DOC'
@AGENTS.md
DOC

cat > "${SRC}/.claude/agents/researcher.md" <<DOC
researcher for ${BAD_TERM}
DOC

cat > "$MAP" <<DOC
mappings:
  - from: "${BAD_TERM}"
    to: "workspace-alpha"
DOC

"${ROOT}/scripts/export-public.sh" \
  --source-root "$SRC" \
  --output-root "$OUT" \
  --map-file "$MAP"

TARGET="${OUT}/policy/global/AGENTS.base.md"
[[ -f "$TARGET" ]] || { echo "missing exported file: $TARGET" >&2; exit 1; }

rg -q "workspace-alpha" "$TARGET"
! rg -q "$BAD_TERM" "$TARGET"
rg -F -q '$HOME' "$TARGET"

echo "test-export passed"
