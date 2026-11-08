Goal: Connect live with payment/parcel/hire fixes + legal pages (PR #5 merged 8 Nov, 66143eb).

Done
- Cash bookings kept until departure; closed/failed Paystack checkouts release (bookings/views.py _release_dead_digital_attempt).
- Unmatched/wrong-amount charges -> UnappliedPayment refunds via process_unapplied cron.
- Parcels: settle_stale_parcels (deliveries/services.py). Hire: paid cancel 48h+, company-cancel (charters/services.py).
- Legal /legal/* as intermediary (frontend-react/src/legal/documents.js); signup needs accept_terms (users 0008).
- CI green on PR #5; breaker x4 clean. Live check: scratchpad livecheck.sh (signup probe + bundle grep).

Next
- Collins: delete Vercel project "backend" (team collins2; fails every PR, not the live site).
- Collins: set VITE_LEGAL_ENTITY, VITE_SUPPORT_EMAIL, VITE_SUPPORT_PHONE in Vercel project connect-zj9i, redeploy.
- Collins: advocate review of documents.js; ODPC registration; CA courier licence check for parcels.
- Test mode on live: close card checkout then pick cash; pay old checkout tab, refund after cron.
- Earlier: remove ADMIN_PASSWORD on Render; GitHub var CONNECT_API_URL + secret CRON_SECRET.
- LOW: hire driver check misses trips leaving just before hire start; company can cancel a started hire.

Gotchas
- Live: frontend connect-zj9i-gamma.vercel.app, API connect-lhqy.onrender.com (vercel.json proxies /api).
- Tests: DEBUG=True ADMIN_SIGNUP_CODE=x PAYSTACK_SECRET_KEY=sk_test_dummy; skip psycopg2 on py3.13.
- Cloud Playwright: executablePath /opt/pw-browsers/chromium, channel undefined.
- PR bodies get a Claude Code footer appended by the platform; strip it on GitHub if unwanted.
