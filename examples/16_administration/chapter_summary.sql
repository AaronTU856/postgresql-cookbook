/*
Title: PostgreSQL Administration Chapter Summary
Difficulty: Intermediate

Learning objectives:
- Review safe administration checks.
- Inspect health, size, activity, and permissions.
- Practise production-minded database diagnostics.

Problem statement:
Summarise common first-response checks for a PostgreSQL-backed application.

Business scenario:
During an incident, backend engineers need quick, safe database facts before
making changes.

SQL solution:
*/

SELECT
    current_database() AS database_name,
    current_user AS connected_user,
    pg_size_pretty(pg_database_size(current_database())) AS database_size,
    pg_postmaster_start_time() AS server_started_at;

SELECT
    COUNT(*) FILTER (WHERE state = 'active') AS active_sessions,
    COUNT(*) FILTER (WHERE state = 'idle') AS idle_sessions,
    COUNT(*) AS total_sessions
FROM pg_stat_activity
WHERE datname = current_database();

SELECT
    'orders' AS table_name,
    has_table_privilege(current_user, 'orders', 'SELECT') AS can_select_orders;

/*
Explanation:
The summary combines health, storage, activity, and permission checks without
changing application data.

Expected output:
The queries return database identity, session counts, and a table privilege
check.

Performance considerations:
These checks are safe for normal troubleshooting, but production monitoring
should use proper observability tooling.

Common mistakes:
- Starting with risky fixes before gathering facts.
- Ignoring permissions and connection context.
- Treating a single point-in-time check as a trend.

Challenge:
Add a table-size check for products.

Challenge solution:
*/

SELECT
    'products' AS table_name,
    pg_size_pretty(pg_total_relation_size('products')) AS total_size;

/*
Related chapters:
- ../12_indexes/chapter_summary.sql
- ../13_performance/chapter_summary.sql
- ../17_docker_postgresql/01_connection_check.sql
*/
