# grill-me-engdocs

A structured interview skill for Claude that grills users to produce
governed, canonical Madgicx artefacts — grounded in the AI & Data Strategy,
aligned to the `InitiativeLifecycle`, and contextualised by `governance-canonical.md`.

Every artefact produced is traceable to a Madgicx value stream, business
objective, architecture component, data domain, and workflow — not generic AI output.

What makes grill-me different from a generic AI document generator: every
session is grounded in `governance-canonical.md`. Claude names your actual
domains (`social_marketing__ad_performance`), your actual systems
(PRISM · θCortex · AgentForge · mdx-gov-hub), your actual workflows, and your
actual objectives before you say them — then drills adaptively based on what's
strong, thin, or missing in your answers.

---

## Lifecycle

All artefacts follow the Madgicx `InitiativeLifecycle`:

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
                    │  PLANNING   │  PRD · Spec · Feature · Epic
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

Artefacts hand off to each other via a `## Handoff` block. Upload a prior
artefact `.md` at the start of a session and Claude pre-populates matched
anchors — skipping what's already been answered.

---

## How it works

1. User types `/grill-me-engdocs` in Claude
2. Claude reads `SKILL.md` and `config.yml` — asks the review mode, presents the menu
3. User selects a mode and optionally uploads a prior artefact for handoff context
4. Claude reads the mode file at `modes/<folder>/default-*.md`
5. Claude grills adaptively, grounded in `_context/governance-canonical.md`
6. Claude validates output against OVR rules, then presents the artefact with a `## Handoff` block

---

## Review modes

| Mode | Description |
|---|---|
| `guided` | One question at a time — Claude recommends, user confirms (default) |
| `express` | All questions upfront — user fills answers, Claude generates |
| `auto` | One opening statement — Claude constructs with no back-and-forth |
| `review` | Full guided session → output → Claude walks each section for final confirm/revise |

---

## Active modes

| # | Mode | File | Stage | From | To | Status |
|---|---|---|---|---|---|---|
| 1 | Brief | `modes/briefs/default-brief.md` | IDEATION | — | PRD | ✅ active |
| 2 | PRD | `modes/prd/default-prd.md` | PLANNING | Brief | Epic · Feature | 🔜 coming soon |
| 3 | Epic | `modes/epics/default-epic.md` | PLANNING | PRD · Brief | Stories | ✅ active |
| 4 | Feature | `modes/features/default-feature.md` | PLANNING | PRD · Brief | Epic · Stories | ✅ active |
| 5 | User Story | `modes/stories/default-user-story.md` | IN_PROGRESS | Feature · Epic | Release Note | 🔜 coming soon |
| 6 | Tech Story | `modes/stories/default-tech-story.md` | IN_PROGRESS | Feature · Epic | Release Note | 🔜 coming soon |
| 7 | Release Note | `modes/briefs/default-release-note.md` | REVIEW | Stories | White-paper | 🔜 coming soon |
| 8 | White-paper | `modes/briefs/default-white-paper.md` | COMPLETED | Release Note · PRD | — | 🔜 coming soon |
| 9 | Investigation | `modes/investigations/default-investigation.md` | IDEATION | Brief · PRD | PRD · Feature | 🔜 coming soon |
| 10 | Spec | `modes/specs/default-spec.md` | PLANNING | Brief · PRD | Epic · Feature | ✅ active |

---

## Repository structure

```
grill-me-engdocs/
├── README.md                          ← this file
├── SKILL.md                           ← generic router · reads config.yml
├── config.yml                         ← mode registry · OVR rules · handoff chain
├── _context/
│   └── governance-canonical.md        ← CI-generated · do not edit manually
├── modes/
│   ├── briefs/
│   │   └── default-brief.md           ← ACTIVE · concept note · IDEATION
│   ├── prd/
│   │   └── default-prd.md             ← coming soon · PLANNING gate
│   ├── epics/
│   │   └── default-epic.md            ← ACTIVE · sprint components · PLANNING
│   ├── features/
│   │   └── default-feature.md         ← ACTIVE · functional spec · PLANNING
│   ├── specs/
│   │   └── default-spec.md            ← ACTIVE · IEEE SRS-style spec · PLANNING
│   ├── stories/                       ← coming soon · IN_PROGRESS
│   │   ├── default-user-story.md
│   │   └── default-tech-story.md
│   └── investigations/                ← coming soon · IDEATION
│       └── default-investigation.md
├── surveys/
│   └── rating-template.xlsx           ← RICE · Wiegers-Risk · MoSCoW
├── tests/                             ← Evals-Driven Development suite
│   ├── README.md                      ← EDD methodology
│   ├── evals/
│   │   └── universal-grounding.yml    ← UG-01·02·03 · covers all active modes
│   ├── personas/
│   │   ├── vague-strategist.md
│   │   ├── technical-expert.md
│   │   └── first-timer.md
│   └── results/                       ← tracked via Langfuse (runner pending)
└── docs/
    ├── productwiki/
    │   └── architecture.md            ← architecture · components · design decisions
    └── runbooks/
        ├── adding-new-mode.md         ← end-to-end checklist for new modes
        ├── modify-skill.md            ← safe vs high-risk changes to the router
        └── eval-universal-grounding.md ← UG eval protocol · current status
```

---

## Documentation

| Document | What it covers |
|---|---|
| [`docs/productwiki/architecture.md`](docs/productwiki/architecture.md) | Architecture — components, OVR rules, rating methods, handoff chain, feature flags, canonical grounding |
| [`docs/runbooks/adding-new-mode.md`](docs/runbooks/adding-new-mode.md) | End-to-end checklist for adding a new artefact type |
| [`docs/runbooks/modify-skill.md`](docs/runbooks/modify-skill.md) | When and how to safely edit `SKILL.md` |
| [`docs/runbooks/eval-universal-grounding.md`](docs/runbooks/eval-universal-grounding.md) | UG-01·02·03 evaluation protocol and current runner status |
| [`tests/README.md`](tests/README.md) | Evals-Driven Development methodology |

---

## Governance context

`_context/governance-canonical.md` grounds every session. It is
**CI-generated** from YAML source files in
`github.com/Madgicx/madgicx-governance-hub` via `generate_canonical.py`.
Do not edit manually — edit source yml files and regenerate.

---

## Rating surveys

`surveys/rating-template.xlsx` — upload during a session for automatic scoring:

| Tab | Method | Anchor | Applies to |
|---|---|---|---|
| RICE | Reach · Impact · Confidence · Effort | Anchor 2 | Brief · Epic · Feature |
| Wiegers-Risk | Benefit · Penalty · Cost · Risk | Anchor 3 / F-Anchor 1 | Brief · Epic · Feature · Investigation |
| MoSCoW | Must · Should · Could · Won't | Portfolio | Epic · PRD |

SSQS (Spec quality score) is always scored in-session — no survey tab.

---

## Installation

```bash
cp -r grill-me-engdocs/ /mnt/skills/organization/
```

Or re-upload via **Claude.ai → Settings → Skills** after pushing to GitHub.

---

## Future

- [ ] Activate `prd/`, `stories/`, `investigations/`, `briefs/release-note`, `briefs/white-paper`
- [ ] Add SSQS tab to `surveys/rating-template.xlsx`
- [ ] Universal grounding automated runner — Langfuse integration
- [ ] ClickUp governance system — artefact flow · ownership · review alerts
- [ ] Migrate to `github.com/madgicx/skills` when org repo is ready
- [ ] Skills MCP server — eliminates manual install step
