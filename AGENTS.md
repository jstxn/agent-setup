# Agent Setup Repo Instructions

Scope: applies to all files in this repository.

## Purpose

This repo is a public reference for agent workflow setup. Prioritize portability and safety over local convenience.

## Core Rules

1. Keep naming generic. Never introduce private workspace or brand names.
2. Keep examples copy-paste friendly and deterministic.
3. Do not vendor third-party skill content without explicit license verification.
4. Preserve tool-agnostic subagent behavior in `subagents/specs/*`; adapters only translate format.
5. Update `catalog/*.yaml` when adding or removing skills/subagents/workflows.

## Preflight

1. Check `git status --short`.
2. Read touched policy files and matching catalog entries.
3. Run touched-scope tests and leak scan before handoff.

## Done Criteria

- Minimal correct diff
- Catalogs still valid
- Leak scan passes
- Tests relevant to touched scripts pass
