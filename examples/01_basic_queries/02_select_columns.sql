/*
Title: Select Specific Columns
Difficulty: Beginner

Learning Objectives:
- Select only the columns needed by a query.
- Return product information in a readable order.
- Avoid unnecessary data transfer.

Problem Statement:
The product page needs a list of active products with their names, prices, and
stock quantities.

SQL Solution:
*/

SELECT
    name,
    price,
    stock_quantity
FROM products
WHERE is_active = TRUE
ORDER BY name;

/*
Expected Output:
The query returns the name, price, and stock quantity for each active product,
ordered alphabetically by product name.

Explanation:
Listing columns after SELECT makes the query explicit. This keeps output stable
even if new columns are added to the table later.

Business Scenario:
An API endpoint for a product listing page should return only the fields needed
by the frontend.

Performance Notes:
Selecting fewer columns can reduce network transfer and memory usage,
especially when tables contain large text, JSONB, or binary columns.

Common Mistakes:
- Selecting columns that the application never displays.
- Forgetting to include a useful ORDER BY for user-facing lists.

Challenge Exercise:
Return category names and descriptions ordered by category name.

Challenge Solution:
*/

SELECT
    name,
    description
FROM categories
ORDER BY name;

/*
Related Chapters:
- 01_select_all.sql
- 05_order_by.sql
*/
