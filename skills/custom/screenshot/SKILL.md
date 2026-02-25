---
name: screenshot
description: Capture OS-level screenshots when explicitly requested or when tool-native capture is unavailable.
---

# Screenshot

## Save Rules

1. If user specifies a path, save there.
2. If no path specified, use OS default screenshot location.
3. For internal inspection-only captures, use temp directory.

## Priority

- Prefer tool-native screenshot methods first (for browser/design tools).
- Use OS-level capture for desktop/system contexts or explicit user request.
