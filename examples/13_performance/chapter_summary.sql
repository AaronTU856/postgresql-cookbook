/*
Title: Performance Chapter Summary
Difficulty: Intermediate

Learning objectives:
- Combine measurement, indexing, and query shape.
- Build a production-minded reporting query.
- Review practical performance habits.

Problem statement:
Summarise performance work by measuring a customer value report.

Business scenario:
Leadership reports need correct results and predictable execution time.

SQL solution:
*/

EXPLAIN (ANALYZE, BUFFERS)
SELECT
    users.email,
    COUNT(DISTINCT orders.id) AS order_count,
    COALESCE(
        SUM(payments.amount) FILTER (WHERE payments.status = 'completed'),
        0
    ) AS completed_payment_total
FROM users
LEFT JOIN orders
    ON orders.user_id = users.id
LEFT JOIN payments
    ON payments.order_id = orders.id
GROUP BY users.email
ORDER BY completed_payment_total DESC, users.email ASC;

/*
Explanation:
The query measures a realistic report using joins, aggregation, filtering inside
an aggregate, and ordering.

Expected output:
PostgreSQL returns an execution plan with actual timing and buffer details.

Performance considerations:
On production data, inspect row estimates, join type, sort cost, and whether
indexes support the join keys.

Common mistakes:
- Tuning without measuring.
- Ignoring join cardinality.
- Adding indexes without retesting the query.

Challenge:
Explain why this query should be tested with realistic data volume.

Challenge solution:
*/

SELECT
    'Seed data is tiny; production row counts can change join choices, sort cost, and index usefulness.'
        AS challenge_answer;

/*
Related chapters:
- ../04_aggregates/10_business_reports.sql
- ../07_window_functions/14_business_reporting.sql
- ../12_indexes/chapter_summary.sql
*/
