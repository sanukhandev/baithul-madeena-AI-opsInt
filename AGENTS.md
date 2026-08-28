# AGENTS.md — Baithul Madeena AI Ops Intelligence

## Mission

Use this parent repository as the coordination, architecture, source-context, code-graph, and intelligence layer for the Baithul Madeena ERP modernization program.

The frontend and backend are independent repositories attached as submodules.

## Mandatory reading order

Before answering architecture questions or changing code, read:

1. `docs/PROJECT_CONTEXT.md`
2. `docs/SOURCE_OF_TRUTH.md`
3. `docs/REPOSITORY_CONTEXT.md`
4. `docs/ARCHITECTURE_CONTEXT.md`
5. relevant Code Graph artifacts under `docs/code-graph/` when present
6. actual source in the affected child repository

## Repository map

- `frontend/` — `sanukhandev/baithul-madeena-ai-hub`, branch `main`
- `backend/` — `sanukhandev/baithul-madeena-ai-hub-be`, branch `main`
- `docs/` — product, architecture, source-of-truth, AI, data, operations, code graph, and development context

## Authority model

The parent defines target product and architecture context.

The child repositories define current executable implementation.

Never silently treat current implementation as target architecture, and never claim target requirements are already implemented without verifying source.

For conflicts, report:

```text
TARGET
CURRENT
GAP
DECISION NEEDED
```

## Backend status

The backend is **partially built and not yet approved as sustainable or complete**.

Existing backend documents with names such as `*_COMPLETE.md`, delivery summaries, or completed checklists are evidence to inspect, not proof that the architecture or implementation is actually complete.

Validate backend claims against:

- GraphQL schema/resolvers/directives
- middleware/policies
- domain/services
- Eloquent models
- migrations
- events/jobs/listeners
- tests
- runtime behavior where available

Do not perform broad backend rewrites until an explicit review/build task authorizes them.

## Current hard stop

This repository remains in **context + analysis / pre-development mode** until a later task explicitly authorizes implementation.

Allowed work:

- initialize/update submodules;
- inspect source and history;
- generate Code Graph/indexing artifacts;
- document target architecture;
- document current implementation;
- document gaps, risks, sustainability concerns, and implementation plans;
- improve parent agent/context documentation.

Not authorized yet:

- broad feature implementation;
- unscheduled refactors;
- database redesign applied to child code;
- GraphQL contract rewrites;
- frontend redesign;
- infrastructure replacement.

## Branch policy

Use `main` for parent, frontend, and backend coordination.

If submodule initialization leaves a detached HEAD, explicitly check out `main` before any later authorized child-repository work.

Never silently switch work to `master`, `develop`, or another branch.

## Architecture baseline

The modernization target is a multi-branch real-estate ERP with:

- strict organization/branch isolation
- internal identity/RBAC
- GraphQL-first application contract
- MySQL persistence
- Laravel Reverb realtime infrastructure
- database queues
- workflow automation
- auditability
- reporting snapshots
- ZaakiyVerse AI
- autonomous Ops Intelligence
- legacy-data migration

Backend target baseline:

- Laravel 12
- PHP 8.3+ target
- GraphQL via Lighthouse
- MySQL 8
- JWT authentication
- branch-aware RBAC
- Laravel Reverb
- database queue driver
- file/database cache in phase 1
- SSE/streaming for AI
- Gemini for deeper reasoning
- modular-monolith domain organization
- controlled service/data access; AI must never query unrestricted DB tables directly

Frontend target baseline is modern React/TypeScript enterprise UX, but respect the actual current framework choices found in the frontend source. Current package evidence includes TanStack Start/Router/Query and React 19; do not replace those simply because older requirements mention React Router.

## Mandatory security invariants

Every implementation proposal must preserve:

1. `organization_id` and `branch_id` isolation for operational data.
2. Explicit authorization for cross-branch operations.
3. Server-side RBAC/action authorization before data access or mutations.
4. Financial/data visibility restrictions.
5. No direct LLM-to-database execution.
6. No destructive autonomous action bypassing approvals.
7. AI, workflow, finance, security, and incident actions must be auditable.
8. Customer-facing incident messages must not expose raw stack traces, secrets, or internal infrastructure details.
9. Frontend visibility controls never substitute for backend authorization.

## Development sequencing baseline

When implementation is authorized, prefer this dependency order:

1. Auth + organization/branch context + RBAC
2. Database + audit foundations
3. GraphQL foundation
4. Property
5. Owner
6. Tenant
7. Agreement
8. Finance
9. Maintenance/vendor
10. CRM when prioritized
11. Workflow/approvals
12. Notifications/Reverb
13. ZaakiyVerse AI/skills
14. Reporting/search/snapshots
15. Ops Intelligence
16. Legacy migration/cutover

Do not begin broad implementation until Code Graph analysis is present and the backend's partial architecture has been reviewed against target context.

## Code Graph expectations

The graph should connect frontend routes/components/GraphQL operations to backend schema/resolvers/services/models/tables, and also capture authorization, events/jobs, realtime, AI, workflows, and environment dependencies.

The graph is evidence and navigation support, not a substitute for source inspection.

## Agent operating rules

Before changing code in a later task:

1. determine whether the question is about target state, current state, or both;
2. read the parent context;
3. inspect Code Graph artifacts;
4. inspect actual affected source;
5. check submodule branch and cleanliness;
6. identify cross-repo GraphQL/event/type impacts;
7. identify authorization/branch/data-scope impacts;
8. keep application commits scoped to the correct child repository;
9. update the parent submodule pointer after approved child commits;
10. document architecture deviations explicitly.

Prefer incremental, reversible work. Do not introduce Redis, Elasticsearch/Meilisearch, vector databases, microservices, or other infrastructure unless later approved requirements and evidence justify them.
