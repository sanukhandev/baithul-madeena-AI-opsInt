# Baithul Madeena ERP — Authoritative Project Context

## Purpose

This parent repository is the coordination, architecture, source-context, code-graph, and agent-instruction layer for the Baithul Madeena ERP modernization program.

Use this document as the primary product context before reviewing or changing code in either child repository.

The child repositories are implementation sources, not complete architecture specifications:

- `frontend/` → `sanukhandev/baithul-madeena-ai-hub` (`main`)
- `backend/` → `sanukhandev/baithul-madeena-ai-hub-be` (`main`)

The backend is partially built. Existing backend code and documentation must be reviewed against this target context before being treated as sustainable or final. Existing implementation may be retained, refactored, replaced, or removed in later authorized work based on evidence from the Code Graph and architecture review.

---

# 1. Product Vision

Baithul Madeena is being transformed from a legacy single-branch ERP into a modern, AI-native, multi-branch real-estate operations platform.

Legacy baseline:

- Backend: CodeIgniter 3
- Frontend: Angular 11
- Database: MySQL
- Current operational focus: Fujairah branch

Modernization target:

- Backend: Laravel 12
- Frontend: React / TypeScript
- Database: MySQL 8
- API: GraphQL
- Realtime: Laravel Reverb
- AI: ZaakiyVerse using a controlled AI orchestration layer, with Gemini for deeper reasoning
- Workflow automation and operational intelligence
- Multi-branch governance with strict isolation

Target branches:

- Fujairah
- Ajman
- Dubai
- Future branches without architectural rewrites

The end-state product should feel like an AI-native operational command center rather than a traditional admin ERP.

---

# 2. Core Business Domains

The platform must support the following operational domains.

## Dashboard and Operational Intelligence

- branch-aware dashboards
- real-time KPIs
- revenue and collection summaries
- occupancy analytics
- agreement lifecycle monitoring
- maintenance monitoring
- pending approvals
- branch comparison
- organization-wide consolidated analytics for authorized users
- AI-generated insights, anomalies, risks, and recommended actions

## Owner Management

- owner profiles
- Emirates ID / passport / KYC documentation
- contact information
- multi-property ownership
- ownership percentage
- owner agreements
- commission tracking
- owner ledger
- payout tracking
- document lifecycle and renewal reminders
- owner portal
- AI-generated owner summaries and performance insights

## Tenant Management

- tenant profiles
- identity and document management
- multiple agreements over time
- occupancy tracking
- payment history
- communication logs
- employer and income information
- tenant lifecycle
- delayed payment risk
- renewal intelligence
- tenant portal
- AI-generated summaries, risk insights, and smart reminders

## Property Management

Hierarchy:

```text
Organization
→ Branch
→ Property
→ Building
→ Unit / Room
```

Capabilities:

- properties, villas, buildings, units, rooms
- FEWA / utility identifiers
- media
- GIS/map support
- occupancy and vacancy state
- maintenance state
- availability
- revenue analytics

Primary unit states include:

- Vacant
- Occupied
- Reserved
- Under Maintenance
- Blocked

## Agreement Management

- tenant agreements
- owner agreements
- version history
- approval lifecycle
- e-signature readiness
- deposits
- payment schedules
- renewal workflow
- expiry notification
- agreement timeline
- AI summaries, missing-field detection, risk analysis, and renewal recommendations

Core agreement lifecycle:

```text
Draft
→ Pending Approval
→ Approved
→ Active
→ Expired / Cancelled
```

## Finance and Accounting

Finance must be modeled as a real accounting domain, not a flat credit/debit CRUD module.

Required capabilities:

- branch-wise accounting
- chart of accounts
- journal entries
- general ledger
- rent collections
- receipts and payment vouchers
- expenses
- owner ledgers
- bank reconciliation
- VAT support
- audit trails
- P&L
- balance sheet
- cash flow
- rent aging
- outstanding balances
- branch profitability
- payroll, overtime, leave deductions, allowances, approvals

## Maintenance and Vendor Operations

- tenant maintenance requests
- ticket lifecycle
- categorization
- assignment
- SLA tracking
- technician/vendor updates
- completion validation
- comments and attachments
- vendor invoices
- repeat-issue tracking
- vendor portal
- AI categorization, predictive suggestions, SLA-risk alerts, escalation

## CRM and Leads

