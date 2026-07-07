/*
Title: Multiple-Row Subquery
Difficulty: Beginner

Learning Objectives:
- Use IN with a subquery returning multiple rows.
- Filter products by categories found in another query.
- Recognise when a subquery returns a list.

Problem Statement:
The product team wants all products in categories whose names include office or
electronics.

SQL Solution:
*/

SELECT
    name,
    category_id,
    price
FROM products
WHERE category_id IN (
    SELECT
        id
    FROM categories
    WHERE name IN ('Electronics', 'Home Office')
)
ORDER BY category_id ASC, name ASC;

/*
Explanation:
The subquery returns the IDs of the Electronics and Home Office categories. The
outer query returns products whose category_id appears in that list.

Expected Output:
The query returns products from Electronics and Home Office.

Business Scenario:
Product filtering often starts with human-readable category names but needs
category IDs to query product rows.

Performance Notes:
IN subqueries are common and readable. For larger datasets, compare the query
plan with an equivalent join.

Common Mistakes:
- Using = instead of IN when the subquery can return multiple rows.
- Returning the wrong column from the subquery.
- Forgetting that text values are case-sensitive unless handled explicitly.

Challenge Exercise:
Find orders placed by customers in Manchester or London.

Challenge Solution:
*/

SELECT
    id AS order_id,
    user_id,
    status,
    order_date
FROM orders
WHERE user_id IN (
    SELECT
        id
    FROM users
    WHERE city IN ('Manchester', 'London')
)
ORDER BY order_date DESC;

/*
Related Chapters:
- ../02_filtering_sorting/07_in_and_not_in.sql
- ../03_joins/10_join_best_practices.sql
- 10_subquery_vs_join.sql
*/
