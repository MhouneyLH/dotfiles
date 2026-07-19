#!/usr/bin/env bash
# Copy the .claude/ scaffold from templates/claude-project into a target repo.
# Usage: ./scripts/new-claude-project.sh /path/to/project
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
template_dir="$script_dir/../templates/claude-project/.claude"
target="${1:?usage: new-claude-project.sh /path/to/project}"
target_claude="$target/.claude"

[ -d "$target" ] || { echo "no such directory: $target" >&2; exit 1; }

mkdir -p "$target_claude"

for item in "$template_dir"/*; do
  name="$(basename "$item")"
  dest="$target_claude/$name"
  if [ -e "$dest" ]; then
    read -r -p "$dest exists, overwrite? [y/N] " reply
    [[ "$reply" =~ ^[Yy]$ ]] || { echo "skipped $name"; continue; }
  fi
  cp -r "$item" "$dest"
  echo "wrote $dest"
done

chmod +x "$target_claude/hooks/"*.sh 2>/dev/null || true

echo "done. edit $target_claude/CLAUDE.md and settings.json next."
