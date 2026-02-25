# Codex Local Agent Policy

version: v7
last_updated: 2026-02-25
owner: ExampleUser
applies_to: Codex runtime behavior in `/Users/<user>/.codex`

## Canonical Global Policy

Canonical global policy lives at `/Users/<user>/AGENTS.md`.
Apply that file as the baseline policy for all work. This file is additive and Codex-local.

## Scope and Precedence

1. system/developer instructions > nearest repository `AGENTS.md` > global `~/AGENTS.md`
2. If a rule here conflicts with higher-precedence instructions, follow the higher-precedence source and note the conflict.

## Task Classifier

- `question`: answer directly, verify unstable facts, include sources when needed.
- `review`: findings-first output ordered by severity, then assumptions/gaps, then short summary.
- `implementation`: smallest correct change, validate touched scope, report residual risk.
- `refactor`: preserve behavior unless explicitly requested otherwise; prove equivalence with tests/checks.
- `release`: prioritize reproducibility, explicit verification steps, and rollback notes.

## Codex Preflight Checklist

Before edits:

1. Read applicable rules (`AGENTS.md` nearest to target path and any closer overrides).
2. Check project memory (`.codex/memories/*.md`) if present.
3. Inspect working state (`git status --short`) and avoid touching unrelated changes.
4. Identify impacted files, interfaces, and tests.
5. Confirm non-goals to prevent scope creep.

## Definition of Done

For code-change sessions, complete all applicable items:

1. Minimal correct diff that solves the requested problem.
2. Validation run for touched scope (`typecheck`, `lint`, `test`, `build` where relevant, or explain skips).
3. Risk note covering edge cases, regressions, or operational impact.
4. File references in handoff (`path:line` when helpful).
5. Concise handoff summary with what changed, what was validated, and what remains.

## Review Rubric (P0-P3)

- `P0`: critical correctness/security/data-loss risk; release-blocking.
- `P1`: high-impact bug or major behavior regression risk.
- `P2`: moderate defect/maintainability issue likely to cause future bugs.
- `P3`: low-impact clarity/style issue with limited risk.

When reporting findings, include: severity, file path + line reference, concrete impact, precise fix recommendation.

## Codex-Specific Defaults

1. Prefer `rg`/`rg --files` for search. Parallelize independent read-only discovery commands.
2. Use non-interactive git commands. Validate assumptions against source files before acting.
3. If sandbox restrictions block required work, request escalation with clear justification.
4. If a named skill is missing/unreadable, state the gap and use the best fallback without blocking.
5. Keep handoffs concise, specific, and actionable.
6. Do NOT use the `obsidian` binary — it is the Electron GUI app and can hang in non-interactive shells. Read and write vault notes as plain Markdown files on disk.
7. Resolve vault roots from local configuration. Use project-specific roots when configured, otherwise use the default local vault root. For plan artifacts (including Plan mode), write a `.md` file under the relevant `plans/` directory and ensure parent directories exist with `mkdir -p`.
8. During agentic work, proactively capture reusable project knowledge. At session start and during planning, list available knowledge-note filenames first and read only notes relevant to the current task. Do NOT read everything.

## Change Log

- `v7` (2026-02-25): added knowledge-capture reference loop guidance (list first, read selectively, do not load all notes).
- `v6` (2026-02-25): replaced Obsidian CLI guidance with direct filesystem vault operations.
- `v5` (2026-02-24): added required Obsidian plan capture to the relevant vault `plans/` folder and aligned vault selection with active project context.
- `v4` (2026-02-24): added Obsidian CLI default for the `workspace-alpha` vault.
- `v3` (2026-02-16): removed sections duplicated by global `~/AGENTS.md` (safety, communication, fallback). Consolidated tooling/communication/fallback into Codex-Specific Defaults.
- `v2` (2026-02-06): upgraded from pointer-only to canonical-pointer-plus-overlay policy.
