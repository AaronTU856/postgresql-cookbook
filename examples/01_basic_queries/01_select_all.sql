/*
Title: Select All Columns
Difficulty: Beginner

Learning objectives:
- Use SELECT * to inspect every column in a table.
- Understand when SELECT * is useful and when it should be avoided.
- Read table data in a predictable order.

Problem statement:
The store team wants to inspect the product categories currently available in
the database.

SQL solution:
*/

SELECT *
FROM categories
ORDER BY id;

/*
Expected result description:
The query returns all columns for the four product categories: Books,
Stationery, Electronics, and Home Office.

Explanation:
SELECT * asks PostgreSQL to return every column from the categories table. This
is useful when exploring a new table, but application queries should usually
name the columns they need.

Real-world example:
A developer checking a new database locally might start with SELECT * to learn
what columns exist before writing a more focused query.

Performance considerations:
SELECT * can return more data than needed. On wide tables or large result sets,
that can increase memory use, network transfer, and application processing time.

Common mistakes:
- Using SELECT * in production code when only two or three columns are needed.
- Forgetting ORDER BY and assuming rows will always appear in the same order.

Challenge exercise:
Inspect every column from the products table and order the results by id.

Challenge solution:
*/

SELECT *
FROM products
ORDER BY id;

/*
Related examples:
- 02_select_columns.sql
- 05_order_by.sql
*/
