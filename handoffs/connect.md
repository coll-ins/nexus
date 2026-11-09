Goal: every trip on a real bus (type + seat cap), real seat plans, random auto-pick, bus/driver on seat page.

Done
- Branch claude/hopeful-ritchie-42re0j pushed (dda6a81), contains 19f8f2f seat work. No PR yet.
- Bus.vehicle_type + seats.py VEHICLES (HiAce 14 Toyota; NMR85 27, FTR90 51, FVR34S 67 ACMG; NQR 33 approximate). Trip.bus/TripSchedule.bus nullable FKs, capacity forced from bus (models.py save).
- companies/fleet.py lock_bus used by create_trip, PATCH trips/<id>/bus/, schedules, trip_generation.
- Frontend: components/Fleet.jsx (fleet page under Buses & seats, TripBusPicker), SeatMap ticket header, passenger "Choose for me".
- 1002 backend tests OK, lint/build OK, seat maps screenshot-checked at 390px.
- e2e 70/70 green: stale auth/booking tests updated; SeatMap moved into booking modal's scroll area (Book stays on screen); signup error no longer doubled.
- Breaker fix b2fadb1: rejected incident refund now locks trip, re-checks capacity, re-assigns seats (views.py resolve_incident_booking).

Next
- Run breaker on this branch (bookings + capacity), fix HIGHs, then PR when Collins says.
- Old bus-less trips: operators must assign a bus (no backfill on purpose).
- 36-seat BasiGo E9: no published plan; added as Other until Collins sends a seat photo.

Gotchas
- role-screens.spec.js:146 flake fixed on branch claude/adoring-feynman-g2pxcb (3D bus off on software WebGL).
- WebFetch DNS cache lags env host changes; use curl.
- Fullstack Playwright spec updated but not run (needs full stack).
