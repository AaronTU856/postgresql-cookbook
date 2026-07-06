/*
Title: Group Rows With GROUP BY
Difficulty: Beginner

Learning objectives:
- Use GROUP BY to calculate one result per group.
- Count orders by status.
- Sort grouped results clearly.

Problem statement:
Operations wants to know how many orders exist in each status.

SQL solution:
*/

SELECT
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC, status ASC;

/*
Explanation:
GROUP BY status creates one group for each order status. COUNT(*) then counts
the rows in each group.

Expected results:
The query returns one row for each order status, with the count for that status.

Real-world example:
Order status counts are common in support queues, fulfilment dashboards, and
operations reports.

Performance notes:
Grouping large tables can require sorting or hashing. Filtering first can reduce
the amount of data PostgreSQL needs to group.

Common mistakes:
- Selecting columns that are not grouped or aggregated.
- Expecting GROUP BY to sort results without ORDER BY.
- Grouping by a label that is not the true business category.

Challenge exercise:
Count payments by payment status.

Challenge solution:
*/

SELECT
    status,
    COUNT(*) AS payment_count
FROM payments
GROUP BY status
ORDER BY payment_count DESC, status ASC;

/*
Related examples:
- 01_count.sql
- ../02_filtering_sorting/05_order_by.sql
- 07_having.sql
*/
