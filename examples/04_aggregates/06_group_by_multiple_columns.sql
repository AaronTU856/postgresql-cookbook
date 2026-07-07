/*
Title: Group by Multiple Columns
Difficulty: Beginner

Learning Objectives:
- Group results by more than one column.
- Count combinations of business values.
- Read multi-column grouped reports.

Problem Statement:
Operations wants order counts by status and shipping city.

SQL Solution:
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

Expected Output:
The query returns one row for each status-city combination in the sample orders.

Business Scenario:
Regional operations teams often need counts grouped by workflow status and
location.

Performance Notes:
Grouping by multiple columns creates more groups than grouping by one column.
Keep grouped columns aligned with the report question.

Common Mistakes:
- Forgetting to include every non-aggregated selected column in GROUP BY.
- Grouping by too many columns and producing overly detailed reports.
- Assuming grouped output is sorted without ORDER BY.

Challenge Exercise:
Count payments by payment method and status.

Challenge Solution:
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
Related Chapters:
- 05_group_by.sql
- ../02_filtering_sorting/09_order_by_multiple_columns.sql
- 07_having.sql
*/
