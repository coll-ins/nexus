#!/usr/bin/env python3
"""UserPromptSubmit hook: if the prompt looks like a correction or preference, tell Nexus to record it."""
import json, re, sys
try:
    prompt = json.load(sys.stdin).get("prompt", "")
except Exception:
    sys.exit(0)
p = prompt.lower()
patterns = [r"^\s*no[,. !]", r"\bactually\b", r"\bdon'?t\b", r"\bstop\b", r"\binstead\b",
            r"\bnot like that\b", r"\bi (said|meant|told you)\b", r"\bremember\b",
            r"\balways\b", r"\bnever\b", r"\bi (prefer|want|like|hate)\b", r"\bwrong\b"]
if any(re.search(x, p) for x in patterns):
    print("[nexus] This message may contain a correction or preference. After handling it, "
          "run the `learn` skill if it reveals something durable about how Collins wants things done. "
          "Skip if it's a one-off instruction for this task only.")
