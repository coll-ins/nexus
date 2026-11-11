# Esicom_suppliers
Goal: Ledger + dashboard + upload page live and working end to end.
Done:
- PR #6 and #7 merged to main. Backend live on Render Docker service esicom-backend (srv-dbpuv10ae00c73cphfng), branch main.
- WeasyPrint verified live (Word->PDF upload ES-F5 converted). Owner esicomsuppliers@gmail.com created, no password yet.
- Dashboard served from website at /dashboard (Vercel token cannot create projects).
- Tests: backend 147, dashboard 25, breakers run, all critical/high fixed.
Next:
- 12 Nov 08:15 Nairobi: Vercel deploy quota resets; deploy main to production (scheduled task trig_012DDRUbdoPcDqh4QyeFYRwg) and verify /api/ and /ledger-api/ rewrites.
- Email: Render free blocks SMTP. Waiting on Collins: paid instance vs Gmail API vs Brevo.
- Database: Render Postgres esicom-db expires 20 Nov 2026; move to Neon before then.
- Old Render service esicom-suppliers still running (suspend refused by classifier); Collins can suspend.
Gotchas:
- Vercel :path* does not match trailing slash; use :path(.*).
- Vercel free: 100 API deploys/day; preview builds of branch pushes count.
- Render free sets WEB_CONCURRENCY=1; SMTP ports blocked; logs lag minutes.
- Old service had REDIS_URL pointing at Connect's Redis (invalid); not copied.
