/*
Title: Common Transaction Mistakes
Difficulty: Intermediate

Learning objectives:
- Avoid long-running transactions.
- Use explicit transaction endings.
- Write safer update conditions.

Problem statement:
The team wants a safe pattern for cancelling an order and refunding its payment
without accidentally changing unrelated rows.

SQL solution:
*/

BEGIN;

UPDATE orders
SET status = 'cancelled'
WHERE id = 3
  AND status IN ('pending', 'paid')
RETURNING
    id AS order_id,
    status;

UPDATE payments
SET status = 'refunded'
WHERE order_id = 3
  AND status = 'completed'
RETURNING
    id AS payment_id,
    order_id,
    status;

ROLLBACK;

/*
Explanation:
Both UPDATE statements include precise filters. The transaction groups the order
cancellation and refund status change, while ROLLBACK keeps the sample data
unchanged.

Expected results:
The order and its payment appear cancelled and refunded inside the transaction,
then the changes are discarded.

Real-world example:
Refund workflows must update order and payment state together or not at all.

Performance notes:
Precise WHERE clauses reduce unnecessary row locks. Indexes on foreign keys and
status columns help frequent transactional updates.

Common mistakes:
- Updating by status only instead of primary key or order id.
- Forgetting the final COMMIT or ROLLBACK.
- Mixing user think time with open transactions.
- Retrying only the failed statement instead of the whole transaction.

Challenge exercise:
Safely cancel order 4 and leave the changes rolled back.

Challenge solution:
*/

BEGIN;

UPDATE orders
SET status = 'cancelled'
WHERE id = 4
  AND status = 'pending'
RETURNING
    id AS order_id,
    status;

ROLLBACK;

/*
Related examples:
- 02_rollback.sql
- 08_deadlock_example.sql
- 11_real_world_transaction.sql
*/
