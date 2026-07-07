/*
Title: LAG
Difficulty: Intermediate

Learning Objectives:
- Use LAG() to read a previous row.
- Compare each order with the prior order.
- Calculate time between events.

Problem Statement:
Operations wants to compare each order date with the previous order date.

SQL Solution:
*/

SELECT
    id AS order_id,
    order_date,
    LAG(order_date) OVER (
        ORDER BY order_date ASC, id ASC
    ) AS previous_order_date,
    order_date - LAG(order_date) OVER (
        ORDER BY order_date ASC, id ASC
    ) AS time_since_previous_order
FROM orders
ORDER BY order_date ASC, id ASC;

/*
Explanation:
LAG(order_date) reads the order_date from the previous row in the ordered
window. The subtraction calculates the interval between orders.

Expected Output:
The first order has no previous_order_date. Later rows show the prior order date
and time since that order.

Business Scenario:
Operations teams may use this pattern to understand gaps between customer or
order activity.

Performance Notes:
LAG() requires ordered rows. Keep the input filtered when comparing a specific
subset of events.

Common Mistakes:
- Forgetting that the first row has no previous row.
- Using final query ORDER BY instead of ORDER BY inside OVER().
- Repeating complex LAG() expressions without considering a CTE for readability.

Challenge Exercise:
Compare each payment amount with the previous payment amount by paid_at.

Challenge Solution:
*/

SELECT
    id AS payment_id,
    paid_at,
    amount,
    LAG(amount) OVER (
        ORDER BY paid_at ASC NULLS LAST, id ASC
    ) AS previous_payment_amount
FROM payments
ORDER BY paid_at ASC NULLS LAST, id ASC;

/*
Related Chapters:
- 06_lead.sql
- ../02_filtering_sorting/10_nulls_first_last.sql
- ../06_ctes/01_basic_cte.sql
*/
