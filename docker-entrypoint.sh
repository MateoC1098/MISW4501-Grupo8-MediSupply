#!/bin/sh
set -e

# echo "▶️ Running migrations..."
# npx knex migrate:latest --knexfile dist/database/knexfile.js

echo "▶️ Starting NestJS app..."
exec node dist/main.js
