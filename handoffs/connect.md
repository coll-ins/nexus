Goal: every trip tied to a real bus (type + seat count cap), real seat layouts, random auto-pick, bus/driver details on seat page.

Done
- Branch claude/hopeful-ritchie-42re0j fast-forwarded to 19f8f2f (seat work from claude/connect-signup-landing-2b5as4). Not pushed yet. 994 tests OK.
- Architect decision (option B): keep Trip.capacity as a server-set copy of bus.capacity; add Trip.bus + TripSchedule.bus FKs (PROTECT); Bus.vehicle_type keyed to seats.py layouts; drop TripSchedule.capacity; bind_bus() helper validates company/operational/no double-book/capacity; POST trips/<id>/add-bus/ clones trip with another bus.
- Verified data so far (search snippets only): Isuzu NQR 33 seats; Mercedes MB-917 41 (Citi Hoppa); Yutong ZK6127 67 seats 2+3; Scania Kenya sells 46 and 67.

Next
- Waiting on Collins: source of exact row plans (allow hosts / his photos / operator seat-plan editor).
- Then: migrations + backfill (bus per driver, capacity=max), bind_bus, seats.py layout_for(vehicle_type), random.sample auto-pick, seat_map bus+driver block, fleet page in frontend (none exists).

Gotchas
- Web fetches blocked: global.toyota, acmgl.com, usedtruckbus.com, kenyalaw.org need allowing.
- Test env: backend/.venv without psycopg2, env vars from ci.yml, sqlite.
