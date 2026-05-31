# governance-canonical.md — Madgicx Governing Context
<!-- ==========================================================================
     Source:       GitHub / datahub-facebook project (yml source files)
     Version:      0.2
     Generated:    May 2026
     Owner:        AI & Data Strategy / devx-data
     Pipeline:     CI/CD — auto-generated from DataHub yml source files.
                   Do NOT edit manually. Edit source files in the
                   datahub-facebook GitHub repository and trigger CI/CD
                   to regenerate this file.

     Usage by skills:
       Load this single file to ground any skill output in canonical Madgicx
       terminology, strategy, and architecture. One file — always current —
       always canonical.

       Skills that use this file:
         - grill-me — product briefs, PRDs, epics, release notes, white-papers,
           and any artefact generated through a structured design process
         - Any AgentForge agent or skill.md requiring Madgicx context
     ========================================================================== -->

---

## Vision

> "Empowering every person at Madgicx and our users to unlock their full potential
> by transforming data into a trusted strategic asset — seamlessly delivering
> AI-powered intelligence and operational excellence that amplifies the quality
> of experience for all."

*Note: This vision is intentionally inclusive of both external users (CustomerX)
and internal teams (OperX). Trusted AI & Data (TrustX) is the governed foundation
that makes both possible.*

---

## Business Objectives

Six objectives define whether something is worth building at Madgicx.
Every initiative — whether CustomerX, OperX, or TrustX — must connect clearly
to at least one. Equal weighting — no objective outranks another. Top-3 ranking
per workflow and brief reflects relative fit, not absolute priority.

### 1. Operational Efficiency
Ensure the right information reaches the right people at the right time — reducing
waste, accelerating workflows, and maximising resource utilisation across all teams
and users.

> Signal: Does this reduce manual effort, eliminate a bottleneck, or give people
> better context to decide faster?

### 2. Process Optimisation
Continuously refine workflows via data-driven insights — automating repetitive tasks,
standardising best practices, and creating improvement cycles informed by metrics and
feedback from both internal teams and external users.

> Signal: Does this create a more scalable, repeatable process or replace a manual
> step with a governed, automated one?

### 3. Customer Retention
Build products — both external-facing and internal — that people interact with daily,
that fit their workflows, and that deliver measurable value. For external users: proven
ROI and negative churn. For internal teams: indispensable tools that raise delivery
quality and consistency.

> Signal: Does this make the product stickier, help users prove value, or reduce
> friction at a known drop-off point?

### 4. Revenue Growth
Expose data capabilities and AI tools as value-add features that hook external users
into the paid ecosystem. Enable upsell identification, pricing optimisation, and
premium-tier justification through data-driven capabilities.

> Signal: Does this create a monetisable capability, support trial-to-paid conversion,
> or enable a data-driven pricing decision?

### 5. Risk Mitigation
Eliminate single-platform dependencies, build adaptable architecture, and maintain
feedback loops that surface industry trends, user needs, and emerging risks proactively
— for both the product and internal operations.

> Signal: Does this reduce platform/vendor/person dependency, add an earlier feedback
> loop, or increase architectural flexibility?

### 6. Quality of Service
Consistent, reliable data, intelligence, and platform performance — 24/7. Covers system
uptime, data accuracy, algorithmic reliability, and platform responsiveness at every
touchpoint — for external users and internal teams equally.

> Signal: Does this improve reliability, accuracy, or latency of something users
> depend on — or reduce the blast radius of a failure?

---

## Value Streams
<!-- Framework: SAFe — Scaled Agile Framework value streams -->
<!-- SAFe defines a value stream as the sequence of steps that delivers value     -->
<!-- to a specific stakeholder. Madgicx has three: two active, one foundational.  -->

Madgicx operates three value streams aligned to the SAFe (Scaled Agile Framework)
model — sequences of steps that deliver value to a specific stakeholder.
Two are active; one is the governed foundation both run on.

```
    CustomerX Value Stream       OperX Value Stream
    (external users)             (internal teams)
    14 workflows defined         engdocs · madgicx-bi — emerging
            │                          │
            └──────────────┬───────────┘
                           │
                      TrustX Foundation
               Governed AI & Data base
          trusted data · governed agents
          quality assurance · compliance
```

---

### CustomerX — Customer Experience Value Stream

