/*
Title: Control NULL Sort Order
Difficulty: Beginner

Concepts:
- ORDER BY
- NULLS FIRST
- NULLS LAST

Learning objectives:
- Control where NULL values appear in sorted results.
- Sort payment timestamps predictably.
- Understand PostgreSQL-specific NULL ordering syntax.

Problem statement:
The finance team wants payments sorted by payment timestamp, with unpaid
payments shown first.

SQL solution:
*/

SELECT
    id,
    order_id,
    status,
    paid_at
FROM payments
ORDER BY paid_at ASC NULLS FIRST;

/*
Explanation:
NULLS FIRST tells PostgreSQL to place NULL values before non-NULL values in the
sort order. This makes unpaid payments appear before completed or refunded
payments.

Expected results:
The pending bank transfer with NULL paid_at appears first, followed by payments
with timestamps from oldest to newest.

Real-world example:
A finance queue may prioritise payments that have not yet completed.

Performance notes:
Sorting NULL values is usually not a problem on small datasets. On large tables,
review indexes and query plans for frequent payment queue queries.

Common mistakes:
- Assuming NULL values always sort first.
- Forgetting that NULL ordering can change with ASC and DESC.
- Hiding NULL values instead of making the sort rule explicit.

Challenge exercise:
Show paid or refunded payments first by newest paid_at timestamp, with NULL
values last.

Challenge solution:
*/

SELECT
    id,
    order_id,
    status,
    paid_at
FROM payments
ORDER BY paid_at DESC NULLS LAST;

/*
Related examples:
- 08_null_handling.sql
- 09_order_by_multiple_columns.sql
- ../01_basic_queries/11_null_values.sql
*/
