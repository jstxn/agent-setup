# Agent Setup (Obfuscated Workflow Example)

This repository is a sanitized, markdown-only example of a real agentic coding workflow setup.

Goal: show how the workflow is actually structured in practice, while removing private names and sensitive path details.

## What This Mirrors

- Global policy: [AGENTS.md](AGENTS.md)
- Workflow orchestration: [WORKFLOW.md](WORKFLOW.md)
- Claude policy: [CLAUDE.md](CLAUDE.md) and [.claude/CLAUDE.md](.claude/CLAUDE.md)
- Codex policy: [.codex/AGENTS.md](.codex/AGENTS.md)
- Claude subagents: [.claude/agents](.claude/agents)
- Commonly used Codex skills: [.codex/skills](.codex/skills)

## Repository Characteristics

- Markdown-only (every tracked file is `.md`)
- Obfuscated identifiers and workspace names
- Copy-first: intended for people to adapt sections/files into their own setup

## Why Each File Exists

Core policy and flow (needed):

- [AGENTS.md](AGENTS.md): Baseline operating contract. Defines precedence, workflow expectations, Obsidian/knowledge-capture behavior, and handoff standards.
- [WORKFLOW.md](WORKFLOW.md): Execution loop. Encodes planning-first behavior, self-improvement cadence, verification bar, and task tracking expectations.
- [CLAUDE.md](CLAUDE.md): Claude-focused adapter. Keeps Claude behavior aligned with global policy while adding concise reminders that reduce drift.
- [.claude/CLAUDE.md](.claude/CLAUDE.md): Claude runtime-local overlay. Mirrors the Claude adapter where local Claude tooling expects it.
- [.codex/AGENTS.md](.codex/AGENTS.md): Codex runtime-local overlay. Captures Codex-specific defaults and local operational constraints.

Operational support files (needed):

- [CONTRIBUTING.md](CONTRIBUTING.md): Contribution guardrails for this mirror repo (markdown-only, obfuscation, no private leaks).
- [LICENSE.md](LICENSE.md): Legal reuse boundary for copying/adapting this setup.

Claude subagents (recommended):

- [.claude/agents/pr-writer.md](.claude/agents/pr-writer.md): Standardizes PR titles/bodies/test plans for consistent review quality.
- [.claude/agents/researcher.md](.claude/agents/researcher.md): Read-only context gathering to reduce implementation mistakes.
- [.claude/agents/reviewer.md](.claude/agents/reviewer.md): Structured post-implementation review pass before shipping.

Codex skills (recommended):

- [.codex/skills/project-memory-enforcer/SKILL.md](.codex/skills/project-memory-enforcer/SKILL.md): Forces preflight rule + memory loading so changes follow local conventions.
- [.codex/skills/review-team/SKILL.md](.codex/skills/review-team/SKILL.md): Produces evidence-first, severity-ordered reviews with a stable output contract.
- [.codex/skills/fix-latest/SKILL.md](.codex/skills/fix-latest/SKILL.md): Converts latest review findings into a concrete prioritized fix plan.
- [.codex/skills/linear/SKILL.md](.codex/skills/linear/SKILL.md): Structured workflow for ticket/project operations when work is tracked in Linear.
- [.codex/skills/playwright/SKILL.md](.codex/skills/playwright/SKILL.md): CLI-first browser automation guidance for UI debugging and flow validation.
- [.codex/skills/screenshot/SKILL.md](.codex/skills/screenshot/SKILL.md): OS-level screenshot workflow when tool-native capture is unavailable.
- `.codex/skills/*/references/*.md`: Keeps each skill deterministic with explicit checklists, templates, and runbooks.

## How This Flow Works

1. Start with policy + workflow context (`AGENTS.md`, `WORKFLOW.md`, runtime overlays).
2. Use subagents/skills to gather context and execute specialized tasks.
3. Run structured review (`review-team`) and close findings (`fix-latest`) before handoff.
4. Capture durable knowledge for future sessions and keep docs aligned with runtime behavior.

## Obfuscation Notes

Some names are intentionally replaced with placeholders such as:

- `workspace-alpha`
- `workspace-beta`
- `/Users/<user>/...`

The structure and workflow behavior are kept close to the original setup.
