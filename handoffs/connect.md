Goal: Connect launch follow-ups after PR coll-ins/connect#10 went live (merge e0ff04a, 2026-11-09).

Done
- Live: landing + 3D hero on connect-zj9i-gamma.vercel.app, seat plans, strict input validation; Render API on new code, migrations applied.

Next
- Delete junk prod account id 66 (user_25412, phone +25412) created by a verification probe before Render redeployed; needs Collins's OK.
- Get a photo of a real 33-seater (Isuzu NQR81) seat plan to verify its layout in backend/bookings/seats.py.

Gotchas
- Vercel "backend" project (root backend/) fails every deploy; not the live API (Render). Consider deleting it.
- Never probe prod with writes to verify a deploy; confirm the new build first with a read-only endpoint.
