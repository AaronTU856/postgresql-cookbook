/*
Title: Indexes For Django Filters
Difficulty: Intermediate

Learning objectives:
- Match Django filters to PostgreSQL indexes.
- Create indexes for common QuerySet patterns.
- Use EXPLAIN for ORM-generated SQL.

Problem statement:
The API frequently filters orders by status and customer, then orders by date.

Business scenario:
Django model Meta.indexes should be based on real QuerySet filters and ordering.

SQL solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_django_orders_user_status_date
    ON orders (user_id, status, order_date DESC);

EXPLAIN
SELECT
    id AS order_id,
    user_id,
    status,
    order_date
FROM orders
WHERE user_id = 1
  AND status = 'paid'
ORDER BY order_date DESC;

/*
Explanation:
This index supports a common Django QuerySet shape:
Order.objects.filter(user_id=1, status="paid").order_by("-order_date").

Expected output:
EXPLAIN returns a plan for the filtered and ordered order lookup.

Performance considerations:
Do not add indexes for every possible QuerySet. Add them for frequent, important
access patterns.

Common mistakes:
- Creating indexes that do not match actual ORM filters.
- Forgetting ordering columns.
- Adding duplicate indexes through migrations.

Challenge:
Create an index for active products by category and name.

Challenge solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_django_products_category_active_name
    ON products (category_id, is_active, name);

EXPLAIN
SELECT
    id AS product_id,
    category_id,
    name
FROM products
WHERE category_id = 1
  AND is_active = TRUE
ORDER BY name ASC;

/*
Related chapters:
- ../12_indexes/02_composite_index.sql
- ../13_performance/01_explain_basics.sql
- 01_django_model_query_shape.sql
*/
