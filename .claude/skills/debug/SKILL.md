---
name: debug
description: Systematic debugging. Use for any bug, failing test, error message or "it doesn't work".
---

# Debug
No guessing, no shotgun edits.
1. Reproduce: get the exact command + exact error. If you can't reproduce, that's the first problem.
2. Read the full traceback; find the first frame in OUR code.
3. Form ONE hypothesis. Test it with the cheapest check (print, log, single test, REPL).
4. Confirmed → fix the root cause, not the symptom. Rejected → next hypothesis. After 3 rejected, step back and re-read the code path end to end.
5. Add a test that fails before the fix and passes after.
6. Run the full test suite.
7. If the bug came from a wrong assumption Nexus made, run `learn`.
Report: cause (one line), fix (diff), proof (test output).
