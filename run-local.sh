#!/bin/bash
# export $(cat .env | xargs)
# npx ts-node test.ts
# npx ts-node --project backend/tsconfig.json backend/test.ts
set -a
source .env
set +a
echo "DB_SSL is: $DB_SSL"
# npx ts-node --project backend/tsconfig.json backend/test.ts
npx ts-node --project backend/configts.json backend/test.ts