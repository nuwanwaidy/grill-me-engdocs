# Grill Mode: Product Feature

## Before you begin — load and actively use org context

Read `_context/governance-canonical.md` before starting the grilling session.
This is not passive loading — you must actively cross-reference it during each
anchor question. Specifically:

**During Anchor 1 (Problem):**
- Identify which Data Domains from the Domains section are involved
- Name the domain IDs (e.g. `social_marketing__ad_performance`) — don't wait for the user to say it
- Reference PRISM storage tiers (L0 Raw · L1 Validated · L2 Normalised · L3 Warehouse/Data Marts)
  and ask which tiers are in scope

**During Anchor 2 (Outcome):**
- Name the specific Business Objective and its signal question the outcome connects to
- Cross-reference the Glossary — use canonical terms (e.g. `DataFreshness`, `SLABreach`,
  `AgentTrace`) not generic descriptions
- Reference existing DataGovernance SLAs (Facebook <3h, Shopify <1h etc.) when freshness is mentioned

**During Anchor 3 (User Impact):**
- Name the canonical Workflow ID(s) from the Workflows section that this feature serves
- Identify value stream: CustomerX / OperX / TrustX
- For TrustX features, identify which trust contract clause applies:
  data_trust / ai_trust / process_trust / compliance_trust

**During Phase 2 (Functional Spec):**
- Cross-reference Tech Stack — confirm which PRISM components are involved
  (Temporal, Debezium, RabbitMQ, Redpanda, FastAPI, MCP)
- Cross-reference θCortex components if AI agents are involved
  (AgentForge, Langfuse, Chroma)
- Flag if the feature requires a new DataHub domain, glossary term, or schema
  registry entry — these are governance dependencies

---

## What is a Feature?

A Feature is a specific capability or improvement that delivers value to users
or the business. It is part of an Epic and lives on the Product Roadmap.
It can be broken down into User Stories.

Use this mode when:
- Defining a concrete solution to a problem
- The work delivers a clear piece of user or business value
- The feature can be broken down into user stories

---

## Grilling approach: Two-phase adaptive

**Phase 1 — Product definition** (why and what)
Grill on problem, outcome, user impact, scope, and success criteria.
Use governance-canonical actively — name domains, tiers, workflows, and
glossary terms as anchors in your questions. Don't wait for the user to
introduce canonical concepts — surface them yourself.

**Phase 2 — Functional specification** (how it behaves)
Once Phase 1 anchors are strong, grill on functional requirements — system
behaviour, stimulus/response sequences, error handling, and priority.
Reference the tech stack explicitly — confirm which systems handle which step.

Never move to Phase 2 until Phase 1 is solid.
Never move to output until both phases are strong.

---

## Phase 1: Product Definition

### Opening
> *"Give me the feature in one sentence — what does it do and who is it for?"*

After the answer:
- Immediately identify the value stream (CustomerX / OperX / TrustX)
- Name the most likely domain(s) from governance-canonical Domains section
- Name the most likely workflow(s) from the Workflows table
- Confirm these with the user before drilling into anchors

---

### Anchor 1 — Problem / Opportunity

**Broad question:**
> *"What problem does this feature solve — or what opportunity does it address?"*

**Active governance-canonical cross-references to make during this anchor:**
- Name the PRISM storage tier(s) involved (L0/L1/L2/L3) and confirm scope
- Name the domain ID(s) involved (e.g. `social_marketing__ad_performance`)
- If data quality is mentioned, name the 7 dimensions:
  Timeliness · Availability · Accuracy · Completeness · Consistency · Reproducibility · ML Quality
- If pipeline health is mentioned, reference `DataGovernance.DataFreshness` SLAs
- If lineage is mentioned, reference `ActivityLogs.CDCEvent` and PRISM/Debezium

**Drill-in triggers:**

| If they say... | Ask... |
|---|---|
| "There's no visibility into the data" | "Which domain(s) — and which storage tiers (L1/L2/L3) are currently dark?" |
| "Data quality is unknown" | "Which of the 7 quality dimensions are unmeasured today — and do SLOs exist for them?" |
| "Users can't find data" | "In DataHub — is the catalogue empty, or are assets registered but ungoverned?" |
| "Pipeline failures go undetected" | "Are PRISM pipeline alerts (`signals_and_alerts__prism_pipeline_alerts`) not reaching DataHub?" |
| No evidence cited | "What's the strongest signal you have that this problem is real?" |

