/*
Title: DENSE_RANK
Difficulty: Beginner

Learning Objectives:
- Use DENSE_RANK() for rankings without gaps.
- Rank products inside each category.
- Combine ranking with PARTITION BY.

Problem Statement:
The merchandising team wants product price ranks inside each category.

SQL Solution:
*/

SELECT
    category_id,
    name,
    price,
    DENSE_RANK() OVER (
        PARTITION BY category_id
        ORDER BY price DESC
    ) AS category_price_rank
FROM products
ORDER BY category_id ASC, category_price_rank ASC, name ASC;

/*
Explanation:
PARTITION BY category_id restarts the ranking for each category. DENSE_RANK()
assigns tied values the same rank without leaving gaps.

Expected Output:
The query returns products ranked by price within each category.

Business Scenario:
Category managers may need to identify the premium and budget products inside
each category.

Performance Notes:
Partitioned ranking sorts rows within each partition. Large partitions can be
more expensive than small ones.

Common Mistakes:
- Forgetting PARTITION BY and ranking products across all categories.
- Confusing RANK() gaps with DENSE_RANK() no-gap behaviour.
- Using category_id without later joining category names in user-facing reports.

Challenge Exercise:
Rank orders by order_date inside each status.

Challenge Solution:
*/

SELECT
    status,
    id AS order_id,
    order_date,
    DENSE_RANK() OVER (
        PARTITION BY status
        ORDER BY order_date DESC
    ) AS status_order_rank
FROM orders
ORDER BY status ASC, status_order_rank ASC;

/*
Related Chapters:
- 02_rank.sql
- 11_partition_by.sql
- ../03_joins/07_join_multiple_tables.sql
*/
