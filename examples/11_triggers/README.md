# Chapter 11: Triggers

## Overview

Triggers run database logic automatically when rows are inserted, updated, or
deleted. They are useful for audit trails, validation, derived values, and
protecting data rules that must hold even when multiple applications write to
the same database.

## Key Concepts

- A trigger calls a trigger function.
- `BEFORE` triggers can validate or modify rows before they are saved.
- `AFTER` triggers are useful for audit records and side effects.
- `NEW` represents the incoming row.
- `OLD` represents the previous row.
- Row-level triggers run once per affected row.
- Statement-level triggers run once per SQL statement.

## Learning Outcomes

After this chapter, you should be able to:

- Create trigger functions with PL/pgSQL.
- Use `BEFORE` and `AFTER` triggers appropriately.
- Audit important business changes.
- Validate data before it is written.
- Avoid common trigger design mistakes.
- Explain trigger tradeoffs in interviews and code reviews.

## When To Use The Feature

Use triggers when the rule must live close to the data: audit logs, updated
timestamps, invariant checks, and defensive validation shared by multiple apps.

## When NOT To Use The Feature

Avoid triggers for complex application workflows, calls to external services,
or hidden business logic that would surprise maintainers.

## Syntax Overview

```sql
CREATE FUNCTION trigger_function()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_name
BEFORE UPDATE ON table_name
FOR EACH ROW
EXECUTE FUNCTION trigger_function();
```

## Best Practices

- Keep trigger functions small.
- Name triggers for timing, table, and purpose.
- Prefer `BEFORE` triggers for validation.
- Prefer `AFTER` triggers for audit logs.
- Document non-obvious trigger behaviour.
- Test triggers with multi-row statements.

## Performance Considerations

Triggers add work to writes. Expensive trigger functions can slow inserts,
updates, and deletes, especially when a statement affects many rows.

## Common Mistakes

- Hiding major business workflows in triggers.
- Forgetting triggers run for every affected row.
- Creating recursive trigger behaviour accidentally.
- Returning the wrong row from a `BEFORE` trigger.
- Failing to test rollback behaviour.

## Business Examples

- Audit product stock changes.
- Track order status changes.
- Validate inventory edits.
- Maintain updated timestamps.
- Prevent unsafe business state transitions.

## Interview Tips

Interviewers often ask whether triggers are good or bad. Strong answers avoid
absolutes: triggers are useful for database-owned rules, but risky when they hide
application workflows.

## Recommended Learning Order

1. [Audit trigger](01_audit_trigger.sql)
2. [BEFORE trigger](02_before_trigger.sql)
3. [Validation trigger](03_validation_trigger.sql)
4. [Order status audit](04_order_status_audit.sql)
5. [Common trigger mistakes](05_common_trigger_mistakes.sql)
6. [Chapter summary](chapter_summary.sql)
7. [Interview questions](interview_questions.md)

## Related Chapters

- [Chapter 8: Transactions & ACID](../08_transactions/README.md)
- [Chapter 10: Functions](../10_functions/README.md)
- [Chapter 12: Indexes](../12_indexes/README.md)

## Difficulty

Intermediate

## Estimated Completion Time

2-3 Hours

## Useful PostgreSQL Documentation References

- [CREATE TRIGGER](https://www.postgresql.org/docs/current/sql-createtrigger.html)
- [Trigger Functions](https://www.postgresql.org/docs/current/plpgsql-trigger.html)
- [PL/pgSQL](https://www.postgresql.org/docs/current/plpgsql.html)
