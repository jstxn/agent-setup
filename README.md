# Agent Setup

Public, copy-first reference repository for an agentic coding workflow.

This repository is intentionally anonymized and generic. Use it to copy policy blocks, skill templates, and subagent patterns into your own setup.

## Design Goals

- Reference-first: readable templates before automation
- Safe-by-default: explicit leak checks for public artifacts
- Runtime-portable: tool-agnostic specs with runtime adapters
- Selective install: optional bootstrap script, never forced home-directory takeover

## Quick Start

1. Read [`AGENTS.md`](AGENTS.md) for global behavior.
2. Copy runtime overlays:
   - Codex: [`codex/AGENTS.md`](codex/AGENTS.md)
   - Claude: [`CLAUDE.md`](CLAUDE.md)
3. Copy or adapt skills from `skills/custom/*`.
4. Copy subagent specs from `subagents/specs/*` and adapter files from `subagents/adapters/*`.

## Optional Selective Install

```bash
./scripts/install-selective.sh --target all --dry-run
./scripts/install-selective.sh --target all --apply --backup
```

## Export Pipeline (Private -> Public)

`export-public.sh` creates sanitized public artifacts from a private source tree:

```bash
./scripts/export-public.sh \
  --source-root "$HOME" \
  --output-root "$(pwd)" \
  --map-file "$HOME/.config/agent-setup/redact-map.yaml" \
  --strict
```

## Repository Map

- `policy/`: global and runtime policy templates
- `skills/custom/`: authored reusable skills
- `skills/external/`: third-party references (not vendored)
- `subagents/specs/`: canonical behavior specs
- `subagents/adapters/`: runtime-specific adapter formats
- `overlays/`: generic workspace policy examples
- `catalog/`: machine-readable manifests and schemas
- `scripts/`: export, sanitize, scan, install, validate
- `tests/`: shell integration checks

## Leak and Naming Policy

- No internal workspace names or brands
- No personal absolute paths
- No credentials or tokens
- CI blocks explicit denylist matches via `scripts/scan-leaks.sh`
