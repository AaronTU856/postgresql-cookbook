/*
Title: ROW_NUMBER
Difficulty: Beginner

Learning objectives:
- Use ROW_NUMBER() to assign a unique sequence.
- Order rows inside a window.
- Build a numbered order list for reporting.

Problem statement:
Customer support wants every order numbered from newest to oldest.

SQL solution:
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

Expected results:
The query returns seven orders numbered from newest to oldest.

Real-world example:
Support dashboards often number recent orders so agents can scan activity in a
stable sequence.

Performance notes:
ROW_NUMBER() requires PostgreSQL to sort rows according to the window ORDER BY.
Indexes on common ordering columns can help larger datasets.

Common mistakes:
- Forgetting ORDER BY inside OVER().
- Expecting ROW_NUMBER() to handle ties like RANK().
- Omitting a tie-breaker when stable ordering matters.

Challenge exercise:
Number products from most expensive to cheapest.

Challenge solution:
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
Related examples:
- ../02_filtering_sorting/05_order_by.sql
- 02_rank.sql
- 12_window_best_practices.sql
*/
