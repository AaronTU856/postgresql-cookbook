/*
Title: Create Function
Difficulty: Beginner

Learning objectives:
- Create a simple PostgreSQL function.
- Reuse a line-total calculation.
- Call a function from a SELECT query.

Problem statement:
The store repeatedly calculates line totals from quantity and unit price.

Business scenario:
Order screens, invoices, and reports all need the same quantity multiplied by
unit price calculation.

SQL solution:
*/

DROP FUNCTION IF EXISTS cookbook_line_total(INTEGER, NUMERIC);

CREATE FUNCTION cookbook_line_total(
    p_quantity INTEGER,
    p_unit_price NUMERIC
)
RETURNS NUMERIC
LANGUAGE SQL
IMMUTABLE
STRICT
AS $$
    SELECT ROUND(p_quantity * p_unit_price, 2);
$$;

SELECT
    order_id,
    product_id,
    quantity,
    unit_price,
    cookbook_line_total(quantity, unit_price) AS line_total
FROM order_items
ORDER BY order_id ASC, product_id ASC;

/*
Explanation:
The function wraps a simple calculation in one reusable name. IMMUTABLE is
appropriate because the same inputs always produce the same output and the
function does not read database tables.

Expected output:
Each order item row includes a calculated line_total value.

Performance considerations:
Small immutable SQL functions are usually inexpensive. Do not wrap very simple
expressions unless reuse or clarity justifies it.

Common mistakes:
- Marking table-reading functions as IMMUTABLE.
- Using vague parameter names such as x and y.
- Creating functions for logic that is only used once.

Challenge:
Create a function that adds VAT to an amount using a supplied tax rate.

Challenge solution:
*/

DROP FUNCTION IF EXISTS cookbook_add_tax(NUMERIC, NUMERIC);

CREATE FUNCTION cookbook_add_tax(
    p_amount NUMERIC,
    p_tax_rate NUMERIC
)
RETURNS NUMERIC
LANGUAGE SQL
IMMUTABLE
STRICT
AS $$
    SELECT ROUND(p_amount * (1 + p_tax_rate), 2);
$$;

SELECT
    amount,
    cookbook_add_tax(amount, 0.20) AS amount_with_tax
FROM payments
WHERE status = 'completed'
ORDER BY paid_at ASC;

/*
Related chapters:
- ../04_aggregates/02_sum.sql
- ../08_transactions/10_acid_properties.sql
- ../09_views/05_aggregate_view.sql
*/
