/*
Title: ROLLBACK
Difficulty: Beginner

Learning objectives:
- Undo changes with ROLLBACK.
- Practise updates safely.
- Inspect data inside a transaction before discarding it.

Problem statement:
Operations wants to test cancelling a pending order without permanently changing
the sample database.

SQL solution:
*/

BEGIN;

UPDATE orders
SET status = 'cancelled'
WHERE status = 'pending'
RETURNING
    id AS order_id,
    status;

ROLLBACK;

/*
Explanation:
The UPDATE runs inside the transaction and RETURNING shows the changed row.
ROLLBACK discards the change, so the pending order remains pending after the
file finishes.

Expected results:
The transaction returns the pending order as cancelled, then discards the change.

Real-world example:
Developers often test cancellation logic inside a transaction before applying it
in application code.

Performance notes:
ROLLBACK is useful for practice, but long test transactions can still hold locks
while they are open.

Common mistakes:
- Assuming ROLLBACK can undo a change after COMMIT.
- Forgetting that other sessions may be blocked while the transaction is open.
- Testing with production data without a clear rollback strategy.

Challenge exercise:
Temporarily mark the refunded payment as pending, inspect it, then roll back.

Challenge solution:
*/

BEGIN;

UPDATE payments
SET status = 'pending'
WHERE status = 'refunded'
RETURNING
    id AS payment_id,
    status;

ROLLBACK;

/*
Related examples:
- 01_begin_commit.sql
- 11_real_world_transaction.sql
- ../02_filtering_sorting/04_comparison_operators.sql
*/
