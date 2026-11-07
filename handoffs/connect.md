Goal: Connect launch-ready on branch ccr-73f405e6-xzh3og (pushed, 9db4e0c); Collins merges, recovers superuser, demos.

Done
- One design system for all roles: src/styles/tokens.css (+ touch.css), Barlow, one accent; all CSS normalized.
- Simulate real trips: backend/companies/simulation.py, Admin > Trips button; routes w/o line drive stop to stop.
- ensure_superuser (ADMIN_PHONE/ADMIN_PASSWORD) runs in procfile start; login lockout counts failures only.
- Breaker x2: 0 critical/high; all mediums fixed with tests. Real names to staff; booking modal pickup fixed.
- Tests: backend 839, e2e 56, fullstack 9 pass. Audit + recorded demo: https://claude.ai/artifact/VsV3pjXXSiQ4bJ2DRkgPMw

Next
- Collins: merge branch to main (open PR only if he asks), set ADMIN_PHONE/ADMIN_PASSWORD + Render start command (in audit), deploy, log in, remove ADMIN_PASSWORD.
- Collins: one Paystack KES test payment in prod; schedule the cleanup cron call.
- Pending OK: force-push main to drop 2 Copilot trailers (a2a1ebb, e27888e).
- Later: Redis cache for login counters; SMS OTP at signup; delete unused DriverDashboard.jsx.

Gotchas
- seed_demo is dev-only; prod simulation needs a real trip with driver, set to Boarding for passenger tracking.
- Cloud Playwright: executablePath /opt/pw-browsers/chromium in a local config; login throttle needs cache.clear() between crawls.
