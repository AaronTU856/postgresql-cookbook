/*
Title: Moving Averages
Difficulty: Intermediate

Learning Objectives:
- Use AVG() as a window function.
- Calculate a moving average over recent rows.
- Define a rolling window frame.

Problem Statement:
Finance wants a three-payment moving average for completed payments.

SQL Solution:
*/

SELECT
    id AS payment_id,
    paid_at,
    amount,
    ROUND(
        AVG(amount) OVER (
            ORDER BY paid_at ASC, id ASC
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS three_payment_moving_average
FROM payments
WHERE status = 'completed'
ORDER BY paid_at ASC, id ASC;

/*
Explanation:
The moving average frame includes the current row and up to two previous rows.
At the start of the result, fewer than three rows may be available.

Expected Output:
Each completed payment row shows a rolling average based on the current and two
previous completed payments.

Business Scenario:
Finance teams may smooth payment values over recent transactions to spot trends.

Performance Notes:
Moving averages require ordered data and frame calculations. Limit the time
range when analysing large tables.

Common Mistakes:
- Forgetting that early rows have a smaller frame.
- Using a moving average without a meaningful order.
- Rounding before later calculations.

Challenge Exercise:
Calculate a three-product moving average of product prices by creation date.

Challenge Solution:
*/

SELECT
    id AS product_id,
    name,
    created_at,
    price,
    ROUND(
        AVG(price) OVER (
            ORDER BY created_at ASC, id ASC
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS three_product_moving_average
FROM products
ORDER BY created_at ASC, id ASC;

/*
Related Chapters:
- ../04_aggregates/03_avg.sql
- 09_running_totals.sql
- 11_partition_by.sql
*/