**Users:** External — media buyers, agency operators, performance marketers
**Status:** Defined — 14 active workflows
**Primary objectives:** Customer Retention · Revenue Growth · Process Optimisation

**Purpose:** Empower media buyers to unlock their advertising revenue potential through
AI-powered intelligence that fits seamlessly into their daily workflows.

**Success measures:**
- Retention rate and churn reduction
- Time-to-value for new users (onboarding velocity)
- Daily active usage across workflows
- Measurable ROAS improvement attributable to Madgicx
- NPS and account expansion (negative churn)
- Satisfaction across all touchpoints — onboarding, billing, support, product

**Quality of Service contract:**
QoS is where TrustX and CustomerX meet — the measurable expression of the governed
foundation experienced by the user. Workflows with critical QoS exposure:
`chatwdata` · `reporting` · `budget` · `tracking`

#### CustomerX Workflows

| # | ID | Name | Primary | Secondary | Tertiary | TrustX |
|---|---|---|---|---|---|---|
| 1 | `onboarding` | Onboarding Madgicx Users | Process Optimisation | Customer Retention | Revenue Growth | |
| 2 | `chatwdata` | Chat with Data | Process Optimisation | Operational Efficiency | Risk Mitigation | |
| 3 | `makeads` | Making Ads with AI | Process Optimisation | Operational Efficiency | Customer Retention | |
| 4 | `adqueue` | Ad Queue Management | Process Optimisation | Operational Efficiency | Customer Retention | |
| 5 | `creatives` | Creative Analysis | Operational Efficiency | Customer Retention | Revenue Growth | |
| 6 | `scaling` | Scaling and Expanding | Risk Mitigation | Operational Efficiency | Revenue Growth | |
| 7 | `budget` | Budget Management | Process Optimisation | Risk Mitigation | Customer Retention | |
| 8 | `commenter` | AI Commenter | Operational Efficiency | Customer Retention | Revenue Growth | |
| 9 | `campaigns` | Creating Campaigns | Process Optimisation | Risk Mitigation | Revenue Growth | |
| 10 | `reporting` | Reporting | Process Optimisation | Risk Mitigation | Customer Retention | |
| 11 | `tracking` | Tracking & Attribution | Risk Mitigation | Process Optimisation | Customer Retention | ✓ |
| 12 | `classification` | Data Labeling & Classification | Operational Efficiency | Risk Mitigation | Customer Retention | ✓ |
| 13 | `restructuring` | Ad Account Restructuring | Risk Mitigation | Customer Retention | Revenue Growth | |
| 14 | `activity` | Activity Logs | Process Optimisation | Operational Efficiency | Risk Mitigation | ✓ |

> **TrustX ✓** — workflow carries a TrustX enforcement responsibility in addition to
> its CustomerX role. See TrustX section below.

**Workflow dependency map:**
```
makeads ◄──────── creatives        (classification insights feed ad creation)
    │                  ▲
    ▼                  │
adqueue ──────────► campaigns      (classification labels inform campaign build)
                       │
creatives ─────────► scaling       (performance patterns drive scaling decisions)
    │
    ▼
classification

tracking ──────────► reporting
    │
    └──► (all workflows — broken tracking corrupts all downstream data)

chatwdata ──────────► (all workflows — horizontal AI interface)
activity ───────────► (all workflows — horizontal audit trail)
onboarding ─────────► (entry point — feeds all workflows for new users)
budget ─────────────► campaigns · scaling
restructuring ──────► campaigns · budget
commenter ──────────► creatives (comment insights feed creative strategy)
```

---

### OperX — Operational Excellence Value Stream

**Users:** Internal — Engineering, Product, Data, Customer Success, Leadership
**Status:** Emerging — first workflows in definition
**Primary objectives:** Operational Efficiency · Process Optimisation · Risk Mitigation

**Purpose:** Eliminate operational friction, knowledge fragmentation, and manual overhead
that slows down the teams building and operating Madgicx. OperX products are the
back-office engine that drives the quality of everything else.

**Note:** Consistent with Madgicx's 'oneness' reform — any AI & Data product for any
user (internal or external) is a product. A brief from an internal team is as valid
as one from the external-facing side.

**Success measures:**
- Reduction in manual effort for recurring operational tasks
- Cross-team knowledge accessibility and discoverability
- Process consistency and SOP compliance
- Engineering and delivery velocity
- Internal onboarding time for new team members

