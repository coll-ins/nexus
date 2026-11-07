Goal: Connect audit + hardening; Collins decides the next task. Branch claude/nexus-connect-audit-fixes-lmjp0w, pushed, CI green (run #38).

Done
- Round 1 (5091dfd): 15 fixes (operator route scope, refund-restore race, parcel refund, currency, staff guards, NUM_PROXIES required, admin Users page, login 500 on fresh DB, UI bugs); full-stack CI job.
- 016fec9: .claude/ removed from Connect repo; Default cloud env setup script installs Nexus (needs a fresh session to prove).
- Round 2 (124fd8d): passenger dead ends (seats left, Pay now/Track/Cancel in My bookings, refresh at trips step), last-seat race test on Postgres, manager Add Driver 400 fixed, platform admin = is_superuser (migration users/0007), demo trip smooth + follow camera.
- Audit doc: https://claude.ai/artifact/QHxvLJDaN51TdxznnzFxPx (both rounds).

Next
- Ask Collins what's next; no PR opened yet (open one only if he asks; squash-merge with his own title, branch name has "claude").
- Collins: set NUM_PROXIES=1 on Render before deploy (prod refuses to start without it).
- Collins: one Paystack test-mode KES payment to confirm webhook carries currency.
- Pending OK: rewrite main to drop 2 "Co-authored-by: Copilot" trailers (a2a1ebb, e27888e) = force-push main.
- Later: SMS OTP at signup (unblocks walk-in claim, softer lockout); clean unused imports in bookings/views.py, drivers/views.py.

Gotchas
- Backend venv must be python3.12 (psycopg2-binary 2.9.9 has no 3.13 wheel).
- Fresh DB: `make migrate` runs createcachetable; `manage.py seed_demo` gives all 6 role logins (password demo-pass-123).
- Playwright in cloud: repo pins a newer version; use a local config with launchOptions.executablePath=/opt/pw-browsers/chromium (don't commit it).
- Full-stack tests: `npx playwright test -c playwright.fullstack.config.js` (ports 8000/5174 must be free).
- Race test needs Postgres: apt install postgresql, then DATABASE_URL=postgres://postgres:postgres@127.0.0.1:5432/<db>.
