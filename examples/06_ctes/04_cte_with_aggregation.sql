/*
Title: CTE With Aggregation
Difficulty: Intermediate

Learning objectives:
- Aggregate data inside a CTE.
- Join aggregated results to descriptive tables.
- Build category-level summaries.

Problem statement:
The merchandising team wants product counts and average price by category.

SQL solution:
*/

WITH category_product_summary AS (
    SELECT
        category_id,
        COUNT(*) AS product_count,
        ROUND(AVG(price), 2) AS average_price
    FROM products
    GROUP BY category_id
)
SELECT
    categories.name AS category_name,
    category_product_summary.product_count,
    category_product_summary.average_price
FROM category_product_summary
INNER JOIN categories
    ON categories.id = category_product_summary.category_id
ORDER BY categories.name ASC;

/*
Explanation:
The CTE calculates one row per category_id. The outer query joins those summary
rows to categories so the report can show readable category names.

Expected results:
The query returns one summary row per category with product count and average
price.

Real-world example:
Category managers may use this pattern to compare product coverage and pricing.

Performance notes:
Aggregating before joining can reduce the number of rows joined later. This is
often helpful for reporting queries.

Common mistakes:
- Grouping by category name before joining categories.
- Selecting non-aggregated columns that are not in GROUP BY.
- Forgetting to join summary rows back to descriptive data.

Challenge exercise:
Summarise order count by user_id in a CTE and join it to users.

Challenge solution:
*/

WITH user_order_summary AS (
    SELECT
        user_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY user_id
)
SELECT
    users.email,
    user_order_summary.order_count
FROM user_order_summary
INNER JOIN users
    ON users.id = user_order_summary.user_id
ORDER BY user_order_summary.order_count DESC, users.email ASC;

/*
Related examples:
- ../04_aggregates/09_aggregate_with_join.sql
- ../03_joins/08_join_with_aggregation.sql
- 08_cte_for_reporting.sql
*/
