---
name: fix-latest
description: Read latest review findings, merge and prioritize them, then apply supported automatic fixes.
---

# Fix Latest

Use this skill to move from review findings to implementation.

## Workflow

1. Resolve repository root.
2. Read latest findings from `.reviews/codex` and `.reviews/claude`.
3. Merge and dedupe findings into one prioritized plan.
4. Write plan to `.reviews/fixes/<date>-<iteration>/fix-plan.md`.
5. Apply only safe exact-match auto-fixes.
6. Report what was auto-fixed vs left for manual follow-up.

## Safety

- Never perform destructive operations.
- Leave ambiguous findings as manual items.