- leads
- source tracking
- pipeline stages
- assignment
- activity timeline
- communication
- conversion analytics
- AI-assisted follow-ups and scoring

## Workflow and Approval Engine

Triggers include:

- agreement expiry
- rent overdue
- maintenance created
- vacancy detected
- tenant onboarding
- owner agreement renewal
- SLA breach
- financial anomaly
- payment failure
- workflow delay

Actions include:

- send in-app notification
- send email
- send WhatsApp
- send SMS
- notify branch admin
- create approval task
- create follow-up
- generate AI summary
- escalate issue

Workflows must remain deterministic and auditable. AI must not bypass validations or approvals.

---

# 3. Multi-Branch Architecture

Organization structure:

```text
Baithul Madeena Organization
├── Fujairah Branch
├── Ajman Branch
└── Dubai Branch
```

Branch domains:

- `fujairah.baithulmadeena.ae`
- `ajman.baithulmadeena.ae`
- `dubai.baithulmadeena.ae`

Each branch requires:

- separate login context
- separate operational visibility
- separate financial visibility
- separate user access
- branch-scoped reports
- branch-scoped workflows

Authorized organization administrators may access consolidated cross-branch analytics.

Branch context can be derived from:

- domain/subdomain
- authenticated user/session
- JWT claims
- organization mapping
- assigned branch access
- RBAC permissions

Cross-branch access must always be explicit, never inferred merely because a user is authenticated.

---

# 4. Identity and RBAC

Internal identity management is required.

Target roles include:

- Super Admin
- Organization Admin
- Branch Admin
- Accountant
- Property Manager
- Maintenance Manager
- HR Manager
- Staff
- Vendor
- Tenant Portal User
- Owner Portal User

Authorization must support:

- module-level permissions
- action-level permissions
- branch-level restrictions
- entity/data visibility
- financial visibility restrictions
- AI capability restrictions
- approval-level restrictions
- user-to-multiple-branch access when explicitly granted

Security is enforced server-side. Frontend role-aware navigation is usability, not authorization.

---

# 5. Backend Target Architecture

Target stack:

- Laravel 12
- PHP 8.3+ target; current backend composer constraint may be lower and must be reviewed
- MySQL 8
- GraphQL through Lighthouse
- JWT authentication
- Spatie Permission or equivalent policy-aware RBAC
- Spatie Activitylog
- Spatie Media Library
- Laravel Reverb
- database queue driver
- file/database cache in phase 1
- Telescope/logging for development and observability
- SSE/streamed HTTP for AI response streaming

Architecture style:

> Modular monolith first.

Do not introduce microservices merely for architectural fashion. Domains should be modular enough to extract later if evidence demands it.

Suggested logical domains:

```text
Organization
Branch
Auth
RBAC
Owner
Tenant
Property
Agreement
Finance
Maintenance
CRM
Workflow
Notification
Reporting
AI
OpsIntelligence
Migration
Shared/Infrastructure
```

GraphQL request path:

```text
Client
→ GraphQL Gateway
→ Authentication
→ Organization/Branch Context
→ RBAC / Policy Validation
→ Resolver
→ Domain Service
→ Repository / Eloquent query
→ MySQL
```

Raw unrestricted models must not be exposed through GraphQL resolvers.

Every resolver must consider:

- organization scope
- branch scope
- action permission
- financial/data visibility
- pagination
- selected columns
- relationship constraints
- N+1 prevention

---

# 6. Database Principles

The target database is normalized, relational, MySQL-first, branch-aware, and audit-friendly.

Internal primary key strategy:

```text
BIGINT UNSIGNED AUTO_INCREMENT
```

Use UUID/public references only when needed for external/public/incident identifiers.

Operational entities generally need:

```text
organization_id
branch_id
created_by
updated_by
created_at
updated_at
deleted_at
```

`branch_id` may be null only when the record is intentionally organization-wide.

Important schema groups include:

- organizations / branches
- users / roles / permissions / branch access
- owners / owner documents / owner-property mappings / owner ledgers
- properties / property types / buildings / units / unit media
- tenants / documents / communications / risk scores
- agreements / versions / approvals / documents / payment schedules
- chart of accounts / journal entries / journal items / payments / expenses
- employees / payroll runs / payroll items
- vendors / maintenance tickets / comments / attachments / invoices
- leads / lead activities / stage history
- workflows / conditions / actions / logs / approval tasks
- notifications / notification logs / realtime events
- AI conversations / messages / logs / suggestions / risk insights / context snapshots
- reporting snapshots
- audit/activity/security logs
- Ops Intelligence incidents / resolutions / deployments / health logs

