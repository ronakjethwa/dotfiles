#!/usr/bin/env bash
# Symlink the versioned Claude Code config into ~/.claude.
# Safe to run repeatedly. Portable to macOS bash 3.2 / BSD tools.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.claude"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$DEST/backups/dotfiles-$STAMP"

TARGETS="settings.json CLAUDE.md agents hooks skills/ship"

mkdir -p "$DEST" "$DEST/skills"

for t in $TARGETS; do
  src="$SRC/$t"
  dest="$DEST/$t"

  if [ ! -e "$src" ]; then
    echo "missing source: $src" >&2
    exit 1
  fi

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "skip   $t (already linked)"
    continue
  fi

  # A real file that differs from the repo copy may hold changes Claude Code wrote
  # (e.g. /config replacing the settings.json symlink). Don't bury them in a backup.
  if [ -f "$dest" ] && [ ! -L "$dest" ] && ! cmp -s "$dest" "$src" && [ "${1:-}" != "--force" ]; then
    echo "conflict $t: $dest is a regular file that differs from the repo copy:" >&2
    diff -u "$src" "$dest" >&2 || true
    echo "Copy the changes you want into $src, then rerun (or pass --force to back it up and relink)." >&2
    exit 1
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mkdir -p "$BACKUP/$(dirname "$t")"
    mv "$dest" "$BACKUP/$t"
    echo "backup $t -> $BACKUP/$t"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "link   $t"
done

echo
echo "Links:"
for t in $TARGETS; do
  ls -ld "$DEST/$t"
done

echo
jq empty "$DEST/settings.json" && echo "settings.json: valid JSON"
