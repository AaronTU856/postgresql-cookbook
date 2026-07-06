/*
Title: Size Monitoring
Difficulty: Beginner

Learning objectives:
- Check database size.
- Check table size.
- Identify larger relations in the sample schema.

Problem statement:
The team wants a safe way to inspect database and table storage.

Business scenario:
Storage growth affects backups, migrations, hosting cost, and operational risk.

SQL solution:
*/

SELECT
    current_database() AS database_name,
    pg_size_pretty(pg_database_size(current_database())) AS database_size;

SELECT
    relname AS table_name,
    pg_size_pretty(pg_total_relation_size(relid)) AS total_size
FROM pg_catalog.pg_statio_user_tables
ORDER BY pg_total_relation_size(relid) DESC, relname ASC;

/*
Explanation:
pg_database_size reports database size. pg_total_relation_size includes table
data, indexes, and related storage.

Expected output:
The queries return readable sizes for the current database and user tables.

Performance considerations:
Size checks are usually safe, but frequent monitoring should be handled by
metrics tooling rather than ad hoc polling.

Common mistakes:
- Looking only at table data and ignoring index size.
- Waiting until disk pressure before monitoring growth.
- Comparing development sizes with production expectations.

Challenge:
Show total size for the orders table only.

Challenge solution:
*/

SELECT
    'orders' AS table_name,
    pg_size_pretty(pg_total_relation_size('orders')) AS total_size;

/*
Related chapters:
- ../12_indexes/chapter_summary.sql
- ../13_performance/chapter_summary.sql
- 05_safe_maintenance.sql
*/
