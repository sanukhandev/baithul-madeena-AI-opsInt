# Codex Prompt — Parent Repository Bootstrap & Code Graph Preparation

You are working in the parent repository `sanukhandev/baithul-madeena-AI-opsInt`.

## Current task mode

This phase is repository setup and analysis only. Do **not** implement or refactor ERP features yet.

## Required repository topology

The parent contains two Git submodules:

- `frontend/` → `https://github.com/sanukhandev/baithul-madeena-ai-hub.git`, branch `main`
- `backend/` → `https://github.com/sanukhandev/baithul-madeena-ai-hub-be.git`, branch `main`

The backend `main` branch was created from the existing backend default-branch tip specifically to standardize this parent workflow.

## First commands

```bash
git submodule sync --recursive
git submodule update --init --recursive
git -C frontend checkout main
git -C frontend pull --ff-only origin main
git -C backend checkout main
git -C backend pull --ff-only origin main
git status --short
git submodule status
```

Do not make child-repository changes if either working tree is dirty unexpectedly. Report the state instead.

## Read before analysis

Read:

- `AGENTS.md`
- `docs/ARCHITECTURE_CONTEXT.md`
- `docs/CODE_GRAPH_PLAN.md`

Then inspect both submodules.

## Code Graph goal

Before development begins, build a machine-readable and human-readable Code Graph covering both repositories and their cross-repo contracts.

At minimum capture:

### Frontend
- route tree
- page/module boundaries
- shared components/layouts
- GraphQL documents/clients/hooks
- authentication/session handling
- branch-context handling
- RBAC/permission checks
- realtime/Reverb/WebSocket usage
- ZaakiyVerse UI surfaces
- data models/types
- environment/config dependencies

### Backend
- Laravel modules/domains
- models and relationships
- migrations/tables
- GraphQL schema, queries, mutations, resolvers/directives
- auth middleware/guards/JWT implementation
- organization/branch context resolution
- RBAC/policies/permissions
- events/listeners/jobs/queues
- Reverb/broadcast channels
- AI/Gemini services and context builders
- workflow/automation services
- reporting/search implementations
- incident/Ops Intelligence hooks

### Cross-repo contracts
- frontend GraphQL operation → backend schema/resolver
- frontend type → GraphQL/backend type
- realtime event/channel producer → frontend consumer
- auth/session claims expected on both sides
- branch/RBAC semantics shared across repos
- environment-variable/API endpoint dependencies

## Output location

Write analysis artifacts only in the parent repository, under:

```text
docs/code-graph/
```

Recommended outputs:

```text
docs/code-graph/
├── README.md
├── frontend-map.md
├── backend-map.md
├── graphql-contracts.md
├── realtime-contracts.md
├── auth-rbac-branch-context.md
├── dependency-risks.md
├── gaps-vs-target-architecture.md
└── graph.json
```

`graph.json` should use stable node identifiers and explicit edges so later agents can query dependencies without rescanning the whole codebase.

## Strict limits for this phase

Do not:
- edit `frontend/` application files;
- edit `backend/` application files;
- create feature code;
- create migrations;
- alter GraphQL contracts;
- change dependencies;
- run destructive database commands;
- deploy;
- merge PRs.

You may run read-only tests/build/static-analysis commands if useful for mapping the codebase, but document failures instead of trying to fix them.

## Completion criteria

This phase is complete when:

1. both submodules are initialized and on `main`;
2. the Code Graph artifacts exist in `docs/code-graph/`;
3. cross-repo contracts and architecture gaps are documented;
4. no application source code was changed;
5. the parent repository contains only analysis/documentation updates and, if needed, updated submodule pointers to already-existing commits.

Stop after producing the graph and analysis. Wait for the next explicit development task.
