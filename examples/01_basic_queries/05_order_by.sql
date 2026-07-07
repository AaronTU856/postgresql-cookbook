/*
Title: Sort Rows With ORDER BY
Difficulty: Beginner

Learning Objectives:
- Use ORDER BY to control result order.
- Sort timestamp values from newest to oldest.
- Understand why database row order should not be assumed.

Problem Statement:
Customer support wants to see the most recent orders first.

SQL Solution:
*/

SELECT
    id,
    status,
    order_date,
    shipping_city
FROM orders
ORDER BY order_date DESC;

/*
Expected Output:
The query returns orders with the newest order_date first, starting with the
March 2026 order.

Explanation:
ORDER BY controls how rows are sorted. DESC sorts values in descending order,
which puts newer timestamps before older timestamps.

Business Scenario:
Support teams commonly review recent orders first because those are more likely
to need active handling.

Performance Notes:
This schema includes an index on orders.order_date, which can help PostgreSQL
retrieve ordered order data efficiently as the table grows.

Common Mistakes:
- Assuming rows are naturally returned in insertion order.
- Forgetting DESC when the newest rows should appear first.

Challenge Exercise:
List products from cheapest to most expensive.

Challenge Solution:
*/

SELECT
    name,
    price
FROM products
ORDER BY price ASC;

/*
Related Chapters:
- 04_where_clause.sql
- 06_limit.sql
*/
