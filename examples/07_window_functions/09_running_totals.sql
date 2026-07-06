/*
Title: Running Totals
Difficulty: Intermediate

Learning objectives:
- Use SUM() as a window function.
- Calculate a running payment total.
- Define a window frame for cumulative calculations.

Problem statement:
Finance wants a running total of completed payments by payment time.

SQL solution:
*/

SELECT
    id AS payment_id,
    paid_at,
    amount,
    SUM(amount) OVER (
        ORDER BY paid_at ASC, id ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_completed_payment_total
FROM payments
WHERE status = 'completed'
ORDER BY paid_at ASC, id ASC;

/*
Explanation:
SUM(amount) becomes a window function because it uses OVER(). The frame starts
at the first row and ends at the current row, creating a running total.

Expected results:
Each completed payment row shows the cumulative completed payment total up to
that point.

Real-world example:
Finance dashboards often use running totals to show revenue accumulation over
time.

Performance notes:
Running totals require ordered rows. For large payment tables, filter to the
needed time period before calculating the window.

Common mistakes:
- Forgetting the frame for cumulative calculations.
- Including pending or refunded payments in completed totals.
- Expecting GROUP BY behaviour from a window aggregate.

Challenge exercise:
Calculate a running order count by order date.

Challenge solution:
*/

SELECT
    id AS order_id,
    order_date,
    COUNT(*) OVER (
        ORDER BY order_date ASC, id ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_order_count
FROM orders
ORDER BY order_date ASC, id ASC;

/*
Related examples:
- ../04_aggregates/02_sum.sql
- 10_moving_average.sql
- 14_business_reporting.sql
*/
