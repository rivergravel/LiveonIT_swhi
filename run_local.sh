#!/bin/bash

# Start postgres container if not running
if [ "$(docker ps -q -f name=postgres-local)" = "" ]; then
  echo "Starting postgres container..."
  docker start postgres-local
  sleep 2
fi

# Setup local user and database if DB_SSL is false (local mode)
set -a
source .env
set +a
echo "DB_SSL is: $DB_SSL"

if [ "$DB_SSL" = "false" ]; then
  echo "Local mode detected - ensuring local DB user and database exist..."
  docker exec postgres-local psql -U postgres -c "CREATE USER localuser WITH PASSWORD 'localpassword';" 2>/dev/null || true
  docker exec postgres-local psql -U postgres -c "CREATE DATABASE app_db OWNER localuser;" 2>/dev/null || true
  docker exec postgres-local psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE app_db TO localuser;" 2>/dev/null || true
  echo "Local DB setup complete"
fi

npx ts-node --project backend/configts.json backend/src/local.ts