---
name: handoff
description: Write a handoff file and end the session cleanly. Use when the session is past ~100k tokens, Claude starts repeating itself or forgetting decisions, or the user says "handoff", "wrap up", or switches to an unrelated task.
---

# Handoff

Goal: the next session starts with only what it needs, not the whole history.

1. Write `.nexus/handoff.md` (overwrite) with exactly these sections, terse bullets:
   - **Goal**: one line.
   - **Decided**: decisions + one-line why each. Link issues/PRs instead of pasting.
   - **Done**: what is finished and verified (tests run? which?).
   - **Tried & failed**: approaches that didn't work and why, so they aren't retried.
   - **Next**: ordered next steps, the first one concrete enough to start immediately.
   - **Files**: paths touched or that matter, with one-line role each.
   - **Risks/open questions**.
2. Update `.nexus/progress.md` to match.
3. Keep handoff.md under ~60 lines. No code blocks longer than 5 lines; reference file:line instead.
4. Tell Collins: "Handoff written. Start a fresh session; it loads automatically."

Do not summarise chit-chat, dead ends already covered in "Tried & failed", or anything already in CLAUDE.md.
