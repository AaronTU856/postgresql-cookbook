/*
Title: Use Comparison Operators
Difficulty: Beginner

Concepts:
- Greater than
- Less than or equal to
- Numeric comparisons

Learning objectives:
- Use comparison operators in WHERE clauses.
- Combine price and stock filters.
- Read business rules expressed as numeric conditions.

Problem statement:
The merchandising team wants products priced above 25.00 where stock is 30 or
lower.

SQL solution:
*/

SELECT
    name,
    price,
    stock_quantity
FROM products
WHERE price > 25.00
    AND stock_quantity <= 30
ORDER BY price DESC;

/*
Explanation:
The > operator keeps products priced above 25.00. The <= operator keeps
products where stock_quantity is less than or equal to 30.

Expected results:
The query returns Mechanical Keyboard, USB-C Dock, Laptop Stand, and Django APIs
Handbook.

Real-world example:
A shop manager might use this filter to review higher-value items with limited
stock.

Performance notes:
Range comparisons can use indexes when suitable indexes exist. Avoid adding
indexes until query patterns and table size justify them.

Common mistakes:
- Confusing > with >=.
- Comparing numbers as quoted text.
- Forgetting to test boundary values such as exactly 25.00 or exactly 30.

Challenge exercise:
Find payments with an amount greater than or equal to 50.00.

Challenge solution:
*/

SELECT
    id,
    order_id,
    amount,
    payment_method,
    status
FROM payments
WHERE amount >= 50.00
ORDER BY amount DESC;

/*
Related examples:
- 01_where_and.sql
- 06_between.sql
- ../01_basic_queries/09_between.sql
*/
