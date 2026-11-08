# Esicom_suppliers
Goal: Get the site fixes live, then build the backend customer/invoice system.
Done:
- PR #5 merged to main (96aa42b): Argwings spelling, readable service cards, link contrast 2.05→8.2, hero oval removed, mobile home 10,053→6,943px. Breaker: 0 critical/high
- Separate "Esicom Suppliers" cloud environment (Connect env untouched)
Next:
- Collins finds the real Vercel URL: esicom-suppliers.vercel.app returns DEPLOYMENT_NOT_FOUND
- Confirm Vercel settings: root dir frontend, build `python build.py`, output dir `dist`
- Verify live pages, then start the backend (customers, products taken, monthly auto-invoice) with architect
- Collins supplies new polo/business-card/asset-tag mockups with the ES logo
Gotchas:
- build.py CSS is ~25 stacked !important overrides; edit the final block (~line 508)
- Collins declined adding the vercel.app host to the env; ask before re-proposing
