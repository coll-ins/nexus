#!/usr/bin/env bash
# Make Nexus global: every Claude Code session in every repo gets the brain, agents, skills and hooks.
set -euo pipefail
NEXUS="$(cd "$(dirname "$0")" && pwd)"
C="$HOME/.claude"; mkdir -p "$C"
link() { if [ -e "$2" ] && [ ! -L "$2" ]; then mv "$2" "$2.bak.$(date +%s)"; echo "backed up $2"; fi; ln -sfn "$1" "$2"; echo "linked $2"; }
link "$NEXUS/CLAUDE.md"       "$C/CLAUDE.md"
link "$NEXUS/brain"           "$C/brain"
link "$NEXUS/.claude/agents"  "$C/agents"
link "$NEXUS/.claude/skills"  "$C/skills"
link "$NEXUS/.claude/hooks"   "$C/hooks"
link "$NEXUS/.claude/settings.json" "$C/settings.json"
echo "Done. Nexus is global. Brain edits land in $NEXUS/brain — commit them to keep history."
