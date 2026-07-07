/*
Title: Filter With WHERE and NOT
Difficulty: Beginner

Concepts:
- WHERE
- NOT
- Excluding rows

Learning Objectives:
- Use NOT to reverse a condition.
- Exclude cancelled orders from a result set.
- Compare NOT with alternative operators.

Problem Statement:
Customer support wants to see orders that have not been cancelled.

SQL Solution:
*/

SELECT
    id,
    status,
    order_date,
    shipping_city
FROM orders
WHERE NOT status = 'cancelled'
ORDER BY order_date DESC;

/*
Explanation:
NOT reverses the condition that follows it. This query keeps every order whose
status is not cancelled.

Expected Output:
The query returns six orders and excludes the cancelled Bristol order.

Business Scenario:
Support tools often hide cancelled records from default queues while still
keeping them available for audit or reporting.

Performance Notes:
Negative filters can be harder to optimise than positive filters. Prefer a
clear positive condition when the business rule allows it.

Common Mistakes:
- Forgetting that NOT applies only to the expression that follows it.
- Writing NOT filters that accidentally include too many rows.
- Using NOT with NULL comparisons instead of IS NOT NULL.

Challenge Exercise:
Find products that are not in the Electronics category.

Challenge Solution:
*/

SELECT
    name,
    category_id,
    price
FROM products
WHERE NOT category_id = 3
ORDER BY category_id, name;

/*
Related Chapters:
- 07_in_and_not_in.sql
- 08_null_handling.sql
- ../01_basic_queries/04_where_clause.sql
*/
