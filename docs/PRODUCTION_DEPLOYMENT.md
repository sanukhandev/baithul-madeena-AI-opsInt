# Production deployment

Target: `https://erp.dw-digitalplatforms.in/` on `147.93.101.184:65002`, path `/home/u249550001/domains/dw-digitalplatforms.in/public_html/erp`.

The intended request flow is Apache → `erp/public/index.php` → Laravel/Lighthouse (`POST /graphql`). The domain document root must point to `/home/u249550001/domains/dw-digitalplatforms.in/public_html/erp/public`; pointing it at the project root would expose application source and is not supported.

The CI packaging workflow at `.github/workflows/package-production.yml` builds the frontend on GitHub Actions (Node 22) and publishes two separate ZIP artifacts: `frontend-dist.zip` and `backend-app-no-vendor.zip`. The backend archive excludes `vendor`, `.env*`, and persistent runtime files. Download and upload these artifacts independently through the hosting file manager; copy the existing compatible `vendor/` directory separately. No workflow step reads, creates, modifies, or uploads either environment file.

`deploy/production.sh` remains an SSH-key/rsync option for hosts that support it. It never carries a password. If password authentication is required, provide it out-of-band as `<SSH_PASSWORD_SECRET>`; never add it to this repository.

## Current release blocker

The frontend is a TanStack Start Cloudflare SSR build. `npm run build` produces `dist/client` assets plus a server worker bundle, but no `dist/client/index.html`. A PHP Laravel deployment cannot safely serve that worker output as a SPA shell. The deployment script therefore aborts before SSH upload until one of these is selected:

1. provide a supported Node SSR runtime on the hosting account and deploy the frontend worker alongside Laravel; or
2. approve a separate static-SPA build target that emits an `index.html` and route fallback compatible with Laravel.

No remote deployment was attempted beyond a non-authenticated capability probe; the server rejected the SSH connection from this environment. No migrations or remote files were changed.

## Artifact deployment procedure

1. Run the workflow manually or push a version tag and download its artifacts.
2. Upload `backend-app-no-vendor.zip` into `/home/u249550001/domains/dw-digitalplatforms.in/public_html/erp` and extract without deleting `.env`, `storage/app`, or `storage/logs`.
3. Copy the manually prepared `vendor/` directory into `erp/vendor` (or run `composer install --no-dev --prefer-dist --optimize-autoloader` on the server).
4. Upload `frontend-dist.zip` to the configured static frontend location only after the static-SPA/SSR decision below is resolved. Do not overwrite Laravel's `public/index.php`.
5. Run Laravel optimization and `php artisan migrate --force` from the hosting terminal. Never run `migrate:fresh`, `db:wipe`, or schema drops.

## Server setup after the blocker is resolved

Create the server `.env` from `backend/.env.production.example` using real secrets out-of-band, point the subdomain document root to `erp/public`, then run `deploy/production.sh` with SSH key authentication. The database worker requires `php artisan queue:work --sleep=3 --tries=3`; if Laravel scheduling is enabled, add a once-per-minute cron for `php artisan schedule:run`. Reverb is optional and should only be started if the hosting account supports a persistent process.

Rollback is the hosting-panel backup or previous release copy; the script does not delete `storage/app` or `storage/logs`.
