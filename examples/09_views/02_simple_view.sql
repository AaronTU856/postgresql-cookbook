/*
Title: Simple View
Difficulty: Beginner

Learning Objectives:
- Build a view from one table.
- Expose only useful columns.
- Use a view to simplify repeated filters.

Problem Statement:
Customer support needs a simple customer directory without exposing unnecessary
table details.

SQL Solution:
*/

DROP VIEW IF EXISTS customer_directory;

CREATE VIEW customer_directory AS
SELECT
    id AS user_id,
    first_name,
    last_name,
    email,
    city,
    country
FROM users;

SELECT
    user_id,
    first_name,
    last_name,
    email,
    city
FROM customer_directory
ORDER BY last_name ASC, first_name ASC;

/*
Explanation:
The view selects a clear subset of columns from users. Readers can query
customer_directory without remembering the full users table structure.

Expected Output:
The query returns the six seeded customers with contact and location columns.

Business Scenario:
Support tooling often needs customer contact data but not every customer table
column.

Performance Notes:
Simple views are usually easy for PostgreSQL to inline into the outer query, but
indexes still belong on the base table.

Common Mistakes:
- Exposing every column instead of the columns the reader needs.
- Using vague view names such as user_view.
- Forgetting to update dependent application queries after renaming columns.

Challenge Exercise:
Create a simple view for UK customers only.

Challenge Solution:
*/

DROP VIEW IF EXISTS uk_customer_directory;

CREATE VIEW uk_customer_directory AS
SELECT
    id AS user_id,
    first_name,
    last_name,
    email,
    city
FROM users
WHERE country = 'United Kingdom';

SELECT
    user_id,
    first_name,
    last_name,
    email,
    city
FROM uk_customer_directory
ORDER BY city ASC, last_name ASC;

/*
Related Chapters:
- 01_create_view.sql
- ../01_basic_queries/02_select_columns.sql
- ../02_filtering_sorting/04_comparison_operators.sql
*/
