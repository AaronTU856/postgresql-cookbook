/*
Title: Find Ranges With MIN and MAX
Difficulty: Beginner

Learning objectives:
- Use MIN() to find the smallest value.
- Use MAX() to find the largest value.
- Summarise product price ranges.

Problem statement:
The merchandising team wants the lowest and highest product price.

SQL solution:
*/

SELECT
    MIN(price) AS lowest_product_price,
    MAX(price) AS highest_product_price
FROM products
WHERE is_active = TRUE;

/*
Explanation:
MIN(price) returns the smallest active product price. MAX(price) returns the
largest active product price.

Expected results:
The query returns one row showing the active product price range.

Real-world example:
An ecommerce team may use price ranges to check catalogue spread or validate
frontend filters.

Performance notes:
MIN and MAX can benefit from suitable indexes on large tables. The sample data is
small, so readability matters most here.

Common mistakes:
- Forgetting filters such as is_active = TRUE.
- Assuming MIN and MAX return the whole row that contains the value.
- Using text columns for numeric comparisons.

Challenge exercise:
Find the first and latest order dates.

Challenge solution:
*/

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS latest_order_date
FROM orders;

/*
Related examples:
- ../02_filtering_sorting/06_between.sql
- 03_avg.sql
- 05_group_by.sql
*/
