#!/usr/bin/env bash
set -euo pipefail

PORT="${PORT:-3000}"

exec npm run start -- --hostname 0.0.0.0 --port "${PORT}"
