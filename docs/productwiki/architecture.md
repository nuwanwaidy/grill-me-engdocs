# grill-me-engdocs — Architecture

This document describes how the skill is structured, how its components
interact, and the design decisions behind them. It is the reference for
anyone building on, extending, or maintaining grill-me-engdocs.

For how to perform specific tasks see [`../runbooks/`](../runbooks/).
For orientation see [`../../README.md`](../../README.md).

---

## Components

```
grill-me-engdocs/
├── SKILL.md                           ← Generic router — entry point
├── config.yml                         ← Mode registry · OVR rules · handoff chain
├── _context/
│   └── governance-canonical.md        ← Canonical grounding context (CI-generated)
├── modes/
│   ├── briefs/
│   ├── prd/
│   ├── epics/
│   ├── features/
│   ├── stories/
│   ├── investigations/
│   └── specs/
├── surveys/
│   └── rating-template.xlsx
├── tests/
│   ├── evals/
│   ├── personas/
│   └── results/
└── docs/
    ├── productwiki/
    │   └── architecture.md            ← this file
    └── runbooks/
```

---

## SKILL.md — the router

`SKILL.md` is the single entry point. It is intentionally generic — it never
contains mode-specific logic. Its job is to:

1. Read `config.yml` to build the menu
2. Ask the user for a review mode
3. Present the mode menu
4. Enforce the lifecycle gate (F1) — require a Brief for gated modes
5. Route to the correct mode file at `config.yml → path`
6. Apply F6 (canonical term suggestion UI) at every bounded-category question
7. Run F7 output schema validation before presenting any output

`SKILL.md` must never be edited to add a new mode. Adding a mode means
adding a `config.yml` entry and a file in `modes/` — nothing else. See
[`../runbooks/adding-new-mode.md`](../runbooks/adding-new-mode.md).

For guidance on when and how to edit `SKILL.md` itself, see
[`../runbooks/modify-skill.md`](../runbooks/modify-skill.md).

---

## config.yml — the registry

`config.yml` is the single source of truth for:

- All available modes (active and coming_soon)
- Lifecycle stage per mode
- Handoff chain (what each mode accepts and produces)
- Rating methods per mode (`rice` · `wiegers` · `moscow` · `ssqs`)
- Output validation rules (OVR-01 through OVR-10)
- Page budget per mode (via OVR-10)

### OVR rules

Output Validation Rules fire before any output is presented to the user.
`SKILL.md` reads `output_validation_rules` from `config.yml` and checks
every rule whose `applies_to` matches the active mode.

Rules currently in effect:

| ID | Description | Scope |
|---|---|---|
| OVR-01 | At least one `BusinessGoals.*` term named | all |
| OVR-02 | At least one Workflow ID named | all |
| OVR-03 | At least one SIEM policy term cited | all |
| OVR-04 | RICE score computed (all four components) | Brief · PRD · Epic · Feature |
| OVR-05 | Wiegers score computed (all four dimensions, 1–5) | Brief · PRD · Epic · Feature · Investigation |
| OVR-06 | Handoff block present with all fields populated | all |
| OVR-07 | Sequence diagram present | Epic · Feature |
| OVR-08 | Upstream Brief loaded before anchoring | Epic · Feature · Spec |
| OVR-09 | SSQS composite ≥ 3.5 and all four dimensions ≥ 3 | Spec |
| OVR-10 | Output length within page budget | all |

### Rating methods

| Method | Formula | Applies to |
|---|---|---|
| `rice` | (Reach × Impact × Confidence) / Effort | Brief · PRD · Epic · Feature |
| `wiegers` | (Benefit + Penalty) / (Cost + Risk) | Brief · PRD · Epic · Feature · Investigation |
| `moscow` | Must · Should · Could · Won't | Epic · PRD |
| `ssqs` | (Completeness + Verifiability + Traceability + Consistency) / 4 | Spec |

`ssqs` is derived from ISO/IEC/IEEE 29148 (supersedes IEEE 830). It replaces
both RICE and Wiegers for the Spec mode because a specification is not being
prioritised for investment — it is being evaluated for document quality.

---

## Modes

Each mode file is a self-contained grilling script for one artefact type.
A mode file defines:

