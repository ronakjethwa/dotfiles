#!/bin/sh
# PreToolUse hook for the Agent tool: enforces the model routing policy in ~/.claude/CLAUDE.md.
#   - Any Fable request -> denied unless ~/.claude/fable-ok exists; that flag is deleted on use (one launch per approval).
#   - researcher -> opus, developer -> sonnet, runner -> haiku: a conflicting model override is rewritten to the tier's model.
# Prints nothing (no opinion) for everything else.
input=$(cat)
flag="$HOME/.claude/fable-ok"
fable_ok=false
if [ -f "$flag" ] && printf '%s' "$input" | jq -e '(.tool_input.model // "") | test("fable"; "i")' >/dev/null 2>&1; then
  fable_ok=true
  rm -f "$flag"
fi
printf '%s' "$input" | jq -c --argjson ok "$fable_ok" '
  (.tool_input.model // "") as $m
  | ({researcher: "opus", developer: "sonnet", runner: "haiku"}[.tool_input.subagent_type // ""]) as $tier
  | if ($m | test("fable"; "i")) then
      if $ok then
        {hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "allow",
          permissionDecisionReason: "Fable approved by user (one-time ~/.claude/fable-ok consumed)."}}
      else
        {hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "deny",
          permissionDecisionReason: "Fable needs explicit user approval. Ask the user in chat; to allow one launch they run: ! touch ~/.claude/fable-ok"}}
      end
    elif $tier != null and $m != "" and ($m | ascii_downcase | contains($tier) | not) then
      {hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "allow",
        permissionDecisionReason: "Model routing policy: \(.tool_input.subagent_type) runs on \($tier); override \($m) replaced.",
        updatedInput: (.tool_input | .model = $tier)}}
    else empty end
'