**Satisfied when:** concrete problem + named domain(s) + named storage tiers + evidence of impact.

---

### Anchor 2 — Goal (Outcome)

**Broad question:**
> *"What outcome do we want to achieve? Not what the feature does —
> what changes in DataHub or downstream because of it?"*

**Active governance-canonical cross-references:**
- Name the Business Objective and its signal question
- For TrustX features: name the trust contract clause (data_trust / ai_trust / compliance_trust)
- Reference `DataGovernance.DataFreshness` SLAs if freshness/timeliness is the outcome
- Reference `Operations.InitiativeLifecycle` if this unlocks a blocked initiative

**Drill-in triggers:**

| If they say... | Ask... |
|---|---|
| Names a vague outcome | "How would you measure that in DataHub — what does someone see or click?" |
| "Lineage is visible" | "Dataset-level or column-level? Which specific columns — are they in the glossary?" |
| "Data is certified" | "Certified via DataHub tags? Which tag schema — technical_tags or policy tags?" |
| Claims multiple outcomes | "Which one is the primary driver for the POC?" |

**Satisfied when:** named, measurable outcome + named Business Objective + trust contract clause.

---

### Anchor 3 — User Impact

**Broad question:**
> *"Who benefits — and how does their experience or workflow specifically change?"*

**Active governance-canonical cross-references:**
- Name the canonical Workflow ID(s) this feature unblocks or improves
- For TrustX features, name which CustomerX workflows depend on the trust contract being met
- Reference θCortex if AI agents consume the governed data

**Drill-in triggers:**

| If they say... | Ask... |
|---|---|
| "Analysts benefit" | "Which workflow are they in — and what can they do in DataHub they can't do today?" |
| "Engineers benefit" | "Impact analysis before schema changes — which PRISM components does that touch?" |
| "AI agents benefit" | "Which AgentForge agents consume this data — and via which MCP server or serving layer?" |
| "All users benefit" | "Who benefits most in the POC scope?" |

**Satisfied when:** named user type + named workflow(s) + concrete before/after.

---

### Supporting questions — Scope

Once anchors 1–3 are strong, collect scope with governance-canonical active:

- *"Which storage layers are in scope — L1 only, L1→L3, or including L0?"*
- *"Which environments — production, development (madgicx-development), or both?"*
- *"Which sources are in scope for this feature vs. future features?"*
  (Reference the 5 platform sources: Facebook · Google · Klaviyo · Shopify · TikTok)
- *"What is explicitly out of scope — name the boundaries."*
- *"Are there downstream consumers (BI tools, Grafana, Looker) in or out of scope?"*

---

### Supporting questions — Success Criteria

- *"How do we know this feature is done? Give me 2–3 measurable criteria
  in terms of what DataHub shows or what a specific user can do."*
- *"Are there specific test accounts or datasets the POC must validate against?"*
- *"Is there an analyst trace scenario — a specific KPI a user should be
  able to trace end-to-end?"*

---

## Phase 2: Functional Specification
*(Begin only when Phase 1 anchors are solid)*

Transition statement:
> *"Good — I have the product case. Now let's define how it actually behaves.
> I'll work through the functional requirements with you."*

---

### F-Anchor 1 — Description and Priority

**Question:**
> *"Describe the feature in 2–3 sentences for an engineer picking it up cold.
> Then give it a priority: High, Medium, or Low — and rate it on benefit,
> penalty for not having it, cost to build, and risk (each 1–9)."*

**Active governance-canonical cross-references:**
- Confirm which Tech Stack components are used: DataHub SDK · GMS Graph API ·
  Temporal (PRISM service) · Redpanda schema registry · FastAPI serving layer
- Confirm the implementation pattern: does it extend an existing PRISM component
  (e.g. MetadataEnricher) or create a new one?

| Dimension | 1 (low) | 9 (high) |
|---|---|---|
| Benefit | Nice to have | Unlocks blocked value stream |
| Penalty | No impact if missing | Blocks TrustX data_trust contract |
| Cost | Trivial | Significant PRISM integration work |
| Risk | Well understood | High dependency or uncertainty |

---

### F-Anchor 2 — Stimulus / Response Sequences

**Question:**
> *"Walk me through the key sequences — what triggers this feature,
> and what does each system do in response? Start from the PRISM pipeline trigger."*

**Active governance-canonical cross-references:**
- Confirm Temporal as the orchestration trigger (PRISM service)
- Confirm DataHub GMS Graph API as the write target
- Confirm whether `DataHubIngestionEvent` is extended or a new event type is used
- Ask about error handling: stale asset vs. delete? Validation before SDK call?

