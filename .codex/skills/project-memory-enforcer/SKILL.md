---
name: "project-memory-enforcer"
description: >-
  Always enforce a "repo rules + project memory" preflight before making code changes in any project.
  Use for virtually any implementation/debug/refactor/test task: first read applicable `AGENTS.md`
  (and any closer `AGENTS.md` for the touched directories) and `.codex/memories/*.md` if present;
  otherwise read the project's closest equivalents (e.g., `README.md`, `CONTRIBUTING.md`, `CLAUDE.md`,
  `GEMINI.md`, `PROMPT.md`). Keep this enforcement low-noise and implicit.
---

# Project Memory Enforcer

## Intent

Make project-specific rules and memory effectively mandatory and low-friction across repos.

## Mandatory preflight (before any edits)

1. Determine the repo root.
   - Prefer `git rev-parse --show-toplevel`.
   - If git is unavailable, treat the current working directory as the root.
2. Read **rules**.
   - Read repo-root `AGENTS.md` if present.
   - For every directory you will touch, read any closer (more specific) `AGENTS.md` files as well.
   - If no `AGENTS.md` exists, read the closest equivalents that exist (in this order): `CONTRIBUTING.md`, `README.md`, `CLAUDE.md`, `GEMINI.md`, `PROMPT.md`.
3. Read **project memory**.
   - If `.codex/memories/` exists: read *all* `.codex/memories/*.md`.
4. Extract constraints that change implementation choices (authz rules, DB patterns, testing expectations, UI conventions).

## Keep it invisible

- Do the preflight silently.
- Only mention rules/memory explicitly when it materially affects the approach, API, schema, test strategy, or UX.
- If you cannot access a required file, stop and ask rather than guessing.

## Helper script (optional)

If an installed helper exists, you may use it. In this markdown-only repo, the helper script is not tracked.

Portable fallback commands:

- Repo root: `git rev-parse --show-toplevel`
- Repo/closest policy files: `find . -name AGENTS.md -o -name CONTRIBUTING.md -o -name README.md -o -name CLAUDE.md -o -name GEMINI.md -o -name PROMPT.md`
- Project memory notes: `find .codex/memories -name '*.md' 2>/dev/null`
