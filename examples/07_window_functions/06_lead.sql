/*
Title: LEAD
Difficulty: Intermediate

Learning objectives:
- Use LEAD() to read a following row.
- Compare each order with the next order.
- Understand forward-looking event comparisons.

Problem statement:
Operations wants to see the next order date beside each order.

SQL solution:
*/

SELECT
    id AS order_id,
    order_date,
    LEAD(order_date) OVER (
        ORDER BY order_date ASC, id ASC
    ) AS next_order_date
FROM orders
ORDER BY order_date ASC, id ASC;

/*
Explanation:
LEAD(order_date) reads the order_date from the next row in the ordered window.
The final row has no next row, so next_order_date is NULL.

Expected results:
Each order row shows the following order date, except the latest order.

Real-world example:
Event reports use LEAD() to compare current and next activity without a self
join.

Performance notes:
Like LAG(), LEAD() depends on ordered rows. Use stable ordering to make results
deterministic.

Common mistakes:
- Forgetting that the last row has no next row.
- Expecting LEAD() to look inside business groups without PARTITION BY.
- Omitting tie-breakers in the window order.

Challenge exercise:
Show each product price with the next higher product price when ordered from
cheapest to most expensive.

Challenge solution:
*/

SELECT
    name,
    price,
    LEAD(price) OVER (
        ORDER BY price ASC, id ASC
    ) AS next_higher_price
FROM products
ORDER BY price ASC, id ASC;

/*
Related examples:
- 05_lag.sql
- 11_partition_by.sql
- ../02_filtering_sorting/05_order_by.sql
*/
