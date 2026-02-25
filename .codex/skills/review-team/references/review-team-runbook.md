# Review Team Runbook

## Default Run (staged + unstaged)

1. Run `/review-team`.
2. Generate scope from:
   - `git diff --cached --name-only`
   - `git diff --name-only`
3. Write one file:
   - `.reviews/codex/YYYY-MM-DD-<iteration>/review-team.md`

Iteration numbering:

1. Ensure `.reviews/` exists, creating it if needed.
2. Ensure `.reviews/codex/` exists, creating it if needed.
3. Determine `today` as `YYYY-MM-DD`.
4. Inspect existing directories under `.reviews/codex` matching `today-*`.
5. Parse trailing numeric suffixes and choose next integer.
6. Use zero-padded suffix (e.g., `01`, `02`) in `<iteration>`.
7. Create the directory before writing the file.

## Scope Override: Staged Only

- User prompt: "only staged"
- Use only `git diff --cached`.
- Keep output label as `Scope mode: staged`.

## Scope Override: Unstaged Only

- User prompt: "only unstaged"
- Use only `git diff`.
- Keep output label as `Scope mode: unstaged`.

## Path Filter

- User prompt may include `path: <glob>`.
- Apply filter after collecting staged/unstaged file lists.
- If filter removes all files, write a no-findings report with no file scope.

## Empty Scope Behavior

- If no staged and no unstaged files:
  - still create `.reviews/codex/YYYY-MM-DD-<iteration>/review-team-empty.md`
  - include explicit statement: `No file changes detected in selected scope.`

## Multi-Agent Merge Rule

- If multiple review passes produce overlapping findings:
  - keep the highest-confidence entry
  - merge into one with most precise file target and recommendation