#### OperX Workflows

##### `engdocs` — Engineering Documentation Management
**Status:** In definition
**Objectives:** Operational Efficiency · Process Optimisation · Risk Mitigation

AI-governed documentation co-pilot (AgentForge) that eliminates manual document
authoring across the full initiative lifecycle:
`Concept Brief → Initiative → PRD → Epic → User Story`

Enforces cross-layer ClickUp linking. Runs monthly governance to surface outdated,
duplicate, or misaligned content. Checks every document against business objectives
and OKR alignment before drafting.

**Domains:** `operations__sops_and_documentation` · `operations__planning_and_okrs` · `operations__execution_tickets`
**Key terms:** `Operations.SOP` · `Operations.OKR` · `Operations.InitiativeLifecycle` · `Operations.ExecutionTicket` · `Operations.Roadmap`

---

##### `madgicx-bi` — Madgicx BI
**Status:** In definition
**Objectives:** Operational Efficiency · Revenue Growth · Customer Retention

Internal BI product serving Marketing and Customer Success teams. Provides
governed, trusted data products for internal performance reporting, customer
health analysis, and marketing intelligence — built on θCortex and BigQuery L3.

**Domains:** `customer_success` · `social_marketing` · `finance_and_hr__finance` · `operations__planning_and_okrs`
**Key terms:** `Finance.MRR` · `Finance.ChurnRate` · `Finance.CAC` · `Finance.LTV` · `EcommerceShopify.CLV`

---

### TrustX — Trusted AI & Data Foundation

**Users:** All — serves CustomerX and OperX equally
**Status:** Cross-cutting foundation — not a value stream beside the others

**Purpose:** Ensure every AI decision, data product, and automated action across both
value streams is trusted, governed, explainable, and compliant. TrustX is the operating
system; CustomerX and OperX are the applications.

**TrustX is not** a team, a product surface, or a workflow owner. It is a governed
base layer — invisible when working well, catastrophic when absent.

#### Trust Contract

##### Data Trust
- All data products governed via DataHub (domains, glossary, ownership)
- Data freshness SLAs enforced per domain
- Policy tags applied at asset level (`INTERNAL_USE_ONLY` · `CONFIDENTIAL_*`)
- No ungoverned data assets — everything has a domain and an owner

##### AI Trust
- All AI agent decisions traceable via Langfuse (`AgentTrace`)
- No automated action without an immutable `ActionExecution` record
- AI Langfuse alerts monitored for PII violations and prompt injection
- Model drift detected via θCortex alerts

##### Process Trust
- Every initiative follows the `InitiativeLifecycle` gate model
- No document created without alignment checks (AgentForge)
- SOPs documented, versioned, and reviewed on cadence
- OKR alignment verified before any initiative progresses

##### Compliance Trust
- GDPR data minimisation applied to all PII-containing sub-domains
- `finance_and_hr` — zero standing engineer access, audit logs on all queries
- Retention tiers enforced per sub-domain (`RetentionTier`)
- Ad action execution — indefinite retention for compliance audit

#### TrustX Enforcement Points
Workflows that carry TrustX responsibilities in addition to their value stream role:

| Workflow | Value Stream | Contract | Role |
|---|---|---|---|
| `tracking` | CustomerX | Data Trust | Validates pixel integrity and attribution accuracy. Broken tracking corrupts the data foundation for all other workflows. |
| `classification` | CustomerX | Data Trust | Enforces canonical terminology and consistent taxonomy. Inconsistent labels corrupt downstream data products. |
| `activity` | CustomerX | AI Trust | System memory and audit trail. Every AI decision, action, and platform event logged here. Authoritative "what happened and why." |

---

## Data Domains
<!-- Source: DataHub domains.yml v0.3 -->

8 parent domains · 26 sub-domains. Sub-domains inherit group from parent unless overridden.

