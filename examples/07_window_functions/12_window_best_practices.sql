/*
Title: Window Function Best Practices
Difficulty: Intermediate

Learning objectives:
- Use clear window ordering.
- Add stable tie-breakers.
- Use named windows when repeated definitions improve readability.

Problem statement:
Finance wants completed payments with both row number and running total using
the same ordering.

SQL solution:
*/

SELECT
    id AS payment_id,
    paid_at,
    amount,
    ROW_NUMBER() OVER payment_order AS payment_sequence,
    SUM(amount) OVER payment_order AS running_payment_total
FROM payments
WHERE status = 'completed'
WINDOW payment_order AS (
    ORDER BY paid_at ASC, id ASC
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
ORDER BY paid_at ASC, id ASC;

/*
Explanation:
The named window payment_order keeps the repeated ordering and frame definition
in one place. Both ROW_NUMBER() and SUM() use it.

Expected results:
Each completed payment has a sequence number and running total using the same
stable order.

Real-world example:
Finance reports often reuse the same time-based window for several calculations.

Performance notes:
Named windows improve readability. They do not remove the need to check query
plans for larger reports.

Common mistakes:
- Repeating slightly different window definitions by accident.
- Forgetting a deterministic tie-breaker.
- Adding unnecessary window functions that make reports harder to read.

Challenge exercise:
Use a named window to show product row number and running average price by
product creation date.

Challenge solution:
*/

SELECT
    id AS product_id,
    name,
    price,
    ROW_NUMBER() OVER product_order AS product_sequence,
    ROUND(AVG(price) OVER product_order, 2) AS running_average_price
FROM products
WINDOW product_order AS (
    ORDER BY created_at ASC, id ASC
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
ORDER BY created_at ASC, id ASC;

/*
Related examples:
- 01_row_number.sql
- 09_running_totals.sql
- 13_common_window_mistakes.sql
*/
