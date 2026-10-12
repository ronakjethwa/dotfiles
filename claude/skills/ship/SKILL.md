---
name: ship
description: Run a change end to end under the model routing policy — investigate and plan on Opus, get the user's approval, implement with the Sonnet `developer` agent, then review on Opus. Use when the user types /ship or asks to plan-and-build a change in one flow.
---

# /ship

Carry the task in the arguments through these steps in order. Don't skip the approval gate.

## 1. Investigate (Opus)
- If this session isn't on Opus, say so and suggest `/model opus` before continuing.
- Investigate in this session, or delegate wide or web-heavy research to the `researcher` agent. Hand mechanical chores (cloning, fetching files) to `runner`.
- Settle the open questions now. The implementer should not have to make design decisions.

## 2. Write the plan
Save it to `~/.claude/plans/<YYYY-MM-DD>-<short-slug>.md` with these sections:
- **Goal**: one or two sentences.
- **Context**: the relevant files (`path:line`) and what was learned.
- **Steps**: numbered, concrete, each one small enough to verify.
- **Acceptance criteria**: the commands to run and what passing looks like.
- **Out of scope**: what not to touch.
- **Ship step**: whether this ends in a push or deploy, and to where.

## 3. Approval gate
Show the user a short summary of the plan and its path, then ask them to approve it, change it, or stop. Continue only after they approve.

## 4. Implement (Sonnet)
Delegate to the `developer` agent. Give it the plan file path and tell it to:
- follow the plan,
- run the acceptance checks,
- stop before any push or deploy, and
- report changed files and check results.

If the developer reports that the plan is wrong, go back to step 1. Don't patch it on the fly.

## 5. Review (Opus)
- Review the diff yourself against the plan's goal and acceptance criteria. For anything non-trivial, also run `/code-review`.
- Fix small issues directly. Send larger ones back to `developer` with specific instructions.

## 6. Ship
If the plan has a ship step (for example `git push` to a branch that auto-deploys), ask the user before running it. Permission rules will also prompt. Afterwards, report what shipped and where, with the plan path for the record.
