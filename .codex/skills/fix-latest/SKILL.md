---
name: fix-latest
description: Read the latest review findings from .reviews/codex and .reviews/claude in the current git repository, combine them into a unified prioritized fix plan, and apply supported automatic fixes.
---

# Fix Latest

Use this skill when you want to move from review findings to implementation.

## Core behavior

1. Resolve repo root with `git rev-parse --show-toplevel`.
2. Read latest review directories from:
   - `.reviews/codex`
   - `.reviews/claude`
3. Parse findings from each source, merge and dedupe.
4. Write a combined plan to `.reviews/fixes/<today>-<iteration>/fix-plan.md`.
5. Apply only supported exact-match automated fixes when `--apply` is enabled.
6. Report plan path, severity counts, auto-fixes applied, and remaining manual items.

## Safety model

- No destructive edits.
- Auto-fixes are limited to exact-pattern replacements from trusted findings.
- Ambiguous or non-matching findings are left as manual follow-up items.

## References

- [fix-latest-checks.md](references/fix-latest-checks.md)
- [fix-latest-output-template.md](references/fix-latest-output-template.md)
- [fix-latest-runbook.md](references/fix-latest-runbook.md)
