/*
Title: SAVEPOINTS
Difficulty: Intermediate

Learning Objectives:
- Create savepoints inside a transaction.
- Roll back only part of a transaction.
- Continue safely after an optional step is discarded.

Problem Statement:
Support wants to test an order status change, then try an optional payment note
step that can be rolled back without discarding the whole transaction.

SQL Solution:
*/

BEGIN;

UPDATE orders
SET status = 'paid'
WHERE id = 4
RETURNING
    id AS order_id,
    status;

SAVEPOINT optional_payment_review;

CREATE TEMP TABLE payment_review_notes (
    payment_id BIGINT,
    note TEXT
) ON COMMIT DROP;

INSERT INTO payment_review_notes (payment_id, note)
VALUES (4, 'Optional review note created during practice');

ROLLBACK TO SAVEPOINT optional_payment_review;

SELECT
    id AS order_id,
    status
FROM orders
WHERE id = 4;

ROLLBACK;

/*
Explanation:
The savepoint marks a position inside the transaction. ROLLBACK TO SAVEPOINT
undoes only the temporary note step. The order status change remains visible
inside the transaction until the final ROLLBACK discards everything.

Expected Output:
The order appears as paid inside the transaction, but no permanent data changes
remain after the final rollback.

Business Scenario:
Checkout flows may reserve stock first, then roll back only optional loyalty or
audit steps if they fail.

Performance Notes:
Savepoints add overhead. Use them for meaningful partial recovery rather than
wrapping every statement.

Common Mistakes:
- Treating a savepoint as a commit.
- Forgetting the outer transaction is still open.
- Creating too many savepoints in high-volume workflows.

Challenge Exercise:
Create a savepoint after changing a payment status, insert a temporary note,
roll back to the savepoint, and then roll back the full transaction.

Challenge Solution:
*/

BEGIN;

UPDATE payments
SET status = 'completed'
WHERE id = 4
RETURNING
    id AS payment_id,
    status;

SAVEPOINT after_payment_status_change;

CREATE TEMP TABLE payment_notes (
    payment_id BIGINT,
    note TEXT
) ON COMMIT DROP;

INSERT INTO payment_notes (payment_id, note)
VALUES (4, 'Temporary payment note');

ROLLBACK TO SAVEPOINT after_payment_status_change;

SELECT
    id AS payment_id,
    status
FROM payments
WHERE id = 4;

ROLLBACK;

/*
Related Chapters:
- 02_rollback.sql
- 11_real_world_transaction.sql
- 12_common_transaction_mistakes.sql
*/
