# Repository Context

## Parent

`sanukhandev/baithul-madeena-AI-opsInt`

Role: architecture, coordination, code graph, project context, agent instructions, review findings, implementation planning, and submodule pointers.

Branch: `main`

## Frontend

`sanukhandev/baithul-madeena-ai-hub`

Mounted as: `frontend/`

Branch: `main`

Observed current package baseline from `package.json`:

- React 19
- TypeScript
- TanStack Start
- TanStack Router
- TanStack Query
- Vite
- Tailwind CSS 4
- Framer Motion
- Recharts
- Radix UI primitives
- React Hook Form
- Zod
- Bun lockfile/tooling present
- Cloudflare Vite plugin present

Implication: older target notes that simply say `React Router` are architectural intent, not an instruction to replace TanStack Router. Review current source before proposing frontend framework changes.

## Backend

`sanukhandev/baithul-madeena-ai-hub-be`

Mounted as: `backend/`

Branch: `main`

Status: **partially implemented; sustainability and completeness not yet approved**.

Observed current package baseline from `composer.json`:

- Laravel Framework 12
- PHP constraint currently `^8.2`
- Laravel Reverb
- Lighthouse GraphQL
- JWT Auth (`php-open-source-saver/jwt-auth`)
- Spatie Activitylog
- Spatie Media Library
- Spatie Permission
- Telescope in dev dependencies
- PHPUnit

The target parent architecture calls for PHP 8.3+; this is a target/current mismatch to review later rather than silently changing now.

The backend repository also contains documentation asserting completion/integration of authorization/framework work. Those documents are review inputs only. They do not override executable source, migrations, tests, or the parent target context.

## Coordination rule

Child application changes belong in the relevant child repository. After an approved child commit is made, update the parent submodule pointer in a separate coordination commit.

Do not copy child application source into the parent.

## Current phase

Until explicitly changed by a later task:

- enrich parent context;
- inspect source;
- build Code Graph;
- review backend architecture and sustainability;
- document gaps;
- do not perform broad application refactoring merely because a gap is discovered.
