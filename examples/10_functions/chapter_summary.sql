/*
Title: Functions Chapter Summary
Difficulty: Intermediate

Learning Objectives:
- Review SQL functions and PL/pgSQL functions.
- Apply functions to business reporting.
- Choose safe volatility and return types.

Problem Statement:
Summarise the chapter by creating reusable customer value and stock label
functions.

Business Scenario:
Customer success wants customer lifetime value, while merchandising wants a
clear stock label for product reports.

SQL Solution:
*/

DROP FUNCTION IF EXISTS cookbook_customer_lifetime_value(BIGINT);

CREATE FUNCTION cookbook_customer_lifetime_value(
    p_user_id BIGINT
)
RETURNS NUMERIC
LANGUAGE SQL
STABLE
AS $$
    SELECT COALESCE(
        SUM(payments.amount) FILTER (WHERE payments.status = 'completed'),
        0
    )
    FROM orders
    LEFT JOIN payments
        ON payments.order_id = orders.id
    WHERE orders.user_id = p_user_id;
$$;

DROP FUNCTION IF EXISTS cookbook_stock_label(INTEGER);

CREATE FUNCTION cookbook_stock_label(
    p_stock_quantity INTEGER
)
RETURNS TEXT
LANGUAGE plpgsql
IMMUTABLE
STRICT
AS $$
BEGIN
    IF p_stock_quantity = 0 THEN
        RETURN 'out_of_stock';
    ELSIF p_stock_quantity < 20 THEN
        RETURN 'low_stock';
    END IF;

    RETURN 'in_stock';
END;
$$;

SELECT
    users.email,
    cookbook_customer_lifetime_value(users.id) AS lifetime_value
FROM users
ORDER BY lifetime_value DESC, users.email ASC;

SELECT
    name,
    stock_quantity,
    cookbook_stock_label(stock_quantity) AS stock_label
FROM products
ORDER BY stock_quantity ASC, name ASC;

/*
Explanation:
The summary combines a STABLE SQL function that reads tables with an IMMUTABLE
PL/pgSQL function that labels input values. Together they show the main design
choices from the chapter.

Expected Output:
The first query returns customer lifetime values. The second query returns
products with stock labels.

Performance Notes:
Use functions for clarity and reuse, but profile them in large reports. A
function that reads tables once per row may be slower than a grouped query.

Common Mistakes:
- Treating every function as a performance optimisation.
- Marking database-reading functions as IMMUTABLE.
- Hiding unclear business definitions inside function bodies.

Challenge Exercise:
Create a final function that returns the number of orders for a given status.

Challenge Solution:
*/

DROP FUNCTION IF EXISTS cookbook_order_count_by_status(VARCHAR);

CREATE FUNCTION cookbook_order_count_by_status(
    p_status VARCHAR
)
RETURNS BIGINT
LANGUAGE SQL
STABLE
AS $$
    SELECT COUNT(*)
    FROM orders
    WHERE orders.status = p_status;
$$;

SELECT
    cookbook_order_count_by_status('paid') AS paid_order_count,
    cookbook_order_count_by_status('delivered') AS delivered_order_count;

/*
Related Chapters:
- ../04_aggregates/10_business_reports.sql
- ../08_transactions/10_acid_properties.sql
- ../09_views/10_business_reporting_view.sql
*/
