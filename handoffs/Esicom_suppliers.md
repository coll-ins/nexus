# Esicom_suppliers
Goal: Build the Esicom ledger (customers, tabs, stock, invoices/receipts, quotes, staff-only file upload) in Django + React; then website cleanup.
Done (decided by Collins):
- Tabs: running per customer; invoice printable any time (bills only unbilled items); owner closes manually; per-customer choice tab or per-sale invoice.
- Cash: receipt only when asked. Partial payment only by owner-approved agreement. Prices excl. VAT. Whole shillings. English only. A4 + 80mm thermal.
- Overpayment refunded by default; option to keep as credit. Credit limit none by default; owner can set per customer with alert.
- Stock: owner enters starting stock by hand; minus button; block sales above stock; cost/profit owner only.
- Buy list: target = reorder level + average monthly sales, per product. Lead time dropped.
- Email: esicom email via Gmail (app password, set by owner, entered in secure form). Reminders: 3 days before due, on due, 7 days after. Statements only when requested.
- WhatsApp: free; staff share PDF by hand. No paid API.
- Files: remove /send-file/ and /file-qr/ from public site; staff-only QR in dashboard; scan opens upload-only page; PDF<->Word convert; files to email + dashboard; old files kept.
- Catalogue: remove nav buttons, PDF, backend model.
- Users: owner only. Forgotten password reset by email. No 2FA. Default session length.
- Accounts: Render yes; Vercel yes; Neon no (create); repo access yes (connected).
- Dashboard: same brand as website, photos and backgrounds.
Next:
- Ask Collins: VAT registered? (blocking); rounding per line or per total; credit-alert recipient; session length; confirm email spelling (esicomsuppliers@ vs secomsupplies@); Vercel project URL; KRA PIN.
- Then build P1.
Gotchas:
- Sandbox proxy blocks vercel.app and onrender.com: live URLs unverified. Repo rewrites /api/* to esicom-suppliers.onrender.com.
- Commit 9f75430 authored "Claude"; check.sh fails on it; force-push not allowed without OK.
