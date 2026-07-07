# Runbook: Adding a New Mode

**When to use this:** You want to add a new artefact type to the grill-me
menu — a new document type, a domain-specific variant, or a coming-soon
placeholder you are activating.

**What you will NOT need to touch:** `SKILL.md`. The router builds itself
from `config.yml`. If you find yourself editing `SKILL.md` to add a mode,
stop — something is wrong. See [`modify-skill.md`](modify-skill.md).

---

## Checklist

```
[ ] 1. Design the mode
[ ] 2. Create the mode file in modes/<folder>/
[ ] 3. Add the config.yml entry
[ ] 4. Add or update OVR rules
[ ] 5. Choose and configure the rating method
[ ] 6. Set the page budget (OVR-10)
[ ] 7. Update the folder conventions comment in config.yml (if new folder)
[ ] 8. Update README.md active modes table and repo tree
[ ] 9. Update docs/productwiki/architecture.md OVR table and rating methods table
[ ] 10. Verify universal grounding applies automatically
[ ] 11. Re-upload the skill in Claude.ai Settings → Skills
```

---

## Step 1 — Design the mode

Answer these questions before writing anything:

**Lifecycle position**
- Which `InitiativeLifecycle` stage does this artefact belong to?
  (`IDEATION · PLANNING · IN_PROGRESS · REVIEW · COMPLETED`)
- What artefact triggers this one (`handoff_accepts`)?
- What artefact does this one hand off to (`handoff_produces`)?

**Lifecycle gate**
- Does this artefact require an upstream Brief before anchoring can begin?
  If yes: set `requires_brief: true` in config.yml and add the mode to
  OVR-08's `applies_to` list.

**Rating method**
- Is this artefact being **prioritised for investment**? → use `rice` and/or `wiegers`
- Is this a **specification document** being evaluated for quality? → use `ssqs`
- Is this purely narrative (release note, white-paper)? → `rating_methods: []`
- See the rating method decision table in [`../productwiki/architecture.md`](../productwiki/architecture.md)

**Page budget**
- How many A4 pages should the output fit? (~500 words/page; diagrams = 1 page each)
- This becomes the OVR-10 entry for this mode

**Sequence diagram**
- Does this artefact include a Mermaid sequence diagram?
  If yes: add the mode to OVR-07's `applies_to` list

---

## Step 2 — Create the mode file

### File location

```
modes/<folder>/default-<name>.md
```

Use an existing active mode file as a reference. The closest structural match:
- Narrative artefact (brief, release note) → copy `modes/briefs/default-brief.md`
- Functional spec with REQs → copy `modes/features/default-feature.md`
- System specification → copy `modes/specs/default-spec.md`
- Investigation/spike → copy `modes/investigations/default-investigation.md` (coming soon)

### Required sections (in order)

Every mode file must contain these sections:

```markdown
# Grill Mode: [Name]

## Before you begin — load and actively use org context
## What is a [Name]?
## Grilling approach: [description]
## Opening
## Anchor 1 — [Name]
## Anchor N — [Name]
## [Rating anchor] — [RICE / Wiegers / SSQS]
## Output: The [Artefact] Document
# [Artefact]: [Name]          ← output template starts here
## SIEM Policy Reference (F5)
## Handoff
## Output Schema (F7)
## Tone and output guidance
```

### Anchor naming convention

| Pattern | Use when |
|---|---|
| `Anchor N` | Standard content anchor |
| `F-Anchor N` | Feature-specific anchor (functional spec phase) |
| `S-Anchor N` | Spec-specific anchor (SSQS scoring gate) |

### Handoff block

The `## Handoff` table must include at minimum:

```markdown
| Artefact              | [mode id]                  |
| Title                 | [artefact name]            |
| Initiative            | [from Brief if known]      |
| Value Stream          | [CustomerX/OperX/TrustX]   |
| Business Objective(s) | [from canonical]           |
| Domain(s)             | [domain IDs]               |
| Workflow(s)           | [workflow IDs]             |
| Status                | [Draft / Approved]         |
| Produces              | [next mode id(s)]          |
| Stored                | [ClickUp URL — TBD]        |
```

Add rating-specific fields (RICE Score / Wiegers Value / SSQS) matching
whatever `rating_methods` the mode uses.

### Output Schema (F7)

Every mode file ends with an `## Output Schema (F7)` table. The table must
include a row for every OVR rule that applies to this mode. Use this template:

```markdown
| # | Check | Required |
|---|---|---|
| 1 | Metadata table present | Yes |
| … | … | Yes |
| N | At least one BusinessGoals.* term named (OVR-01) | Yes |
| N | At least one Workflow ID named (OVR-02) | Yes |
| N | At least one SIEM policy term cited (OVR-03) | Yes |
| N | [rating method check — OVR-04/05/09] | Yes |
| N | Handoff block present (OVR-06) | Yes |
| N | [sequence diagram check — OVR-07, if applicable] | Yes |
| N | Output within page budget (OVR-10) | Yes |
```

---

## Step 3 — Add the config.yml entry

Add a new block under `modes:`. All fields are required:

