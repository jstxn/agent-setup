@~/AGENTS.md

- Never include claude as a co-author
- Use explore agents for non-trivial tasks that require codebase context gathering
- Proactively capture and reference project knowledge during work. See `Knowledge Capture` and `Referencing Captured Knowledge` in `AGENTS.md`.

## Obsidian Vault Operations

- Do NOT use the `obsidian` binary. It launches the Electron GUI app and can hang in non-interactive shells.
- Read notes directly from vault Markdown files on disk.
- Write `.md` files directly into the vault and ensure parent directories exist with `mkdir -p`.
- Resolve vault roots from local configuration. Use project-specific roots when configured, otherwise use the default local vault root.
- When creating plans (including Plan mode), save notes under the relevant vault `plans/` directory.

# Shared Context
On every session start, call context_boot(project: "your-project")
While working, call context_add for decisions and observations.
