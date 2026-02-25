#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<USAGE
Usage:
  export-public.sh --source-root <path> [--output-root <path>] [--map-file <path>] [--manifest <path>] [--strict]
USAGE
}

SOURCE_ROOT=""
OUTPUT_ROOT="$(pwd)"
MAP_FILE=""
MANIFEST="${SCRIPT_DIR}/../config/export-manifest.txt"
STRICT=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source-root)
      SOURCE_ROOT="$2"
      shift 2
      ;;
    --output-root)
      OUTPUT_ROOT="$2"
      shift 2
      ;;
    --map-file)
      MAP_FILE="$2"
      shift 2
      ;;
    --manifest)
      MANIFEST="$2"
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

if [[ -z "$SOURCE_ROOT" ]]; then
  echo "--source-root is required" >&2
  exit 1
fi

if [[ -z "$MAP_FILE" ]]; then
  echo "--map-file is required" >&2
  exit 1
fi

if [[ ! -f "$MANIFEST" ]]; then
  echo "Manifest not found: $MANIFEST" >&2
  exit 1
fi

mkdir -p "$OUTPUT_ROOT"

declare -a COPIED=()
COPIED_COUNT=0
SKIPPED_COUNT=0

while IFS='|' read -r src_rel dst_rel; do
  [[ -n "$src_rel" ]] || continue
  [[ "$src_rel" =~ ^# ]] && continue

  src_path="${SOURCE_ROOT}/${src_rel}"
  dst_path="${OUTPUT_ROOT}/${dst_rel}"

  if [[ ! -f "$src_path" ]]; then
    echo "skip missing: ${src_rel}" >&2
    SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
    continue
  fi

  mkdir -p "$(dirname "$dst_path")"
  cp "$src_path" "$dst_path"
  COPIED+=("$dst_path")
  COPIED_COUNT=$((COPIED_COUNT + 1))
done < "$MANIFEST"

if [[ ${#COPIED[@]} -gt 0 ]]; then
  "${SCRIPT_DIR}/sanitize-content.sh" --map-file "$MAP_FILE" --in-place "${COPIED[@]}"
fi

if [[ "$STRICT" -eq 1 ]]; then
  "${SCRIPT_DIR}/scan-leaks.sh" --root "$OUTPUT_ROOT" --strict
fi

echo "copied=${COPIED_COUNT} skipped=${SKIPPED_COUNT}"
