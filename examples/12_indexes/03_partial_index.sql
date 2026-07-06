/*
Title: Partial Index
Difficulty: Intermediate

Learning objectives:
- Create an index for a subset of rows.
- Match a partial index predicate to a query.
- Reduce index size for focused access patterns.

Problem statement:
Finance frequently reviews completed payments, not every payment.

Business scenario:
Payment reporting often cares most about completed payments while pending or
refunded rows are less common in daily dashboards.

SQL solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_completed_payments_paid_at
    ON payments (paid_at DESC)
    WHERE status = 'completed';

EXPLAIN
SELECT
    id AS payment_id,
    amount,
    paid_at
FROM payments
WHERE status = 'completed'
ORDER BY paid_at DESC;

/*
Explanation:
The partial index only contains completed payments. Queries must include the
matching predicate to benefit from it.

Expected output:
EXPLAIN returns a plan for completed payments ordered by paid_at.

Performance considerations:
Partial indexes are smaller and cheaper than full indexes when the predicate
matches a frequent, selective query.

Common mistakes:
- Forgetting the WHERE predicate in the query.
- Creating partial indexes for rarely used filters.
- Expecting a partial index to support different status values.

Challenge:
Create a partial index for active products by category.

Challenge solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_active_products_category
    ON products (category_id)
    WHERE is_active = TRUE;

EXPLAIN
SELECT
    id AS product_id,
    name,
    category_id
FROM products
WHERE is_active = TRUE
  AND category_id = 1;

/*
Related chapters:
- ../02_filtering_sorting/03_where_not.sql
- ../09_views/01_create_view.sql
- 02_composite_index.sql
*/
