/*
Title: Safe Maintenance
Difficulty: Intermediate

Learning objectives:
- Run ANALYZE safely.
- Understand statistics maintenance.
- Inspect table statistics timestamps.

Problem statement:
After loading data, the team wants PostgreSQL to refresh planner statistics.

Business scenario:
Fresh statistics help PostgreSQL choose better plans after imports, migrations,
or large data changes.

SQL solution:
*/

ANALYZE users;
ANALYZE products;
ANALYZE orders;
ANALYZE payments;

SELECT
    relname AS table_name,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
WHERE relname IN ('users', 'products', 'orders', 'payments')
ORDER BY relname ASC;

/*
Explanation:
ANALYZE refreshes planner statistics. pg_stat_user_tables shows recent analyze
activity for user tables.

Expected output:
The query returns statistics timestamps for selected tables.

Performance considerations:
ANALYZE is safer than many maintenance commands, but still schedule heavy
maintenance thoughtfully on large production tables.

Common mistakes:
- Ignoring statistics after bulk data changes.
- Running risky maintenance commands without understanding locks.
- Assuming development maintenance timing predicts production timing.

Challenge:
Run ANALYZE for order_items and check its statistics row.

Challenge solution:
*/

ANALYZE order_items;

SELECT
    relname AS table_name,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
WHERE relname = 'order_items';

/*
Related chapters:
- ../13_performance/01_explain_basics.sql
- ../12_indexes/chapter_summary.sql
- 02_size_monitoring.sql
*/
