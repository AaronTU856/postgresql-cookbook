/*
Title: Size Monitoring
Difficulty: Beginner

Learning Objectives:
- Check database size.
- Check table size.
- Identify larger relations in the sample schema.

Problem Statement:
The team wants a safe way to inspect database and table storage.

Business Scenario:
Storage growth affects backups, migrations, hosting cost, and operational risk.

SQL Solution:
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

Expected Output:
The queries return readable sizes for the current database and user tables.

Performance Notes:
Size checks are usually safe, but frequent monitoring should be handled by
metrics tooling rather than ad hoc polling.

Common Mistakes:
- Looking only at table data and ignoring index size.
- Waiting until disk pressure before monitoring growth.
- Comparing development sizes with production expectations.

Challenge Exercise:
Show total size for the orders table only.

Challenge Solution:
*/

SELECT
    'orders' AS table_name,
    pg_size_pretty(pg_total_relation_size('orders')) AS total_size;

/*
Related Chapters:
- ../12_indexes/chapter_summary.sql
- ../13_performance/chapter_summary.sql
- 05_safe_maintenance.sql
*/
