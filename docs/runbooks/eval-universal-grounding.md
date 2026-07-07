# Runbook: Evaluating Universal Grounding

**When to use this:** You want to verify that a mode (new or existing)
satisfies the three universal grounding behaviours defined in
`tests/evals/universal-grounding.yml`. Or you want to understand whether
the UG eval suite is currently active and what its status is.

---

## Current status

The universal grounding eval runner is **parked pending tooling decision**.

The eval specifications (`tests/evals/universal-grounding.yml`) and
personas (`tests/personas/`) are fully defined and ready to run. What
is not yet decided is the execution environment — whether to run through
Langfuse, a custom harness, or another LLM-as-judge framework.

Until the runner is live, verification is manual. This runbook covers both
the manual protocol and the intended automated protocol.

---

## What universal grounding tests

Three behaviours, every active mode, automatically:

| ID | Behaviour | Why it matters |
|---|---|---|
| UG-01 | **Proactive grounding** — skill names a canonical term in turn 1 without the user introducing it | A skill that waits for the user to say "PRISM" before using the word is a transcriptionist, not a grounding engine |
| UG-02 | **Drill on vague** — skill pushes back on "it improves efficiency" and uses a canonical signal question | A skill that accepts vague answers produces un-grounded output |
| UG-03 | **Handoff pre-population** — skill reads the `## Handoff` block on upload and skips answered anchors | A skill that re-asks questions already answered in a prior artefact wastes the user's time and breaks the lifecycle chain |

Full specifications: `tests/evals/universal-grounding.yml`.

---

## Manual verification protocol

Run this protocol when:
- A new mode is being activated (`status: coming_soon` → `active`)
- A mode file has been significantly changed
- `SKILL.md` has been changed (affects all modes — run across all active modes)

### UG-01 — Proactive grounding

1. Open a new Claude session with the skill loaded
2. Select the mode under test
3. Give a plain English opening answer with **zero Madgicx terminology**:
   > *"I want to build something that helps our marketing team understand their ad performance better."*
4. Check Claude's first response. It must name at least one of:
   - A domain ID (e.g. `social_marketing__ad_performance`)
   - A system name (PRISM · θCortex · DataHub · AgentForge · mdx-gov-hub)
   - A value stream (CustomerX · OperX · TrustX)
   - A `BusinessGoals.*` term
5. **Pass:** canonical term named in turn 1
6. **Fail:** Claude asks a generic question or paraphrases without canonical terms

If fail: open the mode file's **Opening** section and **During [Anchor]**
instructions. The mode file must explicitly instruct Claude to name the most
likely domain(s) and system(s) after the opening answer — before drilling.

### UG-02 — Drill on vague

1. Open a new Claude session with the skill loaded
2. Select the mode under test
3. At any anchor, give a deliberately vague answer:
   - *"it improves efficiency"*
   - *"it adds business value"*
   - *"it aligns with our strategy"*
4. Claude must **not** accept the answer and move on. It must push back and
   ask a canonical signal question within 3 turns.
5. **Pass:** Claude pushes back and asks a specific, canonical-grounded question
6. **Fail:** Claude accepts the vague answer and proceeds to the next anchor

If fail: open the mode file's anchor section for the question where the vague
answer was given. Check that the **drill-in trigger table** has an entry for
vague/generic answers (e.g. `"No evidence cited" → "What's the strongest
signal you have that this problem is real?"`). Add it if missing.

### UG-03 — Handoff pre-population

1. Produce (or take) a completed artefact `.md` file with a `## Handoff` block
2. Open a new Claude session, select the downstream mode
   (e.g. upload a Brief, select Epic)
3. Upload the `.md` file at the start of the session
4. Check that Claude:
   - Names the uploaded artefact type and title
   - Lists which fields were pre-populated
   - Does not re-ask anchors whose answers are already in the Handoff block
5. **Pass:** upload acknowledged, fields listed, anchors skipped
6. **Fail:** upload ignored, or anchors re-asked

If fail: open the mode file's **Before you begin** section. It must contain
explicit instructions to check for an uploaded `.md`, locate the `## Handoff`
block, extract fields, and announce pre-populated anchors. Add or fix these
instructions.

---

## Automated runner (intended design)

When the tooling decision is made, the runner will:

```
for each active mode in config.yml:
  for each behaviour in [UG-01, UG-02, UG-03]:
    for each persona in behaviour.personas:
      run simulated conversation
      score against behaviour.scoring_criteria
      compare to confidence_threshold
      write result to tests/results/<mode>/<behaviour>.json
      trace to Langfuse alongside production AgentForge traces
```

Pass criteria per behaviour:
- UG-01: SC-01 ≥ 0.95, SC-02 ≥ 0.80
- UG-02: SC-03 ≥ 0.90, SC-04 ≥ 0.90, SC-05 = 1.0 (zero-tolerance)
- UG-03: SC-06 ≥ 0.95, SC-07 ≥ 0.90, SC-08 ≥ 0.95

SC-05 is zero-tolerance: invented canonical terms (domain IDs, system names,
workflow IDs, objective names not in `governance-canonical.md`) result in
automatic fail regardless of other scores.

---

## Is universal grounding actually being used?

As of the current version: **partially**.

The eval *specifications* are complete and correct. The *runner* is not
implemented. This means:

- UG-01–03 are defined and ready to execute
- They have never been run in an automated harness
- Manual spot-checks have been performed during mode file development
- Results are not tracked in `tests/results/` (the folder exists but is empty
  except for `.gitkeep`)
- Langfuse integration is not yet wired

**Practical implication:** universal grounding is enforced by the mode file
instructions (if written correctly) and verified manually during development.
It is not continuously verified. Any mode file change should trigger a manual
UG-01–03 spot-check per this runbook until the automated runner is live.

**Next step to activate:** decide on runner tooling, implement the harness,
wire to Langfuse. This is tracked as a future item in `README.md`.
