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
grep -q '^@~/.claude/nexus/memory/preferences.md$' CLAUDE.md || err "CLAUDE.md: preferences import missing"
lines=$(grep -c '^- ' memory/preferences.md)
[ "$lines" -le 50 ] || err "preferences.md has $lines rules (max 50)"
dups=$(grep '^- ' memory/preferences.md | sort | uniq -d)
[ -z "$dups" ] || err "duplicate preferences: $dups"
words=$(cat CLAUDE.md .claude/agents/*.md | wc -w)
echo "Nexus prompt size (CLAUDE.md + agents): $words words"
[ "$fail" = 0 ] && echo "all checks passed"
exit $fail