Index operational access patterns rather than only individual columns. Common composite leading dimensions are:

- organization + branch
- branch + status
- branch + date
- branch + expiry date
- branch + SLA due time
- user + unread state

Use MySQL full-text search in phase 1 for major searchable entities unless later evidence justifies external search infrastructure.

---

# 7. Reporting and Performance

Avoid calculating large ERP reports from raw transactional tables on every page load.

Target snapshot/aggregate domains include:

- daily branch summary
- monthly financial summary
- occupancy summary
- maintenance summary
- AI context snapshots

Use scheduled jobs to generate expensive aggregates.

Performance goals from the architecture context are directional:

- dashboard perceived load under ~2 seconds
- normal GraphQL operational queries generally below ~500 ms where practical
- AI initial streamed output targeted under ~2 seconds where provider/network conditions permit
- realtime notification updates through Reverb rather than aggressive polling

Do not optimize by bypassing authorization or audit layers.

---

# 8. ZaakiyVerse AI

ZaakiyVerse is not a standalone generic chatbot.

It is the ERP's embedded operational intelligence layer.

Responsibilities include:

- conversational ERP querying
- operational search
- reporting
- contextual recommendations
- workflow orchestration
- summaries
- risk analysis
- intelligent alerts
- workflow actions subject to authorization

AI context should understand:

- current organization
- current branch
- current user and roles
- current module
- current entity
- workflow state
- pending approvals
- financial visibility

Mandatory AI access model:

```text
User Prompt
→ AI Gateway
→ Intent / Skill Routing
→ Permission Validator
→ Context Builder
→ Authorized Domain Service / GraphQL
→ MySQL
→ Gemini only when deeper reasoning is required
→ Response Composer
→ Audit Log
```

Never:

```text
LLM → unrestricted SQL / unrestricted model access
```

Routine deterministic requests should become skills or domain operations instead of consuming deep-reasoning calls unnecessarily.

Examples:

- overdue rent query
- vacancy lookup
- agreement-expiry lookup
- maintenance escalation
- approval creation

Gemini is best reserved for tasks such as:

- financial analysis
- agreement risk analysis
- large operational summaries
- anomaly explanation
- incident RCA
- complex multi-step reasoning

All AI actions must be auditable.

---

# 9. Autonomous Ops Intelligence

The long-term system includes an operational-intelligence layer for engineering and customer-facing reliability.

Monitor classes of failure such as:

- API/HTTP failures
- GraphQL resolver/mutation failures
- database/transaction failures
- slow queries
- queue failures
- scheduler failures
- Gemini/AI failures
- streaming failures
- Reverb/broadcast failures
- storage failures
- suspicious auth/RBAC/branch violations

Target lifecycle:

```text
Failure
→ Incident Collector
→ Operational Context Builder
→ AI Analysis
→ Severity / Deduplication
→ GitHub Issue / Engineering Escalation
→ Patch / PR workflow
→ CI validation
→ Deployment tracking
→ Resolution verification
→ Customer-safe realtime communication
→ Audit closure
```

No automated workflow may expose raw stack traces or infrastructure secrets to customers.

No destructive fix should auto-merge or deploy while bypassing approvals and validation.

---

# 10. Frontend Product and Technical Context

Target frontend experience:

- modern enterprise SaaS command center
- responsive desktop/tablet/mobile operation
- information dense without legacy admin-panel clutter
- branch-aware
- role-aware
- workflow-oriented
- contextual ZaakiyVerse assistance
- realtime updates

Target UX areas:

- fixed/collapsible sidebar
- top navigation with branch switcher/search/notifications/approvals/AI
- advanced tables with sorting/filtering/pagination/saved views/bulk actions/export
- entity activity timelines
- dashboards and charts
- agreement workspace
- owner/tenant/vendor portals
- contextual AI panels
- notifications
- workflow timelines
- reports

The actual frontend source is the implementation truth for current framework choices. At the time this parent context was refreshed, its package manifest shows TanStack Start/Router/Query, React 19, TypeScript, Tailwind 4, Vite, Framer Motion, Recharts, Radix UI and related libraries. Do not rewrite the application around an older assumed React Router baseline merely because earlier requirements used that wording.

