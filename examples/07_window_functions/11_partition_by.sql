/*
Title: PARTITION BY
Difficulty: Intermediate

Learning Objectives:
- Use PARTITION BY to restart calculations per group.
- Number orders within each customer.
- Keep row-level detail while adding per-group context.

Problem Statement:
Customer success wants each customer's orders numbered from oldest to newest.

SQL Solution:
*/

SELECT
    user_id,
    id AS order_id,
    order_date,
    ROW_NUMBER() OVER (
        PARTITION BY user_id
        ORDER BY order_date ASC, id ASC
    ) AS customer_order_number
FROM orders
ORDER BY user_id ASC, customer_order_number ASC;

/*
Explanation:
PARTITION BY user_id restarts ROW_NUMBER() for each customer. The result keeps
every order row and adds the customer's order sequence number.

Expected Output:
Each order is numbered within its user_id. Amelia Clark has order numbers 1 and
2 because she has two orders.

Business Scenario:
Customer lifecycle reports often need to identify first, second, and later
orders per customer.

Performance Notes:
Partitioned windows sort rows inside each partition. Indexes on partition and
ordering columns can help larger datasets.

Common Mistakes:
- Forgetting PARTITION BY and numbering across all customers.
- Using partition columns that do not match the business question.
- Omitting an order tie-breaker.

Challenge Exercise:
Number products from most expensive to cheapest inside each category.

Challenge Solution:
*/

SELECT
    category_id,
    name,
    price,
    ROW_NUMBER() OVER (
        PARTITION BY category_id
        ORDER BY price DESC, id ASC
    ) AS category_price_position
FROM products
ORDER BY category_id ASC, category_price_position ASC;

/*
Related Chapters:
- 01_row_number.sql
- 03_dense_rank.sql
- ../03_joins/08_join_with_aggregation.sql
*/
