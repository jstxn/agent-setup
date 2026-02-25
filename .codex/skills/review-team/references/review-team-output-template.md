# Team Review Output Template

## Required Report Sections

# Team Review Findings

## Scope

- Date and time
- Review artifact path (`.reviews/codex/YYYY-MM-DD-{review-number}`)
- Scope mode (`staged`, `unstaged`, `both`)
- Included files with source tags

## Severity Summary

- P0: _n_
- P1: _n_
- P2: _n_
- P3: _n_

## Findings (Highest Severity First)

### P0

- If none, include: `No P0 findings.`

### P1

- If none, include: `No P1 findings.`

### P2

- If none, include: `No P2 findings.`

### P3

- If none, include: `No P3 findings.`

Finding entry format:

`1) [P1] Brief issue title`

- **Files**: `path:line` or `path` if no stable line
- **Impact**: concrete runtime or release impact
- **Recommendation**: exact next fix
- **Scope**: source tags covered (`staged`, `unstaged`, `both`)

## Residual Risks

- Non-critical risks not blocking merge but should be tracked.

## Recommended Next Actions

1. Highest priority fix
2. Follow-up verification or test
3. Optional hardening / cleanup
