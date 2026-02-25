@~/AGENTS.md

- Never include claude as a co-author
- Use explore agents for non-trivial tasks that require codebase context gathering

## Obsidian CLI

- Use the `obsidian` CLI for note retrieval and referencing tasks.
- Prefer deterministic opens: `obsidian "obsidian://open?vault=<vault>&file=<relative-path>"`.
- When creating plans (including Plan mode), save the note to the relevant Obsidian vault under `plans/`.
- Vault routing: `workspace-beta` projects -> `workspace-beta` vault, `workspace-alpha` projects -> `workspace-alpha` vault, others -> vault matching `{PROJECT_NAME}`.

# Shared Context
On every session start, call context_boot(project: "your-project")
While working, call context_add for decisions and observations.
