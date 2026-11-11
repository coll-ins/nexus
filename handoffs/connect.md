Goal: finish Connect (clean planner, real routes, automatic parcels) and ship to Play.

Done
- PR #20 merged + live (4424e0c): trips/templates/admin pick vehicle type (33 default), driver's bus found or made from plate (companies/fleet.py driver_bus); "Seat booked" push (bookings/views.py _push_booked); 400 not 500 on non-object JSON (connect/parsers.py), bad ids, trips list N+1.
- Breakers (backend, frontend 360px all roles, deploy/push): all critical/high fixed; backend 1063 OK, fullstack 11/11, CI green.
- Verified live: APK cert = assetlinks fingerprint; Render runs daphne (websockets OK).

Next
- Collins on demo phone: tap "turn on bus alerts" on passenger dashboard once; book a seat -> "Seat booked" push.
- Drivers whose bus number is a fleet no. (not plate) need the bus added once under Buses & seats.
- Decide default parcel prices; verify City Shuttle / Super Metro routes; return-route schedules; phone OTP; paginate get_all_bookings.

Gotchas
- Tests need env from .github/workflows/ci.yml backend job (+NUM_PROXIES=1, BEHIND_TLS_PROXY=True for some probes).
- Fullstack Playwright locally: channel undefined + executablePath /opt/pw-browsers/chromium.
- Run redis-server outside the repo or it drops dump.rdb into backend/.
