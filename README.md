# Nexus

Collins's agent council for Claude Code: one orchestrator (**Nexus**) + four specialists.

- `CLAUDE.md`: Nexus, the round rules, memory and token rules
- `.claude/agents/`: architect, builder, breaker, researcher
- `memory/preferences.md`: rules Nexus has learned about how Collins works (Nexus edits this)

## Laptop: every repo, one command
```bash
git clone https://github.com/coll-ins/nexus ~/nexus && ~/nexus/scripts/install.sh
```
Symlinks into `~/.claude/`, so `git pull` updates Nexus everywhere and learned preferences land back in this repo. Commit `memory/` now and then. An existing `~/.claude/CLAUDE.md` gets backed up, not deleted.

## Cloud / phone sessions (they only see the repo)
```bash
~/nexus/scripts/sync.sh ~/code/connect   # then commit .claude/ in that repo
```
Re-run to update. Preferences learned inside that repo get pulled back into Nexus first.

## Handoffs
Unfinished work gets a `.claude/HANDOFF.md` in the project (max 25 lines, overwritten each time, deleted when done). The next session reads it first.

## Changing Nexus
Run `scripts/check.sh` before committing.
