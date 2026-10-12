#!/bin/sh
# PreToolUse hook for the Bash tool: hard gate on publish/deploy commands (auto mode accepts "ask" rules without prompting).
# Gated: git push, npm publish, netlify deploy, vercel (any), wrangler deploy, gh pr merge, gh release create
# (npx prefixes for netlify/vercel/wrangler included; mirrors permissions.ask in settings.json).
#   - A gated command -> denied unless ~/.claude/push-ok exists (Claude touches it after a verbal yes from the user in chat); that flag is deleted on use (one run per approval).
# Prints nothing (no opinion) for everything else, and never consumes the flag for non-gated commands.
input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // ""' 2>/dev/null)
flag="$HOME/.claude/push-ok"
npx='(npx([[:space:]]+-[^[:space:]]+)*[[:space:]]+)?'
re="(^|[;&|(])[[:space:]]*("
re="$re"'git([[:space:]]+-[^[:space:]]+([[:space:]]+[^-[:space:]][^[:space:]]*)?)*[[:space:]]+push'
re="$re"'|npm[[:space:]]+publish'
re="$re|${npx}netlify[[:space:]]+deploy"
re="$re|${npx}vercel"
re="$re|${npx}wrangler[[:space:]]+deploy"
re="$re"'|gh[[:space:]]+pr[[:space:]]+merge'
re="$re"'|gh[[:space:]]+release[[:space:]]+create'
re="$re)([[:space:]]|\$)"
if printf '%s' "$cmd" | grep -Eq "$re"; then
  if [ -f "$flag" ]; then
    rm -f "$flag"
    jq -nc '{hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "allow",
      permissionDecisionReason: "Approved by user (one-time ~/.claude/push-ok consumed)."}}'
  else
    jq -nc '{hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "deny",
      permissionDecisionReason: "Publish/deploy command needs explicit user approval. Ask the user in chat; on a clear yes, run `touch ~/.claude/push-ok` as its own Bash call (not chained with the command), then retry."}}'
  fi
fi
exit 0