- **Pre-session setup** — what to load, what to check for in uploads
- **Opening** — the first question and how to process the answer
- **Anchors** — the structured grilling sequence (each with drill-in triggers)
- **Scoring anchor** — where the rating method is computed (RICE / Wiegers / SSQS)
- **Output template** — the exact structure of the generated artefact
- **SIEM Policy Reference block** — F5 requirement — every output cites ≥1 term
- **Handoff block** — structured fields for the next session to consume
- **Output Schema** — F7 checklist validated before output is presented

### Anchor naming conventions

| Convention | Used in | Purpose |
|---|---|---|
| `Anchor N` | Brief · Epic · Feature | Sequential content anchors |
| `F-Anchor N` | Feature | Feature-specific anchors (functional spec phase) |
| `S-Anchor N` | Spec | Spec-specific scoring anchor (SSQS gate) |

### Handoff chain

Every mode produces a `## Handoff` block. The next mode in the chain
reads this block on upload and pre-populates matching anchors. Fields that are
pre-populated are not re-asked.

```
Brief → PRD → Epic ──► User Story → Release Note → White-paper
           └→ Feature → Epic
           └→ Spec → Epic
                    └→ Feature
```

Correction loops are supported: uploading a Feature into an Epic session (or
vice versa) triggers a correction path — Claude detects the mismatch and asks
what changed.

---

## Canonical grounding

`_context/governance-canonical.md` is the single document Claude actively
cross-references throughout every session. It is **not** loaded passively —
the mode files instruct Claude to name canonical terms proactively before the
user introduces them.

The file contains:
- Value streams (CustomerX · OperX · TrustX)
- Business objectives with signal questions
- `InitiativeLifecycle` stage → artefact mapping
- Data domains and sub-domains with IDs
- Workflows with IDs
- Platform capabilities (PLAT-CAP-01..28)
- SIEM canonical family (SEC-POL · SEC-STD · SEC-RB · SEC-SOP)
- Tech stack — PRISM · θCortex · AgentForge · mdx-gov-hub
- Canonical glossary (~190 terms)

**This file is CI-generated.** It is produced from YAML source files in
`github.com/Madgicx/madgicx-governance-hub` via `generate_canonical.py`
and synced here by `sync-canonical.yml`. Do not edit it manually.

---

## Universal Grounding Contract

Every active mode must satisfy three behaviours defined in
`tests/evals/universal-grounding.yml`:

| ID | Behaviour | Turn budget | Threshold |
|---|---|---|---|
| UG-01 | Proactive canonical grounding — names a canonical term in turn 1 | 1 | 0.95 |
| UG-02 | Drill on vague — pushes back and uses a canonical signal question | 3 | 0.90 |
| UG-03 | Handoff pre-population — reads Handoff block and skips answered anchors | 1 | 0.95 |

New modes are automatically covered by this suite — no new eval files needed.
The runner is parked pending tooling decision. See
[`../runbooks/eval-universal-grounding.md`](../runbooks/eval-universal-grounding.md).

---

## Surveys

`surveys/rating-template.xlsx` provides structured scoring input. Uploading
it during a session allows Claude to compute scores automatically from the
relevant tab rather than estimating through dialogue.

| Tab | Method | Used at anchor |
|---|---|---|
| RICE | Reach · Impact · Confidence · Effort | Anchor 2 (Brief · Epic · Feature) |
| Wiegers-Risk | Benefit · Penalty · Cost · Risk | Anchor 3 / F-Anchor 1 |
| MoSCoW | Must · Should · Could · Won't | Epic · PRD |

SSQS is always scored in-session (no survey tab) — the four dimensions
require a conversation to assess, not a spreadsheet.

---

## Feature flags (F1–F7)

The mode files reference features by ID. These correspond to implemented
behaviours in `SKILL.md`:

| ID | Feature | Where enforced |
|---|---|---|
| F1 | Lifecycle gate — Brief required before Epic/Feature/Spec | SKILL.md Step 4 |
| F2 | Brief hydration via ClickUp URL or `.md` upload | SKILL.md Step 4 |
| F5 | Mandatory SIEM policy term in every output | OVR-03 + mode SIEM block |
| F6 | Canonical term suggestion UI (List / Suggest / Type) | SKILL.md Step 7 |
| F7 | Per-artefact output schema validation | SKILL.md Step 9 |
