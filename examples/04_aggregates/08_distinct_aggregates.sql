/*
Title: Count Unique Values With DISTINCT
Difficulty: Intermediate

Learning objectives:
- Use COUNT(DISTINCT ...) to count unique values.
- Compare row counts with unique entity counts.
- Avoid overcounting repeated values.

Problem statement:
Operations wants to know how many unique customers have placed orders.

SQL solution:
*/

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT user_id) AS unique_customers_with_orders
FROM orders;

/*
Explanation:
COUNT(*) counts every order row. COUNT(DISTINCT user_id) counts each customer
only once, even if they placed multiple orders.

Expected results:
The query returns seven total orders and six unique customers with orders.

Real-world example:
Product teams often compare total activity with unique active users or
customers.

Performance notes:
COUNT(DISTINCT ...) can be more expensive than COUNT(*) because PostgreSQL must
deduplicate values.

Common mistakes:
- Counting rows when the report asks for unique customers.
- Using DISTINCT to hide data quality issues.
- Forgetting that DISTINCT applies to the expression inside the aggregate.

Challenge exercise:
Count how many different products have been ordered.

Challenge solution:
*/

SELECT
    COUNT(DISTINCT product_id) AS unique_products_ordered
FROM order_items;

/*
Related examples:
- 01_count.sql
- 05_group_by.sql
- ../03_joins/11_common_join_mistakes.sql
*/
