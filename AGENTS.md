# AGENTS.md — Baithul Madeena AI Ops Intelligence

## Mission

Use this parent repository as the coordination and intelligence layer for the Baithul Madeena ERP modernization program. The frontend and backend are independent repositories attached as submodules.

## Repository map

- `frontend/` — React frontend: `sanukhandev/baithul-madeena-ai-hub`, branch `main`
- `backend/` — Laravel backend: `sanukhandev/baithul-madeena-ai-hub-be`, branch `main`
- `docs/` — product, architecture, AI, data, operations, and development context

## Current hard stop

This repository is currently in **bootstrap / analysis mode**.

Until a later task explicitly authorizes development:

- do not edit application source code in `frontend/` or `backend/`;
- do not create migrations, GraphQL schema changes, UI changes, or infrastructure changes;
- do not refactor either application repository;
- do not merge or push application-code changes;
- do not infer that repository setup authorizes implementation.

Allowed work in this phase:

- clone/init/update submodules;
- inspect repository structure and history;
- generate Code Graph/indexing artifacts;
- document architecture, dependencies, gaps, risks, and implementation plans;
- improve parent-repo agent/context documentation.

## Branch policy

Use `main` for the parent, frontend, and backend coordination flow. If a submodule working tree is detached after normal Git submodule initialization, check out its `main` branch before any later authorized development work.

Never silently switch application work to `master`, `develop`, or another branch.

## Architecture baseline

The modernization target is a multi-branch real-estate ERP with strict organization/branch isolation, internal RBAC, GraphQL-first backend integration, MySQL persistence, Laravel Reverb realtime infrastructure, database queues, ZaakiyVerse AI, workflow automation, reporting, auditability, and Ops Intelligence.

Backend baseline:

- Laravel 12 / PHP 8.3+
- GraphQL via Lighthouse
- MySQL 8
- JWT authentication
- branch-aware RBAC
- Laravel Reverb
- database queue driver
- Laravel file/database cache (no Redis requirement in phase 1)
- Gemini for deeper enterprise reasoning
- controlled domain/service access; AI must never query unrestricted DB tables directly

Frontend baseline:

- React + TypeScript
- enterprise operational command-center UX
- branch-aware routing/navigation
- role-aware UI
- contextual ZaakiyVerse experiences
- GraphQL integration
- realtime operational updates

## Mandatory security invariants

Every implementation proposal must preserve:

1. `organization_id` and `branch_id` isolation for operational data.
2. RBAC/action authorization before data access or mutations.
3. No direct LLM-to-database execution.
4. No destructive autonomous action that bypasses approvals.
5. AI, workflow, finance, and incident actions must be auditable.
6. Customer-facing incident messages must never expose raw stack traces, secrets, or internal infrastructure details.

## Development sequencing baseline

When implementation is later authorized, prefer this dependency order:

1. Auth + organization/branch context + RBAC
2. Database schema and audit foundations
3. GraphQL foundation
4. Property
5. Owner
6. Tenant
7. Agreement
8. Finance
9. Maintenance/vendor
10. Workflow/approvals
11. Notifications/Reverb
12. ZaakiyVerse AI/skills
13. Reporting snapshots/search
14. Ops Intelligence
15. Legacy migration/cutover

Do not start broad feature implementation until Code Graph analysis has been added to this parent repository and reconciled with the actual frontend/backend codebases.

## Agent operating rules

Before changing code in a later task:

1. read this file and relevant files in `docs/`;
2. inspect the Code Graph and actual code paths affected;
3. check submodule branch and cleanliness;
4. identify cross-repo contract impact (GraphQL/schema/types/events);
5. keep commits scoped to the correct child repository;
6. update the parent submodule pointer only after child-repo changes are committed;
7. document any architecture deviation explicitly.

Prefer incremental, reversible work. Do not introduce Redis, Elasticsearch/Meilisearch, vector databases, microservices, or other infrastructure unless a later approved requirement calls for them.
