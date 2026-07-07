/*
Title: Count Rows With COUNT
Difficulty: Beginner

Learning Objectives:
- Use COUNT(*) to count rows.
- Count records in core business tables.
- Understand what a single aggregate result represents.

Problem Statement:
The operations team wants to know how many orders exist in the store database.

SQL Solution:
*/

SELECT
    COUNT(*) AS total_orders
FROM orders;

/*
Explanation:
COUNT(*) counts every row returned by the query. Because this query reads from
orders without a WHERE clause, it counts every order.

Expected Output:
The query returns one row with total_orders equal to 7.

Business Scenario:
An admin dashboard may show a total order count as a simple operational metric.

Performance Notes:
COUNT(*) on large tables may still require PostgreSQL to scan many rows. For
frequent dashboard metrics, consider whether cached summaries are needed later.

Common Mistakes:
- Using COUNT(column_name) when NULL values should also be counted.
- Expecting COUNT(*) to return one row per status without GROUP BY.
- Forgetting filters when only a subset should be counted.

Challenge Exercise:
Count how many products are currently active.

Challenge Solution:
*/

SELECT
    COUNT(*) AS active_product_count
FROM products
WHERE is_active = TRUE;

/*
Related Chapters:
- ../01_basic_queries/01_select_all.sql
- ../02_filtering_sorting/01_where_and.sql
- 05_group_by.sql
*/
