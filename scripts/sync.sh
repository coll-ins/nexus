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

# 1. Refuse to clobber a project's own .claude/CLAUDE.md (before touching anything)
if [ -f "$DEST/CLAUDE.md" ] && ! head -1 "$DEST/CLAUDE.md" | grep -qx '# NEXUS — Orchestrator'; then
  echo "error: $DEST/CLAUDE.md exists and isn't Nexus. Move it to $PROJ/CLAUDE.md first." >&2
  exit 1
fi
PRIOR_SYNC=0; [ -f "$DEST/CLAUDE.md" ] && PRIOR_SYNC=1
mkdir -p "$DEST/nexus"

# 2. Pull back rules learned in the project copy. 3-way against the copy
#    left by the last sync, so rules deleted in nexus aren't resurrected and
#    rules the project replaced don't leave the old line behind.
PROJ_PREFS="$DEST/nexus/preferences.md"
LAST="$DEST/nexus/last-sync.md"
if [ -f "$PROJ_PREFS" ] && [ ! -f "$LAST" ]; then
  # Synced by an older Nexus: no base to tell "learned here" from "deleted in nexus".
  diff=$(grep -E '^- ' "$PROJ_PREFS" | grep -vxFf "$PREFS" || true)
  [ -z "$diff" ] || printf 'not merged (no sync snapshot yet), add by hand if you want them:\n%s\n' "$diff"
elif [ -f "$PROJ_PREFS" ]; then
  added=$(grep -E '^- ' "$PROJ_PREFS" | grep -vxFf "$LAST" | grep -vxFf "$PREFS" || true)
  removed=$(grep -E '^- ' "$LAST" | grep -vxFf "$PROJ_PREFS" || true)
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

# 3. Copy, pointing the preferences import at the in-repo copy.
# Imports resolve relative to the importing file (.claude/CLAUDE.md), not the repo root.
sed 's#@~/.claude/nexus/memory/preferences.md#@nexus/preferences.md#' \
  "$NEXUS/CLAUDE.md" > "$DEST/CLAUDE.md"
cp "$PREFS" "$PROJ_PREFS"
cp "$PREFS" "$LAST"
python3 "$NEXUS/scripts/merge-attribution.py" "$DEST/settings.json" "$NEXUS/.claude/settings.json"

# 4. Agents and skills. The manifest lists files Nexus put there last time:
#    those get updated (or removed if Nexus dropped them); a project's own file
#    with the same name is backed up, never silently overwritten.
MANIFEST="$DEST/nexus/manifest"
NEW="$DEST/nexus/manifest.new"
(cd "$NEXUS/.claude" && find agents skills -type f | sort) > "$NEW"
if [ ! -f "$MANIFEST" ]; then
  # Synced by an older Nexus (no manifest): same-named files there are Nexus's own.
  if [ "$PRIOR_SYNC" = 1 ]; then cp "$NEW" "$MANIFEST"; else : > "$MANIFEST"; fi
fi
while IFS= read -r f; do
  src="$NEXUS/.claude/$f"; dst="$DEST/$f"
  if [ -f "$dst" ] && ! cmp -s "$src" "$dst" && ! grep -qxF "$f" "$MANIFEST"; then
    mv "$dst" "$dst.bak.$(date +%Y%m%d%H%M%S)"
    echo "backed up project's own $dst"
  fi
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
done < "$NEW"
grep -vxFf "$NEW" "$MANIFEST" | while IFS= read -r f; do
  rm -f "$DEST/$f" && echo "removed $f (dropped from Nexus)"
done || true
mv "$NEW" "$MANIFEST"
echo "synced Nexus into $PROJ/.claude. Commit it in that repo."
