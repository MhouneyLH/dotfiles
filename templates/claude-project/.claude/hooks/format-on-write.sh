#!/usr/bin/env bash
# PostToolUse hook (Write|Edit). Receives tool-call JSON on stdin.
# Fill in the formatter for this project's stack; no-ops until then.
set -euo pipefail

file=$(jq -r '.tool_response.filePath // .tool_input.file_path // empty')
[ -z "$file" ] && exit 0

case "$file" in
  *.ts|*.tsx|*.js|*.jsx) : ;; # e.g. npx prettier --write "$file"
  *.go) : ;;                  # e.g. gofmt -w "$file"
  *.py) : ;;                  # e.g. ruff format "$file"
  *) exit 0 ;;
esac

exit 0
