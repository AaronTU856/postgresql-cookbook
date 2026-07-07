/*
Title: Basic CTE
Difficulty: Beginner

Learning Objectives:
- Write a basic WITH clause.
- Name an intermediate result set.
- Filter products in a readable first step.

Problem Statement:
The merchandising team wants a simple report of active products with low stock.

SQL Solution:
*/

WITH low_stock_products AS (
    SELECT
        id,
        name,
        price,
        stock_quantity
    FROM products
    WHERE is_active = TRUE
        AND stock_quantity < 20
)
SELECT
    id,
    name,
    price,
    stock_quantity
FROM low_stock_products
ORDER BY stock_quantity ASC;

/*
Explanation:
The CTE named low_stock_products stores the filtered product rows. The outer
query then reads from that named result.

Expected Output:
The query returns active products with fewer than 20 items in stock.

Business Scenario:
A stock dashboard may define a low-stock product set before applying final
sorting or additional reporting logic.

Performance Notes:
For a simple query like this, the CTE is mainly for readability. It is not
automatically faster than writing the filter directly in the outer query.

Common Mistakes:
- Forgetting that a CTE only exists for the query that immediately follows it.
- Giving the CTE a vague name such as data or temp.
- Adding ORDER BY inside the CTE when the final output order matters.

Challenge Exercise:
Create a CTE for completed payments and return the payment ID, order ID, and
amount.

Challenge Solution:
*/

WITH completed_payments AS (
    SELECT
        id,
        order_id,
        amount
    FROM payments
    WHERE status = 'completed'
)
SELECT
    id,
    order_id,
    amount
FROM completed_payments
ORDER BY amount DESC;

/*
Related Chapters:
- ../02_filtering_sorting/01_where_and.sql
- ../05_subqueries/09_subquery_in_from.sql
- 02_multiple_ctes.sql
*/
