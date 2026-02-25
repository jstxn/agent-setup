# Global Agent Policy (Template)

## Scope and Precedence

- System/developer instructions override repository instructions.
- Nearest repository `AGENTS.md` overrides this global template.

## Defaults

- Plan before implementation.
- Make the smallest correct change.
- Validate touched scope before handoff.
- Report residual risk when tests are skipped.

## Safety

- Never run destructive git commands unless explicitly requested.
- Never revert unrelated local changes.
- Never expose credentials in code, docs, or logs.
