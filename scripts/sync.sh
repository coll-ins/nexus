#!/usr/bin/env bash
# Put Nexus inside a project repo, for cloud/phone sessions that only see the repo.
# Usage: scripts/sync.sh <path-to-project-repo>
# Re-run any time to update. Preferences Nexus learned inside the project
# are pulled back into nexus/memory/preferences.md first, so nothing is lost.
set -euo pipefail
NEXUS="$(cd "$(dirname "$0")/.." && pwd)"
PROJ="$(cd "${1:?usage: sync.sh <project-dir>}" && pwd)"
PREFS="$NEXUS/memory/preferences.md"
[ "$PROJ" != "$NEXUS" ] || { echo "error: target is the nexus repo itself" >&2; exit 1; }
DEST="$PROJ/.claude"
mkdir -p "$DEST/agents" "$DEST/nexus"

# 1. Pull back rules learned in the project copy. 3-way against the copy
#    left by the last sync, so rules deleted in nexus aren't resurrected and
#    rules the project replaced don't leave the old line behind.
PROJ_PREFS="$DEST/nexus/preferences.md"
LAST="$DEST/nexus/last-sync.md"
if [ -f "$PROJ_PREFS" ]; then
  base="$LAST"; [ -f "$base" ] || base=/dev/null
  added=$(grep -E '^- ' "$PROJ_PREFS" | grep -vxFf "$base" | grep -vxFf "$PREFS" || true)
  removed=$(grep -E '^- ' "$base" | grep -vxFf "$PROJ_PREFS" || true)
  if [ -n "$removed" ]; then
    grep -vxFf <(printf '%s\n' "$removed") "$PREFS" > "$PREFS.tmp" || true
    mv "$PREFS.tmp" "$PREFS"
    echo "removed $(printf '%s\n' "$removed" | wc -l) preference(s) the project dropped."
  fi
  if [ -n "$added" ]; then
    [ -z "$(tail -c1 "$PREFS")" ] || echo >> "$PREFS"
    printf '%s\n' "$added" >> "$PREFS"
    echo "pulled back $(printf '%s\n' "$added" | wc -l) new preference(s) into nexus. Commit nexus."
  fi
fi

# 2. Refuse to clobber a project's own .claude/CLAUDE.md
if [ -f "$DEST/CLAUDE.md" ] && ! head -1 "$DEST/CLAUDE.md" | grep -qx '# NEXUS — Orchestrator'; then
  echo "error: $DEST/CLAUDE.md exists and isn't Nexus. Move it to $PROJ/CLAUDE.md first." >&2
  exit 1
fi

# 3. Copy, pointing the preferences import at the in-repo copy.
# Imports resolve relative to the importing file (.claude/CLAUDE.md), not the repo root.
sed 's#@~/.claude/nexus/memory/preferences.md#@nexus/preferences.md#' \
  "$NEXUS/CLAUDE.md" > "$DEST/CLAUDE.md"
cp "$PREFS" "$PROJ_PREFS"
cp "$PREFS" "$LAST"
[ -f "$DEST/settings.json" ] || cp "$NEXUS/.claude/settings.json" "$DEST/settings.json"
cp "$NEXUS"/.claude/agents/*.md "$DEST/agents/"
mkdir -p "$DEST/skills" && cp -R "$NEXUS"/.claude/skills/. "$DEST/skills/"
echo "synced Nexus into $PROJ/.claude. Commit it in that repo."
