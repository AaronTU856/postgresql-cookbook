/*
Title: Healthcheck Query
Difficulty: Beginner

Learning Objectives:
- Use a simple SQL healthcheck.
- Confirm database responsiveness.
- Keep readiness checks cheap.

Problem Statement:
The Docker service needs a lightweight query that proves PostgreSQL can respond.

Business Scenario:
Applications and CI jobs should wait for PostgreSQL readiness before running
schema or test commands.

SQL Solution:
*/

SELECT
    1 AS database_is_ready;

SELECT
    NOW() AS checked_at,
    current_database() AS database_name;

/*
Explanation:
Simple healthcheck queries should be cheap and reliable. More detailed checks
belong in diagnostics, not high-frequency health probes.

Expected Output:
The first query returns 1. The second query returns the check timestamp and
database name.

Performance Notes:
Keep healthchecks simple. Expensive healthchecks can become their own production
problem.

Common Mistakes:
- Running heavy reports as healthchecks.
- Treating container started as database ready.
- Ignoring healthcheck retries and startup timing.

Challenge Exercise:
Return the current transaction read-only setting.

Challenge Solution:
*/

SELECT
    current_setting('transaction_read_only') AS transaction_read_only;

/*
Related Chapters:
- ../16_administration/01_database_health_checks.sql
- 01_connection_check.sql
- 05_container_troubleshooting_queries.sql
*/
