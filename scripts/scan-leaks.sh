#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage:
  scan-leaks.sh [--root <path>] [--denylist <file>] [--strict]
USAGE
}

ROOT="$(pwd)"
DENYLIST=""
STRICT=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --root)
      ROOT="$2"
      shift 2
      ;;
    --denylist)
      DENYLIST="$2"
      shift 2
      ;;
    --strict)
      STRICT=1
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

if [[ -z "$DENYLIST" ]]; then
  DENYLIST="${ROOT}/config/denylist.public.regex"
fi

if [[ ! -f "$DENYLIST" ]]; then
  echo "Denylist not found: $DENYLIST" >&2
  exit 1
fi

HITS=0

while IFS= read -r pattern; do
  [[ -n "$pattern" ]] || continue
  [[ "$pattern" =~ ^# ]] && continue

  if matches=$(rg -n --hidden \
    --glob '!.git/**' \
    --glob '!tests/fixtures/**' \
    --glob '!config/denylist.public.regex' \
    -e "$pattern" "$ROOT" 2>/dev/null); then
    echo "denylist hit for pattern: $pattern" >&2
    echo "$matches" >&2
    HITS=$((HITS + 1))
  fi
done < "$DENYLIST"

if [[ "$HITS" -gt 0 ]]; then
  if [[ "$STRICT" -eq 1 ]]; then
    echo "leak scan failed: ${HITS} pattern(s) matched" >&2
    exit 1
  fi
  echo "leak scan warning: ${HITS} pattern(s) matched" >&2
else
  echo "leak scan passed"
fi
