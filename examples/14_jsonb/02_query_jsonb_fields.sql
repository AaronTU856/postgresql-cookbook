/*
Title: Query JSONB Fields
Difficulty: Beginner

Learning objectives:
- Extract JSONB values with -> and ->>.
- Filter by JSONB text values.
- Understand text extraction.

Problem statement:
Support needs to find payment events by payment method inside the JSON payload.

Business scenario:
Event payloads often include provider-specific details that support teams need
to inspect during payment investigations.

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
    payload ->> 'payment_method' AS payment_method,
    payload ->> 'payment_status' AS payment_status,
    (payload ->> 'amount')::NUMERIC AS amount
FROM cookbook_payment_events
WHERE payload ->> 'payment_method' = 'card'
ORDER BY payment_id ASC;

/*
Explanation:
The ->> operator extracts a JSON value as text. Numeric values can be cast when
calculation is needed.

Expected output:
Card payment events are returned with method, status, and amount values extracted
from JSONB.

Performance considerations:
Casting JSONB text repeatedly can be expensive. Store frequently calculated
values in typed columns when possible.

Common mistakes:
- Using -> when text is needed.
- Comparing numeric JSON values as text.
- Filtering heavily used fields only inside JSONB.

Challenge:
Extract event_type and amount from all completed payment events.

Challenge solution:
*/

SELECT
    payment_id,
    payload ->> 'event_type' AS event_type,
    (payload ->> 'amount')::NUMERIC AS amount
FROM cookbook_payment_events
WHERE payload ->> 'payment_status' = 'completed'
ORDER BY amount DESC;

/*
Related chapters:
- ../02_filtering_sorting/04_comparison_operators.sql
- 01_create_jsonb_data.sql
- 03_jsonb_containment.sql
*/
