# Global Agent Instructions

This file defines default agent behavior across projects.

@~/WORKFLOW.md

## Scope and Precedence

- This is a global fallback policy.
- For repository work, the nearest `AGENTS.md` in the directory tree takes precedence for repo-specific rules.
- Instruction priority order: system/developer instructions > repository `AGENTS.md` > this global `AGENTS.md`.

## Preferred Workflow

Default session flow for most tasks is:

- **80% Planning and context**: clarify scope, inspect relevant instructions/docs, identify constraints, risks, and success criteria before coding.
- **10% Implementation**: make the smallest correct change with minimal blast radius.
- **10% Review and fix**: verify consistency, correct issues introduced, and prepare handoff notes.

If uncertainty is high, the planning segment can temporarily expand and implementation/review can shrink.

## Core Principles

- **Plan before implementing.** Prioritize a solid plan that matches existing codebase patterns and best practices.
- **Prefer reuse over reinvention.** Search for existing utilities, helpers, hooks, services, shared components, and configs before writing new code.
- **Make the smallest correct change.** Minimal diffs, no unrelated refactors, preserve existing APIs/conventions.
- **Correctness + conciseness > speed.** Understand context, edge cases, and existing patterns before editing.
- **Avoid duplication.** Consolidate repeated logic into shared helpers when lower risk than copying.
- **Match existing style and structure.** Follow established naming, placement, typing, and error-handling patterns.

## Obsidian Filesystem Default

- Do not use the `obsidian` binary. It launches the Electron GUI app and can hang in sandboxed shells.
- Read and write notes directly as Markdown files on disk.
- Vault paths: `g2i` -> `/Users/justen/Development/g2i/`, `upwage` -> `/Users/justen/Development/upwage/`, other work -> `/Users/justen/Obsidian/Main/`.
- For planning artifacts, including anytime a plan is created or Plan mode is used, always place a `.md` note in the relevant vault under `plans/`.
- Ensure the plans directory exists first using `mkdir -p`.

## Session Completion

Classify the session before handoff:

- **Analysis-only session:** Summarize findings, risks, assumptions, and next steps. Do not force commits or pushes.
- **Code-change session:** Run quality gates -> commit with clear message -> hand off with concise context.

### Quality Gates (Preferred Order)

Use repository-standard scripts where available: `typecheck` -> `lint` -> `test` -> `build`. If a gate is skipped, state why.

## Push Policy

Push only when: user explicitly asks, repo policy requires it, or the task is incomplete without remote updates. Never force-push without explicit instruction.

## Safety Guardrails

- Never run destructive commands unless explicitly requested (`git reset --hard`, history rewrites, branch deletion, forced checkout).
- Never force-push without explicit user instruction.
- Never overwrite or revert unrelated local changes you did not make.
- Prefer non-interactive, auditable commands.

## PR & Code Review

When working in repos with automated reviewers (Cursor Bugbot, Greptile, etc.):
- **PR descriptions**: State what changed and why. Call out assumptions, non-obvious constraints, and intentional tradeoffs. Include how to test.
- **Cross-file impact**: ALWAYS update dependent call sites, types/schemas, docs, and tests when behavior or interfaces change.
- **Reviewer-facing comments**: When deviating from a pattern or accepting a risk, add a short rationale in code or PR.
- **If a bot flags intentional behavior**: Respond with the requirement/constraint and propose a compliant alternative.
