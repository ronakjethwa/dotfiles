#!/bin/sh
# PreToolUse hook for the Agent tool: enforces the model routing policy in ~/.claude/CLAUDE.md.
#   - Any Fable request -> ask the user (Fable only with explicit permission).
#   - researcher -> opus, developer -> sonnet, runner -> haiku: a conflicting model override is rewritten to the tier's model.
# Prints nothing (no opinion) for everything else.
jq -c '
  (.tool_input.model // "") as $m
  | ({researcher: "opus", developer: "sonnet", runner: "haiku"}[.tool_input.subagent_type // ""]) as $tier
  | if ($m | test("fable"; "i")) then
      {hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "ask",
        permissionDecisionReason: "Fable requested for a subagent. Policy: Fable only with explicit user permission."}}
    elif $tier != null and $m != "" and ($m | ascii_downcase | contains($tier) | not) then
      {hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "allow",
        permissionDecisionReason: "Model routing policy: \(.tool_input.subagent_type) runs on \($tier); override \($m) replaced.",
        updatedInput: (.tool_input | .model = $tier)}}
    else empty end
'
