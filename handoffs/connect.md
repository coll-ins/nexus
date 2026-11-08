Goal: ship payment/parcel/hire fixes + legal pages (branch ccr-a01d519e-urij3l, not merged).

Done
- Cash bookings no longer expire at 20 min (expire_pending_bookings.py); closed/failed Paystack checkouts release (views.py _release_dead_digital_attempt).
- Orphaned/wrong-amount charges queue refunds via UnappliedPayment + process_unapplied.
- Parcels: settle_stale_parcels (deliveries/services.py) refunds on cancelled/ended trips. Hire: paid cancel 48h+ / company-cancel with refund.
- Legal pages /legal/*, signup requires accept_terms (users 0008 migration). Breaker x4: 0 critical/high. Backend 922, e2e 64 pass.

Next
- Collins: open PR from ccr-a01d519e-urij3l, merge, deploy (runs migration users 0008).
- Collins: set VITE_LEGAL_ENTITY, VITE_SUPPORT_EMAIL, VITE_SUPPORT_PHONE in Vercel.
- Collins: lawyer review of src/legal/documents.js; ODPC registration; CA courier licence check for parcels.
- Test mode: close card checkout then pick cash; pay old checkout tab, confirm refund after cron.
- Earlier: remove ADMIN_PASSWORD on Render; GitHub var CONNECT_API_URL + secret CRON_SECRET.
- LOW open: hire driver check misses trips departing just before hire start; company can cancel a started hire.

Gotchas
- Tests: DEBUG=True ADMIN_SIGNUP_CODE=x PAYSTACK_SECRET_KEY=sk_test_dummy; psycopg2 wheel fails on py3.13, skip it locally.
- Cloud Playwright: executablePath /opt/pw-browsers/chromium, channel undefined.
