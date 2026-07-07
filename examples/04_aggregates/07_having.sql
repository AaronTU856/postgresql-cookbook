/*
Title: Filter Groups With HAVING
Difficulty: Intermediate

Learning Objectives:
- Use HAVING to filter grouped results.
- Find groups that meet aggregate conditions.
- Distinguish WHERE from HAVING.

Problem Statement:
Customer success wants to find customers who have placed more than one order.

SQL Solution:
*/

SELECT
    user_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY user_id
HAVING COUNT(*) > 1
ORDER BY order_count DESC;

/*
Explanation:
GROUP BY creates one row per user_id. HAVING filters those grouped rows after
COUNT(*) has been calculated.

Expected Output:
The query returns Amelia Clark's user_id because that user has two orders.

Business Scenario:
Customer success teams may use this pattern to identify repeat customers.

Performance Notes:
WHERE filters rows before grouping; HAVING filters groups after aggregation.
Use WHERE first when possible to reduce the grouped dataset.

Common Mistakes:
- Using WHERE COUNT(*) > 1, which is invalid SQL.
- Applying HAVING when a normal WHERE filter would be clearer.
- Forgetting that HAVING works on grouped results.

Challenge Exercise:
Find payment statuses with more than one payment.

Challenge Solution:
*/

SELECT
    status,
    COUNT(*) AS payment_count
FROM payments
GROUP BY status
HAVING COUNT(*) > 1
ORDER BY payment_count DESC;

/*
Related Chapters:
- 05_group_by.sql
- 06_group_by_multiple_columns.sql
- ../03_joins/08_join_with_aggregation.sql
*/
