/*
Title: CROSS JOIN Reporting Combinations
Difficulty: Intermediate

Learning Objectives:
- Use CROSS JOIN to create every combination of two result sets.
- Recognise when a Cartesian product is intentional.
- Keep cross joins small and controlled.

Problem Statement:
The reporting team wants a planning grid of every product category and every
payment method currently used.

Business Scenario:
Before building a category-by-payment-method report, analysts may create a grid
of all possible combinations so missing combinations are easy to spot later.

SQL Solution:
*/

SELECT
    categories.name AS category_name,
    payment_methods.payment_method
FROM categories
CROSS JOIN (
    SELECT DISTINCT
        payment_method
    FROM payments
) AS payment_methods
ORDER BY categories.name ASC, payment_methods.payment_method ASC;

/*
Explanation:
CROSS JOIN combines every category with every distinct payment method. With four
categories and four payment methods, the result contains sixteen rows.

Expected Output:
The query returns every category-payment method pair.

Performance Notes:
CROSS JOIN multiplies row counts. A cross join between two large tables can
produce a very large result, so use it deliberately.

Common Mistakes:
- Creating a CROSS JOIN accidentally by forgetting an ON clause.
- Cross joining large tables without estimating the result size.
- Using CROSS JOIN when a normal relationship join is needed.

Challenge Exercise:
Create every combination of shipping city and order status currently present in
the orders table.

Challenge Solution:
*/

SELECT
    cities.shipping_city,
    statuses.status
FROM (
    SELECT DISTINCT
        shipping_city
    FROM orders
) AS cities
CROSS JOIN (
    SELECT DISTINCT
        status
    FROM orders
) AS statuses
ORDER BY cities.shipping_city ASC, statuses.status ASC;

/*
Related Chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
