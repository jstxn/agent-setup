# Contributing

## Contribution Rules

- Keep this repository anonymized and reusable.
- Do not add internal project names, brand names, or personal identifiers.
- Do not add secrets, tokens, or private endpoints.
- Keep changes minimal and scoped to the requested behavior.

## Validation Before PR

Run locally:

```bash
./scripts/validate-catalog.sh
./scripts/scan-leaks.sh --strict
./tests/test-export.sh
./tests/test-redaction.sh
./tests/test-install-selective.sh
```

## Third-Party Content

- Keep third-party skills in `skills/external/` as references only.
- Do not vendor external skill text unless license and attribution are explicit.
