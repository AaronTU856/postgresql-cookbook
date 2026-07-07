/*
Title: Simple Pagination With LIMIT and OFFSET
Difficulty: Beginner

Concepts:
- Pagination
- LIMIT
- OFFSET

Learning Objectives:
- Calculate OFFSET for page-based navigation.
- Return one page of sorted results.
- Understand when simple pagination is acceptable.

Problem Statement:
The admin product list shows three products per page. The team wants page 2,
sorted alphabetically by product name.

SQL Solution:
*/

SELECT
    id,
    name,
    price
FROM products
ORDER BY name ASC, id ASC
LIMIT 3
OFFSET 3;

/*
Explanation:
For page-based pagination, OFFSET is usually calculated as (page_number - 1) *
page_size. Page 2 with a page size of 3 uses OFFSET 3.

Expected Output:
The query returns the second page of products alphabetically: Kanban Sticky
Notes, Laptop Stand, and Mechanical Keyboard.

Business Scenario:
Admin interfaces often use simple pagination for small tables where predictable
navigation matters more than maximum performance.

Performance Notes:
Simple OFFSET pagination is easy to understand but can become slow for high page
numbers. Large production datasets often use keyset pagination instead.

Common Mistakes:
- Calculating OFFSET as page_number * page_size.
- Changing the ORDER BY between pages.
- Sorting by a non-unique column without a tie-breaker such as id.

Challenge Exercise:
Return page 3 of products with the same page size and ordering.

Challenge Solution:
*/

SELECT
    id,
    name,
    price
FROM products
ORDER BY name ASC, id ASC
LIMIT 3
OFFSET 6;

/*
Related Chapters:
- 11_limit_offset.sql
- 09_order_by_multiple_columns.sql
- ../01_basic_queries/06_limit.sql
*/