| Domain | ID | Group | Policy | Sub-domains |
|---|---|---|---|---|
| Social Marketing | `social_marketing` | devx-data | INTERNAL_USE_ONLY → CONFIDENTIAL_OPERATIONAL | `ad_performance` · `ecommerce` |
| External Factors | `external_factors` | devx-data | INTERNAL_USE_ONLY | `socioeconomic_indicators` · `regional_events` · `social_media_signals` |
| Activity Logs | `activity_logs` | devx-data | CONFIDENTIAL_OPERATIONAL | `ad_provider_activity_logs` · `ai_langfuse_traces` · `fe_fullstory_traces` · `ad_action_execution` · `ops_action_execution` · `prism_pipeline_activity` · `cortex_automation_activity` |
| Signals & Alerts | `signals_and_alerts` | devx-data | INTERNAL_USE_ONLY → CONFIDENTIAL_OPERATIONAL | `ad_performance_alerts` · `cortex_data_quality_alerts` · `prism_pipeline_alerts` · `ai_langfuse_alerts` |
| Creative Library | `creative_library` | core-ui-ux | CONFIDENTIAL_OPERATIONAL | `assets` · `metadata` |
| Customer Success | `customer_success` | customer-success | CONFIDENTIAL_PII / CONFIDENTIAL_OPERATIONAL | `accounts` · `support` · `revenue`* |
| Finance & HR | `finance_and_hr` | finance-hr | CONFIDENTIAL_RESTRICTED | `finance` · `infrastructure_costs` · `hr` |
| Operations | `operations` | operations | INTERNAL_USE_ONLY | `planning_and_okrs` · `sops_and_documentation` · `execution_tickets` |

> `revenue`* sub-domain jointly governed by `finance-hr` (group override)

**TrustX domain responsibilities:**
- `signals_and_alerts__ai_langfuse_alerts` — AI safety and compliance
- `signals_and_alerts__cortex_data_quality_alerts` — ML model health
- `signals_and_alerts__prism_pipeline_alerts` — pipeline reliability
- `activity_logs__ai_langfuse_traces` — AI agent audit trail
- `activity_logs__ad_action_execution` — ad action audit trail (indefinite retention)
- `activity_logs__ops_action_execution` — ops action audit trail (indefinite retention)
- `finance_and_hr` — most restricted domain, zero standing engineer access

---

## Glossary
<!-- Source: DataHub glossary_recipe.yml v0.2 -->

13 nodes · ~80 canonical terms. Use these terms — not platform-specific equivalents —
in all Madgicx documents, specs, and artefacts.

### Node → Domain mapping

| Node | Domain |
|---|---|
| `AdPerformanceMetrics` | `social_marketing__ad_performance` |
| `ConversionMetrics` | `social_marketing__ad_performance` |
| `AudienceTargeting` | `social_marketing__ad_performance` |
| `CampaignStructure` | `social_marketing__ad_performance` |
| `EcommerceShopify` | `social_marketing__ecommerce` |
| `EmailMarketing` | `social_marketing__ecommerce` |
| `DataGovernance` | `signals_and_alerts` |
| `SignalsAndAlerts` | `signals_and_alerts` |
| `ActivityLogs` | `activity_logs` |
| `CreativeLibrary` | `creative_library` |
| `Finance` | `finance_and_hr__finance` |
| `HR` | `finance_and_hr__hr` |
| `Operations` | `operations` |

### AdPerformanceMetrics
Core KPIs across Facebook Ads, Google Ads, TikTok Ads.

| Term | Definition | Formula |
|---|---|---|
| `Impressions` | Total ad displays | — |
| `Clicks` | Total ad clicks | — |
| `Spend` | Total ad spend (account currency) | — |
| `Reach` | Unique users who saw ad at least once | — |
| `Frequency` | Avg times each user saw the ad | `impressions / reach` |
| `CTR` | Click-through rate | `(clicks / impressions) * 100` |
| `CPM` | Cost per 1,000 impressions | `(spend / impressions) * 1000` |
| `CPC` | Cost per click | `spend / clicks` |
| `ROAS` | Return on ad spend — **primary profitability metric** | `purchase_value / spend` |
| `CPA` | Cost per acquisition | `spend / conversions` |
| `QualityScore` | Google Ads quality diagnostic (1–10) | — |
| `RelevanceScore` | Meta ad relevance diagnostic | ABOVE_AVERAGE · AVERAGE · BELOW_AVERAGE |

### ConversionMetrics
Purchase events, leads, downstream revenue.

