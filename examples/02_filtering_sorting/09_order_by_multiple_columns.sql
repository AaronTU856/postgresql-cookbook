/*
Title: Sort by Multiple Columns
Difficulty: Beginner

Concepts:
- ORDER BY
- Multiple sort keys
- ASC and DESC

Learning objectives:
- Sort rows by more than one column.
- Use different sort directions in one query.
- Produce stable, readable product lists.

Problem statement:
The merchandising team wants products grouped by category, with the highest
priced products shown first inside each category.

SQL solution:
*/

SELECT
    category_id,
    name,
    price,
    stock_quantity
FROM products
ORDER BY category_id ASC, price DESC;

/*
Explanation:
PostgreSQL sorts by category_id first. When rows have the same category_id, it
then sorts those rows by price from highest to lowest.

Expected results:
The query returns products grouped by category_id. Within each category, the
more expensive product appears first.

Real-world example:
Product management screens often group products by category and then sort each
group by price, stock, or popularity.

Performance notes:
Multi-column sorting can use a matching multi-column index, but only when the
query pattern justifies it. Avoid creating indexes for every possible sort.

Common mistakes:
- Assuming the second sort column applies globally instead of within the first
  sort column.
- Forgetting to specify DESC for columns that need descending order.
- Sorting by a column that is not meaningful to users.

Challenge exercise:
Sort orders by status alphabetically, then newest order first inside each
status.

Challenge solution:
*/

SELECT
    id,
    status,
    order_date,
    shipping_city
FROM orders
ORDER BY status ASC, order_date DESC;

/*
Related examples:
- ../01_basic_queries/05_order_by.sql
- 10_nulls_first_last.sql
- 11_limit_offset.sql
*/
