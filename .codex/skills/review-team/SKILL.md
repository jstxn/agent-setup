---
name: review-team
description: Run an automated, evidence-first review of current repository changes by scanning staged and unstaged diffs together, coordinating multiple review passes, and writing a combined findings report in .reviews/codex/YYYY-MM-DD-{iteration}.
metadata:
  short-description: Multi-pass team review for staged + unstaged changes
---

# Review Team

Use this skill to run `/review-team` for an automated team-style code review over current working-tree changes.

## Core Behavior

- default scope: review both staged and unstaged changes together.
- automated scan: run review passes without asking for each finding.
- output: one combined Markdown report under `.reviews/codex/YYYY-MM-DD-{iteration}`.
- prioritize findings-first summaries and severity ordering.

## Prerequisites

1. User must run the skill in a git repository.
2. If the repo root cannot be resolved, stop and explain the required context.
3. If `.reviews/` does not exist, create it.
4. If `.reviews/codex/` does not exist, create it.

## Execution Workflow

### 1) Build the scoped file set

1. Resolve repo root:
   - `git rev-parse --show-toplevel`
2. Resolve staged files:
   - `git diff --cached --name-only`
3. Resolve unstaged files:
   - `git diff --name-only`
4. If user provides a scope override, honor it:
   - `only staged`
   - `only unstaged`
   - `path: <glob>` (apply after diff collection)
5. Produce a combined file list with provenance tags per file (`staged`, `unstaged`, `both`).
6. If the effective file list is empty, write `.reviews/codex/<date>-<iteration>/review-team-empty.md` with the timestamped header and a short note.

### 2) Run review passes (automated)

Run passes independently and then merge results:

1. Correctness and behavior
2. Security and privacy
3. Type and contract consistency
4. Observability, reliability, and rollout safety
5. Team process and maintainability signals

For each finding, capture:

- severity (`P0`-`P3`)
- exact file targets
- impact with reproducible failure mode
- concrete fix recommendation
- confidence/ambiguity note (short)

Deduplicate overlapping findings before writing final output.

### 3) Write one combined findings file

Create or update exactly one file:

- `.reviews/codex/YYYY-MM-DD-{review-number}/review-team.md`

The `review-number` is a per-day incrementing integer:

1. Ensure `.reviews/` exists, creating it if needed.
2. `YYYY-MM-DD` is the local date at run time.
3. Ensure `.reviews/codex/` exists, creating it if needed.
4. Locate existing directories in `.reviews/codex` matching `YYYY-MM-DD-<number>`.
5. Use the next integer after the highest existing one, zero-padded to 2 or 3 digits (e.g., `2026-02-12-01`).
6. Create that directory before writing the report.

Include all sections from `references/review-team-output-template.md` in exact order.

### 4) Return concise handoff

Reply with:

1. generated report path
2. counts by severity
3. highest-risk 3 findings
4. 2–3 recommended next actions

## Report file contract

Follow this contract:

1. Findings-first order, highest severity first.
2. P0 and P1 must include clear blocking rationale.
3. If no issues are found in a given severity, include explicit empty-state text.
4. Keep recommendations specific and actionable.

## Multi-agent execution preference

When practical, run multiple internal review passes in parallel and merge outputs:

- correctness pass
- security pass
- operational pass

Only merge if each pass can cite distinct evidence for the same file and line.

## References

- [review-team-checks.md](references/review-team-checks.md): per-pass checklist and acceptance criteria.
- [review-team-output-template.md](references/review-team-output-template.md): strict output sections and finding format.
- [review-team-runbook.md](references/review-team-runbook.md): command-level examples and edge cases.
