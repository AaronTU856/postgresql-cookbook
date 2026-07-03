/*
Title: Filter Ranges With BETWEEN
Difficulty: Beginner

Learning objectives:
- Use BETWEEN for inclusive range filters.
- Filter numeric values.
- Recognise when explicit comparisons may be clearer.

Problem statement:
The merchandising team wants products priced between 20.00 and 60.00.

SQL solution:
*/

SELECT
    name,
    price
FROM products
WHERE price BETWEEN 20.00 AND 60.00
ORDER BY price;

/*
Expected result description:
The query returns products priced from 20.00 through 60.00, including Desk Lamp,
Django APIs Handbook, Laptop Stand, USB-C Dock, and any product exactly on the
boundary values.

Explanation:
BETWEEN is inclusive. This condition is equivalent to price >= 20.00 AND
price <= 60.00.

Real-world example:
Product filters often let customers choose a minimum and maximum price.

Performance considerations:
Range filters can use suitable indexes. This beginner schema does not include a
price index yet, but the indexes chapter will cover when one is useful.

Common mistakes:
- Forgetting that BETWEEN includes both boundary values.
- Reversing the lower and upper values, such as BETWEEN 60.00 AND 20.00.

Challenge exercise:
Find orders placed between 2026-02-12 and 2026-02-17, inclusive.

Challenge solution:
*/

SELECT
    id,
    status,
    order_date
FROM orders
WHERE order_date BETWEEN '2026-02-12 00:00:00+00' AND '2026-02-17 23:59:59+00'
ORDER BY order_date;

/*
Related examples:
- 04_where_clause.sql
- 05_order_by.sql
*/
