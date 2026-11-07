---
name: frontend
description: Rules for building or changing any UI (React, HTML/CSS, templates). Use for any frontend task.
---

# Frontend

Design
- Pick one clear visual direction before coding (type, colour, spacing scale). State it in one line.
- Avoid the generic AI look: no purple/blue gradients, no default Inter-everywhere, no card-in-card layouts, no emoji icons, no fake stats or lorem testimonials.
- Use a spacing scale (4/8px) and max 2 font families. Real content over placeholders.

Code
- Reuse existing components and styles before writing new ones. No new UI library unless asked.
- Components small and single-purpose; no prop drilling past 2 levels — lift state or use context.
- Every form: labels, validation, loading, error and empty states. Every button: disabled while submitting.
- Accessible by default: semantic HTML, alt text, focus states, keyboard reachable, contrast AA.
- Mobile-first; check 375px width. Matatu users are on phones.

Verify
- Run it and look at it (screenshot or Playwright) before saying done. Code that compiles is not a UI that works.
- Check the console for errors and the network tab for failed requests.
