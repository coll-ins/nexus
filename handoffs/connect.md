Goal: ship Connect to Google Play as a TWA wrapping https://connect-zj9i-gamma.vercel.app.

Done
- Branch claude/clever-galileo-9upke9 (3 commits on main e0ff04a), pushed, no PR yet.
- Installed app opens on Welcome (src/pages/landing/Welcome.jsx) → Get started → /login with Back + Sign in/Create account switch (src/pages/auth/AuthTopBar.jsx).
- PWA: public/manifest.webmanifest, sw.js (offline page only), icon-512-maskable.png. android/ has twa-manifest.json + README (publish steps).
- Play blockers fixed: account deletion API (users/views.py delete_account) + Profile UI + /legal/delete-account.
- 4 breakers run; all CRITICAL/HIGH/MEDIUM fixed. Backend 1025 OK, e2e 81/81 (prod build), fullstack 11/11.

Next
- Collins: open PR, merge, confirm Vercel serves /manifest.webmanifest and /sw.js.
- Collins (laptop): android/README.md → bubblewrap init/build, Play closed test (12 testers × 14 days).
- After first upload: put Play app-signing SHA-256 in public/.well-known/assetlinks.json (template android/assetlinks.template.json).
- Open: phone OTP at signup (fake accounts), paginate bookings/views.py get_all_bookings.

Gotchas
- dl.google.com blocked in cloud: the AAB cannot be built here.
- packageId ke.connectmatatu.app is permanent once uploaded.
- e2e role-screens.spec.js:146 flaky with 2 workers; passes with 1.
