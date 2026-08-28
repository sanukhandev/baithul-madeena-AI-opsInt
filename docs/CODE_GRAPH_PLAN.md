# Code Graph Preparation Plan

## Purpose

The Code Graph is a pre-development gate. Its purpose is to establish the actual dependency and contract topology of the existing frontend/backend code before modernization work proceeds.

## Required graph domains

### Frontend nodes

- routes/pages
- feature modules
- components/layouts
- hooks/services
- GraphQL operations/fragments
- types/interfaces
- auth/session modules
- branch/RBAC modules
- realtime consumers
- ZaakiyVerse surfaces

### Backend nodes

- domains/modules
- models
- migrations/tables
- GraphQL schema types
- queries/mutations
- resolvers/directives
- middleware/policies
- events/listeners/jobs
- queues/schedules
- broadcasts/channels
- AI services
- workflow services
- reporting/search services
- Ops Intelligence services

### Edge types

Use explicit relationship labels such as:

- `ROUTES_TO`
- `RENDERS`
- `IMPORTS`
- `CALLS_GRAPHQL`
- `IMPLEMENTS_QUERY`
- `IMPLEMENTS_MUTATION`
- `RESOLVES`
- `READS_MODEL`
- `WRITES_MODEL`
- `USES_TABLE`
- `AUTHORIZES_WITH`
- `SCOPED_BY_BRANCH`
- `BROADCASTS`
- `SUBSCRIBES_TO`
- `DISPATCHES_JOB`
- `HANDLES_EVENT`
- `USES_AI_SERVICE`
- `TRIGGERS_WORKFLOW`
- `DEPENDS_ON_ENV`

## Suggested graph JSON shape

```json
{
  "version": 1,
  "generatedAt": "ISO-8601",
  "repositories": [],
  "nodes": [
    {
      "id": "backend:graphql:query:dashboardSummary",
      "repo": "backend",
      "kind": "graphql_query",
      "name": "dashboardSummary",
      "path": "...",
      "metadata": {}
    }
  ],
  "edges": [
    {
      "from": "frontend:graphql:GetDashboardSummary",
      "to": "backend:graphql:query:dashboardSummary",
      "type": "CALLS_GRAPHQL",
      "metadata": {}
    }
  ]
}
```

## Gap analysis

After building the factual graph, compare it against the target architecture in `docs/ARCHITECTURE_CONTEXT.md` and classify gaps as:

- implemented
- partially implemented
- absent
- conflicting implementation
- unknown / needs runtime verification

Do not silently rewrite the target architecture to match legacy implementation. Document differences so the next development task can prioritize them explicitly.

## Security review focus

Specifically identify code paths that could violate:

- organization isolation
- branch isolation
- module/action RBAC
- financial visibility restrictions
- direct AI-to-database access restrictions
- audit logging requirements
- destructive workflow approval requirements

## Output rule

The graph is analysis output only. Do not fix identified gaps during Code Graph generation unless a later task explicitly authorizes code changes.
