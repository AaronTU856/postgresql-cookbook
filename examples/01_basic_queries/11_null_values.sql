/*
Title: Work With NULL Values
Difficulty: Beginner

Learning Objectives:
- Use IS NULL to find missing values.
- Use IS NOT NULL to find present values.
- Understand why NULL is not the same as an empty string or zero.

Problem Statement:
The finance team wants to find payments that have not been paid yet.

SQL Solution:
*/

SELECT
    id,
    order_id,
    amount,
    status,
    paid_at
FROM payments
WHERE paid_at IS NULL
ORDER BY id;

/*
Expected Output:
The query returns the pending bank transfer because its paid_at value is NULL.

Explanation:
NULL means the value is unknown or absent. In SQL, NULL cannot be compared with
= or !=. Use IS NULL and IS NOT NULL instead.

Business Scenario:
A payment reconciliation report may need to find records that do not yet have a
payment timestamp.

Performance Notes:
PostgreSQL can use indexes with IS NULL checks in some cases. For small tables,
readability matters more than adding indexes too early.

Common Mistakes:
- Writing paid_at = NULL. That does not work because NULL is not equal to
  anything, including itself.
- Treating NULL as the same thing as 0, FALSE, or an empty string.

Challenge Exercise:
Find payments that do have a paid_at timestamp.

Challenge Solution:
*/

SELECT
    id,
    order_id,
    amount,
    status,
    paid_at
FROM payments
WHERE paid_at IS NOT NULL
ORDER BY paid_at;

/*
Related Chapters:
- 04_where_clause.sql
- 10_in.sql
*/
