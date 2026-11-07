Goal: Connect frontend polish pass; Collins reviews branch ccr-73f405e6-xzh3og (2 commits on main d0e1a95), no PR yet.

Done
- 777cc2c + eb81b21: all 69 screens x 6 roles crawled at 390/768/1440 (touch below 1024) against real API; 0 JS/API errors, 0 overflow.
- Fixed: auditor incidents now real (/api/bookings/incidents/), manager settings page, wrong empty-state copy, phone padding on manager svc pages, passenger map empty state, icon/text stacking (.btn inline-flex), admin unknown URL redirect, duplicate titles.
- Caps labels -> sentence case, 11px floor, emoji -> lucide, 44px touch targets (src/styles/touch.css), input labels.
- Tests: e2e 58/58, fullstack 9/9 (all-screens now covers real auditor + manager pages).

Next
- Collins: review branch; open PR only if he asks (squash-merge, his title).
- Collins: set NUM_PROXIES=1 on Render before deploy.
- Collins: one Paystack test-mode KES payment to confirm webhook carries currency.
- Pending OK: rewrite main to drop 2 "Co-authored-by: Copilot" trailers (a2a1ebb, e27888e) = force-push main.
- Later: seed_demo has no company accepting bus hire/parcels, so those passenger flows demo as empty.
- Later: DriverDashboard.jsx (868 lines) is unused; navigationConfig.js non-passenger entries are dead.

Gotchas
- Backend venv must be python3.12. Login throttle 10/hour/account: crawls need cache.clear() via manage.py shell.
- Playwright in cloud: local config with launchOptions.executablePath=/opt/pw-browsers/chromium (don't commit).
- Full-stack tests need ports 8000/5174 free.
