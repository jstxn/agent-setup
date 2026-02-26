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

## Strengths of the Obsidian Read-Write Loop

- Compounding context: each session writes reusable patterns/issues/architecture notes, so future sessions start from prior learning instead of from scratch.
- Faster planning: agents can scan note filenames first and pull only relevant knowledge, reducing repeated discovery work.
- Controlled context load: selective reads ("do not read everything") keep token usage proportional to the task, not vault size.
- Better multi-agent consistency: main agent and subagents can align on the same stored conventions before deep exploration.
- Durable audit trail: plain Markdown notes make decisions and discoveries easy to inspect, diff, and refine over time.
- Tool resilience: direct filesystem read/write keeps the loop reliable even when GUI-specific tools are unavailable.

## Invisible Automatic Context Sync (Flow Example)

Goal: keep note indexes current with near-zero user involvement.

### 1) Canonical sync command

Add a single sync command (example: `~/bin/context-sync`) as the source of truth for index updates.

Expected behavior:

- Uses vault roots like `<home>/Development/workspace-alpha/context`, `<home>/Development/workspace-beta/context`, and `<home>/Obsidian/Main/context`.
- Supports:
  - `--all` (sync every known root),
  - `--path <changed-file>` (targeted sync),
  - `--cwd <dir>` (infer relevant root),
  - `--quiet` (silent automation mode).
- Ensures:
  - root `INDEX.md`,
  - project `INDEX.md`,
  - required artifact folders,
  - sorted note links by recency.

### 2) Claude hook bridge

Add a small hook script (example: `~/.claude/hooks/context-sync-hook.sh`) that reads hook JSON from stdin and triggers sync:

- `PostToolUse` for write/edit tools (`Write`, `Edit`, `MultiEdit`, `NotebookEdit`) -> run targeted sync using changed file path.
- `SessionEnd` and `Stop` -> run sync for the active workspace.
- Optional `Bash` fallback: if command text touches `/context/*.md`, run sync.

### 3) Claude settings wiring

Wire the hook in `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/context-sync-hook.sh"
          }
        ]
      }
    ],
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/context-sync-hook.sh"
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/context-sync-hook.sh"
          }
        ]
      }
    ]
  }
}
```

### 4) Background safety net (tool-agnostic)

Add a lightweight scheduler so indexes self-heal even when a path bypasses hooks.

macOS LaunchAgent example:

- `Label`: `com.user.context-sync`
- `ProgramArguments`: `~/bin/context-sync --quiet --all`
- `RunAtLoad`: `true`
- `StartInterval`: `120` (seconds)
- Set `PATH` in agent env so `python3`/dependencies resolve in non-interactive runs.

### 5) Runtime flow

1. Agent writes a note under `context/<project>/<artifact-type>/...`.
2. Hook fires and calls `context-sync` automatically.
3. Root and project `INDEX.md` files update.
4. Periodic background run reconciles any missed updates.
5. Next session reads `context/INDEX.md` then `context/<project>/INDEX.md` before note bodies.

### 6) Fallback command

If automation is disabled or being debugged:

```bash
context-sync --cwd "$PWD"
```

## Obfuscation Notes

Some names are intentionally replaced with placeholders such as:

- `workspace-alpha`
- `workspace-beta`
- `/Users/<user>/...`

The structure and workflow behavior are kept close to the original setup.
