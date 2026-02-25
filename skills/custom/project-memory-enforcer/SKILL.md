---
name: project-memory-enforcer
description: Enforce preflight reads of local repo rules and project memory before any code edits.
---

# Project Memory Enforcer

## Mandatory Preflight

1. Resolve repo root.
2. Read nearest applicable `AGENTS.md` files for touched paths.
3. Read `.codex/memories/*.md` when present.
4. Extract constraints affecting implementation and testing.

## Behavior

- Keep preflight low-noise.
- Explicitly mention rules only when they change implementation choices.
- Stop and ask if required context cannot be read.
