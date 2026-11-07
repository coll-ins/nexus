# Nexus

Collins's agent council for Claude Code: one orchestrator (**Nexus**) + four specialists.

- `CLAUDE.md` — Nexus, the orchestrator, and the round rules
- `.claude/agents/` — architect, builder, breaker, researcher

## Use it in any project
```bash
git clone https://github.com/coll-ins/nexus ~/nexus
mkdir -p ~/.claude/agents
cp ~/nexus/.claude/agents/*.md ~/.claude/agents/   # agents available in every project
cp ~/nexus/CLAUDE.md ~/.claude/CLAUDE.md           # Nexus becomes your global orchestrator
```
Phone / cloud sessions: copy `.claude/agents/` and `CLAUDE.md` into each repo you work on from the Claude app, since cloud sessions only see the repo.
