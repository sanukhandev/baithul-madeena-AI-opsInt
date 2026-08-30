# Production deployment

Production is deployed independently from the `dev` branch of each child repository:

- URL: https://erp.dw-digitalplatforms.in/
- Laravel root: `/home/u249550001/domains/dw-digitalplatforms.in/public_html/erp`
- Web document root: `/home/u249550001/domains/dw-digitalplatforms.in/public_html/erp/public`

The frontend is a plain Vite browser SPA. Apache serves `public/index.html` and `public/assets/`; no Node, SSR worker, Nitro server, or adapter runs in production. TanStack Router keeps browser history routes, and `/graphql` is same-origin.

`frontend/.github/workflows/deploy-production.yml` builds and replaces only `public/index.html` and `public/assets/`. It creates a private remote backup under `~/deploy-backups/frontend-<stamp>/` before activation.

`backend/.github/workflows/deploy-production.yml` packages Laravel with production Composer dependencies, then overlays code into the existing root. It never deletes the root, uses no `--delete`, excludes `.env`, storage runtime data, and `public/storage`, and backs up previous code outside the web root under `~/deploy-backups/backend-<stamp>/`. It does not run migrations.

Required repository secrets are `PRODUCTION_SSH_HOST`, `PRODUCTION_SSH_PORT`, `PRODUCTION_SSH_USER`, and `PRODUCTION_SSH_PASSWORD`. A private key can replace password authentication later. Never put secret values in YAML or artifacts.

Apache serves physical files directly, routes `/graphql` and `/up` to Laravel `index.php`, and falls back other non-file browser paths to `index.html`. `public/index.php` remains the Laravel front controller.

Rollback: restore `index.html` and `assets/` from the frontend backup. For backend, extract `previous-code.tar.gz` over the application root with `.env`, `storage`, and `public/storage` excluded, then clear/rebuild Laravel caches. Validate `/`, `/login`, a nested route, static assets, and a JSON response from `/graphql` after either rollback.

The workflows refuse any ref other than `dev`; `workflow_dispatch` from another branch is skipped and the explicit shell check also fails.
