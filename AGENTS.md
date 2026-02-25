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

## Obsidian Vault Operations

- Do NOT use the `obsidian` binary. It launches the Electron GUI app and can hang in non-interactive shells.
- Read notes directly from vault Markdown files on disk.
- Write `.md` files directly into the vault and ensure parent directories exist with `mkdir -p`.
- Resolve vault roots from local configuration. Use project-specific roots when configured, otherwise use the default local vault root.
- For planning artifacts, including anytime a plan is created or Plan mode is used, always place notes under the relevant vault `plans/` directory.

## Knowledge Capture

During agentic work, proactively capture reusable project knowledge discovered while exploring, debugging, or implementing. Write findings as Markdown notes to the project's vault.

### What to Capture

- **Best practices** (`best-practices/`): Proven patterns, idiomatic usage, performance tips specific to the project.
- **Coding patterns** (`coding-patterns/`): Recurring code structures, abstractions, conventions, and rationale.
- **Common issues** (`common-issues/`): Bugs, gotchas, footguns, and their solutions.
- **Architecture** (`architecture/`): Design decisions, system boundaries, data flows, and integration points.

### Where to Write

Path: `{vault-root}/plans/{project-name}/{category}/{descriptive-slug}.md`

Examples:
- `<vault-root>/plans/<project-name>/best-practices/error-handling-patterns.md`
- `<vault-root>/plans/<project-name>/coding-patterns/transformer-adapter-pattern.md`
- `<vault-root>/plans/<project-name>/common-issues/migration-ordering-gotchas.md`
- `<vault-root>/plans/<project-name>/architecture/event-processing-boundaries.md`

Derive `{project-name}` from the repository name.

### When to Capture

- When discovering a non-obvious pattern while exploring the codebase.
- When solving a tricky bug that others or future sessions might encounter.
- When identifying a best practice that is followed inconsistently.
- When learning architecture details that took effort to uncover.
- At natural breakpoints: end of exploration, end of implementation, or session completion.

### When NOT to Capture

- Trivial or widely-known information.
- Session-specific context that will not be useful later.
- Information already documented in project docs such as ADRs, specs, or READMEs.
- Do not interrupt implementation flow. Batch note updates at natural breakpoints.

### Note Format

```markdown
# {Descriptive Title}

**Discovered:** {YYYY-MM-DD}
**Context:** {Brief context of how or why this was discovered}

## Summary

{1-2 sentence overview}

## Details

{Clear explanation of the pattern, practice, issue, or decision}

## Examples

{Code examples if applicable, with file references}

## References

{Links to relevant files: `path/to/file.ts:line`}
```

### Deduplication

Before writing a new note, check for existing notes in the same category. Update an existing note rather than creating a duplicate. If a note becomes outdated, update or remove it.

### Referencing Captured Knowledge

- **Session start:** List the project knowledge directory (`ls {vault-root}/plans/{project-name}/`) to see what exists. Read notes relevant to the current task or domain.
- **Before deep exploration:** Check for relevant notes before diving into a domain area.
- **During planning:** Read `architecture/` and `coding-patterns/` notes to align plans with established project conventions.
- **Subagents:** When delegating exploration, instruct subagents to check the project knowledge directory for prior findings.
- **Do NOT read everything.** Only read notes relevant to the current work. Use directory listings and filenames to decide what to load.

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
