# Agent Setup Repo Instructions

Scope: applies to all files in this repository.

## Purpose

This repository is a public markdown-only reference for agent workflow setup.

## Core Rules

1. Keep naming generic. Never introduce private workspace or brand names.
2. Keep examples copy-paste friendly and deterministic.
3. Preserve tool-agnostic subagent behavior in `subagents/specs/*`; adapters only translate format.
4. Update markdown catalogs in `catalog/*.md` when skills/subagents/workflow patterns change.
5. Do not add non-markdown files.

## Preflight

1. Check `git status --short`.
2. Read touched policy/catalog docs before editing.
3. Keep changes scoped to documentation intent.

## Done Criteria

- Minimal correct diff
- Repository remains markdown-only
- Catalog docs reflect changed content
- No private names or credentials introduced
