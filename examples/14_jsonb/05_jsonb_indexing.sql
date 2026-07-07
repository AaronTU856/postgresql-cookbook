/*
Title: JSONB Indexing
Difficulty: Advanced

Learning Objectives:
- Create a GIN index on JSONB.
- Explain JSONB containment performance.
- Use EXPLAIN with a JSONB query.

Problem Statement:
The event log will grow, and support needs faster lookup by payload attributes.

Business Scenario:
Payment event logs can become large because every provider callback is stored.

SQL Solution:
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

CREATE INDEX idx_cookbook_payment_events_payload
    ON cookbook_payment_events
    USING GIN (payload);

EXPLAIN
SELECT
    payment_id,
    payload
FROM cookbook_payment_events
WHERE payload @> '{"payment_status": "completed"}'::JSONB;

/*
Explanation:
GIN indexes can support containment queries on JSONB payloads. The seed data is
tiny, so PostgreSQL may still choose a sequential scan.

Expected Output:
EXPLAIN returns a plan for the JSONB containment query.

Performance Notes:
GIN indexes can be large. Add them for important JSONB access patterns, not for
every JSONB column by default.

Common Mistakes:
- Expecting a GIN index to help every JSONB operation.
- Ignoring index size and write overhead.
- Using JSONB when typed columns would be faster and safer.

Challenge Exercise:
Run EXPLAIN for a payment_method containment query.

Challenge Solution:
*/

EXPLAIN
SELECT
    payment_id,
    payload
FROM cookbook_payment_events
WHERE payload @> '{"payment_method": "card"}'::JSONB;

/*
Related Chapters:
- ../12_indexes/01_basic_index.sql
- ../13_performance/01_explain_basics.sql
- 03_jsonb_containment.sql
*/
