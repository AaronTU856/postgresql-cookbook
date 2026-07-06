/*
Title: RANK
Difficulty: Beginner

Learning objectives:
- Use RANK() for ordered rankings.
- Understand that tied rows share a rank.
- Rank payments by amount.

Problem statement:
Finance wants to rank payments from largest to smallest.

SQL solution:
*/

SELECT
    RANK() OVER (
        ORDER BY amount DESC
    ) AS payment_rank,
    id AS payment_id,
    order_id,
    amount,
    status
FROM payments
ORDER BY payment_rank ASC, payment_id ASC;

/*
Explanation:
RANK() assigns the same rank to tied values. If ties occur, later ranks leave a
gap.

Expected results:
The query returns payments ranked by amount from highest to lowest.

Real-world example:
Finance teams may rank payments or orders to review the largest transactions.

Performance notes:
Ranking requires sorting. Add filters when only a subset of rows needs ranking.

Common mistakes:
- Using RANK() when a unique row number is required.
- Forgetting that ties can create gaps in the ranking sequence.
- Not adding a final ORDER BY for display.

Challenge exercise:
Rank products by price from highest to lowest.

Challenge solution:
*/

SELECT
    RANK() OVER (
        ORDER BY price DESC
    ) AS product_price_rank,
    name,
    price
FROM products
ORDER BY product_price_rank ASC, name ASC;

/*
Related examples:
- 01_row_number.sql
- 03_dense_rank.sql
- ../04_aggregates/04_min_max.sql
*/
