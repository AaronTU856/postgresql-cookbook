/*
Title: Use LIMIT and OFFSET
Difficulty: Beginner

Concepts:
- LIMIT
- OFFSET
- Deterministic ordering

Learning Objectives:
- Skip rows with OFFSET.
- Return a fixed number of rows with LIMIT.
- Always combine LIMIT and OFFSET with ORDER BY.

Problem Statement:
The product team wants the third, fourth, and fifth cheapest products.

SQL Solution:
*/

SELECT
    name,
    price
FROM products
ORDER BY price ASC, id ASC
LIMIT 3
OFFSET 2;

/*
Explanation:
ORDER BY creates a predictable product order. OFFSET 2 skips the first two rows,
and LIMIT 3 returns the next three rows.

Expected Output:
The query returns PostgreSQL Pocket Guide, Desk Lamp, and Django APIs Handbook.

Business Scenario:
Small admin screens sometimes use LIMIT and OFFSET to move through a sorted
list of products.

Performance Notes:
OFFSET gets slower on large datasets because PostgreSQL still has to work
through skipped rows. Later chapters can introduce keyset pagination for large
tables.

Common Mistakes:
- Using OFFSET without ORDER BY.
- Assuming OFFSET is free on large result sets.
- Forgetting that OFFSET starts at 0, not 1.

Challenge Exercise:
Return the third and fourth newest orders.

Challenge Solution:
*/

SELECT
    id,
    status,
    order_date
FROM orders
ORDER BY order_date DESC, id DESC
LIMIT 2
OFFSET 2;

/*
Related Chapters:
- ../01_basic_queries/06_limit.sql
- 09_order_by_multiple_columns.sql
- 12_simple_pagination.sql
*/
