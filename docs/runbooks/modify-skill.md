# Runbook: Modifying SKILL.md

**When to use this:** You need to change how the skill router behaves —
not what modes exist, but how modes are processed. This is a high-risk
change. A broken `SKILL.md` breaks every mode simultaneously.

**When NOT to use this:** You are adding a new mode or changing a mode file.
Those changes never require touching `SKILL.md`. See
[`adding-new-mode.md`](adding-new-mode.md).

---

## What SKILL.md controls

`SKILL.md` implements the nine steps that run for every session:

| Step | Behaviour | Feature flag |
|---|---|---|
| 1 | Load `config.yml` and `_context/governance-canonical.md` | — |
| 2 | Ask the user for a review mode | `review_mode_prompt` in config.yml |
| 3 | Present the mode menu (built from `config.yml`) | — |
| 4 | Enforce lifecycle gate — require Brief for gated modes | F1 |
| 4 | Hydrate Brief from ClickUp URL or `.md` upload | F2 |
| 5 | Route to the correct mode file via `config.yml → path` | — |
| 6 | Handle prior artefact uploads | — |
| 7 | Apply canonical term suggestion UI at bounded-category questions | F6 |
| 8 | Run the grilling session per the mode file | — |
| 9 | Validate output against OVR rules before presenting | F7 |

Changes to `SKILL.md` affect all of these steps for all modes.

---

## Safe changes

These changes are low-risk and well-understood:

**Updating the canonical term suggestion UI (F6)**
- Adding new canonical categories to the suggestion list (SIEM, Workflows,
  Platform Capabilities, Business Objectives)
- Updating the list of terms offered for an existing category
- Changing the UI prompt phrasing (A/B/C options)

**Updating the review mode prompt (Step 2)**
- Adding a new review mode — also requires adding it to every mode's
  `review_modes` list in `config.yml`
- Updating the description of an existing review mode

**Updating the lifecycle gate message (F1)**
- Changing the wording of the "Brief required" message
- Adding a new mode to the gate (also requires `requires_brief: true` in
  config.yml for that mode)

**Updating OVR enforcement logic (F7)**
- Adding a new check to the validation loop
- Note: the OVR rules themselves live in `config.yml` — the logic that
  reads and enforces them lives in `SKILL.md`

---

## High-risk changes

These changes can break all modes and require careful testing:

**Changing Step 1 — context loading**
The skill depends on `_context/governance-canonical.md` being fully loaded
before any grilling begins. Any change that delays or conditions this loading
risks un-grounded output across all modes.

Rule: `_context/governance-canonical.md` must always be loaded at Step 1,
unconditionally, before any user input is processed.

**Changing Step 5 — routing logic**
The routing reads `config.yml → path` to find the mode file. If routing
logic changes, verify:
- Every `status: active` mode resolves to a real file path under `modes/`
- `status: coming_soon` modes are still presented as greyed-out (not routed)
- Trigger matching handles partial strings (e.g. "brief" matches "default-brief")

**Changing Step 9 — OVR enforcement**
OVR rules fire before output is presented. Any change to enforcement order
or gate logic risks silent rule bypasses. After any change here, manually
test at least one mode against a deliberately incomplete output to confirm
the gate blocks correctly.

---

## Before making any change

1. **Read the current `SKILL.md` in full.** Never edit from memory.
2. **Identify which steps are affected.** Write them down.
3. **Check whether the change belongs in `config.yml` instead.**
   If it can be expressed as a `config.yml` field, it should be there —
   not hardcoded in `SKILL.md`.
4. **Identify which modes are affected.** All of them? A subset?

---

## Testing after a change

There is no automated runner yet. Manual test protocol:

```
1. Open a new Claude session after re-uploading the skill
2. Test Brief mode — confirm menu appears, review mode is asked
3. Test Epic mode without a Brief — confirm F1 gate fires and blocks
4. Test Epic mode with a Brief URL — confirm F2 hydration runs
5. Test any mode with a deliberately vague answer — confirm UG-02 drill fires
6. Test any mode with a prior artefact upload — confirm UG-03 pre-population fires
7. Generate output from any mode and confirm OVR checks run (F7)
8. Deliberately omit a SIEM term and confirm OVR-03 blocks output
```

Run at minimum steps 1–4 and 7–8 after any `SKILL.md` change.

---

## Change log discipline

Every `SKILL.md` change must be committed with a message that names:
- Which step(s) changed
- Which feature flag(s) are affected
- Whether any `config.yml` changes accompany it

Example commit message:
```
SKILL.md: F6 — add SIEM policy suggestion list to canonical term UI

Step 7 updated. New canonical category: SIEM (SEC-POL · SEC-STD · SEC-RB · SEC-SOP).
No config.yml changes. No mode file changes required.
```
