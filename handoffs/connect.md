Goal: Connect live in prod (PR #3, #4 deployed on Render + Vercel, verified 7 Nov).

Done
- One design system for all roles: src/styles/tokens.css (+ touch.css), Barlow, one accent; all CSS normalized.
- Simulate real trips: backend/companies/simulation.py, Admin > Trips button; routes w/o line drive stop to stop.
- ensure_superuser (ADMIN_PHONE/ADMIN_PASSWORD) runs in procfile start; login lockout counts failures only.
- Breaker x2: 0 critical/high; all mediums fixed with tests. Real names to staff; booking modal pickup fixed.
- Tests: backend 839, e2e 56, fullstack 9 pass. Audit + recorded demo: https://claude.ai/artifact/VsV3pjXXSiQ4bJ2DRkgPMw

Next
- Collins: log in with ADMIN_PHONE, then remove ADMIN_PASSWORD on Render.
- Verify NUM_PROXIES (1 vs 2 behind Cloudflare) once an IP-echo check exists.
- Collins: GitHub Actions var CONNECT_API_URL + secret CRON_SECRET (scheduled-jobs.yml).
- Supermetro + Latema have 0 trips in prod: manager creates trips or service templates.
- Collins: one Paystack KES test payment in prod; schedule the cleanup cron call.
- Pending OK: force-push main to drop 2 Copilot trailers (a2a1ebb, e27888e).
- Later: Redis cache for login counters; SMS OTP at signup; delete unused DriverDashboard.jsx.

Gotchas
- seed_demo is dev-only; prod simulation needs a real trip with driver, set to Boarding for passenger tracking.
- Cloud Playwright: executablePath /opt/pw-browsers/chromium in a local config; login throttle needs cache.clear() between crawls.
