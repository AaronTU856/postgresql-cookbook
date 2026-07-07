/*
Title: Count Unique Values With DISTINCT
Difficulty: Intermediate

Learning Objectives:
- Use COUNT(DISTINCT ...) to count unique values.
- Compare row counts with unique entity counts.
- Avoid overcounting repeated values.

Problem Statement:
Operations wants to know how many unique customers have placed orders.

SQL Solution:
*/

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT user_id) AS unique_customers_with_orders
FROM orders;

/*
Explanation:
COUNT(*) counts every order row. COUNT(DISTINCT user_id) counts each customer
only once, even if they placed multiple orders.

Expected Output:
The query returns seven total orders and six unique customers with orders.

Business Scenario:
Product teams often compare total activity with unique active users or
customers.

Performance Notes:
COUNT(DISTINCT ...) can be more expensive than COUNT(*) because PostgreSQL must
deduplicate values.

Common Mistakes:
- Counting rows when the report asks for unique customers.
- Using DISTINCT to hide data quality issues.
- Forgetting that DISTINCT applies to the expression inside the aggregate.

Challenge Exercise:
Count how many different products have been ordered.

Challenge Solution:
*/

SELECT
    COUNT(DISTINCT product_id) AS unique_products_ordered
FROM order_items;

/*
Related Chapters:
- 01_count.sql
- 05_group_by.sql
- ../03_joins/11_common_join_mistakes.sql
*/
