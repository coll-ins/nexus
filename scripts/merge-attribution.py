#!/usr/bin/env python3
"""Set Nexus's attribution block in a Claude Code settings.json, keeping every other key.
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
    wanted = json.load(f)["attribution"]
if settings.get("attribution") != wanted:
    settings["attribution"] = wanted
    os.makedirs(os.path.dirname(os.path.abspath(target)), exist_ok=True)
    tmp = target + ".tmp"
    with open(tmp, "w") as f:
        json.dump(settings, f, indent=2)
        f.write("\n")
    os.replace(tmp, target)
    print(f"set attribution in {target}")
