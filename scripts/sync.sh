#!/usr/bin/env bash
# Put Nexus inside a project repo, for cloud/phone sessions that only see the repo.
# Usage: scripts/sync.sh <path-to-project-repo>
# Re-run any time to update. Preferences Nexus learned inside the project
# are pulled back into nexus/memory/preferences.md first, so nothing is lost.
set -euo pipefail
NEXUS="$(cd "$(dirname "$0")/.." && pwd)"
PROJ="$(cd "${1:?usage: sync.sh <project-dir>}" && pwd)"
PREFS="$NEXUS/memory/preferences.md"
DEST="$PROJ/.claude"
mkdir -p "$DEST/agents" "$DEST/nexus"

# 1. Pull back rules learned in the project copy
if [ -f "$DEST/nexus/preferences.md" ]; then
  new=$(grep -E '^- ' "$DEST/nexus/preferences.md" | grep -vxFf "$PREFS" || true)
  if [ -n "$new" ]; then
    printf '%s\n' "$new" >> "$PREFS"
    echo "pulled back $(printf '%s\n' "$new" | wc -l) new preference(s) into nexus. Commit nexus."
  fi
fi

# 2. Refuse to clobber a project's own .claude/CLAUDE.md
if [ -f "$DEST/CLAUDE.md" ] && ! head -1 "$DEST/CLAUDE.md" | grep -q '^# NEXUS'; then
  echo "error: $DEST/CLAUDE.md exists and isn't Nexus. Move it to $PROJ/CLAUDE.md first." >&2
  exit 1
fi

# 3. Copy, pointing the preferences import at the in-repo copy
sed 's#@~/.claude/nexus/memory/preferences.md#@.claude/nexus/preferences.md#' \
  "$NEXUS/CLAUDE.md" > "$DEST/CLAUDE.md"
cp "$PREFS" "$DEST/nexus/preferences.md"
[ -f "$DEST/settings.json" ] || cp "$NEXUS/.claude/settings.json" "$DEST/settings.json"
cp "$NEXUS"/.claude/agents/*.md "$DEST/agents/"
mkdir -p "$DEST/skills" && cp -R "$NEXUS"/.claude/skills/. "$DEST/skills/"
echo "synced Nexus into $PROJ/.claude. Commit it in that repo."
