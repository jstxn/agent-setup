# Review Team Checklists

## 1) Scope Check

1. Confirm repository detection succeeds.
2. Confirm staged + unstaged scope (or override mode).
3. Confirm path list excludes files outside user scope.

## 2) Correctness Pass

1. Identify behavioral edge cases introduced by changed logic.
2. Verify control flow handles empty/error states.
3. Check for mismatched assumptions between related modules.
4. Flag race/ordering/state bugs where applicable.

## 3) Security & Privacy Pass

1. Look for credential handling and secret leakage paths.
2. Verify auth checks and authorization boundaries remain consistent.
3. Check for unsafe command execution or input injection risks.
4. Review file writes/uploads for path trust issues.

## 4) Type/Contract Pass

1. Validate type consistency for changed public contracts.
2. Check for silent contract drift in DTO/model/function interfaces.
3. Verify optional values and defaults have safe fallback behavior.
4. Identify likely runtime type mismatches from changed callsites.

## 5) Operational Reliability Pass

1. Error handling completeness and propagation quality.
2. Logging quality and signal-to-noise ratio.
3. Test coverage touchpoints impacted by changed behavior.
4. Backwards compatibility and migration path if behavior changed.

## 6) Maintainability & Team Process Pass

1. Duplicated logic and missing extraction opportunities.
2. TODO/FIXME that block safe merge readiness.
3. Documentation/config mismatch relative to behavior.
4. Missing or inconsistent cleanup/resource lifecycle handling.
