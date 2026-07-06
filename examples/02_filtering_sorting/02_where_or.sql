/*
Title: Filter With WHERE and OR
Difficulty: Beginner

Concepts:
- WHERE
- OR
- Status filtering

Learning objectives:
- Combine alternative conditions with OR.
- Filter rows where at least one condition is true.
- Recognise when IN may be cleaner than repeated OR conditions.

Problem statement:
The fulfilment team wants to review orders that are either shipped or still
pending.

SQL solution:
*/

SELECT
    id,
    status,
    order_date,
    shipping_city
FROM orders
WHERE status = 'shipped'
    OR status = 'pending'
ORDER BY order_date ASC;

/*
Explanation:
OR keeps a row when any condition is true. This query returns orders with a
status of shipped or pending.

Expected results:
The query returns the shipped Birmingham order and the pending Edinburgh order.

Real-world example:
An operations queue may combine several statuses that still need attention.

Performance notes:
Short OR filters are fine for small lists. When checking one column against
several values, IN is often easier to read.

Common mistakes:
- Using OR when all conditions must match.
- Mixing AND and OR without parentheses in more complex filters.
- Repeating long expressions that could be simplified with IN.

Challenge exercise:
Find products that are in the Books category or cost less than 10.00.

Challenge solution:
*/

SELECT
    name,
    category_id,
    price
FROM products
WHERE category_id = 1
    OR price < 10.00
ORDER BY category_id, price;

/*
Related examples:
- 01_where_and.sql
- 07_in_and_not_in.sql
- ../01_basic_queries/10_in.sql
*/
