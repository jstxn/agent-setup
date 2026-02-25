# Contributing

## Contribution Rules

- Keep the repository markdown-only.
- Keep naming generic and reusable.
- Do not add internal project names, brand names, or personal identifiers.
- Do not add secrets, tokens, or private endpoints.
- Keep changes minimal and scoped to the requested behavior.

## Manual Validation Before PR

1. Confirm markdown-only file set:
   ```bash
   find . -type f -not -path './.git/*' | grep -v '\\.md$' || true
   ```
   Expected output: no lines.
2. Review changed docs for private naming/path leakage.
3. Verify links between docs still resolve.

## Third-Party Content

- Keep third-party skills in `skills/external/` as references only.
- Do not vendor external skill text unless license and attribution are explicit.
