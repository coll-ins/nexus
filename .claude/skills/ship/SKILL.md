---
name: ship
description: Pre-merge/deploy checklist. Use before opening a PR, merging, or deploying.
---

# Ship
1. `git diff main...HEAD` — re-read every change. Delete anything not required (no-slop rules).
2. `git diff --staged` / grep for secrets: `.env`, keys, tokens, passwords, debug prints, commented-out code.
3. Run tests + linter. Paste the result line.
4. Risky area (auth, payments, bookings, user data, anything public)? → `breaker` agent first; fix criticals.
5. Migrations present if models changed. `.env.example` updated if config changed. README updated if behaviour changed.
6. PR description: what, why, how verified, known risks. Three to eight lines.
