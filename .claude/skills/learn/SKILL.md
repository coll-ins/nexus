---
name: learn
description: Record a durable lesson or preference into the Nexus brain. Use when Collins corrects you, states how he wants something done, says "remember", approves a choice you'd otherwise ask again, or after a mistake that cost a retry.
---

# Learn

1. Decide if it's durable. One-off task details ("rename this var") are NOT lessons. Skip those.
2. Pick the file (all under `~/.claude/brain/`, or `brain/` in the nexus repo):
   - How he wants work done / communication → `preferences.md`
   - A choice he made that will recur (tool, library, structure) → `defaults.md`
   - A mistake you made + the rule preventing it → `lessons.md` (top of list, dated)
   - Fact about a specific project → `projects.md` under that project
3. Before writing, grep the file. If a line already covers it, update that line instead of adding a new one. If the new info contradicts a line, replace it.
4. One line, imperative, specific. Bad: "be careful with tests". Good: "Run pytest from repo root; labs import from `app`, not `server.app`."
5. Say "Noted: <the line>" in one line. No more ceremony.

Never record: secrets, passwords, tokens, personal sensitive info.