| Term | Definition | Formula |
|---|---|---|
| `Conversions` | Total desired actions post ad interaction | — |
| `Purchases` | Completed purchase transactions attributed to ads | — |
| `PurchaseValue` | Total revenue from purchase conversions | — |
| `AOV` | Average order value | `purchase_value / purchases` |
| `AddToCart` | Products added to cart after ad interaction | — |
| `InitiateCheckout` | Checkout sessions started after ad interaction | — |
| `Leads` | Lead form submissions after ad interaction | — |
| `AttributionWindow` | Period in which conversion credits ad. Default: 7d click · 1d view | — |
| `ViewThroughConversion` | Conversion from ad viewed but not clicked | — |

### AudienceTargeting

| Term | Definition |
|---|---|
| `CustomAudience` | First-party data audience (email lists, pixel visitors, CRM) |
| `LookalikeAudience` | Algorithmically generated audience mirroring a source audience |
| `RetargetingAudience` | Users who previously interacted with the brand |
| `ProspectingAudience` | Cold audience — no prior brand interaction |
| `AudienceOverlap` | % of users shared between audiences. High overlap → inflated CPMs |
| `KlaviyoSegment` | Dynamic/static Klaviyo contact list. Source for Facebook Custom Audiences |

### CampaignStructure

**Facebook:** `AdAccount → Campaign → AdSet → Ad`
**Google:** `GoogleAdAccount → GoogleCampaign → AdGroup → Ad/Keyword`
**TikTok:** `Account → Campaign → Ad Group → Ad`

Key terms: `CBO` (Campaign Budget Optimization — budget auto-distributed across ad sets) ·
`PerformanceMax` (Google automated campaign across all inventory — replaced Smart Shopping 2022)

### EcommerceShopify

| Term | Definition | Formula |
|---|---|---|
| `ShopifyOrder` | Completed/pending transaction — primary revenue record | — |
| `ShopifyProduct` | Sellable item. Used for product-level ROAS and ad catalog feeds | — |
| `ShopifyCustomer` | Customer record. Used for audience building and CLV | — |
| `CLV` | Customer lifetime value | `avg_order_value * purchase_frequency * customer_lifespan` |
| `RefundRate` | % of orders refunded | `(refunded_orders / total_orders) * 100` |
| `NewVsReturningCustomer` | First-time (NEW) vs repeat (RETURNING) buyer | `orders_count == 1 → NEW` |

### EmailMarketing (Klaviyo)

| Term | Definition |
|---|---|
| `EmailOpenRate` | % of delivered emails opened. ⚠ Inflated post iOS 15 MPP — use click rate |
| `EmailClickRate` | % of delivered emails with at least one click. More reliable post-iOS 15 |
| `KlaviyoFlow` | Automated email/SMS sequence triggered by Shopify event. Continuous revenue driver |
| `KlaviyoCampaign` | One-time broadcast email/SMS. 14-day click attribution default |
| `EmailAttributedRevenue` | Revenue attributed to Klaviyo. ⚠ May double-count with Facebook/Google |
| `ListGrowthRate` | Net subscriber growth rate | `((new - unsubscribes - bounces) / starting) * 100` |

### DataGovernance

**Attribution models:**
`LastClickAttribution` (single-touch) · `DataDrivenAttribution` (ML multi-touch — Google recommended) ·
`MetaAttributedConversions` (⚠ subject to iOS 14.5+ signal loss — deduplicate via `event_id`)

**Ingestion health:**

| Term | Definition |
|---|---|
| `DataFreshness` | Time since last successful sync. SLAs: Facebook <3h · Google <3h · Shopify <1h · Klaviyo <6h |
| `APIRateLimit` | Facebook: 200 score-based · Google: 15,000 ops/day · Shopify: 40 req/sec |
| `DataGap` | Missing/incomplete data period. Severity: WARNING · CRITICAL. Remediation: backfill |
| `ConversionDelay` | Facebook up to 72h delay. Madgicx uses 3-day buffer for stable ROAS |

### SignalsAndAlerts

| Term | Definition |
|---|---|
| `AlertSeverity` | INFO · WARNING · CRITICAL |
| `PerformanceThreshold` | Predefined boundary triggering an alert. Scope: campaign · adset · account · benchmark |
| `AnomalySignal` | Statistical deviation from baseline — no explicit threshold needed |
| `SLABreach` | Alert when data freshness or pipeline health SLA is violated |
| `AdFatigue` | Creative shown too often → declining engagement + rising CPMs. Threshold: `frequency > 3.5 AND ctr_decline > 15%` |