```yaml
- id: default-<name>
  menu_number: <next available integer>
  label: "<Display Name>"
  description: "<one-line description of what the user gets>"
  triggers:
    - "<menu_number as string>"
    - "<name>"
    - "default <name>"
    # add common phrases users might type
  path: "modes/<folder>/default-<name>.md"
  status: active                          # or coming_soon
  requires_brief: true                    # only if gated — omit if not
  folder: <folder>
  lifecycle_stage: <IDEATION|PLANNING|IN_PROGRESS|REVIEW|COMPLETED>
  handoff_accepts: [<list of mode ids>]   # [] if first in chain
  handoff_produces: [<list of mode ids>]  # [] if last in chain
  review_modes: [guided, express, auto, review]
  default_review_mode: guided
  rating_methods: [<rice|wiegers|moscow|ssqs>]   # [] if none
  supports_upload: [prior_artefact]       # add rating_table if upload scoring supported
```

If you are activating a `coming_soon` mode: change `status: coming_soon` to
`status: active`. Do not change any other fields unless intentional.

---

## Step 4 — Add or update OVR rules

### Do you need a new OVR rule?

A new OVR rule is needed when:
- The new mode introduces a **new quality gate** not covered by existing rules
  (e.g. SSQS was a new gate for Spec — became OVR-09)
- The new mode has a **structural requirement** that existing rules don't capture

A new OVR rule is NOT needed when:
- The new mode reuses an existing rating method (rice, wiegers) — just add it
  to the existing OVR-04 or OVR-05 `applies_to` list
- The new mode should satisfy an existing rule — add it to `applies_to`

### Updating applies_to on existing rules

Check every existing OVR rule and ask: should this rule apply to the new mode?

| OVR | Check |
|---|---|
| OVR-01 | Almost always `all` — only exclude if artefact has no business objective |
| OVR-02 | Almost always `all` — only exclude narrative artefacts with no workflow |
| OVR-03 | Always `all` |
| OVR-04 | Add if mode uses `rice` |
| OVR-05 | Add if mode uses `wiegers` |
| OVR-06 | Always `all` |
| OVR-07 | Add if mode produces a sequence diagram |
| OVR-08 | Add if mode has `requires_brief: true` |
| OVR-09 | Add if mode uses `ssqs` |
| OVR-10 | Always `all` — add page budget line to the rule's description table |

### Adding OVR-10 page budget

OVR-10 contains a page budget table in its `description`. Add a line:

```yaml
        default-<name>       ≤ N pages
```

Page budget guidelines:
- Single-concept, single-decision artefacts (story, release note): 1 page
- Concept notes (brief, investigation): 2–3 pages
- Requirement artefacts (epic, feature): 3 pages
- Requirement documents with context (PRD): 5 pages
- System specifications: up to 15 pages
- Long-form position documents (white-paper): up to 10 pages

---

## Step 5 — Choose and configure the rating method

### Decision table

| Artefact type | Right method | Reason |
|---|---|---|
| Initiative prioritisation (brief, prd, epic, feature, investigation) | `wiegers` and/or `rice` | Measures investment value — benefit vs cost/risk |
| System specification | `ssqs` | Measures document quality — ISO/IEC/IEEE 29148 |
| Narrative output (release note, white-paper) | none (`[]`) | No scoring needed |
| User/tech story | `rice` only | Scope is too small for Wiegers |

### Configuring the rating anchor in the mode file

Every mode with a rating method needs a dedicated anchor section that:
1. Names the method and its purpose
2. Defines the 1–5 scale inline before asking each dimension
3. Computes the composite score
4. States the gate threshold (if any)

For RICE: go at Anchor 2 (opportunity sizing).
For Wiegers: go at Anchor 3 or F-Anchor 1 (risk/priority).
For SSQS: go at S-Anchor 1 (spec quality gate, last anchor before output).

The `## Output Schema (F7)` table must include a check row for the rating
score (e.g. "SSQS composite ≥ 3.5 and all dimensions ≥ 3").

---

## Step 6 — Verify universal grounding applies automatically

Universal grounding (UG-01–03) applies to every active mode automatically.
You do not need to create new eval files.

Mentally verify:
- Does the mode file's **Opening** instruct Claude to name canonical terms
  proactively? (UG-01)
- Do the anchor **drill-in triggers** push back on vague answers? (UG-02)
- Does the **Before you begin** section instruct Claude to read the Handoff
  block on upload and announce pre-populated fields? (UG-03)

If any of these are missing from the mode file, add them before activating.
See [`eval-universal-grounding.md`](eval-universal-grounding.md) for the
full manual verification protocol.

---

## Step 7 — Update README.md and architecture.md

In `README.md`:
- Add a row to the **Active modes** table (or move from coming_soon to active)
- Add a line to the **Repository structure** tree

In `docs/productwiki/architecture.md`:
- Add a row to the OVR rules table if a new OVR was added
- Add a row to the rating methods table if a new method was added

---

## Step 8 — Re-upload the skill

Skills are read-only at `/mnt/skills/`. Changes require a GitHub push and
re-upload via **Claude.ai → Settings → Skills**.

```
1. Commit and push changes to github.com/nuwanwaidya/grill-me-engdocs
2. In Claude.ai: Settings → Skills → grill-me-engdocs → Re-upload
3. Open a new Claude session and verify the mode appears in the menu
4. Test with at least one vague opening answer to confirm UG-01 fires
```
