#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
CONTENT_DIR="${TMP_DIR}/content"
BAD_TERM="$(printf 'up%s' 'wage')"
BAD_USER_SEGMENT="$(printf 'just%s' 'en')"

mkdir -p "$CONTENT_DIR"

cat > "${TMP_DIR}/denylist.regex" <<DOC
${BAD_TERM}
DOC

cat > "${CONTENT_DIR}/note.md" <<DOC
This references ${BAD_TERM} and /Users/${BAD_USER_SEGMENT}/private.
DOC

set +e
"${ROOT}/scripts/scan-leaks.sh" --root "$CONTENT_DIR" --denylist "${TMP_DIR}/denylist.regex" --strict
FAILED=$?
set -e

if [[ "$FAILED" -eq 0 ]]; then
  echo "expected strict leak scan to fail before sanitization" >&2
  exit 1
fi

cat > "${TMP_DIR}/map.yaml" <<DOC
mappings:
  - from: "${BAD_TERM}"
    to: "workspace-alpha"
DOC

"${ROOT}/scripts/sanitize-content.sh" --map-file "${TMP_DIR}/map.yaml" --in-place "${CONTENT_DIR}/note.md"
"${ROOT}/scripts/scan-leaks.sh" --root "$CONTENT_DIR" --denylist "${TMP_DIR}/denylist.regex" --strict

! rg -q "$BAD_TERM" "${CONTENT_DIR}/note.md"
rg -q "workspace-alpha" "${CONTENT_DIR}/note.md"
rg -F -q '$HOME' "${CONTENT_DIR}/note.md"

echo "test-redaction passed"
