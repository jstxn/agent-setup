# Agent Setup

Public, copy-first reference repository for an agentic coding workflow.

This repository is intentionally anonymized and generic. It is markdown-only by design.

## Design Goals

- Reference-first: readable templates with no operational tooling overhead
- Runtime-portable: tool-agnostic specs with runtime adapters
- Copy-friendly: users can copy single files or selected sections
- Safe publishing posture: no private workspace or brand identifiers

## Quick Start

1. Read [`AGENTS.md`](AGENTS.md) for repository-level behavior.
2. Copy runtime overlays:
   - Codex: [`codex/AGENTS.md`](codex/AGENTS.md)
   - Claude: [`CLAUDE.md`](CLAUDE.md)
3. Copy skills from `skills/custom/*/SKILL.md`.
4. Copy subagent specs from `subagents/specs/*` and runtime adapters from `subagents/adapters/*`.
5. Tailor `overlays/workspace-*` templates for your own workspaces.

## Repository Map

- `policy/`: global and runtime policy templates
- `skills/custom/`: authored reusable skills
- `skills/external/`: third-party references (not vendored)
- `subagents/specs/`: canonical behavior specs
- `subagents/adapters/`: runtime-specific adapter formats
- `overlays/`: generic workspace policy examples
- `catalog/`: markdown catalogs for skills, subagents, and workflow patterns

## Markdown-Only Constraint

- Every tracked repository file is `.md`.
- No scripts, tests, CI configs, schemas, or machine manifests are included.
- Validation is a manual review process focused on content clarity and anonymization.

## Publishing Guardrails

- No internal workspace names or brands
- No personal absolute paths
- No credentials or secrets
