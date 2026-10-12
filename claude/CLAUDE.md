# Global conventions

These apply everywhere. A project's own `CLAUDE.md` wins where they disagree.

## Git

- Never add `Co-Authored-By: Claude` or `Generated with Claude Code` to a commit message or PR description. My commits are mine.
- Branch, then open a PR. Don't commit or push straight to `main`.
- Commit subjects: imperative, under ~60 chars. Body only when the diff doesn't already explain the why.

## Model routing

- **Opus** — investigation, debugging, architecture, anything research-shaped.
- **Sonnet** — landing a change whose shape is already decided.
- **Haiku** — mundane mechanical work: search, renames, file moves, formatting.
- **Fable** — ask me first. Never choose it on your own.

- Delegate research to the `researcher` agent (Opus), settled implementation to `developer` (Sonnet), and mundane work to `runner` (Haiku) rather than doing it at Opus prices.
- Don't hand investigation to Haiku-backed agents such as Explore.
- Pushes, publishes and deploys need a clear yes from me in chat first.

## Typography and design

- No tiny text. Sentence-length copy sits around 0.95–1.05rem; sub-0.8rem prose is a bug, not a style.
- Three fonts maximum, each with exactly one job. Mono is for short uppercase labels, kickers and dates — never sentences.
- I review visually. For a design change, show rendered output; a prose description of a layout isn't a review.

## Working style

- Report what you actually ran and what came back. If a check failed, show its output.
- No comments that restate the code.
- Smallest change that works. Don't refactor what I didn't ask about.
