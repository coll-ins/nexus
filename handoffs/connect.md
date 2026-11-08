Goal: get PR #6/#7 (3D bus, real-road divert, payment return, auto sign-in, splash) live on connect-zj9i.

Done
- PR #6 merged (9493440): 3D bus, divert on real roads, bus snapped to reroute line, traffic within 1 km, payment callback from trusted Origin (backend/connect/frontend.py), login returns to `from`.
- PR #7 (claude/3d-bus-model-fixes-fx3h0n): auto sign-in on /login, one-press map exit (backToOverview state), splash back (signed-in only), splash-mobile.jpg 1080x2340, cash PIN fullstack test, unknown stored role ignored.
- CI e2e now runs on `vite preview` in CI (playwright.config.js).

Next
- Merge PR #7 once CI green (if not already).
- Collins: Vercel says "Deployment rate limited, retry in 24 hours" (from 14:30 UTC 8 Nov). Disconnect Git on duplicate projects connect, connect-i251, connect-ahzg, backend; then Redeploy latest main on connect-zj9i.
- After deploy: livecheck bundle has Vehicle3D chunk + check VITE_TOMTOM_KEY in BaseTileLayer chunk; do a real Paystack test payment from Chrome.
- Collins: set Render FRONTEND_URL to https://connect-zj9i-gamma.vercel.app (currently a protected Vercel URL, caused the Vercel login wall).
- LOW open: traffic cache per own_driver_id, no scheduled LocationPing purge (drivers/traffic.py).

Gotchas
- Live frontend connect-zj9i-gamma.vercel.app, API connect-lhqy.onrender.com. Paystack/OSRM/tiles hosts blocked in cloud sandbox.
- Each push builds 5 Vercel projects: batch pushes.
- Cloud Playwright: executablePath /opt/pw-browsers/chromium, channel undefined; fullstack needs PYTHON=venv python.
