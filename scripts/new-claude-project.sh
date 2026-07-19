#!/usr/bin/env bash
# Copy the claude-project scaffold (CLAUDE.md, .mcp.json.example, .claude/) into a target repo.
# Usage: ./scripts/new-claude-project.sh /path/to/project
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
template_dir="$script_dir/../templates/claude-project"
target="${1:?usage: new-claude-project.sh /path/to/project}"

[ -d "$target" ] || { echo "no such directory: $target" >&2; exit 1; }

copy_item() {
  local src="$1" dest="$2"
  if [ -e "$dest" ]; then
    read -r -p "$dest exists, overwrite? [y/N] " reply
    [[ "$reply" =~ ^[Yy]$ ]] || { echo "skipped $(basename "$dest")"; return; }
  fi
  cp -r "$src" "$dest"
  echo "wrote $dest"
}

copy_item "$template_dir/CLAUDE.md" "$target/CLAUDE.md"
copy_item "$template_dir/.mcp.json.example" "$target/.mcp.json.example"

mkdir -p "$target/.claude"
for item in "$template_dir/.claude"/*; do
  copy_item "$item" "$target/.claude/$(basename "$item")"
done

chmod +x "$target/.claude/hooks/"*.sh 2>/dev/null || true

echo "done. edit $target/CLAUDE.md and $target/.claude/settings.json next."
