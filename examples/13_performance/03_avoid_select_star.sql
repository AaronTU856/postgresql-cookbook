/*
Title: Avoid SELECT Star
Difficulty: Beginner

Learning Objectives:
- Select only columns the caller needs.
- Reduce unnecessary data transfer.
- Make query intent clearer.

Problem Statement:
The product catalogue page only needs product names, prices, and stock labels.

Business Scenario:
APIs often become slower when they return full rows instead of screen-specific
fields.

SQL Solution:
*/

SELECT
    name,
    price,
    stock_quantity
FROM products
WHERE is_active = TRUE
ORDER BY name ASC;

/*
Explanation:
The query names the required columns directly. This is clearer and avoids
returning unused data.

Expected Output:
Active products are returned with only name, price, and stock quantity.

Performance Notes:
Selecting fewer columns can reduce I/O, memory, and network transfer,
especially on wide tables.

Common Mistakes:
- Using SELECT * in application endpoints.
- Returning sensitive columns by accident.
- Making clients depend on implicit column order.

Challenge Exercise:
Rewrite a customer directory query to return only email, city, and created_at.

Challenge Solution:
*/

SELECT
    email,
    city,
    created_at
FROM users
ORDER BY created_at DESC;

/*
Related Chapters:
- ../01_basic_queries/02_select_columns.sql
- ../09_views/02_simple_view.sql
- 04_avoid_n_plus_one.sql
*/
