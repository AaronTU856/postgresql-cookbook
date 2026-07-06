/*
Title: Order Status Audit
Difficulty: Intermediate

Learning objectives:
- Audit status transitions.
- Use AFTER UPDATE triggers on business workflow tables.
- Keep status history separate from the current order row.

Problem statement:
Support needs to see when an order status changes.

Business scenario:
Order status changes drive fulfilment, support responses, and customer
communication.

SQL solution:
*/

CREATE TABLE IF NOT EXISTS cookbook_order_status_audit (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id BIGINT NOT NULL,
    old_status VARCHAR(30) NOT NULL,
    new_status VARCHAR(30) NOT NULL,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

DROP TRIGGER IF EXISTS trg_orders_status_audit ON orders;
DROP FUNCTION IF EXISTS cookbook_audit_order_status();

CREATE FUNCTION cookbook_audit_order_status()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF OLD.status IS DISTINCT FROM NEW.status THEN
        INSERT INTO cookbook_order_status_audit (
            order_id,
            old_status,
            new_status
        )
        VALUES (
            NEW.id,
            OLD.status,
            NEW.status
        );
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_orders_status_audit
AFTER UPDATE OF status ON orders
FOR EACH ROW
EXECUTE FUNCTION cookbook_audit_order_status();

BEGIN;

UPDATE orders
SET status = 'shipped'
WHERE id = 3
RETURNING id AS order_id, status;

SELECT
    order_id,
    old_status,
    new_status
FROM cookbook_order_status_audit
ORDER BY id DESC
LIMIT 1;

ROLLBACK;

/*
Explanation:
The trigger records old and new order status values after a status update. The
final rollback keeps the sample data unchanged.

Expected output:
The update shows order 3 as shipped inside the transaction, and the audit query
shows the paid-to-shipped transition.

Performance considerations:
Status audit tables can grow quickly. Plan retention, indexing, and archive
strategy for production systems.

Common mistakes:
- Storing only the new status and losing transition context.
- Auditing updates where status did not change.
- Forgetting to include the order id in the audit row.

Challenge:
Add an audit concept for payment status changes.

Challenge solution:
*/

SELECT
    'Create a payment_status_audit table and an AFTER UPDATE OF status trigger on payments.'
        AS suggested_solution;

/*
Related chapters:
- ../03_joins/09_join_and_filter.sql
- ../08_transactions/11_real_world_transaction.sql
- 01_audit_trigger.sql
*/
