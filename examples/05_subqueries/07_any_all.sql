/*
Title: Compare With ANY and ALL
Difficulty: Intermediate

Learning Objectives:
- Use ANY to compare against at least one subquery value.
- Use ALL to compare against every subquery value.
- Read set comparisons carefully.

Problem Statement:
The merchandising team wants products priced higher than at least one
Stationery product.

SQL Solution:
*/

SELECT
    name,
    price
FROM products
WHERE price > ANY (
    SELECT
        products.price
    FROM products
    INNER JOIN categories
        ON categories.id = products.category_id
    WHERE categories.name = 'Stationery'
)
ORDER BY price ASC;

/*
Explanation:
> ANY means the product price must be greater than at least one value returned
by the subquery. Because Stationery includes low-priced products, many products
match.

Expected Output:
The query returns products priced above at least one Stationery product.

Business Scenario:
A merchandising analyst may compare one product set with prices from another
category.

Performance Notes:
ANY and ALL are expressive but can be less familiar to readers. In some reports,
MIN or MAX in a scalar subquery may communicate the intent more clearly.

Common Mistakes:
- Confusing ANY with ALL.
- Forgetting that an empty subquery can produce surprising logical results.
- Using ANY or ALL when MIN or MAX would be clearer.

Challenge Exercise:
Find products priced higher than all Stationery products.

Challenge Solution:
*/

SELECT
    name,
    price
FROM products
WHERE price > ALL (
    SELECT
        products.price
    FROM products
    INNER JOIN categories
        ON categories.id = products.category_id
    WHERE categories.name = 'Stationery'
)
ORDER BY price ASC;

/*
Related Chapters:
- ../02_filtering_sorting/04_comparison_operators.sql
- ../04_aggregates/04_min_max.sql
- 01_scalar_subquery.sql
*/
