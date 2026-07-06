/*
Title: Refresh Materialized View
Difficulty: Intermediate

Learning objectives:
- Refresh a materialized view.
- Understand snapshot freshness.
- Build a unique index for concurrent refresh readiness.

Problem statement:
Finance wants a payment summary snapshot that can be refreshed after new payment
data is loaded.

SQL solution:
*/

DROP MATERIALIZED VIEW IF EXISTS payment_status_snapshot;

CREATE MATERIALIZED VIEW payment_status_snapshot AS
SELECT
    status AS payment_status,
    COUNT(*) AS payment_count,
    SUM(amount) AS total_amount
FROM payments
GROUP BY status;

CREATE UNIQUE INDEX idx_payment_status_snapshot_status
    ON payment_status_snapshot (payment_status);

REFRESH MATERIALIZED VIEW payment_status_snapshot;

SELECT
    payment_status,
    payment_count,
    total_amount
FROM payment_status_snapshot
ORDER BY payment_status ASC;

/*
Explanation:
REFRESH MATERIALIZED VIEW reruns the stored query and replaces the snapshot
contents. The unique index prepares the snapshot for future concurrent refresh
patterns when appropriate.

Expected results:
The refreshed materialized view returns one row per payment status.

Real-world example:
Nightly reporting jobs often refresh materialized views after importing new
orders or payments.

Performance notes:
Refreshing can be expensive and may block readers depending on the refresh
method. Schedule refreshes deliberately.

Common mistakes:
- Forgetting to refresh after source data changes.
- Refreshing too frequently for a costly report.
- Assuming a unique index is optional for concurrent refresh workflows.

Challenge exercise:
Create and refresh a materialized view for active product stock by category.

Challenge solution:
*/

DROP MATERIALIZED VIEW IF EXISTS category_stock_snapshot;

CREATE MATERIALIZED VIEW category_stock_snapshot AS
SELECT
    categories.name AS category_name,
    SUM(products.stock_quantity) AS total_stock
FROM categories
INNER JOIN products
    ON products.category_id = categories.id
WHERE products.is_active = TRUE
GROUP BY categories.name;

REFRESH MATERIALIZED VIEW category_stock_snapshot;

SELECT
    category_name,
    total_stock
FROM category_stock_snapshot
ORDER BY category_name ASC;

/*
Related examples:
- 07_materialized_views.sql
- 10_business_reporting_view.sql
- ../04_aggregates/10_business_reports.sql
*/
