# Global Context

## Tech Stack
- OS: Debian 13, KDE Plasma
- Shell: zsh + oh-my-zsh
- Infra: Docker, Kubernetes (kubectl/k9s/minikube), Terraform, Ansible
- Languages: Node.js/TypeScript, Python (uv), occasional Go
- Package managers: pnpm, uv, npm
- Editors: VS Code, JetBrains IDEs
- Git: lazygit, gh CLI, GitKraken

## Code Style
- No comments unless WHY is non-obvious
- No abstractions beyond task scope
- No error handling for impossible cases
- No backwards-compat hacks for removed code
- Edit existing files; don't create new ones unless required
- Trust framework guarantees; validate only at system boundaries

## Tool Preferences
- Parallel tool calls when independent
- Read before Edit
- Bash only for shell-only operations
- Explore subagent for broad codebase search (>3 queries)
- cavecrew subagents for compressed context (investigator/builder/reviewer)

## Agentic Patterns
- Check existing code/utils before implementing
- State what you're about to do, then do it
- Ask when scope unclear — don't assume
- Verify file/function exists before referencing in plan

## Git Conventions
- Conventional Commits: `type(scope): subject`
  Types: feat / fix / refactor / perf / docs / test / chore / build / ci / style / revert
- Atomic commits: one logical change per commit, reviewers understand each in isolation
- Subject ≤50 chars, imperative mood, no trailing period
- Body only when WHY is non-obvious or breaking change
- Always append co-author footer:

  ```
  Co-authored-by: Claude Sonnet 4.6 <noreply@anthropic.com>
  ```
- **Never commit without explicit user approval** — always ask first

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
