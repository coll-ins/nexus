Goal: ship smooth bus turning, stuck-bus traffic, cash PIN on boarding, and get the bank-return fix live on connect-zj9i.

Done
- Branch ccr-2e8b4e7a-g5lfp4 (pushed, no PR): includes claude/driver-map-bus-model-cre4ms reroute commits + e210fc7 + be96b85.
- Bus turns via rear/front lookahead heading (useRoadDriverPosition.js bodyHeading) + eased yaw in Vehicle3D.jsx.
- Own bus standing still mid-route = heavy traffic (drivers/traffic.py); "bus stuck in heavy traffic" line on passenger map.
- Cash: PIN shown before paying; cash bookings survive departure; driver confirms cash until trip ends (bookings/services.py cash_due_on_board, cash_still_payable; process_noshows exclude).
- Breaker: HIGH departure sweep fixed. Tests: 788 backend OK, 9 node unit OK, build OK.

Next
- Open PR for ccr-2e8b4e7a-g5lfp4 when Collins asks, then merge.
- Collins: after Vercel limit lifts (~14:30 UTC 9 Nov) redeploy main on connect-zj9i; live build is still 07:38 UTC, so bank return goes to login until then.
- Collins: set Render FRONTEND_URL to https://connect-zj9i-gamma.vercel.app.
- Collins decision: unpaid cash booking can watch live bus (kept; cap 3 unpaid/user). Stricter = hide until cash confirmed.
- Open MEDIUM: process_noshows no-shows confirmed bookings on departed trips after grace, mid-route passengers affected (pre-existing).
- Open MEDIUM: users/identity.py:25 driver with company_id None matches other companies' driver with same phone.

Gotchas
- Simulated GPS never paints traffic (drivers/views.py:520); test traffic with a real phone.
- Backend tests: venv without psycopg2, env from .github/workflows/ci.yml; run serially (--parallel crashes pickling tracebacks).
- Each push builds 5 Vercel projects: batch pushes.
