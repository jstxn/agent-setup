@~/AGENTS.md

- Never include claude as a co-author
- Use explore agents for non-trivial tasks that require codebase context gathering

## Obsidian Filesystem

- Do not use the `obsidian` binary. It launches the Electron GUI app and can hang in sandboxed shells.
- Read and write notes directly as Markdown files on disk.
- Vault routing: `g2i` -> `/Users/justen/Development/g2i/`, `upwage` -> `/Users/justen/Development/upwage/`, others -> `/Users/justen/Obsidian/Main/`.
- When creating plans (including Plan mode), save a `.md` note to the relevant vault under `plans/`.
- Ensure the plans directory exists first with `mkdir -p`.

# Shared Context
On every session start, call context_boot(project: "your-project")
While working, call context_add for decisions and observations.
