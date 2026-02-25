# Fix Latest Runbook

1. Resolve repo root: `git rev-parse --show-toplevel`.
2. Identify latest review outputs from `.reviews/codex` and `.reviews/claude`.
3. Merge and dedupe findings into one prioritized plan.
4. Apply safe exact-match fixes when enabled.
5. Report summary, applied fixes, and manual follow-ups.
