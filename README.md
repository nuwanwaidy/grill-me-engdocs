# grill-me-engdocs

A structured interview skill for Claude that grills users to produce
governed, canonical Madgicx playbooks — grounded in the AI & Data Strategy,
aligned to the `InitiativeLifecycle`, and contextualised by `governance-canonical.md`.

Every playbook produced is traceable to a Madgicx value stream, business
objective, architecture component, data domain, and workflow — not generic AI output.

What makes grill-me different from a generic AI document generator is that every
interview is strongly grounded in `governance-canonical.md` — the single canonical
context file that captures Madgicx's AI & Data Strategy, value streams, business
objectives, data domains, glossary, and tech stack. Claude doesn't ask generic
questions and fill in blanks. It names your actual domains
(`social_marketing__ad_performance`), your actual systems (PRISM · θCortex ·
DataHub · AgentForge), your actual workflows (`tracking` · `chatwdata` · `budget`),
and your actual objectives (`QualityOfService` · `RiskMitigation`) before you say
them — then drills adaptively based on what's strong, thin, or missing in your
answers. The result is an playbook that speaks Madgicx — not a document that
could have been written for any company.

## Lifecycle

All playbooks follow the Madgicx `InitiativeLifecycle`, driven by the
AI & Data Strategy which is revised annually based on quarterly reporting
on strategic achievements and next-quarter priorities:

```
        ┌─────────────────────────────────────────────┐
        │         AI & Data Strategy (for year=YYYY)  │
        │  revised each year from quarterly reports   │
        └──────────────────┬──────────────────────────┘
                           │
              ┌────────────▼────────────┐
              │   Roadmap & Initiatives  │
              └────────────┬────────────┘
                           │
                    ┌──────▼──────┐
                    │  IDEATION   │  Investigation · Brief
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │  PLANNING   │  PRD · Feature · Epic
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │ IN_PROGRESS │  User Story · Tech Story
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │   REVIEW    │  Release Note
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │  COMPLETED  │  White-paper
                    └──────┬──────┘
                           │
              ┌────────────▼────────────┐
              │   Quarterly Report      │  Strategic achievements Qx
              │   & Next Quarter Plan   │  + next priorities Qx+1
              └────────────┬────────────┘
                           │
                           └──────────────► AI & Data Strategy
                                            (revised for year=YYYY+1)
```

Playbooks hand off to each other. Upload a prior playbook `.md` at the start
of a session and Claude pre-populates context from the `## Handoff` block —
skipping anchors already answered.

Correction loops are supported: upload a Feature into an Epic session
(or vice versa) and Claude detects the correction and updates scope accordingly.

## How it works

1. User types `/grill-me` in Claude
2. Claude reads `SKILL.md` and `config.yml` — asks the review mode then presents the menu
3. User selects a mode and optionally uploads a prior playbook for handoff context
4. Claude reads the sub-skill from `playbooks/<folder>/default-*.md`
5. Claude grills adaptively, grounded in `_context/governance-canonical.md`
6. Claude generates the playbook with a `## Handoff` block for the next session

## Review modes

| Mode | Description |
|---|---|
| `guided` | One question at a time — Claude recommends, user confirms (default) |
| `express` | All questions upfront — user fills answers, Claude generates |
| `auto` | One opening statement — Claude constructs with no back-and-forth |
| `review` | Full guided session → output → Claude walks each section for final confirm/revise |

## Repository structure

```
grill-me-engdocs/
├── README.md                          ← this file
├── SKILL.md                           ← generic router · reads config.yml
├── config.yml                         ← mode registry · lifecycle · handoff chain
├── _context/
│   └── governance-canonical.md        ← generated from github.com/madgicx/datahub
├── playbooks/
│   ├── briefs/
│   │   └── default-brief.md           ← ACTIVE · concept note · IDEATION
│   ├── prd/
│   │   └── default-prd.md             ← coming soon · PLANNING gate
│   ├── features/
│   │   └── default-feature.md         ← ACTIVE · IEEE SRS spec · PLANNING
│   ├── epics/
│   │   └── default-epic.md            ← ACTIVE · sprint components · PLANNING
│   ├── stories/                       ← coming soon · IN_PROGRESS
│   │   ├── default-user-story.md
│   │   └── default-tech-story.md
│   └── investigations/                ← coming soon · IDEATION
│       └── default-investigation.md
├── surveys/
│   └── rating-template.xlsx           ← RICE · Wiegers-Risk · MoSCoW
└── tests/                             ← Evals-Driven Development suite
    ├── README.md                      ← EDD methodology
    ├── evals/
    │   └── universal-grounding.yml    ← UG-01·02·03 · covers all playbooks
    ├── personas/                      ← simulated user types
    │   ├── vague-strategist.md        ← "it improves efficiency"
    │   ├── technical-expert.md        ← precise systems, skips rationale
    │   └── first-timer.md             ← no Madgicx terminology
    └── results/                       ← tracked via Langfuse
```

