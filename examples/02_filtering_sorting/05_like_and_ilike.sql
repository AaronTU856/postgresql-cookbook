/*
Title: Match Text With LIKE and ILIKE
Difficulty: Beginner

Concepts:
- LIKE
- ILIKE
- Wildcards

Learning Objectives:
- Use LIKE for case-sensitive text matching.
- Use ILIKE for case-insensitive text matching in PostgreSQL.
- Place wildcards deliberately.

Problem Statement:
The product team wants to find products related to guides or Django.

SQL Solution:
*/

SELECT
    name,
    description,
    price
FROM products
WHERE name ILIKE '%guide%'
    OR description LIKE '%Django%'
ORDER BY name;

/*
Explanation:
ILIKE matches text without caring about letter case. LIKE is case-sensitive.
The % wildcard matches any number of characters before or after the search text.

Expected Output:
The query returns Django APIs Handbook and PostgreSQL Pocket Guide.

Business Scenario:
A simple admin search field may start with LIKE or ILIKE before the project
needs full-text search.

Performance Notes:
Patterns that start with %, such as '%guide%', usually cannot use a normal
B-tree index efficiently. Larger search features often need full-text search or
trigram indexes.

Common Mistakes:
- Forgetting the % wildcard.
- Expecting LIKE to be case-insensitive.
- Using text search patterns for large production search features without
  checking query performance.

Challenge Exercise:
Find customers whose email address ends with example.com.

Challenge Solution:
*/

SELECT
    first_name,
    last_name,
    email
FROM users
WHERE email LIKE '%@example.com'
ORDER BY email;

/*
Related Chapters:
- ../01_basic_queries/08_like.sql
- 01_where_and.sql
- 12_simple_pagination.sql
*/
