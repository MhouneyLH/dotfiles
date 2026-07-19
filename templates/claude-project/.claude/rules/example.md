---
paths:
  - "**/*.test.ts"
  - "**/*.test.tsx"
---

# Testing Rules

Only loaded when Claude reads a file matching the `paths:` globs above -
delete this file and write real path-scoped rules, or delete the whole
rules/ folder if CLAUDE.md alone stays under ~200 lines.

- Use descriptive test names: "should [expected] when [condition]"
- Mock external dependencies, not internal modules
- Clean up side effects in afterEach
