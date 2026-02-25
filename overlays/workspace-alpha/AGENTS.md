# Workspace Alpha Overlay (Template)

Use this for a multi-service backend workspace.

## Rules

1. Services are isolated; share contracts only through APIs/events.
2. Validate changed service scopes inside service-local tooling.
3. Add or update service-level tests for behavior changes.
4. Keep migration or schema updates explicit and reversible.