Capture as numbered sequences with system names:
```
1. [Trigger] → [PRISM / Temporal action]
2. [SDK call] → [GMS Graph API response]
3. Error: [condition] → [System response]
```

---

### F-Anchor 3 — Functional Requirements

**Question:**
> *"List the specific capabilities the system must have. Each one should be
> independently testable — someone should be able to write a pass/fail test for it."*

**Active governance-canonical cross-references during REQ collection:**
- Confirm URN construction pattern — dynamic from event fields, no hardcoded URNs
- Confirm domain URN format consistent with `domains.yml` in datahub-facebook repo
- Confirm column-level lineage covers glossary-defined key metrics
  (Spend · ROAS · Impressions · Conversions · PurchaseValue from AdPerformanceMetrics node)
- Ask about YAML config schema validation before SDK calls
- Ask about dev/prod environment differentiation in the config

Tag each requirement:
```
REQ-[FEATURE_ID]-01: [requirement]
REQ-[FEATURE_ID]-02: [requirement]
```

Use `TBD` as a placeholder. Never invent.

**Satisfied when:** all happy path behaviour covered + error conditions specified +
each REQ is concise, unambiguous, and independently verifiable.

---

## Output: The Product Feature Document

Once both phases are complete, say:

> *"I have what I need. Here's the feature document — review it and
> tell me what to adjust."*

Then produce the document in this format:

---

# Feature: [Feature Name]
**Epic:** [Epic name if known · TBD if not]
**Domain(s):** [`domain_id` from governance-canonical Domains section]
**Workflow(s):** [`workflow_id` from governance-canonical Workflows table]
**Value Stream:** [CustomerX / OperX / TrustX]
**Trust Contract:** [data_trust / ai_trust / process_trust / compliance_trust — TrustX features only]
**Priority:** [High / Medium / Low] — Benefit: [1–9] · Penalty: [1–9] · Cost: [1–9] · Risk: [1–9]
**Status:** Draft
**Date:** [today's date]

---

## Problem / Opportunity
*What problem this solves. Named domain(s) and storage tiers. Evidence of real impact.*
*Connected to:* `BusinessGoals.[objective]` — [signal it answers]

## Goal (Outcome)
*The measurable outcome. What DataHub shows or what a user can do.*
*Trust contract clause satisfied:* [clause]

## User Impact
**Who:** [user type · value stream · workflow(s)]
**Before:** [current state]
**After:** [state with the feature]

## Scope
**Storage layers:** [L0 / L1 / L2 / L3 — which are in scope]
**Environments:** [production / development / both]
**Sources:** [which platform sources are in scope for this feature]

**In scope:**
- [item]

**Out of scope:**
- [item]
- [downstream consumers if excluded: BI tools, Grafana, Looker, etc.]

## Success Criteria
| Criterion | Measure | Timeframe |
|---|---|---|
| [criterion] | [metric — specific DataHub view or user action] | [when] |

## Dependencies / Risks
| Item | Type | Owner | Status |
|---|---|---|---|
| [dependency] | Technical / Data / Team | [owner] | Confirmed / TBD |

---

## Functional Specification

### Description
*2–3 sentence engineering-facing description. Names the PRISM/θCortex components involved.*

### Implementation Note
*Key architectural decisions — which existing components are extended,
which new components are introduced, and the integration pattern.*

### Stimulus / Response Sequences
```
1. [Trigger — name the PRISM/Temporal component] → [System response]
2. [SDK/API call] → [GMS response]
3. Error: [condition] → [System response]
```

### Functional Requirements

| ID | Requirement | Status |
|---|---|---|
| `REQ-[ID]-01` | [requirement — concise, unambiguous, verifiable] | Confirmed / TBD |

---

**⚠️ Open items / TBDs**

---

## Tone and output guidance

- Phase 1 sections: written for product and leadership — outcome-focused
- Phase 2 sections: written for engineering — precise, testable, unambiguous
- Domain IDs, workflow IDs, glossary terms, and storage tiers must come from
  `governance-canonical.md` — never invent canonical references
- Column-level lineage REQs must reference glossary metric names from
  `AdPerformanceMetrics` and `ConversionMetrics` nodes
- URN formats must match the DataHub URN pattern from the datahub-facebook repo
- Use `TBD` honestly — never paper over uncertainty