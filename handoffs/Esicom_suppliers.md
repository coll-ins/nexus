# Esicom_suppliers
Goal: Build the Esicom ledger (customers, tabs, stock, invoices/receipts, quotes) in Django + React; then website cleanup.
Done (decided by Collins):
- Running tab per customer; invoice printable any time; printing bills only unbilled items; tab stays open.
- Tab closed manually by owner, any time. Per-customer choice: tab or one invoice per sale.
- Cash: receipt only when customer asks. Partial payment only by owner-approved agreement.
- Prices exclude VAT. Overpayment refunded by default, option to keep as credit.
- Credit limit: none by default; owner can set one per customer; notify when exceeded.
- Whole shillings, no cents. Documents English only. Paper: A4 + 80mm thermal.
- Stock: owner enters starting stock by hand; "minus" button for sales; block sales above stock. Cost/profit owner-only.
- Document numbering approved. KRA pin/eTIMS, bank/paybill details: later.
Next:
- Ask Collins: VAT on/off per customer request (tax-rule check); overpayment/limit notify target; lead time; rounding per line vs per total; remaining questionnaire sections E-H.
- Show him the sample PDF (sent as PNG on 11 Nov); fix look with brand fonts.
- Confirm eTIMS path with owner (portal manual today); KRA sandbox only after sign-off.
Gotchas:
- Sandbox proxy blocks vercel.app and onrender.com: live URLs unverified.
- Commit 9f75430 authored "Claude"; check.sh fails on it; force-push not allowed without OK.
