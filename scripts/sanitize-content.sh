#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<USAGE
Usage:
  sanitize-content.sh --map-file <path> --in-place <file> [file ...]
  sanitize-content.sh --map-file <path> --root-dir <dir>
USAGE
}

MAP_FILE=""
ROOT_DIR=""
INPLACE_FILES=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --map-file)
      MAP_FILE="$2"
      shift 2
      ;;
    --root-dir)
      ROOT_DIR="$2"
      shift 2
      ;;
    --in-place)
      shift
      while [[ $# -gt 0 && "$1" != --* ]]; do
        INPLACE_FILES+=("$1")
        shift
      done
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

if [[ -z "$MAP_FILE" ]]; then
  echo "--map-file is required" >&2
  exit 1
fi

if [[ ! -f "$MAP_FILE" ]]; then
  echo "Map file not found: $MAP_FILE" >&2
  exit 1
fi

if [[ -z "$ROOT_DIR" && ${#INPLACE_FILES[@]} -eq 0 ]]; then
  echo "Provide --root-dir or --in-place files" >&2
  exit 1
fi

if [[ -n "$ROOT_DIR" && ${#INPLACE_FILES[@]} -gt 0 ]]; then
  echo "Use either --root-dir or --in-place, not both" >&2
  exit 1
fi

declare -a FROMS=()
declare -a TOS=()

while IFS=$'\t' read -r from to; do
  [[ -n "$from" ]] || continue
  FROMS+=("$from")
  TOS+=("$to")
done < <(
  awk '
    /^[[:space:]]*-[[:space:]]*from:[[:space:]]*/ {
      from=$0
      sub(/^[[:space:]]*-[[:space:]]*from:[[:space:]]*/, "", from)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", from)
      gsub(/^"|"$/, "", from)
      gsub(/^\047|\047$/, "", from)
      next
    }
    /^[[:space:]]*to:[[:space:]]*/ {
      if (from != "") {
        to=$0
        sub(/^[[:space:]]*to:[[:space:]]*/, "", to)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", to)
        gsub(/^"|"$/, "", to)
        gsub(/^\047|\047$/, "", to)
        print from "\t" to
        from=""
      }
    }
  ' "$MAP_FILE"
)

escape_perl() {
  printf '%s' "$1" | perl -pe 's/([\\\/\[\]\(\)\{\}\^\$\.\|\?\*\+\-])/\\$1/g'
}

sanitize_file() {
  local file="$1"
  [[ -f "$file" ]] || return 0

  local tmp="${file}.sanitized.tmp"
  cp "$file" "$tmp"

  perl -i -pe 's#/Users/[A-Za-z0-9._-]+#\$HOME#g' "$tmp"

  local i from to from_esc to_esc
  for i in "${!FROMS[@]}"; do
    from="${FROMS[$i]}"
    to="${TOS[$i]}"
    from_esc="$(escape_perl "$from")"
    to_esc="$(escape_perl "$to")"
    perl -i -pe "s/${from_esc}/${to_esc}/g" "$tmp"
  done

  mv "$tmp" "$file"
}

if [[ -n "$ROOT_DIR" ]]; then
  while IFS= read -r file; do
    sanitize_file "$file"
  done < <(find "$ROOT_DIR" -type f -not -path '*/.git/*')
else
  for file in "${INPLACE_FILES[@]}"; do
    sanitize_file "$file"
  done
fi
