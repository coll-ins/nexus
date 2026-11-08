# Esicom_suppliers
Goal: Fix homepage issues found in the site review.
Done:
- ca11f36 on branch ccr-1a68af09-ptjcxq: Argwings spelling, service cards (text below photo), link contrast 2.05→8.2, hero oval/filler removed, mobile home 10,053→6,943px
Next:
- Collins supplies new polo / business-card / asset-tag mockups with the official ES logo (current ones show an orange "E")
- Open a PR from ccr-1a68af09-ptjcxq when ready
- Optional: sitewide 9–10px text (topline, eyebrows, buttons) is under 11px
Gotchas:
- build.py CSS is ~25 stacked overrides with !important; the last rule wins. Edit the final block (~line 508), don't append more layers
- .hero:before was a ring (line 52) reused as a text label (line 327), so it rendered as a giant oval
