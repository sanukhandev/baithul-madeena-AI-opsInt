# Baithul Madeena AI Ops Intelligence Parent Repository

This repository is the parent coordination workspace for the Baithul Madeena ERP modernization program.

## Repository topology

- `frontend/` → `sanukhandev/baithul-madeena-ai-hub` (`main`)
- `backend/` → `sanukhandev/baithul-madeena-ai-hub-be` (`main`)

Both application repositories are consumed as Git submodules. Development inside the application repositories is intentionally out of scope for this setup phase.

## Current phase

Parent repository bootstrap only:

1. establish the parent orchestration repository;
2. pin frontend/backend submodules to known commits on `main`;
3. add agent instructions and architecture/context documentation;
4. prepare for Code Graph integration before development starts.

## Clone

```bash
git clone --recurse-submodules https://github.com/sanukhandev/baithul-madeena-AI-opsInt.git
cd baithul-madeena-AI-opsInt
git submodule update --init --recursive
```

## Update submodules to their tracked `main` branches

```bash
git submodule update --remote --merge frontend backend
```

Do not modify frontend or backend code during repository-bootstrap tasks unless a later task explicitly authorizes development work.
