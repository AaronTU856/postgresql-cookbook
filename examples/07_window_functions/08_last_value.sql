/*
Title: LAST_VALUE
Difficulty: Intermediate

Learning objectives:
- Use LAST_VALUE() safely with an explicit frame.
- Find the cheapest product in each category.
- Understand why window frames matter.

Problem statement:
The merchandising team wants each product shown with the cheapest product in its
category.

SQL solution:
*/

SELECT
    category_id,
    name,
    price,
    LAST_VALUE(name) OVER (
        PARTITION BY category_id
        ORDER BY price DESC, id ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS cheapest_product_in_category
FROM products
ORDER BY category_id ASC, price DESC;

/*
Explanation:
LAST_VALUE() reads the last row in the window frame. The explicit frame tells
PostgreSQL to look from the first row through the last row in each category.

Expected results:
Each product row includes the name of the lowest-priced product in its category.

Real-world example:
Product reports can compare every item with the lowest-priced item in the same
category.

Performance notes:
LAST_VALUE() often needs an explicit frame. Without it, PostgreSQL's default
frame can produce surprising results.

Common mistakes:
- Using LAST_VALUE() without ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED
  FOLLOWING.
- Ordering in the wrong direction.
- Confusing final query ordering with window ordering.

Challenge exercise:
Show each user order with the latest order date for that user.

Challenge solution:
*/

SELECT
    user_id,
    id AS order_id,
    order_date,
    LAST_VALUE(order_date) OVER (
        PARTITION BY user_id
        ORDER BY order_date ASC, id ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS latest_order_date_for_user
FROM orders
ORDER BY user_id ASC, order_date ASC;

/*
Related examples:
- 07_first_value.sql
- 13_common_window_mistakes.sql
- ../06_ctes/10_common_cte_mistakes.sql
*/