## Active modes

| # | Mode | Playbook | Lifecycle Stage | Handoff From | Handoff To |
|---|---|---|---|---|---|
| 9 | Investigation | `investigations/default-investigation.md` | IDEATION | Brief · PRD | PRD · Feature |
| 1 | Brief | `briefs/default-brief.md` | IDEATION | — | PRD |
| 2 | PRD | `prd/default-prd.md` | PLANNING | Brief | Epic · Feature |
| 4 | Feature | `features/default-feature.md` | PLANNING | PRD · Brief · Epic | Epic · Stories |
| 3 | Epic | `epics/default-epic.md` | PLANNING | PRD · Brief · Feature | Stories |
| 5 | User Story | `stories/default-user-story.md` | IN_PROGRESS | Feature · Epic | Release Note |
| 6 | Tech Story | `stories/default-tech-story.md` | IN_PROGRESS | Feature · Epic | Release Note |
| 7 | Release Note | `briefs/default-release-note.md` | REVIEW | Stories | White-paper |
| 8 | White-paper | `briefs/default-white-paper.md` | COMPLETED | Release Note · PRD | Quarterly Report |

## Governance context

`_context/governance-canonical.md` grounds every grill-me session in:
- Madgicx value streams (CustomerX · OperX · TrustX)
- Business objectives and signal questions
- `InitiativeLifecycle` stage → playbook mapping
- Data domains and sub-domains
- Canonical glossary (~100 terms with formulas and field names)
- Tech stack — PRISM · θCortex (DataHub is part of the θCortex data fabric
  for governance) · AgentForge

Generated from yml source files in
[github.com/madgicx/datahub](https://github.com/madgicx/datahub)
via CI/CD. Do not edit manually — edit source yml files and regenerate.

## Testing — Evals-Driven Development

grill-me uses **EDD (Evals-Driven Development)** — the LLM equivalent of TDD.
Adversarial personas send weak, vague answers to the skill. Scorers measure
whether the skill drills correctly, names canonical terms proactively, and
pre-populates from prior playbooks. Langfuse traces every eval run alongside
production AgentForge traces.

See `tests/README.md` for the full methodology.

## Rating surveys

`surveys/rating-template.xlsx` provides structured input for priority scoring:

| Tab | Method | Used at | Applies to |
|---|---|---|---|
| RICE | Reach · Impact · Confidence · Effort | Anchor 2 | Brief · Epic · Feature · Stories |
| Wiegers-Risk | Benefit · Penalty · Cost · Risk | F-Anchor 1 | Brief · Epic · Feature · Investigation |
| MoSCoW | Must · Should · Could · Won't | Portfolio | Epic · PRD |

Upload during a session and Claude computes scores automatically.

## Adding a new grill mode

Two steps — `SKILL.md` never needs editing:

1. Create `playbooks/<folder>/default-<name>.md` following an existing mode as reference
2. Add one entry to `config.yml` with `status: active`

The menu builds itself from `config.yml`.

## Adding a domain-specific PRD

The `prd/` folder supports domain-specific variants alongside `default-prd.md`:

```
playbooks/prd/
├── default-prd.md    ← general purpose
├── data-prd.md       ← data platform initiatives
└── ai-prd.md         ← AI/ML product initiatives
```

Add each variant as a separate mode in `config.yml`.

## Installation (manual — until Skills MCP server is live)

```bash
cp -r grill-me-engdocs/ /mnt/skills/organization/
```

Claude picks up the skill automatically on next session.

## Future

- [ ] `playbooks/prd/default-prd.md` — PRD grilling mode (next)
- [ ] `playbooks/stories/default-user-story.md` — User story
- [ ] `playbooks/stories/default-tech-story.md` — Tech story
- [ ] `playbooks/investigations/default-investigation.md` — Spike / discovery
- [ ] `playbooks/briefs/default-release-note.md` — Release note
- [ ] `playbooks/briefs/default-white-paper.md` — White-paper
- [ ] ClickUp governance system — playbook flow · ownership · review alerts (`engdocs` OperX workflow)
- [ ] Migrate to `github.com/madgicx/skills` when org repo is ready
- [ ] Skills MCP server — eliminates manual install step