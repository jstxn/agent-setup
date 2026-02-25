# Fix Latest Checks

## Preflight

- Confirm current directory is a git repository.
- Confirm `.reviews/codex` and/or `.reviews/claude` exist.
- Resolve latest review folders per source.

## Plan Integrity

- Merge duplicate findings across sources.
- Preserve highest severity per merged finding.
- Include file references when available.

## Safety

- Apply only exact-match, deterministic fixes.
- Skip ambiguous matches and leave manual follow-up notes.
