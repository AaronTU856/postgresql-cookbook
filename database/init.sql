-- Bootstrap the local learning database.
-- The PostgreSQL Docker image runs this file when the database volume is first created.

\set ON_ERROR_STOP on

CREATE EXTENSION IF NOT EXISTS pgcrypto;

\i /database/schema.sql
\i /database/seed.sql
