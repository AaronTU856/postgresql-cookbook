/*
Title: BEGIN and COMMIT
Difficulty: Beginner

Learning Objectives:
- Start a transaction with BEGIN.
- Make work permanent with COMMIT.
- Use a temporary receipt table for safe practice.

Problem Statement:
Finance wants to record a short payment audit note as one committed unit of
work without changing the permanent sample data.

SQL Solution:
*/

BEGIN;

CREATE TEMP TABLE transaction_receipts (
    payment_id BIGINT,
    note TEXT
) ON COMMIT DROP;

INSERT INTO transaction_receipts (payment_id, note)
SELECT
    id,
    'Payment reviewed during transaction practice'
FROM payments
WHERE status = 'completed'
ORDER BY paid_at ASC
LIMIT 1;

SELECT
    payment_id,
    note
FROM transaction_receipts;

COMMIT;

/*
Explanation:
BEGIN opens the transaction. The temporary table and insert happen inside that
transaction. COMMIT completes the unit of work. Because the table is temporary
and uses ON COMMIT DROP, the example is safe to run repeatedly.

Expected Output:
The query returns one reviewed completed payment before the transaction commits.

Business Scenario:
Applications often write audit rows alongside business changes so support teams
can trace payment reviews.

Performance Notes:
Keep transactions short. Long transactions can hold locks and delay cleanup.

Common Mistakes:
- Starting a transaction and leaving it open.
- Forgetting that committed permanent changes remain after the session ends.
- Using transactions for read-only work that does not need transactional scope.

Challenge Exercise:
Create a temporary table inside a transaction for one pending payment review and
commit it safely.

Challenge Solution:
*/

BEGIN;

CREATE TEMP TABLE pending_payment_reviews (
    payment_id BIGINT,
    review_reason TEXT
) ON COMMIT DROP;

INSERT INTO pending_payment_reviews (payment_id, review_reason)
SELECT
    id,
    'Pending payment needs follow-up'
FROM payments
WHERE status = 'pending'
LIMIT 1;

SELECT
    payment_id,
    review_reason
FROM pending_payment_reviews;

COMMIT;

/*
Related Chapters:
- 02_rollback.sql
- 10_acid_properties.sql
- ../01_basic_queries/01_select_all.sql
*/
