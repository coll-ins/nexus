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
python3 -c "import json;json.load(open('.claude/settings.json'))" || err "settings.json invalid"
if git log --format=%B | grep -qiE 'co-authored-by: claude|claude-session|generated with \[?claude'; then err "AI attribution found in git history"; fi
[ "$fail" = 0 ] && echo "all checks passed"
exit $fail