### ActivityLogs

| Term | Definition | Retention |
|---|---|---|
| `AgentTrace` | Complete AI agent execution record via Langfuse | 90d hot · 1yr cold |
| `ActionExecution` | Immutable record of every AI action against ad platform | Indefinite |
| `CDCEvent` | Change Data Capture event from PRISM via Debezium | Per pipeline SLA |
| `SessionTrace` | User session record via FullStory. Pseudonymised | Per GDPR policy |
| `RetentionTier` | HOT_90D · HOT_1Y · COLD_1Y · COLD_7Y · INDEFINITE | — |

### CreativeLibrary

| Term | Definition |
|---|---|
| `CreativeAsset` | Single ad creative (VIDEO · IMAGE · CAROUSEL · COPY). Identified by asset URN |
| `AssetLifecycleStatus` | DRAFT · ACTIVE · PAUSED · ARCHIVED · REJECTED |
| `PerformanceScore` | Composite score: ROAS contribution + CTR lift + fatigue. Range: 0.0–10.0 |
| `CreativeFatigue` | Engagement decline from overexposure. Triggers rotation signal to AI agent |
| `ABTestAssignment` | Creative assignment to control/treatment variant under controlled traffic split |

### Finance
⚠ CONFIDENTIAL_RESTRICTED — Finance team and named executives only

| Term | Definition | Formula |
|---|---|---|
| `MRR` | Monthly Recurring Revenue — primary SaaS health metric | `sum(active_subscription_monthly_value)` |
| `ARR` | Annual Recurring Revenue | `MRR * 12` |
| `ChurnRate` | % of MRR lost in period | `(churned_mrr / starting_mrr) * 100` |
| `CAC` | Customer Acquisition Cost | `total_sales_marketing_spend / new_customers_acquired` |
| `LTV` | Customer Lifetime Value (SaaS) | `ARPU / churn_rate` |
| `PaybackPeriod` | Months to recover CAC | `CAC / (ARPU * gross_margin)` |
| `GrossMargin` | Revenue after COGS | `(revenue - cogs) / revenue * 100` |

### HR
⚠ CONFIDENTIAL_RESTRICTED — HR lead and C-suite only. Named-user grants.

`Headcount` · `SalaryBand` · `EquityGrant` · `OrganisationalStructure`

### Operations

| Term | Definition |
|---|---|
| `OKR` | Objectives and Key Results. Quarterly cadence — company · team · individual |
| `SOP` | Standard Operating Procedure. Versioned, owner-assigned, review-cadenced |
| `ExecutionTicket` | Discrete work item in ClickUp/Linear. Audit trail from initiative to delivery |
| `Roadmap` | Time-bounded initiative sequence. Quarterly review aligned to OKR cycle |
| `InitiativeLifecycle` | IDEATION → PLANNING → IN_PROGRESS → REVIEW → COMPLETED → ARCHIVED |

---

## Tech Stack
<!-- Source: tech-stack.yml v0.3 — GitHub / datahub-facebook project -->

### Architecture Overview

```
GOVERNANCE (above everything)
  DataHub — SSOT · GitHub/datahub-facebook · generates governance-canonical.md
        │
        ▼ governs both
        │
PRISM ──────────────────────────────────────────────────────────────────────────
Platform for Real-time Ingestions, Semantics, and Modeling
  Ingestion        Debezium · BentoS · RabbitMQ
  Semantics        Redpanda · Avro schema registry
  Modeling         GCS L0-L2 · BigQuery L3
  Orchestration    Temporal (PRISM saga service)
  Observability    Pipeline health → feeds DataHub
  Serving Layer    FastAPI · Kong · JWT · MCP servers
        │
        ▼ consumes PRISM capabilities
        │
θCortex ────────────────────────────────────────────────────────────────────────
Intelligence & Product Layer — ALL data products delivered here
  Agentic          AgentForge · LangChain · Langfuse
  Retrieval        Chroma (RAG / vector store)
  Models           Model-agnostic · selected per use case
  Augmented BI     Apache Superset → BigQuery L3
        │
        ▼ delivers to
        │
CustomerX workflows (14) · OperX workflows (engdocs · madgicx-bi · future)

PLATFORM OBSERVABILITY (cross-cutting across PRISM + θCortex)
  OpenTelemetry · Jaeger · Grafana → feeds DataHub quality signals

FRONTEND
  ReactJS widget framework — AI-rendered interactive UI
```

