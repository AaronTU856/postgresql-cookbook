/*
Title: JSONB Containment
Difficulty: Intermediate

Learning objectives:
- Use @> for JSONB containment.
- Filter rows by payload shape.
- Match exact JSON key-value pairs.

Problem statement:
Finance wants to find events where the payload says a payment was completed.

Business scenario:
Containment queries are useful for event logs where payloads contain flexible
provider metadata.

SQL solution:
*/

CREATE TEMP TABLE cookbook_payment_events (
    payment_id BIGINT,
    payload JSONB NOT NULL
);

INSERT INTO cookbook_payment_events (payment_id, payload)
SELECT
    id,
    jsonb_build_object(
        'event_type', 'payment_status_snapshot',
        'payment_status', status,
        'payment_method', payment_method,
        'amount', amount
    )
FROM payments;

SELECT
    payment_id,
    payload
FROM cookbook_payment_events
WHERE payload @> '{"payment_status": "completed"}'::JSONB
ORDER BY payment_id ASC;

/*
Explanation:
The @> operator checks whether the left JSONB value contains the right JSONB
structure.

Expected output:
Rows with payment_status completed in the payload are returned.

Performance considerations:
Containment queries can benefit from GIN indexes on JSONB columns for larger
event tables.

Common mistakes:
- Using invalid JSON syntax in containment values.
- Expecting containment to behave like a text search.
- Forgetting JSONB string values need double quotes.

Challenge:
Find payloads for PayPal payments using containment.

Challenge solution:
*/

SELECT
    payment_id,
    payload
FROM cookbook_payment_events
WHERE payload @> '{"payment_method": "paypal"}'::JSONB;

/*
Related chapters:
- ../12_indexes/03_partial_index.sql
- 05_jsonb_indexing.sql
- 02_query_jsonb_fields.sql
*/
