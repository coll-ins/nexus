# Nexus

Collins's agent council for Claude Code: one orchestrator (**Nexus**) + four specialists.

- `CLAUDE.md`: Nexus, the round rules, memory and token rules
- `.claude/agents/`: architect (your main model), builder + breaker (Sonnet), researcher (Haiku)
- `.claude/skills/nexus-design/`: anti-slop frontend design (spacing, type, color, motion, banned AI tells). Loads only for UI work
- `.claude/skills/fix-bug/`: root-cause bug fixing, loads only when there's a bug (or type `/fix-bug`)
- `memory/preferences.md`: rules Nexus has learned about how Collins works (Nexus edits this)

## Laptop: every repo, one command
```bash
git clone https://github.com/coll-ins/nexus ~/nexus && ~/nexus/scripts/install.sh
```
Symlinks into `~/.claude/`, so `git pull` updates Nexus everywhere and learned preferences land back in this repo. Commit `memory/` now and then. Anything in the way gets backed up (`*.bak.<time>`), not deleted; rules from an old `~/.claude/nexus` are merged in. `settings.json` stays your own file: only the `attribution` block is set.

## Cloud / phone sessions (they only see the repo)
```bash
~/nexus/scripts/sync.sh ~/code/connect   # then commit .claude/ in that repo
```
Re-run to update. Preferences learned or removed inside that repo are merged back into Nexus first (3-way, against `.claude/nexus/last-sync.md`). A project's own agent or skill with a Nexus name is backed up, not overwritten; agents Nexus dropped are removed. Projects synced before this version print their unmerged rules once instead of merging blind.

## Claude.ai chat (web/phone app, no repo)
Zip each skill folder (`cd .claude/skills && zip -r fix-bug.zip fix-bug`) and upload it in claude.ai: Settings → Capabilities → Skills. Re-upload after changing a skill.

## Handoffs
Unfinished work gets a `.claude/HANDOFF.md` in the project (max 25 lines, overwritten each time, deleted when done). The next session reads it first.

## Changing Nexus
Run `scripts/check.sh` before committing.

## Credits
Code-writing rules adapted from [ponytail](https://github.com/DietrichGebert/ponytail) (MIT) and [andrej-karpathy-skills](https://github.com/multica-ai/andrej-karpathy-skills). `fix-bug` condensed from [superpowers](https://github.com/obra/superpowers) systematic-debugging (MIT). `nexus-design` synthesized from Anthropic frontend-design, impeccable, unslop (CC BY 4.0, Damir Sokolovsky), taste-skill and ui-ux-pro-max; sources in the skill file.