---

### Governance Layer

**DataHub** — Single Source of Truth for all data and AI product governance.
Governs domain ownership, business glossary, data lineage, and asset metadata
across both PRISM and θCortex. Sits above the data fabric — not part of it.

- **Repository:** GitHub / datahub-facebook project
- **Generates:** `governance-canonical.md` via CI/CD pipeline from yml source files
- **Data quality:** Pulls timeliness, availability, and freshness signals from Grafana/OpenTelemetry — OTEL captures, DataHub governs
- **CI/CD status:** In progress — not yet fully active
- **MCP integration:** Planned future phase — MCP-triggered regeneration on commit

> Do not edit `governance-canonical.md` directly. Edit yml source files in the
> datahub-facebook repository and trigger CI/CD to regenerate.

---

### PRISM — Platform for Real-time Ingestions, Semantics, and Modeling

The Madgicx data fabric infrastructure. Owns the full data lifecycle and provides
the capabilities θCortex consumes to deliver data products.

**Cloud:** Google Cloud Platform (GCP) — GCP-native
**Activity log:** `activity_logs__prism_pipeline_activity`
**Alerts:** `signals_and_alerts__prism_pipeline_alerts`

#### Ingestion

| Component | Role |
|---|---|
| **Debezium** | Change Data Capture (CDC) from PostgreSQL. Produces `CDCEvent` streams in Avro/JSON |
| **BentoS** | Webhook-based event ingestion for real-time API-push sources |
| **RabbitMQ** | Message broker. Routes events between ingestion, pipeline stages, and consumers |

#### Semantics — Schema Registry
Schema-first discipline — all data contracts registered before any pipeline or product is built.

| Component | Role |
|---|---|
| **Redpanda** | External schema registry. Manages Avro schema versions and compatibility |
| **Apache Avro** | Schema format for all structured event streams and pipeline contracts |

> Any new pipeline or data product spec must register its schema first.

#### Modeling — Storage Tiers

| Tier | Name | Description | Storage |
|---|---|---|---|
| L0 | Raw | As-is from source. Unmodified | GCS |
| L1 | Validated | Schema-validated, Avro/Parquet formatted | GCS |
| L2 | Normalised | Cleaned, deduplicated, normalised | GCS |
| L3 | Warehouse & Data Marts | Aggregated, modelled. Serves θCortex and Superset | BigQuery |

> dbt not used — all L0→L3 transformations via Temporal sagas.

#### Orchestration

**Temporal** — Saga orchestration service within PRISM. Not a standalone system.
Drives all pipeline transformations (L0→L3) and θCortex workflow execution.
Every multi-step data or agent workflow must define its Temporal saga before build.
Activity log: `activity_logs__cortex_automation_activity`

#### Pipeline Observability
PRISM-level pipeline health — distinct from platform observability (OpenTelemetry/Jaeger).
Monitors connector health, ingestion SLAs, DLQ thresholds, data freshness per domain.
Produces `signals_and_alerts__prism_pipeline_alerts` · Feeds timeliness signals to DataHub.

#### Serving Layer
Data access and consumption layer within PRISM. All access to θCortex data products
routes through this layer — no direct BigQuery or GCS access from agents or workflows.

| Component | Role |
|---|---|
| **FastAPI** | Primary Python API framework. Exposes PRISM data products to θCortex and integrations |
| **Kong Gateway** | API gateway. Routing, authentication (JWT), rate limiting, observability |
| **JWT** | Authentication standard across all API services via Kong |
| **MCP Servers** | Model Context Protocol — structured intent/capability interface for θCortex value stream workflows |

**MCP Servers — live:**

| Server | Value Stream | Domain / Workflow |
|---|---|---|
| Facebook Ads | CustomerX | `social_marketing` |
| Google Analytics | CustomerX | `social_marketing` |
| ClickUp | OperX | `engdocs` workflow |
| Shopify | CustomerX | `social_marketing__ecommerce` |
| Slack · Gmail · Notion · Linear · Figma | Both | — |
| HubSpot · Intercom · Miro · Asana · Atlassian | Both | — |
| monday.com · Webflow · Supermetrics · Fireflies | Both | — |

---

### θCortex — Intelligence & Product Layer

