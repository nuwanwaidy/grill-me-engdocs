# tests/ — Evals-Driven Development for grill-me

## Methodology: Evals-Driven Development (EDD)

EDD is the LLM equivalent of Test-Driven Development (TDD). Instead of
asserting deterministic function outputs, we evaluate LLM behaviour through
scored conversations. The eval loop:

  1. A persona simulates a user with a specific answering pattern
  2. The skill (Claude + playbook .md + governance-canonical.md) responds
  3. A judge scores the response against universal criteria
  4. Results are traced via Langfuse alongside production AgentForge traces
  5. Eval passes when all criteria meet 0.95 threshold within turn budget
  6. If eval fails: update the playbook file and re-run (RED → GREEN)

**Why EDD and not TDD:**
grill-me is a conversational skill — outputs are not deterministic. What
matters is behaviour: did the skill name a canonical domain proactively?
Did it drill on a vague answer? Did it pre-populate from a prior handoff?
EDD measures behaviour through scoring, not assertion.

**Why adversarial personas:**
A skill that only works when users give perfect answers is not a skill — it
is a template. Personas simulate real user behaviour: the strategist who
speaks in generalities, the first-timer who doesn't know Madgicx terminology,
the expert who front-loads technical detail but skips business rationale.

**Why multi-turn with a turn budget:**
Turn budget measures efficiency — a skill that grounds output in 1 turn is
better than one that takes 5. Both may eventually pass; only one is good.

---

## Universal grounding contract

Every playbook active in config.yml must satisfy three behaviours (UG-01–03).
Adding a new playbook requires no new eval files — this suite covers it.

See `evals/universal-grounding.yml` for the full specification.

---

## Structure

```
tests/
├── README.md                          ← this file
├── evals/
│   └── universal-grounding.yml        ← UG-01·02·03 · covers all playbooks
├── personas/
│   ├── vague-strategist.md            ← "it improves efficiency"
│   ├── technical-expert.md            ← precise systems, skips business rationale
│   └── first-timer.md                 ← no Madgicx terminology
└── results/                           ← tracked via Langfuse
    └── .gitkeep
```

---

## Running

Runner implementation is parked pending tooling decision.
See `evals/universal-grounding.yml` for the eval specifications.
Personas are defined in `personas/`.