#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

have_rg() {
  command -v rg >/dev/null 2>&1
}

match_lines() {
  local pattern="$1"
  local file="$2"
  if have_rg; then
    rg -N "$pattern" "$file" || true
  else
    grep -E "$pattern" "$file" || true
  fi
}

has_match() {
  local pattern="$1"
  local file="$2"
  if have_rg; then
    rg -q "$pattern" "$file"
  else
    grep -Eq "$pattern" "$file"
  fi
}

count_matches() {
  local pattern="$1"
  local file="$2"
  match_lines "$pattern" "$file" | wc -l | tr -d ' '
}

validate_json() {
  local file="$1"
  python3 - <<PY
import json
from pathlib import Path
p = Path("$file")
json.loads(p.read_text(encoding="utf-8"))
PY
}

unique_ids() {
  local file="$1"
  local dupes
  dupes=$(match_lines '^[[:space:]]*-[[:space:]]*id:' "$file" | sed -E 's/^[[:space:]]*-[[:space:]]*id:[[:space:]]*//' | sort | uniq -d || true)
  if [[ -n "$dupes" ]]; then
    echo "duplicate ids in $file:" >&2
    echo "$dupes" >&2
    return 1
  fi
}

require_key_count() {
  local file="$1"
  local key="$2"
  local items="$3"
  local count
  if [[ "$key" == "id" ]]; then
    count=$(count_matches "^[[:space:]]*-[[:space:]]*id:" "$file")
  else
    count=$(count_matches "^[[:space:]]*${key}:" "$file")
  fi
  if [[ "$count" -lt "$items" ]]; then
    echo "key '$key' missing for one or more items in $file" >&2
    return 1
  fi
}

validate_manifest() {
  local file="$1"
  shift
  local top_key="$1"
  shift

  has_match "^${top_key}:" "$file" || { echo "missing top key '${top_key}' in $file" >&2; return 1; }

  local items
  items=$(count_matches '^[[:space:]]*-[[:space:]]*id:' "$file")
  if [[ "$items" -eq 0 ]]; then
    echo "no items found in $file" >&2
    return 1
  fi

  local key
  for key in "$@"; do
    require_key_count "$file" "$key" "$items"
  done

  unique_ids "$file"
}

validate_json "${ROOT}/catalog/skills.schema.json"
validate_json "${ROOT}/catalog/subagents.schema.json"
validate_json "${ROOT}/catalog/workflows.schema.json"

validate_manifest "${ROOT}/catalog/skills.yaml" "skills" "id" "type" "runtime" "source" "license" "status" "paths"
validate_manifest "${ROOT}/catalog/subagents.yaml" "subagents" "id" "spec" "adapters" "tools" "model_hints" "intended_use"
validate_manifest "${ROOT}/catalog/workflows.yaml" "workflows" "id" "summary" "inputs" "outputs" "steps"

echo "catalog validation passed"
