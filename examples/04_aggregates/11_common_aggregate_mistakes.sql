/*
Title: Common Aggregate Mistakes
Difficulty: Intermediate

Learning Objectives:
- Recognise row multiplication after joins.
- Use COUNT(DISTINCT ...) when counting unique entities.
- Keep aggregate reports aligned with business meaning.

Problem Statement:
The analytics team wants to count orders and line items without confusing the
two metrics.

SQL Solution:
*/

SELECT
    COUNT(DISTINCT orders.id) AS order_count,
    COUNT(order_items.id) AS order_item_count
FROM orders
INNER JOIN order_items
    ON order_items.order_id = orders.id;

/*
Explanation:
Joining orders to order_items creates one row per order item, not one row per
order. COUNT(DISTINCT orders.id) counts unique orders, while COUNT(order_items.id)
counts line items.

Expected Output:
The query returns seven orders and twelve order items.

Business Scenario:
Reporting teams must separate order counts from line-item counts when analysing
sales volume.

Performance Notes:
COUNT(DISTINCT ...) is useful but can be more expensive than a plain COUNT.
Use it when the join shape requires unique entity counts.

Common Mistakes:
- Counting orders after joining order_items without DISTINCT.
- Summing values from the wrong level of detail.
- Mixing business definitions in one report without clear aliases.

Challenge Exercise:
Count unique customers and total order rows from the orders table.

Challenge Solution:
*/

SELECT
    COUNT(DISTINCT user_id) AS unique_customer_count,
    COUNT(*) AS order_count
FROM orders;

/*
Related Chapters:
- 08_distinct_aggregates.sql
- 10_business_reports.sql
- ../03_joins/11_common_join_mistakes.sql
*/
