# Claude Code project template

Official `.claude/` layout (per [code.claude.com/docs/en/claude-directory](https://code.claude.com/docs/en/claude-directory)), current as of 2026.

## What's in this scaffold

```
CLAUDE.md                        - project instructions, loaded every session
.mcp.json.example                - team-shared MCP servers (rename to .mcp.json)
.claude/
  settings.json                  - permissions + hooks, committed
  settings.local.json.example    - personal overrides (copy to settings.local.json, gitignored)
  rules/example.md               - path-scoped instructions (loads only for matching files)
  skills/example-skill/SKILL.md  - on-demand workflow, Claude auto-invokes by description
  skills/ship/SKILL.md           - user-only skill (disable-model-invocation: true) -> /ship
  agents/code-reviewer.md        - subagent, own context window, restricted tools
  hooks/format-on-write.sh       - PostToolUse hook, wired in settings.json
```

Not scaffolded (created automatically, don't hand-author):
- `.claude/workflows/` - saved from `/workflows` inside a session
- `.claude/agent-memory/` - written by subagents with `memory: project` frontmatter
- `.claude/output-styles/` - usually personal, put in `~/.claude/output-styles/` instead

## Setup

- Run `scripts/new-claude-project.sh /path/to/project` to copy this into a repo
- Fill in `CLAUDE.md`: stack, commands, hard rules - keep it under ~200 lines
- Rename `.mcp.json.example` → `.mcp.json` and add real servers, or delete it
- Trim `.claude/settings.json` permissions to what this project actually needs
- Copy `.claude/settings.local.json.example` → `.claude/settings.local.json` for personal overrides (already gitignored by Claude Code on first write)
- Replace `code-reviewer.md`, `example-skill/`, `ship/` with real agents/skills, or delete them
- If `CLAUDE.md` grows past ~200 lines, split path-specific instructions into `.claude/rules/<topic>.md` with a `paths:` glob
- `git add CLAUDE.md .mcp.json .claude && git commit`

## Precedence (only matters if a key collides)

- `settings.json`: managed (org) > CLI flags > `.claude/settings.local.json` > `.claude/settings.json` (project) > `~/.claude/settings.json` (user). Arrays like `permissions.allow` merge across all of these; scalars (`model`, etc.) use the most specific.
- `CLAUDE.md`: user-level and project-level are both loaded together, not merged - if they conflict, project wins.
- `commands/` still works but is deprecated - use `skills/` instead (same `/name` invocation, plus you can bundle files).

## Further reading

- [Claude Code: Explore the .claude directory](https://code.claude.com/docs/en/claude-directory) (source of truth for this template)
- [Claude Code best practices](https://code.claude.com/docs/en/best-practices)
- [Extend Claude with skills](https://code.claude.com/docs/en/skills)
- Bartek Paczesny, [Claude Code Hooks, Skills and Subagents: a Practical Setup](https://dev.paczesny.pl/blog/en/how-to-setup-claude-code-hooks-skills)
- ChrisWiles, [claude-code-showcase](https://github.com/ChrisWiles/claude-code-showcase) - full example repo
