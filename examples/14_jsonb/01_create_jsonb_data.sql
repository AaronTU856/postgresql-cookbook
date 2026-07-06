/*
Title: Create JSONB Data
Difficulty: Beginner

Learning objectives:
- Create a table with a JSONB column.
- Insert realistic event payloads.
- Read JSONB payloads from a table.

Problem statement:
The platform needs to store payment event payloads received from an external
payment provider.

Business scenario:
External provider payloads can vary over time, so storing the raw event payload
beside relational data is useful for audit and debugging.

SQL solution:
*/

CREATE TEMP TABLE cookbook_payment_events (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    payment_id BIGINT NOT NULL,
    payload JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
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
FROM payments
WHERE status = 'completed';

SELECT
    payment_id,
    payload
FROM cookbook_payment_events
ORDER BY payment_id ASC;

/*
Explanation:
The payload column stores structured JSONB data. jsonb_build_object creates JSONB
from existing relational payment rows.

Expected output:
Completed payments are returned with JSONB event payloads.

Performance considerations:
Keep relational columns for values that are filtered or joined frequently. Store
raw provider metadata in JSONB when flexibility matters.

Common mistakes:
- Storing all payment data only as JSONB.
- Forgetting to keep important identifiers as typed relational columns.
- Inserting inconsistent payload keys without a plan.

Challenge:
Create JSONB product metadata for active products.

Challenge solution:
*/

SELECT
    id AS product_id,
    jsonb_build_object(
        'name', name,
        'price', price,
        'active', is_active
    ) AS product_metadata
FROM products
WHERE is_active = TRUE
ORDER BY id ASC;

/*
Related chapters:
- ../01_basic_queries/02_select_columns.sql
- ../10_functions/08_reporting_function.sql
- 04_build_json_response.sql
*/
