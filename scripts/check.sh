#!/usr/bin/env bash
# Sanity checks for Nexus files. Run before committing changes to Nexus.
set -uo pipefail
cd "$(dirname "$0")/.."
fail=0
err() { echo "FAIL: $*"; fail=1; }

for a in .claude/agents/*.md; do
  n=$(basename "$a" .md)
  head -1 "$a" | grep -qx -- '---' || err "$a: missing frontmatter"
  grep -qx "name: $n" "$a" || err "$a: 'name:' must be '$n'"
  grep -q '^description: .\{20,\}' "$a" || err "$a: description missing or too short"
done
for k in .claude/skills/*/SKILL.md; do
  n=$(basename "$(dirname "$k")")
  grep -qx "name: $n" "$k" || err "$k: 'name:' must be '$n'"
  grep -q '^description: .\{20,\}' "$k" || err "$k: description missing or too short"
done
for a in .claude/agents/*.md; do
  grep -qE '^model: (inherit|opus|sonnet|haiku)$' "$a" || err "$a: model must be inherit/opus/sonnet/haiku"
done
grep -q '^@~/.claude/nexus/memory/preferences.md$' CLAUDE.md || err "CLAUDE.md: preferences import missing"
lines=$(grep -c '^- ' memory/preferences.md)
[ "$lines" -le 50 ] || err "preferences.md has $lines rules (max 50)"
dups=$(grep '^- ' memory/preferences.md | sort | uniq -d)
[ -z "$dups" ] || err "duplicate preferences: $dups"
words=$(cat CLAUDE.md | wc -w)
echo "always-loaded CLAUDE.md: $words words"
[ "$words" -le 1200 ] || err "CLAUDE.md over 1200 words: trim it"
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
if bash scripts/sync.sh "$tmp" >/dev/null; then
  imp=$(sed -n 's/^@//p' "$tmp/.claude/CLAUDE.md")
  [ -f "$tmp/.claude/$imp" ] || err "sync.sh: import '@$imp' doesn't resolve from .claude/CLAUDE.md"
else err "sync.sh failed"; fi
# Pull-back regressions, run on a throwaway copy of nexus
n="$tmp/n"; p="$tmp/p"; mkdir -p "$n" "$p"
cp -R CLAUDE.md .claude scripts memory "$n/"
np="$n/memory/preferences.md"; pp="$p/.claude/nexus/preferences.md"
bash "$n/scripts/sync.sh" "$p" >/dev/null
first=$(grep -m1 '^- ' "$np")
grep -vxF -- "$first" "$np" > "$np.t" && mv "$np.t" "$np"      # Collins deletes a rule in nexus
sed -i "s/^- No AI attribution.*/- Replaced rule./" "$pp"        # project replaces a rule
printf -- '- Added rule.' >> "$pp"                               # no trailing newline
truncate -s -1 "$np"
bash "$n/scripts/sync.sh" "$p" >/dev/null || err "sync.sh resync failed"
grep -qxF -- "$first" "$np" && err "sync.sh resurrected a rule deleted in nexus"
grep -q 'No AI attribution' "$np" && err "sync.sh kept a rule the project replaced"
grep -qx -- '- Replaced rule.' "$np" || err "sync.sh lost a replaced rule"
grep -qx -- '- Added rule.' "$np" || err "sync.sh glued or lost an added rule"
bash "$n/scripts/sync.sh" "$n" >/dev/null 2>&1 && err "sync.sh accepted nexus itself as target"
# sync: a project's own same-named agent is backed up; files Nexus dropped are removed
q="$tmp/q"; mkdir -p "$q/.claude/agents"; echo mine > "$q/.claude/agents/builder.md"
bash "$n/scripts/sync.sh" "$q" >/dev/null
ls "$q"/.claude/agents/builder.md.bak.* >/dev/null 2>&1 || err "sync.sh overwrote a project's own agent without backup"
grep -q 'Builder on Collins' "$q/.claude/agents/builder.md" || err "sync.sh didn't install builder"
grep -q '"attribution"' "$q/.claude/settings.json" || err "sync.sh didn't set attribution"
mv "$n/.claude/agents/researcher.md" "$tmp/researcher.md"
bash "$n/scripts/sync.sh" "$q" >/dev/null
[ ! -e "$q/.claude/agents/researcher.md" ] || err "sync.sh left an agent Nexus dropped"
mv "$tmp/researcher.md" "$n/.claude/agents/"
# sync: project synced by an older Nexus (no snapshot/manifest) is updated, not backed up or merged blind
o="$tmp/o"; mkdir -p "$o/.claude/agents" "$o/.claude/nexus"
printf '# NEXUS — Orchestrator\n' > "$o/.claude/CLAUDE.md"; echo old > "$o/.claude/agents/builder.md"
printf -- '- Stale rule.\n' > "$o/.claude/nexus/preferences.md"
bash "$n/scripts/sync.sh" "$o" >/dev/null
ls "$o"/.claude/agents/*.bak.* >/dev/null 2>&1 && err "sync.sh backed up an old Nexus agent as the project's own"
grep -qx -- '- Stale rule.' "$np" && err "sync.sh merged prefs blind without a snapshot"
# install: real settings.json kept + attribution merged, foreign symlink and old nexus backed up and merged
h="$tmp/h"; mkdir -p "$h/.claude/nexus/memory" "$h/dot"
echo '{"model": "x"}' > "$h/.claude/settings.json"; echo mine > "$h/dot/CLAUDE.md"
ln -s "$h/dot/CLAUDE.md" "$h/.claude/CLAUDE.md"; printf -- '- Old local rule.\n' > "$h/.claude/nexus/memory/preferences.md"
HOME="$h" bash "$n/scripts/install.sh" >/dev/null || err "install.sh failed"
[ ! -L "$h/.claude/settings.json" ] || err "install.sh symlinked settings.json"
python3 -c "import json,sys;d=json.load(open(sys.argv[1]));assert d['model']=='x' and d['attribution']['commit']==''" "$h/.claude/settings.json" || err "install.sh lost settings or attribution"
ls "$h"/.claude/CLAUDE.md.bak.* >/dev/null 2>&1 || err "install.sh replaced a symlinked CLAUDE.md without backup"
grep -qx -- '- Old local rule.' "$np" || err "install.sh stranded the old install's preferences"
[ -f "$h/.claude/nexus/memory/preferences.md" ] || err "install.sh: preferences import doesn't resolve"
before=$(find "$h/.claude" -name '*.bak.*' | wc -l)
HOME="$h" bash "$n/scripts/install.sh" >/dev/null || err "install.sh re-run failed"
[ "$(find "$h/.claude" -name '*.bak.*' | wc -l)" = "$before" ] || err "install.sh re-run made new backups"
python3 -c "import json;json.load(open('.claude/settings.json'))" || err "settings.json invalid"
if git log --format=%B | grep -qiE 'co-authored-by: claude|claude-session|generated with \[?claude'; then err "AI attribution found in git history"; fi
[ "$fail" = 0 ] && echo "all checks passed"
exit $fail
