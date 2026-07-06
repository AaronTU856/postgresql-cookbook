/*
Title: Subquery vs Join
Difficulty: Intermediate

Learning objectives:
- Compare a subquery with an equivalent join.
- Choose the clearer approach for a business question.
- Recognise when both forms return the same result.

Problem statement:
The product team wants products in the Books category.

SQL solution:
*/

SELECT
    name,
    price
FROM products
WHERE category_id = (
    SELECT
        id
    FROM categories
    WHERE name = 'Books'
)
ORDER BY name ASC;

/*
Explanation:
The subquery finds the Books category ID, and the outer query returns products
with that category_id. This is clear when only the category ID is needed for
filtering.

Expected results:
The query returns the products in the Books category.

Real-world example:
Application filters often receive a category name or slug and need the related
products.

Performance notes:
For simple filters, PostgreSQL can often optimise either form well. Prefer the
version that is clearest, then check the query plan when performance matters.

Common mistakes:
- Assuming subqueries are always slower than joins.
- Using a subquery when the output needs columns from both tables.
- Using = when the subquery may return multiple category IDs.

Challenge exercise:
Return the same Books products using a join.

Challenge solution:
*/

SELECT
    products.name,
    products.price
FROM products
INNER JOIN categories
    ON categories.id = products.category_id
WHERE categories.name = 'Books'
ORDER BY products.name ASC;

/*
Related examples:
- ../03_joins/10_join_best_practices.sql
- 03_multiple_row_subquery.sql
- 09_subquery_in_from.sql
*/
