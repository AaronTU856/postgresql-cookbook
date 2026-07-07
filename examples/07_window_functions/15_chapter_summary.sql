/*
Title: Window Functions Chapter Summary
Difficulty: Intermediate

Learning Objectives:
- Combine multiple window functions in one report.
- Use ranking, navigation, and running totals together.
- Review practical window-function reporting patterns.

Problem Statement:
Finance wants a completed payment report with sequence, rank, previous payment,
and running total.

SQL Solution:
*/

SELECT
    id AS payment_id,
    paid_at,
    amount,
    ROW_NUMBER() OVER (
        ORDER BY paid_at ASC, id ASC
    ) AS payment_sequence,
    RANK() OVER (
        ORDER BY amount DESC
    ) AS amount_rank,
    LAG(amount) OVER (
        ORDER BY paid_at ASC, id ASC
    ) AS previous_payment_amount,
    SUM(amount) OVER (
        ORDER BY paid_at ASC, id ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_completed_payment_total
FROM payments
WHERE status = 'completed'
ORDER BY paid_at ASC, id ASC;

/*
Explanation:
This query combines several window functions. It sequences payments by time,
ranks them by amount, compares each payment with the previous payment, and
calculates a running completed payment total.

Expected Output:
Each completed payment row includes sequence number, amount rank, previous
payment amount, and running total.

Business Scenario:
Finance teams often need several analytical values beside transaction-level
detail in one report.

Performance Notes:
Multiple window functions may require multiple sorts when their window
definitions differ. Keep only the calculations the report needs.

Common Mistakes:
- Mixing window definitions without checking whether the orderings differ.
- Expecting one final ORDER BY to control every window calculation.
- Adding too many analytical columns to one report.

Challenge Exercise:
Create a product report with row number, category rank, and previous price by
price order.

Challenge Solution:
*/

SELECT
    category_id,
    name,
    price,
    ROW_NUMBER() OVER (
        ORDER BY price DESC, id ASC
    ) AS overall_price_position,
    DENSE_RANK() OVER (
        PARTITION BY category_id
        ORDER BY price DESC
    ) AS category_price_rank,
    LAG(price) OVER (
        ORDER BY price DESC, id ASC
    ) AS previous_higher_price
FROM products
ORDER BY overall_price_position ASC;

/*
Related Chapters:
- 01_row_number.sql
- 05_lag.sql
- 09_running_totals.sql
*/
