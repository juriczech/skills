#!/usr/bin/env bash
# Symlink this repo's rules and skills into every agent's global config. Idempotent.
# Re-run only after adding or renaming a skill; edits to existing files are live through the links.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RULES="$REPO/rules/workflow.md"

link() {
  mkdir -p "$(dirname "$2")"
  if [ -e "$2" ] && [ ! -L "$2" ]; then
    echo "skip  $2 (real file in the way; move it and re-run)"
    return
  fi
  ln -sfn "$1" "$2"
  echo "link  $2"
}

# Rules
link "$RULES" "$HOME/.claude/rules/workflow.md"
link "$RULES" "$HOME/.codex/AGENTS.md"
[ -d "$HOME/.gemini" ] && link "$RULES" "$HOME/.gemini/GEMINI.md"
[ -d "$HOME/.config/opencode" ] && link "$RULES" "$HOME/.config/opencode/AGENTS.md"

# Skills: ~/.agents/skills (Codex, OpenCode, skills CLI) and ~/.claude/skills (Claude Code)
find "$REPO/skills" -name SKILL.md -type f | while read -r f; do
  dir="$(dirname "$f")"
  link "$dir" "$HOME/.agents/skills/$(basename "$dir")"
  link "$dir" "$HOME/.claude/skills/$(basename "$dir")"
done

# Claude Code: no Co-Authored-By / "Generated with" lines
SETTINGS="$HOME/.claude/settings.json"
if command -v jq >/dev/null && [ -f "$SETTINGS" ]; then
  tmp="$(mktemp)"
  jq '.attribution = {"commit": "", "pr": ""}' "$SETTINGS" > "$tmp" && mv "$tmp" "$SETTINGS"
  echo "set   attribution off in $SETTINGS"
fi
