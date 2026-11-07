#!/usr/bin/env python3
"""Set Nexus's attribution block in a Claude Code settings.json, keeping every other key.
Usage: merge-attribution.py <target settings.json> <nexus settings.json>"""
import json
import os
import sys

target, source = sys.argv[1:3]
settings = {}
if os.path.exists(target):
    with open(target) as f:
        settings = json.load(f)  # invalid JSON aborts here, before anything is written
with open(source) as f:
    wanted = json.load(f)["attribution"]
if settings.get("attribution") != wanted:
    settings["attribution"] = wanted
    tmp = target + ".tmp"
    with open(tmp, "w") as f:
        json.dump(settings, f, indent=2)
        f.write("\n")
    os.replace(tmp, target)
    print(f"set attribution in {target}")
