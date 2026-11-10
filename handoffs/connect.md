Goal: live demo of Connect on City Shuttle CBD to Kamangu with real GPS and push alerts.

Done
- PR coll-ins/connect#19: trips auto-board/depart from GPS (backend/bookings/departure.py), Web Push alerts (backend/notifications/push.py, frontend-react/src/utils/push.js, public/sw.js), Kamangu route (companies/migrations/0021). Backend 1042 OK, e2e 87/87, 2 breakers fixed.

Next
- Collins: merge #19, wait for Render + Vercel deploy, create a Kamangu trip with driver + bus departing ~20 min ahead.
- Set the real Kamangu fare (KES 150 is provisional) in the planner.
- Rebuild APK with bubblewrap (twa-manifest enableNotifications now true).
- Verify push on a real phone; traffic needs 3 companies' buses, so it shows nothing with 1 bus.

Gotchas
- pywebpush won't build (http-ece); push is hand-rolled on cryptography, tested on the RFC 8291 vector.
- Overpass is blocked from cloud; Nominatim/Photon/OSRM work.
- Tests need env vars from .github/workflows/ci.yml.
