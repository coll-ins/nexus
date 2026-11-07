#!/usr/bin/env bash
# Install Nexus globally on this machine (every repo you open with Claude Code).
# Symlinks, not copies: `git pull` in the nexus repo updates everything,
# and preferences Nexus learns are written back into this repo.
set -euo pipefail
NEXUS="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_HOME="$HOME/.claude"
mkdir -p "$CLAUDE_HOME/agents"

link() {  # link <source> <target>; back up a real file that's in the way
  if [ -e "$2" ] && [ ! -L "$2" ]; then
    mv "$2" "$2.bak.$(date +%Y%m%d%H%M%S)"
    echo "backed up existing $2"
  fi
  ln -sfn "$1" "$2"
  echo "linked $2"
}

link "$NEXUS" "$CLAUDE_HOME/nexus"
link "$NEXUS/CLAUDE.md" "$CLAUDE_HOME/CLAUDE.md"
for a in "$NEXUS"/.claude/agents/*.md; do
  link "$a" "$CLAUDE_HOME/agents/$(basename "$a")"
done
mkdir -p "$CLAUDE_HOME/skills"
for d in "$NEXUS"/.claude/skills/*/; do
  link "${d%/}" "$CLAUDE_HOME/skills/$(basename "$d")"
done
if [ -e "$CLAUDE_HOME/settings.json" ]; then
  grep -q '"attribution"' "$CLAUDE_HOME/settings.json" || echo "add the attribution block from $NEXUS/.claude/settings.json to $CLAUDE_HOME/settings.json"
else
  link "$NEXUS/.claude/settings.json" "$CLAUDE_HOME/settings.json"
fi
echo "Nexus installed. Restart Claude Code."
