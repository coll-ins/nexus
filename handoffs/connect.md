Goal: launch-ready passenger flow: signup, landing, M-Pesa/card only, seat picking, change cut-off.

Done
- Branch claude/connect-signup-landing-2b5as4 pushed, no PR (last 19f8f2f). 994 backend tests OK, lint/build OK.
- Landing page at / (frontend-react/src/pages/landing), split-name signup + password checklist (users/validators.py).
- Receipts show driver name/bus/phone on paid trips (bookings/views.py passenger_records).
- Cash OFF at launch: settings CASH_ENABLED=false; later 30 trips, 95%+, 60-day account (users/models.py can_pay_cash).
- PIN check records cash on board (verify_boarding pays_cash_now); cash no-shows counted (services.py settle_unboarded_no_shows).
- 15-min change cut-off: free cancel/change bus before, 50% after (services.py before_change_cutoff; refund policy text updated, TERMS_VERSION 2026-11-09).
- Seats: SeatAssignment model + migrations 0026/0027, bookings/seats.py layouts (HiAce 14, 29/33 minibus, 51 coach), components/SeatMap.jsx in passenger booking, driver Passengers tab, operator Seat map (block/unblock).
- Breaker run on cash and seats; all HIGH fixed.

Next
- Ask Collins what is left from his list, then open a PR for this branch when he says.
- Optional: Trip.vehicle_type so operators pick the exact body when capacity is ambiguous (layout is by capacity now).
- Older branch ccr-2e8b4e7a-g5lfp4 still needs its PR; Render FRONTEND_URL=https://connect-zj9i-gamma.vercel.app.

Gotchas
- Backend tests: venv without psycopg2, env vars from .github/workflows/ci.yml, run serially.
- Old cash tests need @override_settings(CASH_ENABLED=True, CASH_MIN_TRIPS=1, CASH_MIN_ACCOUNT_DAYS=0).
- Each push builds 5 Vercel projects: batch pushes.
