/*
Title: Group by Multiple Columns
Difficulty: Beginner

Learning objectives:
- Group results by more than one column.
- Count combinations of business values.
- Read multi-column grouped reports.

Problem statement:
Operations wants order counts by status and shipping city.

SQL solution:
*/

SELECT
    status,
    shipping_city,
    COUNT(*) AS order_count
FROM orders
GROUP BY
    status,
    shipping_city
ORDER BY status ASC, shipping_city ASC;

/*
Explanation:
GROUP BY status, shipping_city creates a separate group for each unique
combination of status and shipping city.

Expected results:
The query returns one row for each status-city combination in the sample orders.

Real-world example:
Regional operations teams often need counts grouped by workflow status and
location.

Performance notes:
Grouping by multiple columns creates more groups than grouping by one column.
Keep grouped columns aligned with the report question.

Common mistakes:
- Forgetting to include every non-aggregated selected column in GROUP BY.
- Grouping by too many columns and producing overly detailed reports.
- Assuming grouped output is sorted without ORDER BY.

Challenge exercise:
Count payments by payment method and status.

Challenge solution:
*/

SELECT
    payment_method,
    status,
    COUNT(*) AS payment_count
FROM payments
GROUP BY
    payment_method,
    status
ORDER BY payment_method ASC, status ASC;

/*
Related examples:
- 05_group_by.sql
- ../02_filtering_sorting/09_order_by_multiple_columns.sql
- 07_having.sql
*/
