#!/bin/sh
# PreToolUse hook for the Bash tool: hard gate on git push (auto mode accepts "ask" rules without prompting).
#   - A git push -> denied unless ~/.claude/push-ok exists; that flag is deleted on use (one push per approval).
# Prints nothing (no opinion) for everything else, and never consumes the flag for non-push commands.
input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // ""' 2>/dev/null)
flag="$HOME/.claude/push-ok"
re='(^|[;&|(])[[:space:]]*git([[:space:]]+-[^[:space:]]+([[:space:]]+[^-[:space:]][^[:space:]]*)?)*[[:space:]]+push([[:space:]]|$)'
if printf '%s' "$cmd" | grep -Eq "$re"; then
  if [ -f "$flag" ]; then
    rm -f "$flag"
    jq -nc '{hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "allow",
      permissionDecisionReason: "Push approved by user (one-time ~/.claude/push-ok consumed)."}}'
  else
    jq -nc '{hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "deny",
      permissionDecisionReason: "git push needs explicit user approval. Ask the user in chat; to allow one push they run: ! touch ~/.claude/push-ok"}}'
  fi
fi
exit 0
