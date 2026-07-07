/*
Title: Safe Maintenance
Difficulty: Intermediate

Learning Objectives:
- Run ANALYZE safely.
- Understand statistics maintenance.
- Inspect table statistics timestamps.

Problem Statement:
After loading data, the team wants PostgreSQL to refresh planner statistics.

Business Scenario:
Fresh statistics help PostgreSQL choose better plans after imports, migrations,
or large data changes.

SQL Solution:
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

Expected Output:
The query returns statistics timestamps for selected tables.

Performance Notes:
ANALYZE is safer than many maintenance commands, but still schedule heavy
maintenance thoughtfully on large production tables.

Common Mistakes:
- Ignoring statistics after bulk data changes.
- Running risky maintenance commands without understanding locks.
- Assuming development maintenance timing predicts production timing.

Challenge Exercise:
Run ANALYZE for order_items and check its statistics row.

Challenge Solution:
*/

ANALYZE order_items;

SELECT
    relname AS table_name,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
WHERE relname = 'order_items';

/*
Related Chapters:
- ../13_performance/01_explain_basics.sql
- ../12_indexes/chapter_summary.sql
- 02_size_monitoring.sql
*/
