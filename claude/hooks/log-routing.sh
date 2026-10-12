#!/bin/sh
# PreToolUse hook for the Agent tool: appends one tab-separated line per launch to ~/.claude/logs/routing.log.
#   Columns: local ISO-8601 time, cwd basename, subagent_type, effective model, description (flattened, 80 chars).
#   Effective model: researcher -> opus, developer -> sonnet, runner -> haiku (policy forces these);
#   otherwise the requested model or "default"; any Fable request is logged as "fable (approval asked)".
# Prints nothing to stdout and always exits 0: a logging failure must never block an agent.
log_dir="$HOME/.claude/logs"
mkdir -p "$log_dir" 2>/dev/null || exit 0
jq -r --arg ts "$(date +%Y-%m-%dT%H:%M:%S%z)" '
  (.tool_input.subagent_type // "general-purpose") as $type
  | (.tool_input.model // "") as $m
  | ({researcher: "opus", developer: "sonnet", runner: "haiku"}[$type]) as $tier
  | [ $ts,
      ((.cwd // "") | split("/") | map(select(. != "")) | last // ""),
      $type,
      (if ($m | test("fable"; "i")) then "fable (approval asked)"
       elif $tier != null then $tier
       elif $m != "" then $m
       else "default" end),
      ((.tool_input.description // "") | gsub("[\t\r\n]"; " ") | .[0:80])
    ] | @tsv
' >> "$log_dir/routing.log" 2>/dev/null
exit 0
