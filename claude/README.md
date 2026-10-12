# Claude Code config

Versioned Claude Code setup, symlinked into `~/.claude/`.

## What's here

**Routing policy** (`CLAUDE.md`)

| Work | Model | How |
|---|---|---|
| Deep tasks, research, investigation | Opus | Main session or the `researcher` agent |
| Implementation | Sonnet | The `developer` agent |
| Mundane, mechanical tasks | Haiku | The `runner` agent |
| Anything | Fable | Only with explicit permission in the conversation |

- `agents/`: `researcher` (Opus), `developer` (Sonnet), `runner` (Haiku).
- `hooks/model-routing.sh`: a PreToolUse hook on `Agent` that forces each agent type onto its policy model.
- `hooks/log-routing.sh`: a second, async `Agent` hook that appends one tab-separated line per launch (time, project, agent type, effective model, description) to `~/.claude/logs/routing.log`. It never blocks.
- `hooks/statusline.sh`: the status line, `<model> · effort <level> · <dir> · <branch>`, with the branch left out outside a git repo.
- `skills/ship/`: the `/ship` skill. Opus plans, Sonnet implements, Opus reviews.
- `settings.json`: default model, fallback model, the hook wiring, and `permissions.ask` rules that prompt before pushes, publishes, and deploys.

## Install

```bash
./claude/install.sh
```

Existing real files are moved to `~/.claude/backups/dotfiles-<timestamp>/`, then symlinked. Re-running is harmless.

## Not versioned

- `settings.local.json`: machine-local permissions.
- `skills/synced/`: managed by claude.ai sync.
- `projects/` (memory), `plans/`, history, cache, sessions, plugins: local state.

## Caveat

Claude Code can rewrite `settings.json` (for example after `/config` changes). If it replaces the symlink with a regular file, rerun `install.sh`: it stops and shows a diff so you can copy the changes back here first (`--force` backs the file up and relinks instead).

`settings.json` contains one machine-specific path (the gitkraken marketplace); adjust it on a new machine.
