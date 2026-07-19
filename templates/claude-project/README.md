# Claude Code project template

Drop-in `.claude/` scaffold for wiring a repo up for Claude Code: CLAUDE.md, hooks, subagents, skills, commands, permissions. Copy this into a project with `scripts/new-claude-project.sh`, or by hand.

## Layers, and when to reach for each

| Layer | File(s) | Loaded | Use for |
|---|---|---|---|
| CLAUDE.md | `.claude/CLAUDE.md` (or repo-root `CLAUDE.md`) | Always, every turn | Project-wide rules that apply to nearly every task. Keep it under ~200 lines - the more it holds, the more gets ignored. |
| Skills | `.claude/skills/<name>/SKILL.md` | On-demand, model decides | Repeatable expertise/workflows that only matter *sometimes* (a review checklist, a release process, a codegen recipe). |
| Subagents | `.claude/agents/<name>.md` | Delegated by main thread | Isolated, noisy, or parallelizable work (research, code review, investigation) that shouldn't burn main-context tokens. |
| Commands | `.claude/commands/<name>.md` | User-invoked via `/name` | Explicit shortcuts for things a human triggers on purpose, not things Claude should decide to run. |
| Hooks | `.claude/settings.json` `hooks` block | Event-driven, deterministic | Enforcement that must never depend on the model remembering: format-on-write, block-edits-on-main, run-tests-before-stop, log every Bash call. |
| Permissions | `.claude/settings.json` `permissions` block | Every tool call | Allow/deny/ask lists so routine tool calls (read, grep, safe bash) don't interrupt with prompts, while destructive ops still ask. |
| MCP | `.mcp.json` | Session start | External tool/data integration (issue trackers, DBs, internal APIs) - not included in this template, project-specific. |

Rule of thumb: if removing a CLAUDE.md line would make Claude produce a wrong answer on the *next* task, keep it. If it's advice for an occasional workflow, move it to a skill.

## What's in this scaffold

```
.claude/
  CLAUDE.md              - starter project rules (edit for your stack)
  settings.json           - permissions + example hook wiring
  hooks/
    format-on-write.sh    - example PostToolUse hook (safe no-op until you fill in a formatter)
  agents/
    code-reviewer.md       - example subagent: read-only review, no edits
  commands/
    ship.md                - example slash command
  skills/
    example-skill/SKILL.md - example on-demand skill
```

## Install

```
./scripts/new-claude-project.sh /path/to/your/project
```

Copies `.claude/` into the target repo without clobbering an existing `.claude/CLAUDE.md` or `settings.json` (asks first). Then:

1. Edit `.claude/CLAUDE.md` - replace the placeholders with your actual stack/conventions.
2. Edit `.claude/settings.json` - trim the permission allowlist to what this project actually needs; wire up real hook commands.
3. Delete the example agent/command/skill or use them as templates for real ones.
4. `git add .claude && git commit`

## Further reading

- Anthropic, [Claude Code best practices](https://code.claude.com/docs/en/best-practices)
- Anthropic docs, [Extend Claude with skills](https://code.claude.com/docs/en/skills)
- Bartek Paczesny, [Claude Code Hooks, Skills and Subagents: a Practical Setup](https://dev.paczesny.pl/blog/en/how-to-setup-claude-code-hooks-skills)
- ChrisWiles, [claude-code-showcase](https://github.com/ChrisWiles/claude-code-showcase) - full example repo with hooks/skills/agents/commands/CI
