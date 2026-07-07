/*
Title: ROW_NUMBER
Difficulty: Beginner

Learning Objectives:
- Use ROW_NUMBER() to assign a unique sequence.
- Order rows inside a window.
- Build a numbered order list for reporting.

Problem Statement:
Customer support wants every order numbered from newest to oldest.

SQL Solution:
*/

SELECT
    ROW_NUMBER() OVER (
        ORDER BY order_date DESC, id DESC
    ) AS order_position,
    id AS order_id,
    status,
    order_date
FROM orders
ORDER BY order_position ASC;

/*
Explanation:
ROW_NUMBER() assigns a unique number to each row based on the order inside
OVER(). The final ORDER BY displays the rows in that numbered order.

Expected Output:
The query returns seven orders numbered from newest to oldest.

Business Scenario:
Support dashboards often number recent orders so agents can scan activity in a
stable sequence.

Performance Notes:
ROW_NUMBER() requires PostgreSQL to sort rows according to the window ORDER BY.
Indexes on common ordering columns can help larger datasets.

Common Mistakes:
- Forgetting ORDER BY inside OVER().
- Expecting ROW_NUMBER() to handle ties like RANK().
- Omitting a tie-breaker when stable ordering matters.

Challenge Exercise:
Number products from most expensive to cheapest.

Challenge Solution:
*/

SELECT
    ROW_NUMBER() OVER (
        ORDER BY price DESC, id ASC
    ) AS price_position,
    name,
    price
FROM products
ORDER BY price_position ASC;

/*
Related Chapters:
- ../02_filtering_sorting/05_order_by.sql
- 02_rank.sql
- 12_window_best_practices.sql
*/