Consumes PRISM capabilities — storage, Temporal, serving layer — to implement
Madgicx-specific value stream workflows, intents, and capabilities.
**All data products are delivered through θCortex — never directly from PRISM.**

**Built on:** PRISM · **Orchestration:** Temporal (PRISM service)
**Activity log:** `activity_logs__cortex_automation_activity`
**Alerts:** `signals_and_alerts__cortex_data_quality_alerts`
**Delivers to:** CustomerX (14 workflows) · OperX (engdocs · madgicx-bi · future)

#### Agentic Framework

| Component | Role |
|---|---|
| **AgentForge** | Madgicx proprietary agentic framework. Spec-driven — behaviour, triggers, validation, and handoff contracts defined before build. Built on LangChain. Traced via Langfuse. TrustX: all agents satisfy `ai_trust` contract |
| **LangChain** | Agent orchestration and tool-use framework underlying AgentForge |
| **Langfuse** | AI agent tracing and evaluation. Full `AgentTrace` per run. Domain: `activity_logs__ai_langfuse_traces`. Retention: 90d hot · 1yr cold. TrustX primary AI enforcement tool |
| **Chroma** | Vector store (RAG). Agent context retrieval — governance-canonical.md, ClickUp index, domain knowledge |

> No agent is built without a defined AgentForge spec. Spec is a required PRD artefact.

#### Models
Model-agnostic — selected per use case and capability. Multi-model routing strategy in place.

#### Augmented BI
**Apache Superset** — Visual analytics and internal dashboarding. Connects to BigQuery (L3).
Part of the θCortex intelligence layer — not a platform observability tool.

---

### Platform Observability
Cross-cutting across all PRISM and θCortex services. Distinct from PRISM pipeline observability.
**TrustX requirement:** All services and agents must instrument OpenTelemetry before production.

| Component | Role |
|---|---|
| **OpenTelemetry** | Instrumentation standard. Traces, metrics, logs across all services. Mandatory for all new services |
| **Jaeger** | Distributed tracing. Request-level performance debugging across microservices |
| **Grafana** | Monitoring dashboards and alerting. Feeds timeliness/availability signals to DataHub |

---

### Frontend

**ReactJS Widget Framework** — AgentForge agents render ReactJS widgets directly in the
interface. Interactive, data-driven UI without traditional frontend deployment cycles.
Used across CustomerX and OperX value stream interfaces.

> PRDs proposing new UI capabilities must specify: ReactJS widget framework or traditional build.

---

### Engineering Culture

| Principle | Detail |
|---|---|
| Primary language | Python |
| Philosophy | Open source first — prefer open source before proprietary |
| Schema discipline | Schema-first — all data contracts registered before build |
| Agent discipline | Spec-first — all AgentForge agents specced before build |
| UI capability | AI-rendered ReactJS widgets |
| Infrastructure as code | Not in use |
| CI/CD | In progress — not yet fully active |

---

## How Skills Use This File

### All skills — on load
1. Read this file once before generating any output
2. Use canonical terms from the Glossary — never platform-specific equivalents
3. Map any proposal to its value stream (CustomerX / OperX) before proceeding
4. Check business objective alignment against the top-3 ranking convention
5. Verify technical fit against the Tech Stack — check if a capability already exists

### grill-me
The grill-me skill uses this file for any structured design process — not only
product briefs. Any artefact that requires leadership acceptance or governance
sign-off should go through grill-me grounded in this context. Examples:

| Artefact | Value Stream | Notes |
|---|---|---|
| Concept Note / Product Brief | CustomerX or OperX | First gate — is this worth building? |
| PRD | CustomerX or OperX | Second gate — what exactly are we building? |
| Epic | CustomerX or OperX | Derived from approved PRD |
| Release Note | CustomerX or OperX | Documents what was delivered and why |
| White-paper | Either | Strategic or technical position document |
| Initiative proposal | Either | Connects to OKR before progressing |

For each artefact type grill-me loads this file, identifies the value stream,
checks objective alignment, verifies technical fit, and grills on the specific
anchors relevant to that artefact — before generating the output.

### AgentForge agents and skill.md files
Any agent or skill that generates Madgicx artefacts — documents, specs, analyses,
recommendations — loads this file to ensure outputs are grounded in canonical
terminology, correct domain ownership, and the right value stream context.