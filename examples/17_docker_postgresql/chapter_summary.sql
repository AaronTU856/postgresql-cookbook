/*
Title: Docker & PostgreSQL Chapter Summary
Difficulty: Beginner

Learning Objectives:
- Review Docker PostgreSQL verification queries.
- Confirm connection, readiness, and initialization.
- Gather safe troubleshooting data.

Problem Statement:
Summarise a reliable post-startup checklist for the cookbook PostgreSQL
container.

Business Scenario:
New contributors should be able to prove their local database is ready before
running examples or tests.

SQL Solution:
*/

SELECT
    current_database() AS database_name,
    current_user AS connected_user,
    pg_postmaster_start_time() AS server_started_at;

SELECT
    (SELECT COUNT(*) FROM users) AS users_count,
    (SELECT COUNT(*) FROM products) AS products_count,
    (SELECT COUNT(*) FROM orders) AS orders_count;

SELECT
    COUNT(*) AS current_database_sessions
FROM pg_stat_activity
WHERE datname = current_database();

/*
Explanation:
The summary confirms identity, seed data, and session visibility from inside the
PostgreSQL server.

Expected Output:
The queries return connection details, seed counts, and current session count.

Performance Notes:
This is safe for local and CI checks. Production readiness requires deeper
backup, monitoring, and security checks.

Common Mistakes:
- Skipping database verification after container startup.
- Resetting containers but not volumes.
- Treating Docker local performance as production performance.

Challenge Exercise:
Check the table list in the public schema.

Challenge Solution:
*/

SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name ASC;

/*
Related Chapters:
- ../16_administration/chapter_summary.sql
- ../13_performance/chapter_summary.sql
- ../18_django_examples/README.md
*/
