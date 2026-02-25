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

## Knowledge Capture

- Proactively capture reusable project knowledge discovered during exploration, debugging, and implementation.
- Capture in these categories: `best-practices/`, `coding-patterns/`, `common-issues/`, and `architecture/`.
- Write notes to `{vault-root}/plans/{project-name}/{category}/{descriptive-slug}.md`.
- Derive `{project-name}` from the repository name and avoid duplicates by updating existing notes.
- Capture at natural breakpoints and skip trivial/session-only information.
- At session start, before deep exploration, and during planning, list the knowledge directory and read only notes relevant to the current task.
- Do NOT read everything. Use directory listings and filenames to select relevant notes.
- Use this note structure: title, discovered date, context, summary, details, examples, and references.

# Shared Context
On every session start, call context_boot(project: "your-project")
While working, call context_add for decisions and observations.
