/*
Title: Complex View
Difficulty: Intermediate

Learning objectives:
- Create a view with calculated columns.
- Use CASE expressions inside a view.
- Encapsulate business-friendly product status labels.

Problem statement:
Merchandising wants products labelled as in stock, low stock, or out of stock
without rewriting the CASE logic in every report.

SQL solution:
*/

DROP VIEW IF EXISTS product_stock_status;

CREATE VIEW product_stock_status AS
SELECT
    id AS product_id,
    name,
    price,
    stock_quantity,
    CASE
        WHEN stock_quantity = 0 THEN 'out_of_stock'
        WHEN stock_quantity < 20 THEN 'low_stock'
        ELSE 'in_stock'
    END AS stock_status
FROM products
WHERE is_active = TRUE;

SELECT
    product_id,
    name,
    stock_quantity,
    stock_status
FROM product_stock_status
ORDER BY stock_quantity ASC, name ASC;

/*
Explanation:
The view centralises the CASE expression that converts numeric stock quantities
into business-friendly stock status labels.

Expected results:
Active products are returned with a calculated stock_status value.

Real-world example:
Product dashboards often reuse the same stock status logic across several
screens and reports.

Performance notes:
Calculated columns in regular views are evaluated when queried. Expensive
expressions may need indexes, generated columns, or materialized views later.

Common mistakes:
- Duplicating business logic across many queries.
- Hiding complicated logic in a view without documenting it.
- Forgetting that filters on calculated columns may still evaluate the expression.

Challenge exercise:
Create a view that labels products as budget, standard, or premium by price.

Challenge solution:
*/

DROP VIEW IF EXISTS product_price_bands;

CREATE VIEW product_price_bands AS
SELECT
    id AS product_id,
    name,
    price,
    CASE
        WHEN price < 20 THEN 'budget'
        WHEN price < 60 THEN 'standard'
        ELSE 'premium'
    END AS price_band
FROM products
WHERE is_active = TRUE;

SELECT
    product_id,
    name,
    price,
    price_band
FROM product_price_bands
ORDER BY price ASC;

/*
Related examples:
- 02_simple_view.sql
- ../02_filtering_sorting/04_comparison_operators.sql
- ../04_aggregates/10_business_reports.sql
*/
