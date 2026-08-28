# Source of Truth and Review Policy

## Why this file exists

The Baithul Madeena program has requirements, architecture documents, frontend source, a partially built backend, and future Code Graph artifacts. Agents must know which source is authoritative for which question.

## Authority order by question type

### Product scope and target behavior

Use:

1. `docs/PROJECT_CONTEXT.md`
2. other parent `docs/` architecture/context files
3. approved architecture decisions added later

Do not remove a requirement merely because current code does not implement it.

### Current implementation behavior

Use executable source in the relevant child repository.

- frontend source for current frontend behavior/framework
- backend source/migrations/schema/config/tests for current backend behavior

Repository documentation is supporting evidence, not proof of implementation.

### Cross-repository contracts

Use:

1. current backend GraphQL schema/resolvers
2. current frontend GraphQL consumers/types
3. Code Graph mappings
4. target contract documents in the parent

Any mismatch must be recorded as a contract gap.

### Database truth

For current backend schema, migrations and actual model relationships are stronger evidence than design documents.

For target schema, parent project context and approved architecture decisions remain authoritative.

### Security truth

Security invariants in the parent are non-negotiable target constraints. Current implementation must be audited against them.

## Backend partial-state rule

The backend is partially implemented. Never infer architectural approval from:

- file names containing `COMPLETE`;
- delivery summaries;
- checklists marked complete;
- package installation;
- generated scaffolding.

Validate implementation through source paths, migrations, policies/middleware, resolvers, tests, and runtime behavior where available.

## Conflict handling

When sources conflict, explicitly report:

```text
TARGET: what parent context requires
CURRENT: what code currently does
GAP: why the difference matters
DECISION NEEDED: retain / refactor / replace / investigate
```

Do not silently reconcile contradictory sources.

## Code Graph role

The future Code Graph is an evidence index, not a replacement for source. It should make it easier to answer:

- where a frontend page gets its data;
- which GraphQL operation it calls;
- which resolver/service/model/table implements it;
- where authorization is enforced;
- what events/jobs/realtime paths are triggered;
- which modules depend on a schema or service;
- which requirements are absent or only partial.

## Agent query behavior

When asked about a feature or code path:

1. read the relevant parent context;
2. inspect the relevant frontend/backend source;
3. inspect Code Graph artifacts when present;
4. state whether the answer describes current behavior, target architecture, or both;
5. identify uncertainty rather than inventing implementation details.
