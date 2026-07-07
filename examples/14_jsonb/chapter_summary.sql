/*
Title: JSONB Chapter Summary
Difficulty: Intermediate

Learning Objectives:
- Review JSONB creation, querying, containment, and aggregation.
- Keep relational and JSONB responsibilities clear.
- Build practical event payload reports.

Problem Statement:
Summarise JSONB usage by building and querying order event payloads.

Business Scenario:
Operations wants a flexible event log for order lifecycle events.

SQL Solution:
*/

CREATE TEMP TABLE cookbook_order_events (
    order_id BIGINT,
    payload JSONB NOT NULL
);

INSERT INTO cookbook_order_events (order_id, payload)
SELECT
    orders.id,
    jsonb_build_object(
        'event_type', 'order_snapshot',
        'order_status', orders.status,
        'customer_email', users.email,
        'shipping_city', orders.shipping_city
    )
FROM orders
INNER JOIN users
    ON users.id = orders.user_id;

SELECT
    order_id,
    payload ->> 'order_status' AS order_status,
    payload ->> 'customer_email' AS customer_email
FROM cookbook_order_events
WHERE payload @> '{"shipping_city": "Manchester"}'::JSONB
ORDER BY order_id ASC;

/*
Explanation:
The summary creates JSONB event payloads from relational rows, extracts fields,
and filters with containment.

Expected Output:
Manchester order events are returned with extracted order status and customer
email.

Performance Notes:
Use JSONB for flexible payloads, but keep frequently joined and constrained data
in relational columns.

Common Mistakes:
- Treating JSONB as a replacement for schema design.
- Forgetting to cast extracted values when needed.
- Indexing JSONB before measuring query needs.

Challenge Exercise:
Return all order event payloads where order_status is paid.

Challenge Solution:
*/

SELECT
    order_id,
    payload
FROM cookbook_order_events
WHERE payload @> '{"order_status": "paid"}'::JSONB
ORDER BY order_id ASC;

/*
Related Chapters:
- ../09_views/10_business_reporting_view.sql
- ../12_indexes/04_expression_index.sql
- ../13_performance/02_explain_analyze.sql
*/
