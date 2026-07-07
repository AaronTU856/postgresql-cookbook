/*
Title: Common Join Mistakes
Difficulty: Beginner

Learning Objectives:
- Avoid accidental row multiplication.
- Join through the correct relationship table.
- Use aliases to make join intent visible.

Problem Statement:
The reporting team wants order line details without accidentally joining orders
to unrelated products.

Business Scenario:
Incorrect joins can produce reports that look plausible but contain inflated or
incorrect rows. This is especially risky in revenue and fulfilment reports.

SQL Solution:
*/

SELECT
    o.id AS order_id,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price
FROM orders AS o
INNER JOIN order_items AS oi
    ON oi.order_id = o.id
INNER JOIN products AS p
    ON p.id = oi.product_id
ORDER BY o.id ASC, p.name ASC;

/*
Explanation:
Orders do not connect directly to products. The correct path is orders to
order_items, then order_items to products. This avoids accidentally pairing
orders with products that were not purchased in that order.

Expected Output:
The query returns twelve order-item rows with the correct product for each
order line.

Performance Notes:
Correct join paths are a correctness issue before they are a performance issue.
Indexes help only after the query represents the right relationship.

Common Mistakes:
- Joining tables only because they both have an id column.
- Forgetting the bridge table in many-to-many style relationships.
- Trusting row counts without checking whether rows were duplicated.

Challenge Exercise:
Return order IDs, customer email, and payment amount using the correct join
path.

Challenge Solution:
*/

SELECT
    o.id AS order_id,
    u.email AS customer_email,
    p.amount
FROM orders AS o
INNER JOIN users AS u
    ON u.id = o.user_id
INNER JOIN payments AS p
    ON p.order_id = o.id
ORDER BY o.id ASC;

/*
Related Chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
