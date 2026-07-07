/*
Title: Project - Operational Runbook Checks
Difficulty: Advanced

Learning Objectives:
- Write safe operational SQL for a PostgreSQL-backed service.
- Check core table counts and payment health.
- Create a concise runbook query for support incidents.

Problem Statement:
During an incident, engineers need fast read-only checks for database health and business data signals.

Business Scenario:
Orders are reported as missing from the admin UI. The team needs to confirm whether data exists and whether payment states look normal.

SQL Solution:
*/

WITH table_counts AS (
    SELECT 'users' AS metric_name, COUNT(*)::TEXT AS metric_value FROM users
    UNION ALL
    SELECT 'products', COUNT(*)::TEXT FROM products
    UNION ALL
    SELECT 'orders', COUNT(*)::TEXT FROM orders
    UNION ALL
    SELECT 'payments', COUNT(*)::TEXT FROM payments
),
payment_status_counts AS (
    SELECT
        CONCAT('payments_', status) AS metric_name,
        COUNT(*)::TEXT AS metric_value
    FROM payments
    GROUP BY status
),
latest_order AS (
    SELECT
        'latest_order_at' AS metric_name,
        MAX(order_date)::TEXT AS metric_value
    FROM orders
)
SELECT metric_name, metric_value
FROM table_counts
UNION ALL
SELECT metric_name, metric_value
FROM payment_status_counts
UNION ALL
SELECT metric_name, metric_value
FROM latest_order
ORDER BY metric_name;

/*
Explanation:
This runbook query stays read-only and returns counts that help distinguish empty data, stale data, and payment-state issues.

Expected Output:
A list of operational metrics including table counts, payment status counts, and the latest order timestamp.

Performance Notes:
Exact `COUNT(*)` can be expensive on very large tables. For large production systems, use targeted filters, approximate catalog statistics, or dashboard metrics collected separately.

Common Mistakes:
- Running destructive maintenance during diagnosis.
- Writing runbook queries that are too complex to trust under pressure.
- Forgetting that exact counts can be slow on large tables.

Challenge Exercise:
Add a metric for orders created in the last 30 days.

Challenge Solution:
Add another CTE or `UNION ALL` branch using `WHERE order_date >= NOW() - INTERVAL '30 days'`.

Related Chapters:
- Chapter 8 - Transactions
- Chapter 16 - PostgreSQL Administration
- Chapter 17 - Docker & PostgreSQL
*/
