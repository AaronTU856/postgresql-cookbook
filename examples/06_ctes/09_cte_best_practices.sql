/*
Title: CTE Best Practices
Difficulty: Intermediate

Learning Objectives:
- Name CTEs after business meaning.
- Keep each CTE focused.
- Select only columns needed by later steps.

Problem Statement:
Finance wants a readable query for completed card payments with customer email.

SQL Solution:
*/

WITH completed_card_payments AS (
    SELECT
        id,
        order_id,
        amount
    FROM payments
    WHERE status = 'completed'
        AND payment_method = 'card'
)
SELECT
    completed_card_payments.id AS payment_id,
    users.email AS customer_email,
    completed_card_payments.amount
FROM completed_card_payments
INNER JOIN orders
    ON orders.id = completed_card_payments.order_id
INNER JOIN users
    ON users.id = orders.user_id
ORDER BY completed_card_payments.amount DESC;

/*
Explanation:
The CTE name describes the business set: completed card payments. It exposes
only the columns the outer query needs.

Expected Output:
The query returns completed card payments with customer email and amount.

Business Scenario:
Readable CTE names make finance and operations reports easier to review with
non-database stakeholders.

Performance Notes:
Selecting only needed columns keeps intermediate results easier to reason about.
PostgreSQL may still optimise the query internally.

Common Mistakes:
- Naming CTEs cte1 or temp_data.
- Selecting every column from the source table.
- Packing unrelated business rules into one large CTE.

Challenge Exercise:
Create a focused CTE for shipped or delivered orders and join it to users.

Challenge Solution:
*/

WITH fulfilled_orders AS (
    SELECT
        id,
        user_id,
        status,
        order_date
    FROM orders
    WHERE status IN ('shipped', 'delivered')
)
SELECT
    fulfilled_orders.id AS order_id,
    fulfilled_orders.status,
    fulfilled_orders.order_date,
    users.email
FROM fulfilled_orders
INNER JOIN users
    ON users.id = fulfilled_orders.user_id
ORDER BY fulfilled_orders.order_date DESC;

/*
Related Chapters:
- ../02_filtering_sorting/07_in_and_not_in.sql
- ../03_joins/10_join_best_practices.sql
- 10_common_cte_mistakes.sql
*/
