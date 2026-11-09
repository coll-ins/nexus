#!/usr/bin/env bash
# Save, read or clear a session handoff in Nexus (never in the project repo).
#   handoff.sh show  [project]          print the handoff, if any
#   handoff.sh save  [project] < note   overwrite it from stdin (max 25 lines)
#   handoff.sh done  [project]          delete it: the task is finished
# project defaults to the current git repo's folder name.
set -euo pipefail

NX=$(cd "$(dirname "$0")/.." && pwd)
cmd=${1:-show}
proj=${2:-$(basename "$(git rev-parse --show-toplevel 2>/dev/null || pwd)")}
case "$proj" in */*|.*|'') echo "bad project name: $proj" >&2; exit 2 ;; esac
file="$NX/handoffs/$proj.md"

publish() {  # commit + push one handoff change straight to nexus main
  local msg=$1
  [ "$(git -C "$NX" config user.email)" = mainacollins184@gmail.com ] || {
    git -C "$NX" config user.name Collins
    git -C "$NX" config user.email mainacollins184@gmail.com
  }
  if ! bash "$NX/scripts/check.sh" >/dev/null; then
    echo "Not saved: nexus check.sh failed (run it to see why)"; exit 1
  fi
  [ -f "$NX/handoffs/$proj.md" ] && git -C "$NX" add -- "handoffs/$proj.md"
  git -C "$NX" diff --cached --quiet && { echo "No change to $proj handoff"; return; }
  git -C "$NX" commit -q -m "$msg" -- "handoffs/$proj.md"
  if [ "$(git -C "$NX" branch --show-current)" = main ]; then
    git -C "$NX" push -q origin main || { echo "Not saved: push to nexus main failed"; exit 1; }
  else
    # On a work branch: put just this commit on main without touching the branch.
    local sha; sha=$(git -C "$NX" rev-parse HEAD)
    git -C "$NX" fetch -q origin main
    local tmp; tmp=$(mktemp -d)
    git -C "$NX" worktree add -q "$tmp" origin/main
    git -C "$tmp" cherry-pick "$sha" >/dev/null 2>&1 \
      || { git -C "$tmp" cherry-pick --abort >/dev/null 2>&1 || true; git -C "$NX" worktree remove --force "$tmp"; echo "Not saved: handoff conflicts with main"; exit 1; }
    git -C "$tmp" push -q origin HEAD:main || { git -C "$NX" worktree remove --force "$tmp"; echo "Not saved: push to nexus main failed"; exit 1; }
    git -C "$NX" worktree remove --force "$tmp"
  fi
  echo "Saved: $msg"
}

sync_main() {
  if [ "$(git -C "$NX" branch --show-current)" = main ]; then
    git -C "$NX" pull --rebase -q origin main || true
  fi
}

case "$cmd" in
  show)
    sync_main
    [ -f "$file" ] && cat "$file" || echo "No handoff for $proj."
    ;;
  save)
    sync_main
    note=$(cat)
    [ -n "$note" ] || { echo "Not saved: empty handoff" >&2; exit 2; }
    lines=$(printf '%s\n' "$note" | wc -l)
    [ "$lines" -le 25 ] || { echo "Not saved: $lines lines (max 25). Trim it." >&2; exit 2; }
    for h in Goal Done Next; do
      printf '%s\n' "$note" | grep -q "^$h" || { echo "Not saved: missing '$h' section" >&2; exit 2; }
    done
    if printf '%s\n' "$note" | grep -qiE '(sk_live|sk_test|api[_-]?key|password|secret|token)[=:] *[A-Za-z0-9_-]{8,}'; then
      echo "Not saved: looks like it contains a secret" >&2; exit 2
    fi
    printf '%s\n' "$note" > "$file"
    publish "Update $proj handoff"
    ;;
  done)
    sync_main
    [ -f "$file" ] || { echo "No handoff for $proj."; exit 0; }
    git -C "$NX" rm -q -- "handoffs/$proj.md"
    publish "Clear $proj handoff"
    ;;
  *) echo "usage: handoff.sh show|save|done [project]" >&2; exit 2 ;;
esac
