/*
Title: Create View
Difficulty: Beginner

Learning objectives:
- Create a reusable view.
- Query a view like a table.
- Drop and recreate a view safely while practising.

Problem statement:
The catalogue team frequently needs a list of active products with their current
prices and stock levels.

SQL solution:
*/

DROP VIEW IF EXISTS active_product_catalog;

CREATE VIEW active_product_catalog AS
SELECT
    id AS product_id,
    name,
    price,
    stock_quantity
FROM products
WHERE is_active = TRUE;

SELECT
    product_id,
    name,
    price,
    stock_quantity
FROM active_product_catalog
ORDER BY name ASC;

/*
Explanation:
CREATE VIEW stores the SELECT statement under a name. Querying the view runs the
saved query and returns active products from the products table.

Expected results:
The view returns active products with product id, name, price, and stock level.

Real-world example:
Application screens often use views to keep common read queries consistent.

Performance notes:
A regular view does not store data or automatically improve performance. The
underlying SELECT still runs when the view is queried.

Common mistakes:
- Assuming a regular view stores a copy of the rows.
- Forgetting that changing the base table affects the view result.
- Creating view names that do not describe the business purpose.

Challenge exercise:
Create a view that lists products with fewer than 20 units in stock.

Challenge solution:
*/

DROP VIEW IF EXISTS low_stock_products;

CREATE VIEW low_stock_products AS
SELECT
    id AS product_id,
    name,
    stock_quantity
FROM products
WHERE stock_quantity < 20;

SELECT
    product_id,
    name,
    stock_quantity
FROM low_stock_products
ORDER BY stock_quantity ASC, name ASC;

/*
Related examples:
- 02_simple_view.sql
- ../02_filtering_sorting/04_comparison_operators.sql
- ../08_transactions/09_locking.sql
*/
