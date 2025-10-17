#!/usr/bin/env bash
set -euo pipefail

# Your desired data directory (can be overridden at runtime: -e DATA_DIR=/workspace/data)
DATA_DIR="${DATA_DIR:-/workspace/data}"

# Ensure it exists & permissions are correct
mkdir -p "$DATA_DIR"
chown -R postgres:postgres "$DATA_DIR"
chmod 700 "$DATA_DIR" || true

if [ -d "$DATA_DIR" ] && [ -z "$(ls -A "$DATA_DIR")" ] && [ -d /var/tmp_data ] && [ "$(ls -A /var/tmp_data)" ]; then
  mv /var/tmp_data/* "$DATA_DIR"
fi

# Export PGDATA so the upstream entrypoint *and* postgres use it
export PGDATA="$DATA_DIR"

# Hand off to the upstream entrypoint used by the image
exec /usr/local/bin/docker-entrypoint.sh "$@"
