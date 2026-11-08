Goal: get the 3D bus, road-snapped driver map, auto sign-in and splash live on connect-zj9i.

Done
- PR #6/#7 merged to main (600d0d0): 3D bus, real-road divert, payment return, auto sign-in, splash.
- Branch claude/driver-map-bus-model-cre4ms (2 commits, pushed, no PR yet): driver map off route >40 m asks GET /bookings/driver/<id>/reroute/ and draws the bus on that road (backend/bookings/views.py driver_reroute, ConnectMap.jsx rerouteUrl). Breaker: no critical/high. Tests: 716 backend, 70/70 e2e.
- Live site checked 8 Nov 15:25 UTC: still the 07:38 UTC build (old orange box bus, no splash/auto sign-in).

Next
- Open PR for claude/driver-map-bus-model-cre4ms when Collins asks, then merge.
- Collins: after the Vercel limit lifts (~14:30 UTC 9 Nov), disconnect Git on duplicate projects connect, connect-i251, connect-ahzg, backend; Redeploy latest main on connect-zj9i.
- Verify: live Vehicle3D chunk contains "f5f3ee" (new model), Login chunk has auto sign-in.
- Collins: set Render FRONTEND_URL to https://connect-zj9i-gamma.vercel.app.
- Open MEDIUM: users/identity.py:25 driver account with company_id None matches any company's driver with same phone.
- Option: 3D bus is ~110 px at zoom 14 (~1 km of map); scale with map zoom if Collins wants.

Gotchas
- Live frontend connect-zj9i-gamma.vercel.app, API connect-lhqy.onrender.com. OSRM/tiles/Paystack blocked in cloud sandbox.
- Each push builds 5 Vercel projects: batch pushes.
- Cloud Playwright: copy config with channel undefined + executablePath /opt/pw-browsers/chromium; CI=1 for preview build.
- Backend tests need SECRET_KEY, DEBUG=True, ADMIN_SIGNUP_CODE, PAYSTACK_SECRET_KEY env (see .github/workflows/ci.yml); skip psycopg2 locally. Full suite >10 min; run bookings drivers companies/tests.
