/*
Title: Filter Rows With WHERE
Difficulty: Beginner

Learning Objectives:
- Use WHERE to filter rows.
- Compare numeric values.
- Return only records that match a business rule.

Problem Statement:
The merchandising team wants to review products priced at 25.00 or above.

SQL Solution:
*/

SELECT
    name,
    price,
    stock_quantity
FROM products
WHERE price >= 25.00
ORDER BY price DESC;

/*
Expected Output:
The query returns higher-priced products such as Mechanical Keyboard, USB-C
Dock, Laptop Stand, and Django APIs Handbook.

Explanation:
WHERE filters rows before they are returned. The condition price >= 25.00 keeps
only products whose price is greater than or equal to 25.00.

Business Scenario:
An ecommerce admin screen may filter products by price band when planning sales
or promotions.

Performance Notes:
Filtering can be faster when PostgreSQL can use a suitable index. This schema
does not yet include an index on price because the dataset is intentionally
small for beginner examples.

Common Mistakes:
- Putting the WHERE clause after ORDER BY.
- Using a string comparison for numeric data, such as price >= '25.00'.

Challenge Exercise:
Find products with fewer than 20 items in stock, ordered by stock quantity.

Challenge Solution:
*/

SELECT
    name,
    stock_quantity
FROM products
WHERE stock_quantity < 20
ORDER BY stock_quantity;

/*
Related Chapters:
- 05_order_by.sql
- 09_between.sql
*/
