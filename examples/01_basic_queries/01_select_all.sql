/*
Title: Select All Columns
Difficulty: Beginner

Learning Objectives:
- Use SELECT * to inspect every column in a table.
- Understand when SELECT * is useful and when it should be avoided.
- Read table data in a predictable order.

Problem Statement:
The store team wants to inspect the product categories currently available in
the database.

SQL Solution:
*/

SELECT *
FROM categories
ORDER BY id;

/*
Expected Output:
The query returns all columns for the four product categories: Books,
Stationery, Electronics, and Home Office.

Explanation:
SELECT * asks PostgreSQL to return every column from the categories table. This
is useful when exploring a new table, but application queries should usually
name the columns they need.

Business Scenario:
A developer checking a new database locally might start with SELECT * to learn
what columns exist before writing a more focused query.

Performance Notes:
SELECT * can return more data than needed. On wide tables or large result sets,
that can increase memory use, network transfer, and application processing time.

Common Mistakes:
- Using SELECT * in production code when only two or three columns are needed.
- Forgetting ORDER BY and assuming rows will always appear in the same order.

Challenge Exercise:
Inspect every column from the products table and order the results by id.

Challenge Solution:
*/

SELECT *
FROM products
ORDER BY id;

/*
Related Chapters:
- 02_select_columns.sql
- 05_order_by.sql
*/
