Goal: live demo of Connect on City Shuttle CBD to Kamangu with real GPS and push alerts.

Done
- PR coll-ins/connect#19 merged and live (d9b759a): GPS starts, departs and ends trips (backend/bookings/departure.py), Web Push (backend/notifications/push.py), GPS accuracy/jump filter (backend/drivers/views.py _imprecise_fix), Kamangu routes 89/90 live.

Next
- Collins: run the demo; report whether push arrives on a real phone.
- Set the real Kamangu fare (KES 150 provisional).
- Rebuild APK with bubblewrap (twa-manifest enableNotifications true).
- Background GPS needs a native wrapper (Capacitor + foreground service): web/TWA stops GPS when screen is off.
- Boarding still needs the driver to verify each PIN, or the rider becomes a no-show at auto-end.

Gotchas
- pywebpush won't build (http-ece); push is hand-rolled on cryptography, tested on the RFC 8291 vector.
- GitHub Actions doesn't report on PRs; run tests locally (env vars from ci.yml).
- Overpass blocked from cloud; Nominatim/Photon/OSRM work.
