/*
Title: Find Ranges With MIN and MAX
Difficulty: Beginner

Learning Objectives:
- Use MIN() to find the smallest value.
- Use MAX() to find the largest value.
- Summarise product price ranges.

Problem Statement:
The merchandising team wants the lowest and highest product price.

SQL Solution:
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

Expected Output:
The query returns one row showing the active product price range.

Business Scenario:
An ecommerce team may use price ranges to check catalogue spread or validate
frontend filters.

Performance Notes:
MIN and MAX can benefit from suitable indexes on large tables. The sample data is
small, so readability matters most here.

Common Mistakes:
- Forgetting filters such as is_active = TRUE.
- Assuming MIN and MAX return the whole row that contains the value.
- Using text columns for numeric comparisons.

Challenge Exercise:
Find the first and latest order dates.

Challenge Solution:
*/

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS latest_order_date
FROM orders;

/*
Related Chapters:
- ../02_filtering_sorting/06_between.sql
- 03_avg.sql
- 05_group_by.sql
*/
