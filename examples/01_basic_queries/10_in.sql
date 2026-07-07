/*
Title: Filter Lists With IN
Difficulty: Beginner

Learning Objectives:
- Use IN to match one of several values.
- Write cleaner filters than repeated OR conditions.
- Apply list filters to business status values.

Problem Statement:
The fulfilment team wants orders that are paid or shipped and may need active
handling.

SQL Solution:
*/

SELECT
    id,
    status,
    order_date,
    shipping_city
FROM orders
WHERE status IN ('paid', 'shipped')
ORDER BY order_date;

/*
Expected Output:
The query returns orders whose status is paid or shipped, ordered from oldest to
newest.

Explanation:
IN checks whether a value matches any value in a list. It is easier to read than
status = 'paid' OR status = 'shipped'.

Business Scenario:
An operations queue might show orders that are ready for fulfilment but not yet
delivered.

Performance Notes:
IN works well for short lists. For long dynamic lists, applications should use
query parameters carefully and avoid building SQL strings manually.

Common Mistakes:
- Forgetting quotes around text values.
- Using IN with a list that mixes unrelated meanings.

Challenge Exercise:
Find products whose category_id is 1 or 3.

Challenge Solution:
*/

SELECT
    name,
    category_id,
    price
FROM products
WHERE category_id IN (1, 3)
ORDER BY category_id, name;

/*
Related Chapters:
- 03_select_distinct.sql
- 04_where_clause.sql
*/
