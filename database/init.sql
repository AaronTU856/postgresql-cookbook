-- Bootstrap the local learning database.
-- The PostgreSQL Docker image runs this file when the database volume is first created.
-- Re-run with docker compose down -v when you want a clean database reset.

\set ON_ERROR_STOP on

-- pgcrypto is enabled now so later chapters can use UUID examples without
-- changing the Docker bootstrap process.
CREATE EXTENSION IF NOT EXISTS pgcrypto;

\i /database/schema.sql
\i /database/seed.sql
