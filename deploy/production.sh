#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKEND="$ROOT/backend"
FRONTEND="$ROOT/frontend"
REMOTE_USER="u249550001"
REMOTE_HOST="147.93.101.184"
REMOTE_PORT="65002"
REMOTE_PATH="/home/u249550001/domains/dw-digitalplatforms.in/public_html/erp"

command -v php >/dev/null || { echo "php is required" >&2; exit 1; }
command -v composer >/dev/null || { echo "composer is required" >&2; exit 1; }
command -v npm >/dev/null || { echo "npm is required" >&2; exit 1; }
command -v rsync >/dev/null || { echo "rsync is required (use SSH key authentication)" >&2; exit 1; }

cd "$FRONTEND"
npm ci
npm run build

# Laravel must remain the HTTP entrypoint. A static SPA shell is required for
# PHP-only hosting; the current TanStack Start SSR build intentionally fails
# here instead of uploading a worker bundle as if it were an index.html.
if [[ ! -f "$FRONTEND/dist/client/index.html" ]]; then
  echo "No frontend/dist/client/index.html was produced; current build is SSR/worker output." >&2
  echo "Configure a supported static SPA build or Node SSR runtime before deploying." >&2
  exit 2
fi

cd "$BACKEND"
composer install --no-dev --prefer-dist --optimize-autoloader
php artisan lighthouse:validate-schema

ssh -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" "mkdir -p '$REMOTE_PATH' '$REMOTE_PATH/storage' '$REMOTE_PATH/bootstrap/cache'"
rsync -az --delete \
  --exclude='.env' --exclude='.git' --exclude='storage/app/*' --exclude='storage/logs/*' \
  --exclude='node_modules' \
  "$BACKEND/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH/"

ssh -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" "cd '$REMOTE_PATH' && php artisan migrate --force && php artisan optimize:clear && php artisan config:cache && php artisan route:cache && php artisan view:cache && php artisan storage:link || true"
echo "Deployment completed: https://erp.dw-digitalplatforms.in/"
