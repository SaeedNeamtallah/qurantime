#!/usr/bin/env bash
set -euo pipefail

PORT="${PORT:-8000}"
WORKERS="${WEB_CONCURRENCY:-2}"
TIMEOUT="${GUNICORN_TIMEOUT:-120}"

exec gunicorn -k uvicorn.workers.UvicornWorker -w "${WORKERS}" --timeout "${TIMEOUT}" --bind "0.0.0.0:${PORT}" main:app
