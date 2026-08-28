# Baithul Madeena AI Ops Intelligence Parent Repository

This repository is the coordination and project-intelligence workspace for the Baithul Madeena ERP modernization program.

## Repository topology

- `frontend/` → `sanukhandev/baithul-madeena-ai-hub` (`main`)
- `backend/` → `sanukhandev/baithul-madeena-ai-hub-be` (`main`)

Both application repositories are Git submodules.

## Start here

For agents, Codex, and architecture work, read in this order:

1. `AGENTS.md`
2. `docs/PROJECT_CONTEXT.md`
3. `docs/SOURCE_OF_TRUTH.md`
4. `docs/REPOSITORY_CONTEXT.md`
5. `docs/ARCHITECTURE_CONTEXT.md`
6. `docs/CODE_GRAPH_PLAN.md`
7. Code Graph artifacts under `docs/code-graph/` once generated

The parent repository is the target-state source of truth. The child repositories are the source of truth for current executable implementation.

The backend is partially built and has not yet been accepted as a sustainable final architecture. Existing backend completion documents must be verified against source, schema, migrations, policies, resolvers, and tests before their claims are trusted.

## Clone

```bash
git clone --recurse-submodules https://github.com/sanukhandev/baithul-madeena-AI-opsInt.git
cd baithul-madeena-AI-opsInt
git submodule update --init --recursive
```

## Track child `main` branches

```bash
git submodule update --remote --merge frontend backend
```

## Current working mode

The project is currently preparing for source-aware development:

- consolidate full project context in the parent;
- inspect frontend/backend source;
- generate Code Graph artifacts;
- map frontend ↔ GraphQL ↔ backend dependencies;
- review backend architecture, security, branch isolation, schema quality, and sustainability;
- then begin approved implementation work incrementally.

Do not silently refactor child application code during context or Code Graph tasks.
