# grill-me

A structured interview skill for Claude that grills users to produce
governed, canonical Madgicx artefacts — concept notes, PRDs, epics,
release notes, white-papers, and any artefact requiring leadership
sign-off or governance review.

## How it works

1. User types `/grill-me` in Claude
2. Claude reads `SKILL.md` — presents the menu of available modes
3. User selects a mode (e.g. Product Brief)
4. Claude reads the corresponding `briefs/*.md` sub-skill
5. Claude grills the user adaptively, grounded in `_context/governance-canonical.md`
6. Claude generates the final artefact

## Repository structure

```
grill-me/
├── README.md                        ← this file
├── SKILL.md                         ← entry point · menu · routing logic
├── briefs/
│   ├── product-brief.md             ← concept note for leadership review
│   └── [future]                     ← prd.md · epic.md · release-note.md · ...
└── _context/
    └── governance-canonical.md      ← generated from github.com/madgicx/datahub
                                        via CI/CD · do not edit manually
```

## Governance context

`_context/governance-canonical.md` is the single file that grounds all grill-me
sessions in Madgicx canonical terminology, value streams, business objectives,
data domains, glossary, and tech stack.

It is **generated** from the yml source files in
[github.com/madgicx/datahub](https://github.com/madgicx/datahub)
via CI/CD pipeline. Do not edit it manually here — changes must be made
to the source yml files in the datahub repository.

## Adding a new grill mode

1. Create `briefs/<artefact-name>.md` following the structure of `product-brief.md`
2. Add a row to the menu table in `SKILL.md`
3. Add a row to the routing table in `SKILL.md`
4. Submit a PR — no other changes needed

## Installation (manual — until Skills MCP server is live)

Copy the contents of this repo to:
```
/mnt/skills/organization/grill-me/
```

Claude will pick up the skill automatically on next session.

## Roadmap

- [ ] `briefs/prd.md` — PRD grilling mode
- [ ] `briefs/epic.md` — Epic grilling mode
- [ ] `briefs/release-note.md` — Release note generation
- [ ] `briefs/white-paper.md` — White-paper / position paper
- [ ] Migrate to `github.com/madgicx/skills` when org repo is ready
- [ ] Serve via Skills MCP server — eliminates manual install step