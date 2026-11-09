---
name: handoff
description: Save where this session stopped so the next one picks up cold. Use when Collins says "handoff", "save progress", "pick this up later", when a session ends with work unfinished, or at session start to read the last one ("where did we stop").
---

# Handoff

One file per project: `$NX/handoffs/<repo folder>.md`. Never in the project repo (partners see it).
`$NX/scripts/handoff.sh` does all git work: check, commit, push to nexus `main`. Don't do it by hand.

## Read (session start, or "where did we stop")
`bash "$NX/scripts/handoff.sh" show <project>`. Act on the first `Next` bullet. Verify any claim in it against the code before trusting it: it can be stale.

## Write (work unfinished, or Collins says "handoff")
Overwrite, never append. Max 25 lines, exactly these sections:

```
Goal: <one line: what the whole task is for>

Done
- <shipped change> (<branch or commit>, file:line)

Next
- <the very next action, concrete enough to start without asking>
- <then...>

Gotchas
- <only things that cost time: env quirks, failing commands and the fix>
```

Rules: no logs, no pasted code, no conversation history; point to `file:line`. State verification honestly (tests run and result). No secrets. Name the branch and whether a PR exists.

Save with a heredoc:
`bash "$NX/scripts/handoff.sh" save <project> <<'EOF' ... EOF`

Then tell Collins the script's last line verbatim (`Saved: ...` or `Not saved: <why>`).

## Clear (task finished and merged)
`bash "$NX/scripts/handoff.sh" done <project>`. A stale handoff misleads the next session, so clear it the same turn the work lands.
