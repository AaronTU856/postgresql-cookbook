/*
Title: Select Distinct Values
Difficulty: Beginner

Learning objectives:
- Use DISTINCT to remove duplicate values.
- Discover the set of values stored in a column.
- Sort distinct values for easier reading.

Problem statement:
The operations team wants to know which order statuses currently exist in the
orders table.

SQL solution:
*/

SELECT DISTINCT
    status
FROM orders
ORDER BY status;

/*
Expected result description:
The query returns each order status once, such as cancelled, delivered, paid,
pending, and shipped.

Explanation:
DISTINCT removes duplicate rows from the result. Because only status is
selected, PostgreSQL returns one row per unique status value.

Real-world example:
Before building a status filter in an admin dashboard, a developer may inspect
the existing status values in the database.

Performance considerations:
DISTINCT may require PostgreSQL to sort or hash results. It is fine for small
tables, but on large datasets it can be more expensive than a simple SELECT.

Common mistakes:
- Expecting DISTINCT to apply to only one column when multiple columns are
  selected. DISTINCT applies to the whole selected row.
- Using DISTINCT to hide duplicate data problems instead of fixing the source.

Challenge exercise:
Return each payment method used in the payments table.

Challenge solution:
*/

SELECT DISTINCT
    payment_method
FROM payments
ORDER BY payment_method;

/*
Related examples:
- 04_where_clause.sql
- 10_in.sql
*/
