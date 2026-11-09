Goal: ship PR coll-ins/connect#10 (landing, real bus seat plans, strict input validation) to the live site.

Done
- Branch claude/hopeful-ritchie-42re0j at e2cb6b6, PR #10 open. Backend 1017 OK, e2e 78/78 (1 worker), fullstack 11/11 local.
- Inputs validated server-side (backend/connect/validation.py) + forms mirror it (frontend-react/src/utils/inputRules.js, FieldNote, ValidatedInput).
- Plates KXX 000X (buses/serializers.py), walk-in/M-PESA/signup phone holes closed.
- Landing hero = app's 3D matatu (pages/landing/HeroBus3D.jsx). All 82 routes smoke-tested (tests/e2e/all-routes.spec.js).
- Breaker: no critical/high; mediums fixed in 620d4e6. Seat plans 27/51/67 match ACMG drawings; 33 has none published.

Next
- When CI on e2cb6b6 is green: merge PR #10, then check https://connect-zj9i-gamma.vercel.app serves the landing and Render /api/health/ is 200 (migrations run on start).
- Collins: send a photo of the real 33-seater seat plan to verify NQR81 layout.

Gotchas
- CI backend job had been failing on main at `pyflakes users/` (fixed here), so tests never ran in CI.
- role-screens.spec.js:146 flaky with 2 workers (another session fixing on claude/adoring-feynman-g2pxcb).
- Blob log host and Actions log URLs are blocked here; reproduce CI steps locally.
