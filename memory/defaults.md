# Standing decisions — use these, don't ask
If a choice is covered here, make it and mention it in one line. Ask only if the task contradicts a default or the choice is irreversible.

## Stack
- Backend: Python. Flask for APIs/labs, Django when admin/ORM-heavy. FastAPI only if asked.
- Frontend: React (Vite). Plain CSS or CSS modules; Tailwind only if the repo already uses it.
- DB: SQLite for labs/dev, PostgreSQL for anything deployed.
- ORM: SQLAlchemy (Flask), Django ORM (Django). Migrations: Flask-Migrate / Django migrations.
- Tests: pytest (Python), Vitest (React). Python formatting: ruff.
- Env/config: `.env` + python-dotenv; always ship `.env.example`, never `.env`.
- Deploy: backend → Render, frontend → Vercel, Postgres → Neon (free tiers).
- Python env: `python -m venv .venv` + requirements.txt unless repo uses pipenv/uv already.

## Workflow
- Branch per task, PR to main. Commit messages: imperative, short.
- Follow the repo's existing conventions over these defaults.
- Missing tests → write them. Missing README section for a new feature → add it.
- Ambiguous small detail (naming, file location, copy text) → pick the sensible one, note it, move on.

## Ask only when
- Spending money, deleting data, force operations, touching prod, or sending anything external.
- Two reasonable options with very different cost to reverse.
- Requirements genuinely contradict each other.
