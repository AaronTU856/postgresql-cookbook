/*
Title: Function Parameters
Difficulty: Beginner

Learning objectives:
- Pass parameters into a function.
- Use parameters to make business rules reusable.
- Apply a function to product data.

Problem statement:
Marketing wants to preview discounted prices without permanently changing the
products table.

Business scenario:
Promotional campaigns often need the same discount formula across product pages,
emails, and reports.

SQL solution:
*/

DROP FUNCTION IF EXISTS cookbook_discounted_price(NUMERIC, NUMERIC);

CREATE FUNCTION cookbook_discounted_price(
    p_price NUMERIC,
    p_discount_percent NUMERIC
)
RETURNS NUMERIC
LANGUAGE SQL
IMMUTABLE
STRICT
AS $$
    SELECT ROUND(p_price * (1 - (p_discount_percent / 100)), 2);
$$;

SELECT
    id AS product_id,
    name,
    price,
    cookbook_discounted_price(price, 10) AS ten_percent_discount_price
FROM products
WHERE is_active = TRUE
ORDER BY price DESC;

/*
Explanation:
Parameters make the function reusable for different prices and discount
percentages. The products table is only read; no prices are changed.

Expected output:
Each active product appears with its original price and a discounted preview.

Performance considerations:
This function is safe for small result sets. For very large reports, compare the
function call with the inline expression in an execution plan.

Common mistakes:
- Hard-coding one discount value inside the function.
- Forgetting that this function previews prices but does not update products.
- Allowing invalid discount percentages without separate validation.

Challenge:
Create a function that applies a fixed currency reduction to a product price.

Challenge solution:
*/

DROP FUNCTION IF EXISTS cookbook_price_after_reduction(NUMERIC, NUMERIC);

CREATE FUNCTION cookbook_price_after_reduction(
    p_price NUMERIC,
    p_reduction NUMERIC
)
RETURNS NUMERIC
LANGUAGE SQL
IMMUTABLE
STRICT
AS $$
    SELECT GREATEST(ROUND(p_price - p_reduction, 2), 0);
$$;

SELECT
    name,
    price,
    cookbook_price_after_reduction(price, 5.00) AS reduced_price
FROM products
ORDER BY price ASC;

/*
Related chapters:
- ../02_filtering_sorting/04_comparison_operators.sql
- ../04_aggregates/03_avg.sql
- 01_create_function.sql
*/
