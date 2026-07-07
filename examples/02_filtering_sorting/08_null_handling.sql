/*
Title: Filter NULL Values
Difficulty: Beginner

Concepts:
- NULL
- IS NULL
- IS NOT NULL

Learning Objectives:
- Find missing values with IS NULL.
- Find present values with IS NOT NULL.
- Avoid invalid NULL comparisons.

Problem Statement:
The finance team wants payments that do not yet have a payment timestamp.

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
Explanation:
NULL means the value is unknown or absent. Use IS NULL to find rows where a
column has no stored value.

Expected Output:
The query returns the pending bank transfer payment with no paid_at timestamp.

Business Scenario:
Finance dashboards often need to identify payments that have been created but
not completed.

Performance Notes:
IS NULL filters can use indexes in PostgreSQL in some cases. For this small
dataset, the important point is correct NULL handling.

Common Mistakes:
- Writing paid_at = NULL.
- Treating NULL like an empty string or zero.
- Forgetting that NOT IN behaves unexpectedly when a list contains NULL.

Challenge Exercise:
Find payments that do have a payment timestamp.

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
ORDER BY paid_at ASC;

/*
Related Chapters:
- ../01_basic_queries/11_null_values.sql
- 10_nulls_first_last.sql
- 07_in_and_not_in.sql
*/
