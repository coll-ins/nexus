Goal: finish Connect (clean planner, real routes, automatic parcels) and ship to Play.

Done
- PR coll-ins/connect#13: planner hides removed stages (RoutePlanner.jsx pins filter), parcel wizard From/To across companies (DeliveryWizard.jsx), long-distance town stages (migration 0020). Backend 1034 OK, e2e 83/83, breaker: no critical/high.
- Nexus: graphify 0.9.105 installed by scripts/install.sh (no LLM), rule in CLAUDE.md.

Next
- Collins: merge #13 (also adds the landing Install button), check Kisumu on the live map, install from phone.
- Decide default parcel prices (routes with no rates show no parcels): needs a real price source.
- Verify company route lists: researcher couldn't confirm City Shuttle routes or Super Metro Kisumu/Kakamega (news sites DNS-blocked in cloud). "CBD to Mfangano" is a 0.3 km CBD hop: likely bogus.
- Schedules for return routes; android/README.md Play steps; phone OTP; paginate get_all_bookings.

Gotchas
- Photon resets connections now and then: retry. OSRM works.
- Tests need env vars: copy the backend job env from .github/workflows (ADMIN_SIGNUP_CODE etc).
- psycopg2-binary in requirements fails on Python 3.13: install >=2.9.10.
