---
name: review-team
description: Run an evidence-first review over staged and unstaged changes and produce one combined findings report.
---

# Review Team

Use this skill to run a multi-pass repository review on current working-tree changes.

## Core Behavior

1. Resolve repo root with `git rev-parse --show-toplevel`.
2. Collect staged and unstaged files.
3. Run review passes for:
   - Correctness and regressions
   - Security and privacy
   - Type/API contract consistency
   - Reliability and rollout risk
4. Produce a findings-first report ordered by severity (`P0`..`P3`).

## Output Expectations

For each finding include:

- severity
- file path
- concrete impact
- fix recommendation
- confidence note (short)
