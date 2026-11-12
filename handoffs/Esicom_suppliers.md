# Esicom_suppliers
Goal: Ledger + dashboard + upload page live and working end to end.
Done:
- 12 Nov: data copied to Neon project esicom (sparkling-queen-65415199, us-west-2); DATABASE_URL now Neon, row counts matched.
- 12 Nov: website + /dashboard deployed to Vercel production (8c8a374); /api, /ledger-api, /admin, /upload verified 200.
- PR #6 and #7 merged to main. Backend live on Render Docker service esicom-backend (srv-dbpuv10ae00c73cphfng), branch main.
- WeasyPrint verified live (Word->PDF upload ES-F5 converted). Owner esicomsuppliers@gmail.com created, no password yet.
- Dashboard served from website at /dashboard (Vercel token cannot create projects).
- Tests: backend 147, dashboard 25, breakers run, all critical/high fixed.
Next:
- Email: Gmail API backend merged (PR #8). Waiting on Collins to add GMAIL_CLIENT_ID/SECRET/REFRESH_TOKEN in Render (README steps). Then test with Forgot password.
- Old Render service esicom-suppliers still running (suspend refused by classifier); Collins can suspend.
Gotchas:
- Vercel :path* does not match trailing slash; use :path(.*).
- Vercel free: 100 API deploys/day; preview builds of branch pushes count.
- Render free sets WEB_CONCURRENCY=1; SMTP ports blocked; logs lag minutes.
- Old service had REDIS_URL pointing at Connect's Redis (invalid); not copied.
