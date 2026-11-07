#!/usr/bin/env python3
"""UserPromptSubmit hook: nudge Nexus to save a preference when Collins states or corrects one."""
import json, re, sys
try:
    p = json.load(sys.stdin).get("prompt", "").lower()
except Exception:
    sys.exit(0)
patterns = [r"\balways\b", r"\bnever\b(?! mind)", r"\bfrom now on\b", r"\bi (prefer|hate)\b",
            r"\bstop (doing|adding|using|writing)\b", r"\bdon'?t ever\b", r"\bnot like that\b",
            r"\bi (said|told you|already told)\b", r"\bremember (that|to)\b"]
if any(re.search(x, p) for x in patterns):
    print("[nexus] Possible standing preference. If it should apply next time, save it to the preferences file and say `Saved: <rule>`.")
