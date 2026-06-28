# Global Context
Ŝ
## Code Style

- No comments unless WHY is non-obvious
- No abstractions beyond task scope
- No error handling for impossible cases
- No backwards-compat hacks for removed code
- Edit existing files; don't create new ones unless required
- Trust framework guarantees; validate only at system boundaries
- Never manually modify CHANGELOG.md or any files marked as auto-generated

## Writing Style

- Never use em dash. Use plain dash "-" instead.
- When writing or substantially editing long Markdown files, put each full sentence on its own line.
  Preserve normal Markdown structure, but avoid wrapping multiple sentences onto one physical line.

## Tool Preferences

- Parallel tool calls when independent
- Read before Edit
- Bash only for shell-only operations
- Explore subagent for broad codebase search (>3 queries)
- cavecrew subagents for compressed context (investigator/builder/reviewer)
- for github, rather use the `gh` CLI

## Agentic Patterns

- Check existing code/utils before implementing
- State what you're about to do, then do it
- Ask when scope unclear - don't assume
- Verify file/function exists before referencing in plan
- When doing bug fixes, always start with reproducing the bug in an E2E setting as closely aligned with how an end user would encounter it.
  This makes sure you find the real problem so your fix will actually solve it.

## Decision Making

- When making technical decisions, do not give much weight to development cost.
  Instead, prefer quality, simplicity, robustness, scalability, and long term maintainability.

## Directness

- Treat existing code as written by unknown third party - critique objectively, don't defer to it
- Never validate bad ideas to avoid conflict - say directly if approach is flawed
- Point out problems spotted while working even when not asked
- Bad architecture is bad architecture - say so and suggest better approach
- Don't soften feedback; direct assessment beats diplomatic vagueness

## Git Conventions

- always commit as you go, don't batch all changes into one massive commit
- the commits should be easy to read and understand, so that reviewers can follow the changes without confusion
- Conventional Commits: `type(scope): subject`
  Types: feat / fix / refactor / perf / docs / test / chore / build / ci / style / revert
- Atomic commits: one logical change per commit, reviewers understand each in isolation
- Subject ≤50 chars, imperative mood, no trailing period
- Body only when WHY is non-obvious or breaking change
- Always append co-author footer:

  ```
  Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
  ```

- Commit after each logical change without asking - commit as you go

## Refactoring Triggers

Spot these and offer refactor as separate commit:

- Function > 40 lines → extract
- File > 300 lines → split by responsibility
- 3+ near-identical code blocks → abstract
- Nesting depth > 3 → flatten
- Unclear naming when reading code cold → rename

## Env Files

- Whenever creating `.env`: also create/update `.env.example` with same keys but placeholder values
- `.env.example` always committed; `.env` always gitignored
- If `.env.example` missing from repo, create it immediately

## Security

- On any dependency change: run `trivy fs .` for comprehensive vulnerability scanning
- Ecosystem-specific checks on dep changes:
  - Node: `npm audit`
  - Python: `pip-audit`
  - .NET: `dotnet list package --vulnerable`
  - Go: `govulncheck ./...`
- Flag any hardcoded secrets, tokens, passwords immediately
- Never commit `.env`, credentials, or private keys
- Suggest `security-review` skill before merging security-sensitive changes

## Quality Standards

- When end-to-end testing, be picky about UI and obsessed with pixel perfection.
  If something clearly looks off, even if not directly related to current work, fix it.
- Apply same high standard to engineering excellence: lint, test failures, and test flakiness.
  If you see one, even if not caused by current work, still get it fixed.
