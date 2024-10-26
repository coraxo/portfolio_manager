#!/bin/bash
set -e

databases=("portfolio_manager_production_cache" "portfolio_manager_production_queue" "portfolio_manager_production_cable")

for db in "${databases[@]}"; do
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE $db;
    GRANT ALL PRIVILEGES ON DATABASE $db TO $POSTGRES_USER;
EOSQL
done
