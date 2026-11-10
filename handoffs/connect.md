Goal: ship Connect to Google Play as a TWA wrapping https://connect-zj9i-gamma.vercel.app.

Done
- PR coll-ins/connect#11 merged (980e3ae), live on Vercel + Render since 19:19 9 Nov, verified in browser.
- Installed app opens on Welcome (src/pages/landing/Welcome.jsx) → Get started → /login with Back + Sign in/Create account switch (src/pages/auth/AuthTopBar.jsx).
- PWA: public/manifest.webmanifest, sw.js (offline page only), icon-512-maskable.png. android/ has twa-manifest.json + README (publish steps).
- Play blockers fixed: account deletion API (users/views.py delete_account) + Profile UI + /legal/delete-account.
- 4 breakers run; all CRITICAL/HIGH/MEDIUM fixed. Backend 1025 OK, e2e 81/81 (prod build), fullstack 11/11.

Next
- Routes/stages/return routes are live (coll-ins/connect#12, cbd6c03). Collins: eyeball CBD to Ngong on the live map, set real fares on new routes, add schedules for return routes.
- Rebuild route data: tools/build_route_network.py (needs OSRM + Photon hosts, already allowed in the Connect env).
- Collins (laptop): android/README.md → bubblewrap init/build, Play closed test (12 testers × 14 days).
- After first upload: put Play app-signing SHA-256 in public/.well-known/assetlinks.json (template android/assetlinks.template.json).
- Open: phone OTP at signup (fake accounts), paginate bookings/views.py get_all_bookings.

Gotchas
- Overpass and Nominatim reset connections from cloud; Photon works for OSM stop lookups.
- dl.google.com blocked in cloud: the AAB cannot be built here.
- packageId ke.connectmatatu.app is permanent once uploaded.
- Vercel project `backend` failed on the PR #11 preview; looks unused (API is Render via vercel.json).
- e2e role-screens.spec.js:146 flaky with 2 workers; passes with 1.
