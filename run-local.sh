#!/bin/bash

# Start postgres container if not running
if [ "$(docker ps -q -f name=postgres-local)" = "" ]; then
  echo "Starting postgres container..."
  docker start postgres-local
  sleep 2
fi

set -a
source .env
set +a
echo "DB_SSL is: $DB_SSL"
# npx ts-node --project backend/tsconfig.json backend/test.ts
npx ts-node --project backend/configts.json backend/test.ts