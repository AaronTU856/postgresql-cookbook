/*
Title: Triggers Chapter Summary
Difficulty: Intermediate

Learning Objectives:
- Review trigger functions and trigger registration.
- Combine validation and audit ideas.
- Inspect trigger metadata.

Problem Statement:
Summarise the chapter by creating a small audit trigger for payment status
changes.

Business Scenario:
Payment status changes are important for finance, support, and refunds.

SQL Solution:
*/

CREATE TABLE IF NOT EXISTS cookbook_payment_status_audit (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    payment_id BIGINT NOT NULL,
    old_status VARCHAR(30) NOT NULL,
    new_status VARCHAR(30) NOT NULL,
    changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

DROP TRIGGER IF EXISTS trg_payments_status_audit ON payments;
DROP FUNCTION IF EXISTS cookbook_audit_payment_status();

CREATE FUNCTION cookbook_audit_payment_status()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF OLD.status IS DISTINCT FROM NEW.status THEN
        INSERT INTO cookbook_payment_status_audit (
            payment_id,
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

CREATE TRIGGER trg_payments_status_audit
AFTER UPDATE OF status ON payments
FOR EACH ROW
EXECUTE FUNCTION cookbook_audit_payment_status();

BEGIN;

UPDATE payments
SET status = 'refunded'
WHERE id = 1
RETURNING id AS payment_id, status;

SELECT
    payment_id,
    old_status,
    new_status
FROM cookbook_payment_status_audit
ORDER BY id DESC
LIMIT 1;

ROLLBACK;

/*
Explanation:
The summary creates a trigger function, attaches it to payments, performs a safe
test update, inspects the audit row, and rolls back the data change.

Expected Output:
The update shows a temporary refunded payment, and the audit query shows the
completed-to-refunded transition.

Performance Notes:
Audit triggers are useful, but audit tables need retention and indexing plans in
production.

Common Mistakes:
- Forgetting to test rollback behaviour.
- Auditing every column change when only status matters.
- Creating triggers without documenting them.

Challenge Exercise:
Inspect all trigger names currently visible in the public schema.

Challenge Solution:
*/

SELECT
    trigger_name,
    event_object_table,
    action_timing
FROM information_schema.triggers
WHERE trigger_schema = 'public'
ORDER BY event_object_table ASC, trigger_name ASC;

/*
Related Chapters:
- ../08_transactions/02_rollback.sql
- ../10_functions/04_sql_vs_plpgsql.sql
- ../12_indexes/README.md
*/
