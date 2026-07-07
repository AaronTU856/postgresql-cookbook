/*
Title: Use Column Aliases
Difficulty: Beginner

Learning Objectives:
- Rename output columns with AS.
- Create readable labels for calculated values.
- Keep database column names separate from presentation names.

Problem Statement:
The customer export should display a full customer name and contact email.

SQL Solution:
*/

SELECT
    first_name || ' ' || last_name AS customer_name,
    email AS contact_email,
    city AS home_city
FROM users
ORDER BY last_name;

/*
Expected Output:
The query returns one row per user with readable output columns named
customer_name, contact_email, and home_city.

Explanation:
AS assigns an alias to a selected expression or column. The first selected value
combines first_name and last_name into a single customer_name column.

Business Scenario:
Reports often need friendly column names that differ from the underlying table
columns used by the application.

Performance Notes:
Simple aliases do not materially affect performance. Calculated expressions can
cost more on very large result sets, especially if they are used for sorting or
filtering.

Common Mistakes:
- Expecting an alias to rename the actual table column. It only changes the
  query result.
- Using aliases with spaces in application queries, which requires quoting and
  can make code awkward.

Challenge Exercise:
Return product names and prices using the aliases product_name and unit_price.

Challenge Solution:
*/

SELECT
    name AS product_name,
    price AS unit_price
FROM products
ORDER BY product_name;

/*
Related Chapters:
- 02_select_columns.sql
- 05_order_by.sql
*/
