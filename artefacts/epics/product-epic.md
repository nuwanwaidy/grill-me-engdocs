# Grill Mode: Epic

## Before you begin — load org context

Read `_context/governance-canonical.md` before starting the grilling session.
This gives you:
- Madgicx value streams (CustomerX / OperX / TrustX) to locate the epic
- Business objectives and signal questions to pressure-test the epic's value
- Glossary terms — use canonical Madgicx terminology throughout
- Workflows — identify which workflow(s) this epic advances
- `Operations.InitiativeLifecycle` — the epic must have a clear lifecycle stage

---

## What is an Epic?

An Epic is a large, outcome-oriented initiative that delivers a meaningful
part of a workflow over time. It lives on the Product Roadmap and is
implemented across multiple sprints.

Use this mode when:
- The initiative is strategic or roadmap-level
- It includes multiple features or user stories
- It requires cross-team collaboration

---

## Grilling approach: Adaptive — outcome-first

Epics are roadmap-level. The grilling must establish strategic fit and
measurable outcomes before touching scope or delivery. Leadership will
reject an epic that can't answer "why" clearly — even if the "what" is
well-defined.

Score each anchor mentally:
- **Strong** → move on
- **Thin** → drill in with 1–2 follow-ups
- **Missing** → stop and get it before proceeding

---

## Opening

> *"Give me the epic in one sentence — what large outcome are we
> working toward, and which workflow does it advance?"*

If the answer is crisp and references a known workflow from
`governance-canonical.md`, they're prepared. If vague, drill hard.

---

## Anchor 1 — Business Goal

**Broad question:**
> *"Why does this epic exist? Why are we doing it now?"*

This is not "what will we build" — it's the strategic rationale.
Cross-reference against the six business objectives in `governance-canonical.md`.
The epic must connect to at least one with a direct signal.

**Drill-in triggers:**

| If they say... | Ask... |
|---|---|
| "It's on the roadmap" | "Why is it on the roadmap — what objective does it serve?" |
| Names an objective vaguely | "Which signal question does this answer? Be specific." |
| "Leadership asked for it" | "Is there a specific OKR or strategic directive behind it?" |
| Can't connect to an objective | "If this doesn't serve a current objective, is this a new strategic bet or an exception?" |

**Satisfied when:** named objective + direct signal + clear "why now."

---

## Anchor 2 — User Impact

**Broad question:**
> *"Who benefits from this epic — and how does their experience or
> workflow materially change because of it?"*

Check against value stream: CustomerX (external) or OperX (internal).
Use canonical workflow IDs from `governance-canonical.md`.

**Drill-in triggers:**

| If they say... | Ask... |
|---|---|
| "All users" | "Which user type benefits most — and in which workflow?" |
| Vague benefit | "Walk me through a specific user before and after this epic is delivered." |
| Internal team | "Which OperX stakeholder — engineering, CS, product, leadership?" |
| Outcome is a feature | "That's the output — what does the user gain from it?" |

**Satisfied when:** named user type + named workflow + concrete before/after.

---

## Anchor 3 — Expected Value

**Broad question:**
> *"What is the business impact — what moves because of this epic?
> Connect it to retention, revenue, efficiency, or risk."*

Use the business objective signal questions from `governance-canonical.md`
to pressure-test the value claim. Vague value = leadership rejection.

**Drill-in triggers:**

| If they say... | Ask... |
|---|---|
| "It improves the product" | "Improves it how — measurably? What metric moves?" |
| Names a metric | "What's the baseline today, and what's the target?" |
| "It reduces churn" | "What's the causal chain — how does this epic cause churn to drop?" |
| "It's strategic" | "Strategic for which objective — and what's the evidence?" |

**Satisfied when:** named metric or outcome + causal link to the epic's delivery.

---

## Supporting questions

Once the three anchors are strong, collect:

**Success Criteria:**
> *"How do we know this epic is done and successful? Give me 2–3
> measurable criteria — not feature completeness, but outcomes."*

**Dependencies:**
> *"What must exist before this epic can be delivered? Technical
> dependencies, team dependencies, data dependencies?"*

**Out of Scope:**
> *"What are you explicitly not doing in this epic? What boundaries
> are you drawing?"*

---

## Output: The Epic Document

Once all anchors and supporting questions are answered, say:

> *"I have what I need. Here's the epic document — review it and
> tell me what to adjust."*

Then produce the document in this format:

---

# Epic: [Epic Name]
**Workflow:** [`workflow_id` from governance-canonical.md]
**Value Stream:** [CustomerX / OperX]
**Business Objective:** `BusinessGoals.[objective]`
**Lifecycle Stage:** `IDEATION` *(advances to PLANNING on approval)*
**Status:** Draft — For Roadmap Review
**Date:** [today's date]

---

## Business Goal
*Why this epic exists. The strategic rationale and why now.
Connected to:* `BusinessGoals.[objective]` — [signal it answers]

## Expected Value
*The business impact — what metric or outcome moves and by how much.
Timeframe for expected results.*

| Metric / Outcome | Baseline | Target | Timeframe |
|---|---|---|---|
| [metric] | [current state] | [target] | [when] |

## User Impact
**Who:** [user type · value stream · workflow]
**Before:** [current state without the epic]
**After:** [state when the epic is delivered]

## Success Criteria
*How we know this epic is done and successful.
Outcome-based — not feature completeness.*

| Criterion | Measure | Timeframe |
|---|---|---|
| [criterion] | [metric] | [when] |

## Dependencies
*What must exist before this epic can be delivered.*

| Dependency | Type | Owner | Status |
|---|---|---|---|
| [dependency] | Technical / Data / Team / External | [owner] | Confirmed / TBD |

## Out of Scope
*What this epic explicitly does not include.*
- [item]
- [item]

---

**⚠️ Open items / TBDs** *(if any gaps remain)*

---

## Features / User Stories
*To be defined as the epic progresses through PLANNING.*
*(Use /grill-me → Product Feature or User Story for each)*

---

## Tone and output guidance

- Write for a roadmap-level audience — product leadership and engineering leads
- Lead every section with the conclusion, not the build-up
- Business Goal and Expected Value sections must name real Madgicx objectives
  from `governance-canonical.md` — no generic language
- Out of Scope is as important as scope — be explicit
- Success Criteria must be outcome-based, not delivery-based
  ("ROAS improves by X%" not "feature is shipped")
- Use `TBD` honestly — never invent numbers or owners
- Use canonical workflow IDs and glossary terms throughout