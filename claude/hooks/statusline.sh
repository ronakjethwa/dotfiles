#!/bin/sh
# Status line: "<model> · effort <level> · <dir> · <git branch>" (branch omitted outside a git repo).
# Reads the status line JSON on stdin. Effort comes from .effort.level, then effortLevel in
# ~/.claude/settings.json, then $CLAUDE_CODE_EFFORT_LEVEL, then "default". Dim ANSI on separators only.
input=$(cat)
model=$(printf '%s' "$input" | jq -r '.model.display_name // "Claude"')
dir=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // ""')
effort=$(printf '%s' "$input" | jq -r '.effort.level // empty')
[ -n "$effort" ] || effort=$(jq -r '.effortLevel // empty' "$HOME/.claude/settings.json" 2>/dev/null)
[ -n "$effort" ] || effort=${CLAUDE_CODE_EFFORT_LEVEL:-default}
name=$(basename "${dir:-.}")
branch=""
[ -n "$dir" ] && branch=$(git -C "$dir" branch --show-current 2>/dev/null)
sep=$(printf ' \033[2m·\033[0m ')
out="$model${sep}effort $effort${sep}$name"
[ -n "$branch" ] && out="$out${sep}$branch"
printf '%s\n' "$out"
