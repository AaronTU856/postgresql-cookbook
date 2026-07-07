/*
Title: Filter Ranges With BETWEEN
Difficulty: Beginner

Concepts:
- BETWEEN
- Inclusive ranges
- Date filtering

Learning Objectives:
- Filter timestamp values with BETWEEN.
- Understand inclusive range boundaries.
- Sort date-filtered results predictably.

Problem Statement:
The operations team wants orders placed from 12 February 2026 through
17 February 2026.

SQL Solution:
*/

SELECT
    id,
    status,
    order_date,
    shipping_city
FROM orders
WHERE order_date BETWEEN '2026-02-12 00:00:00+00' AND '2026-02-17 23:59:59+00'
ORDER BY order_date ASC;

/*
Explanation:
BETWEEN includes both boundary values. This query keeps orders placed at or
after the start timestamp and at or before the end timestamp.

Expected Output:
The query returns orders 2, 3, 4, and 5.

Business Scenario:
Date range filters appear in order history screens, finance reports, and admin
dashboards.

Performance Notes:
The schema includes an index on orders.order_date, which can help range filters
as the orders table grows.

Common Mistakes:
- Forgetting that BETWEEN is inclusive.
- Using a date-only upper bound and accidentally excluding later rows on that
  day.
- Reversing the lower and upper bounds.

Challenge Exercise:
Find products priced between 20.00 and 60.00.

Challenge Solution:
*/

SELECT
    name,
    price
FROM products
WHERE price BETWEEN 20.00 AND 60.00
ORDER BY price ASC;

/*
Related Chapters:
- ../01_basic_queries/09_between.sql
- 04_comparison_operators.sql
- 09_order_by_multiple_columns.sql
*/
