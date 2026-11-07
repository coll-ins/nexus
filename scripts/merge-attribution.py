#!/usr/bin/env python3
"""Set Nexus's attribution block and hooks in a Claude Code settings.json, keeping every other key.
Usage: merge-attribution.py <target settings.json> <nexus settings.json>"""
import json
import os
import sys

target, source = sys.argv[1:3]
settings = {}
if os.path.exists(target) and os.path.getsize(target) > 0:
    try:
        with open(target) as f:
            settings = json.load(f)
    except ValueError as e:
        sys.exit(f"error: {target} isn't valid JSON ({e}); fix it, then re-run")
    if not isinstance(settings, dict):
        sys.exit(f"error: {target} must be a JSON object; fix it, then re-run")
with open(source) as f:
    src = json.load(f)
changed = settings.get("attribution") != src["attribution"]
settings["attribution"] = src["attribution"]
for event, groups in src.get("hooks", {}).items():
    have = settings.setdefault("hooks", {}).setdefault(event, [])
    cmds = {h.get("command") for g in have for h in g.get("hooks", [])}
    for g in groups:
        if any(h["command"] not in cmds for h in g["hooks"]):
            have.append(g)
            changed = True
if changed:
    os.makedirs(os.path.dirname(os.path.abspath(target)), exist_ok=True)
    tmp = target + ".tmp"
    with open(tmp, "w") as f:
        json.dump(settings, f, indent=2)
        f.write("\n")
    os.replace(tmp, target)
    print(f"set attribution and hooks in {target}")
