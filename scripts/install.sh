#!/usr/bin/env bash
# Install Nexus globally on this machine (every repo you open with Claude Code).
# Symlinks, not copies: `git pull` in the nexus repo updates everything,
# and preferences Nexus learns are written back into this repo.
set -euo pipefail
NEXUS="$(cd "$(dirname "$0")/.." && pwd)"
PREFS="$NEXUS/memory/preferences.md"
CLAUDE_HOME="$HOME/.claude"
mkdir -p "$CLAUDE_HOME/agents" "$CLAUDE_HOME/skills"

link() {  # link <source> <target>; back up anything in the way that isn't already this link
  BAK=""
  if [ "$1" -ef "$2" ]; then echo "ok $2"; return; fi
  if { [ -e "$2" ] || [ -L "$2" ]; } && [ "$(readlink "$2" || true)" != "$1" ]; then
    BAK="$2.bak.$(date +%Y%m%d%H%M%S).$$"
    mv "$2" "$BAK"
    echo "backed up existing $2 -> $BAK"
  fi
  ln -sfn "$1" "$2"
  echo "linked $2"
}

link "$NEXUS" "$CLAUDE_HOME/nexus"
# An old real ~/.claude/nexus may hold rules learned before: merge them, don't strand them.
if [ -n "$BAK" ] && [ -f "$BAK/memory/preferences.md" ]; then
  old=$(grep -E '^- ' "$BAK/memory/preferences.md" | grep -vxFf "$PREFS" || true)
  if [ -n "$old" ]; then
    [ -z "$(tail -c1 "$PREFS")" ] || echo >> "$PREFS"
    printf '%s\n' "$old" >> "$PREFS"
    echo "merged $(printf '%s\n' "$old" | wc -l) rule(s) from the old install into $PREFS. Review and commit."
  fi
fi
link "$NEXUS/CLAUDE.md" "$CLAUDE_HOME/CLAUDE.md"
for a in "$NEXUS"/.claude/agents/*.md; do
  link "$a" "$CLAUDE_HOME/agents/$(basename "$a")"
done
for d in "$NEXUS"/.claude/skills/*/; do
  link "${d%/}" "$CLAUDE_HOME/skills/$(basename "$d")"
done

# settings.json is a real file, not a link: Claude Code writes /config and /model
# choices into it, and those must not land in the nexus repo.
S="$CLAUDE_HOME/settings.json"
[ "$(readlink "$S" || true)" != "$NEXUS/.claude/settings.json" ] || rm "$S"  # undo older installs
python3 "$NEXUS/scripts/merge-attribution.py" "$S" "$NEXUS/.claude/settings.json"
# graphify: local code map (tree-sitter, no LLM calls) so Nexus reads less.
# Pinned and in its own venv: an unpinned package auto-installed every session
# is a supply-chain risk. Optional: a failure never stops the install.
G="$HOME/.local/share/nexus-graphify"
if [ -z "${NEXUS_NO_GRAPHIFY:-}" ] && [ ! -x "$G/bin/graphify" ]; then
  { python3 -m venv "$G" && "$G/bin/pip" install -q graphifyy==0.9.105; } >/dev/null 2>&1 \
    || echo "graphify not installed (optional)"
fi
if [ -x "$G/bin/graphify" ]; then
  mkdir -p "$HOME/.local/bin" && ln -sfn "$G/bin/graphify" "$HOME/.local/bin/graphify" && echo "linked graphify"
fi
echo "Nexus installed. Restart Claude Code."
