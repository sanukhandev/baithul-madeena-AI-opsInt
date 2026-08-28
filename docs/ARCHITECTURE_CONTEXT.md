# Architecture Context

## Product

Baithul Madeena ERP modernization is a multi-branch real-estate operations platform serving Fujairah, Ajman, Dubai, and future branches under one organization. It replaces a legacy CodeIgniter 3 + Angular 11 + MySQL system with a Laravel + React + MySQL platform.

## Core product domains

- Dashboard and operational intelligence
- Owners and owner portal
- Tenants and tenant portal
- Properties, buildings, units/rooms
- Agreements and approvals
- Finance/accounting/payroll
- Maintenance and vendor portal
- CRM/leads
- Workflow and automation
- Notifications/realtime
- Reporting/search
- ZaakiyVerse AI
- Autonomous Ops Intelligence
- Legacy data migration

## Organizational hierarchy

```text
Organization
└── Branch
    ├── Users/RBAC
    ├── Owners
    ├── Properties
    │   ├── Buildings
    │   └── Units
    ├── Tenants
    ├── Agreements
    ├── Finance
    ├── Maintenance/Vendors
    ├── Workflows
    ├── Notifications
    ├── Reporting
    └── AI/Ops Intelligence
```

Operational data is branch-aware. Organization-level users may access consolidated data only through explicit authorization.

## Branch domains

- Fujairah: `fujairah.baithulmadeena.ae`
- Ajman: `ajman.baithulmadeena.ae`
- Dubai: `dubai.baithulmadeena.ae`

Branch context may be derived from domain, authenticated session/JWT claims, organization mapping, and permissions.

## Backend baseline

- Laravel 12
- PHP 8.3+
- MySQL 8
- GraphQL via Lighthouse
- JWT authentication
- RBAC with branch/action/data visibility controls
- Laravel Reverb for realtime events and notifications
- Database queue driver
- Laravel file/database cache; no mandatory Redis in phase 1
- SSE/streamed HTTP responses for AI streaming
- MySQL optimized search and reporting snapshot tables

GraphQL resolvers must enforce organization, branch, RBAC, field/data visibility, pagination, selective columns, and relationship constraints. Raw unrestricted Eloquent models should not be exposed through GraphQL.

## ZaakiyVerse AI baseline

ZaakiyVerse is an embedded operational intelligence and orchestration layer, not a generic chatbot.

Recommended flow:

```text
User
→ Frontend AI Interface
→ AI Gateway
→ Intent/Skill Router
→ Permission Validator
→ Context Builder
→ Domain Service / GraphQL
→ MySQL
→ Gemini when reasoning is required
→ Response Composer
→ Audit Log
```

Use deterministic skills/workflows for routine operational actions and reserve Gemini for deeper reasoning, summarization, risk analysis, financial analysis, reporting, or incident RCA.

AI must never directly query unrestricted database tables or bypass business validation, approvals, RBAC, or branch isolation.

## Ops Intelligence baseline

The platform should eventually support incident collection and AI-assisted operational intelligence for API/GraphQL/database/queue/AI/Reverb/storage/security failures.

Target lifecycle:

```text
Failure
→ Incident Collector
→ Operational Context Builder
→ AI Analysis
→ GitHub Escalation
→ Engineering/Codex/Copilot Resolution Workflow
→ CI Validation
→ Deployment Tracking
→ Realtime Status Communication
→ Resolution Audit
```

No autonomous destructive merge/deploy behavior should bypass human approvals and CI validation.

## Database principles

- BIGINT auto-increment internal primary keys for transactional efficiency
- public UUID/external reference only where needed
- normalized modular schema
- organization/branch scoping on operational data
- created/updated actor metadata and timestamps
- soft deletes for critical business records where appropriate
- composite indexes led by branch/status/date for operational queries
- reporting/context snapshots for expensive aggregation/AI context
- MySQL full-text search initially instead of external search infrastructure

## Frontend principles

The UI should operate as an enterprise AI-native command center: modern, information-dense, responsive, branch-aware, role-aware, contextual, workflow-oriented, and realtime. ZaakiyVerse should be embedded in entity/module context rather than presented as a detached consumer chatbot.

## Pre-development gate

Before feature development begins, add Code Graph output to this parent repository and reconcile these target requirements with the actual frontend/backend implementation. Treat the graph and live source as implementation truth where they reveal existing contracts, while this document remains the target architecture baseline.
