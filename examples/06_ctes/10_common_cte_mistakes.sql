/*
Title: Common CTE Mistakes
Difficulty: Intermediate

Learning objectives:
- Avoid treating CTEs as permanent tables.
- Keep final ordering in the outer query.
- Use clear CTE boundaries.

Problem statement:
Operations wants a clean recent orders report without relying on ordering inside
the CTE.

SQL solution:
*/

WITH recent_orders AS (
    SELECT
        id,
        user_id,
        status,
        order_date
    FROM orders
    WHERE order_date >= '2026-02-12 00:00:00+00'
)
SELECT
    recent_orders.id AS order_id,
    users.email,
    recent_orders.status,
    recent_orders.order_date
FROM recent_orders
INNER JOIN users
    ON users.id = recent_orders.user_id
ORDER BY recent_orders.order_date DESC;

/*
Explanation:
The CTE defines which orders are considered recent. The final ORDER BY belongs
in the outer query because that is the result being returned.

Expected results:
The query returns orders on or after 12 February 2026 with customer email,
ordered newest first.

Real-world example:
Recent activity reports often use a named filtered set before joining customer
details.

Performance notes:
Filtering inside the CTE can reduce the rows used by later joins. Keep filters
aligned with the report question.

Common mistakes:
- Assuming a CTE can be queried again later like a permanent table.
- Depending on ORDER BY inside a CTE for final output order.
- Creating a CTE that simply hides a one-line filter.

Challenge exercise:
Create a CTE for pending payments and order the final result by amount.

Challenge solution:
*/

WITH pending_payments AS (
    SELECT
        id,
        order_id,
        amount
    FROM payments
    WHERE status = 'pending'
)
SELECT
    id,
    order_id,
    amount
FROM pending_payments
ORDER BY amount DESC;

/*
Related examples:
- 01_basic_cte.sql
- 09_cte_best_practices.sql
- 11_performance_considerations.sql
*/
