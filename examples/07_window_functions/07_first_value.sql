/*
Title: FIRST_VALUE
Difficulty: Intermediate

Learning Objectives:
- Use FIRST_VALUE() to read the first row in a window.
- Find the most expensive product per category.
- Combine FIRST_VALUE() with PARTITION BY.

Problem Statement:
The merchandising team wants each product shown with the most expensive product
in its category.

SQL Solution:
*/

SELECT
    category_id,
    name,
    price,
    FIRST_VALUE(name) OVER (
        PARTITION BY category_id
        ORDER BY price DESC, id ASC
    ) AS most_expensive_product_in_category
FROM products
ORDER BY category_id ASC, price DESC;

/*
Explanation:
FIRST_VALUE(name) reads the first product name in each category partition after
ordering by price descending.

Expected Output:
Each product row includes the name of the highest-priced product in its category.

Business Scenario:
Merchandising reports can show each product compared with the premium product in
the same category.

Performance Notes:
FIRST_VALUE() uses the window ordering. Large partitions require sorting and may
benefit from indexes aligned with the partition and order columns.

Common Mistakes:
- Forgetting PARTITION BY and getting the first value across all products.
- Ordering in the wrong direction.
- Expecting FIRST_VALUE() to reduce rows like GROUP BY.

Challenge Exercise:
Show each user order with the first order date for that user.

Challenge Solution:
*/

SELECT
    user_id,
    id AS order_id,
    order_date,
    FIRST_VALUE(order_date) OVER (
        PARTITION BY user_id
        ORDER BY order_date ASC, id ASC
    ) AS first_order_date_for_user
FROM orders
ORDER BY user_id ASC, order_date ASC;

/*
Related Chapters:
- 08_last_value.sql
- 11_partition_by.sql
- ../04_aggregates/04_min_max.sql
*/