---

# 11. Frontend ↔ Backend Contract

GraphQL is the integration contract between frontend and backend.

The target contract includes operational queries/mutations for:

- authentication/session
- dashboard aggregates
- properties
- owners
- tenants
- agreements
- finance
- maintenance
- reports
- settings/branding
- AI advisory/chat operations
- e-signature/workflow operations where applicable

The frontend and backend must not evolve independently when a GraphQL contract changes.

For every contract change, identify:

1. schema/type/input change
2. resolver/domain impact
3. frontend query/mutation impact
4. generated/manual TypeScript type impact
5. permission/branch-scope impact
6. tests and migration impact

The Code Graph should map GraphQL operation consumers in frontend to schema/resolvers/services in backend.

---

# 12. Legacy Data Migration

Migration from the current ERP is a core deliverable, not an afterthought.

Phases:

1. legacy schema assessment
2. dependency/orphan analysis
3. data cleaning and normalization
4. mapping to new schema
5. ETL
6. record count validation
7. financial reconciliation
8. agreement validation
9. random QA sampling
10. parallel/UAT testing
11. legacy write freeze
12. final synchronization and cutover

Historical relationships and financial integrity must be preserved.

---

# 13. Current Repository State and Authority Rules

## Parent repository

The parent is the authoritative source for:

- target product requirements
- target architecture
- security invariants
- cross-repo contracts
- code graph
- architecture decisions
- implementation plans
- agent instructions

## Frontend child repository

Treat the frontend source as factual evidence of current implementation.

Its present framework/package choices take precedence over stale assumptions about the current codebase.

## Backend child repository

The backend is **partially implemented and explicitly not yet approved as a sustainable final architecture**.

Observed package-level foundations currently include Laravel 12, Lighthouse GraphQL, JWT auth, Reverb, Spatie permission/activity/media packages, and Telescope development support.

This does not mean:

- authorization is complete;
- branch isolation is correct everywhere;
- schema design is sustainable;
- GraphQL resolvers are safe/optimized;
- finance modeling is correct;
- domain boundaries are final;
- AI architecture is complete;
- migration strategy is implemented;
- existing `*_COMPLETE.md` backend documents are proof that the implementation is actually complete.

Validate claims against executable source and tests.

When documentation and code conflict:

- record the conflict;
- prefer executable code as evidence of current behavior;
- use this parent project context as target-state authority;
- do not silently declare either side correct without review.

---

# 14. Non-Negotiable Security Invariants

Every future implementation must preserve:

1. Organization isolation.
2. Branch isolation.
3. Server-side RBAC and action authorization.
4. Financial visibility restrictions.
5. No unrestricted AI-to-DB access.
6. No destructive autonomous actions bypassing approval.
7. Auditability for AI, workflow, finance, security, and incident actions.
8. No secrets or raw technical incident payloads exposed to customers.
9. Cross-branch operations must require explicit authorization.
10. Frontend visibility controls must never substitute for backend authorization.

---

# 15. Development Order

Recommended dependency order after Code Graph review:

```text
1. Auth + organization/branch context + RBAC
2. Database and audit foundations
3. GraphQL foundation
4. Property
5. Owner
6. Tenant
7. Agreement
8. Finance
9. Maintenance/vendor
10. CRM where prioritized
11. Workflow/approvals
12. Notifications/Reverb
13. ZaakiyVerse skills/AI
14. Reporting/search/snapshots
15. Ops Intelligence
16. Legacy migration and cutover
```

Do not interpret this list as permission to implement. It is a dependency model for later approved work.

---

# 16. Current Pre-Development Gate

Before broad implementation work:

- initialize both submodules on `main`;
- generate and commit the Code Graph;
- map frontend GraphQL consumers to backend schema/resolvers;
- inventory backend domains/models/migrations/policies/services/events/jobs;
- verify organization/branch/RBAC enforcement paths;
- compare actual database schema to target domain/data model;
- identify technical debt and sustainability risks in the partial backend;
- classify each target capability as implemented / partial / absent / conflicting / unknown;
- produce an architecture review before major backend refactoring.

This parent repository exists so agents can answer questions about the whole system by consulting project context plus both source repositories instead of reasoning from isolated code fragments.
