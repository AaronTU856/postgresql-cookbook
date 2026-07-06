/*
Title: Count Rows With COUNT
Difficulty: Beginner

Learning objectives:
- Use COUNT(*) to count rows.
- Count records in core business tables.
- Understand what a single aggregate result represents.

Problem statement:
The operations team wants to know how many orders exist in the store database.

SQL solution:
*/

SELECT
    COUNT(*) AS total_orders
FROM orders;

/*
Explanation:
COUNT(*) counts every row returned by the query. Because this query reads from
orders without a WHERE clause, it counts every order.

Expected results:
The query returns one row with total_orders equal to 7.

Real-world example:
An admin dashboard may show a total order count as a simple operational metric.

Performance notes:
COUNT(*) on large tables may still require PostgreSQL to scan many rows. For
frequent dashboard metrics, consider whether cached summaries are needed later.

Common mistakes:
- Using COUNT(column_name) when NULL values should also be counted.
- Expecting COUNT(*) to return one row per status without GROUP BY.
- Forgetting filters when only a subset should be counted.

Challenge exercise:
Count how many products are currently active.

Challenge solution:
*/

SELECT
    COUNT(*) AS active_product_count
FROM products
WHERE is_active = TRUE;

/*
Related examples:
- ../01_basic_queries/01_select_all.sql
- ../02_filtering_sorting/01_where_and.sql
- 05_group_by.sql
*/
