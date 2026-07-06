/*
Title: Covering Index
Difficulty: Advanced

Learning objectives:
- Create an index with included columns.
- Understand read-heavy lookup support.
- Avoid overusing covering indexes.

Problem statement:
Support frequently lists recent orders for a customer and needs status and
shipping city.

Business scenario:
Customer profile pages often load recent orders repeatedly.

SQL solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_orders_user_date_include_status
    ON orders (user_id, order_date DESC)
    INCLUDE (status, shipping_city);

EXPLAIN
SELECT
    user_id,
    order_date,
    status,
    shipping_city
FROM orders
WHERE user_id = 1
ORDER BY order_date DESC;

/*
Explanation:
The index keys support filtering by user and ordering by date. Included columns
can help satisfy selected output without making them part of the search key.

Expected output:
EXPLAIN returns a plan for recent orders for user 1.

Performance considerations:
Included columns make indexes larger. Use them only for important read-heavy
queries.

Common mistakes:
- Including too many columns.
- Treating INCLUDE columns as useful for filtering order.
- Adding covering indexes before checking whether the query is important.

Challenge:
Create a covering index for completed payment reports by paid_at including
amount and payment_method.

Challenge solution:
*/

CREATE INDEX IF NOT EXISTS idx_cookbook_payments_completed_paid_at_include_amount
    ON payments (paid_at DESC)
    INCLUDE (amount, payment_method)
    WHERE status = 'completed';

EXPLAIN
SELECT
    paid_at,
    amount,
    payment_method
FROM payments
WHERE status = 'completed'
ORDER BY paid_at DESC;

/*
Related chapters:
- ../07_window_functions/09_running_totals.sql
- ../09_views/10_business_reporting_view.sql
- 03_partial_index.sql
*/
