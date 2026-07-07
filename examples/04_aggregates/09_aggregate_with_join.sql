/*
Title: Aggregate With Joins
Difficulty: Intermediate

Learning Objectives:
- Combine joins with aggregate functions.
- Summarise products by category.
- Use GROUP BY with columns from joined tables.

Problem Statement:
The merchandising team wants product counts and average price by category.

SQL Solution:
*/

SELECT
    categories.name AS category_name,
    COUNT(products.id) AS product_count,
    ROUND(AVG(products.price), 2) AS average_price
FROM categories
INNER JOIN products
    ON products.category_id = categories.id
GROUP BY categories.name
ORDER BY category_name ASC;

/*
Explanation:
The join adds category names to product rows. GROUP BY categories.name creates
one group per category, then COUNT and AVG summarise products in each group.

Expected Output:
The query returns four categories with two products in each category.

Business Scenario:
Category managers may use this report to compare catalogue size and pricing by
category.

Performance Notes:
Join before aggregation only when the grouped report needs columns from both
tables. Indexes on join keys help as the dataset grows.

Common Mistakes:
- Grouping by product name instead of category name.
- Using LEFT JOIN without deciding how empty categories should be handled.
- Forgetting that joined rows are aggregated after the join.

Challenge Exercise:
Calculate total quantity sold by category.

Challenge Solution:
*/

SELECT
    categories.name AS category_name,
    SUM(order_items.quantity) AS total_quantity_sold
FROM categories
INNER JOIN products
    ON products.category_id = categories.id
INNER JOIN order_items
    ON order_items.product_id = products.id
GROUP BY categories.name
ORDER BY total_quantity_sold DESC;

/*
Related Chapters:
- ../03_joins/08_join_with_aggregation.sql
- 05_group_by.sql
- 10_business_reports.sql
*/
