# Conventions

- Commits: no `Co-Authored-By: Claude` trailer (`attribution.commit` is empty in settings). Keep commit messages plain and descriptive.
- Repos with a production deploy on `main` (ronakjethwa-com, ronakjethwa.photos): work on a branch and open a PR. Never push to `main` directly.
- Project-specific rules (stack, design system, build quirks) live in each repo's own `CLAUDE.md`, not here. This file is public in github.com/ronakjethwa/dotfiles.

# Model routing policy

| Work | Model | How |
|---|---|---|
| Deep tasks, research, investigation (root-causing bugs, understanding systems, comparing options, reading docs/web, designing plans) | **Opus** | Do it in the main session when it is on Opus, or delegate to the `researcher` agent. Don't hand investigation to Haiku-backed agents (e.g. Explore). |
| Implementation (writing code, executing a plan, following explicit instructions, builds, tests, deploys) | **Sonnet** | Delegate to the `developer` agent with the plan and clear acceptance criteria. |
| Mundane, mechanical tasks that need no judgment (cloning a repo, fetching/downloading a file, moving files, running a known command and returning output) | **Haiku** | Delegate to the `runner` agent. Escalate back if the task turns out to need thinking. |
| Anything | **Fable** | Only when the user explicitly gives permission in the current conversation. Never on my own initiative. |

- Typical flow: Opus investigates and writes the plan → Sonnet implements it → Opus reviews if the change is risky. `/ship` runs this flow end to end, saving plans to `~/.claude/plans/`.
- Pushes, publishes, and deploys always need the user's confirmation; `permissions.ask` in settings enforces this.
- When a task mixes both, split it: investigation first on Opus, then hand the settled plan to Sonnet.
- Use the family aliases (`opus`, `sonnet`, `haiku`) so models resolve to the latest version.
