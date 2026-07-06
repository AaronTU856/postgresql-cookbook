# Chapter 8: Transactions & ACID

## What Is a Transaction?

A transaction is a group of database statements treated as one unit of work.
PostgreSQL either makes the full unit visible with `COMMIT` or discards it with
`ROLLBACK`.

Transactions matter whenever one business action touches more than one row or
table. Placing an order, processing a payment, reducing stock, cancelling an
order, and issuing a refund all need consistent data.

## Why Transactions Matter

Without transactions, a failed payment could leave an order marked as paid, or a
stock update could succeed while the matching order item fails. Transactions
protect the database from half-finished business workflows.

## ACID Explained

- **Atomicity** means all statements succeed together or fail together.
- **Consistency** means constraints and business rules remain valid.
- **Isolation** means concurrent transactions do not see unsafe intermediate
  work.
- **Durability** means committed data survives database crashes.

## BEGIN / COMMIT / ROLLBACK

Use `BEGIN` to start a transaction, `COMMIT` to save it, and `ROLLBACK` to undo
it.

```sql
BEGIN;

UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE id = 1;

COMMIT;
```

## SAVEPOINT

`SAVEPOINT` lets you roll back part of a transaction while keeping earlier work.
It is useful when one optional step fails but the main transaction can continue.

## Isolation Levels

Isolation levels control how much one transaction can see from another
concurrent transaction.

- `READ COMMITTED` is PostgreSQL's default.
- `REPEATABLE READ` keeps reads stable inside a transaction.
- `SERIALIZABLE` provides the strongest protection and may require retries.

## Locks

PostgreSQL uses locks to protect data while transactions are running. Row locks
such as `FOR UPDATE` are common in stock, payment, and order workflows.

## Deadlocks

A deadlock happens when two transactions wait on each other in a cycle.
PostgreSQL detects deadlocks and cancels one transaction so the other can
continue.

## Banking And E-Commerce Examples

Banking systems use transactions to move money between accounts. E-commerce
systems use the same ideas to place orders, reserve inventory, process payments,
cancel orders, and refund payments.

## Best Practices

- Keep transactions short.
- Lock rows in a consistent order.
- Validate business rules before writing when possible.
- Use `ROLLBACK` while practising.
- Retry transactions that fail under `SERIALIZABLE`.
- Avoid waiting for user input inside an open transaction.

## Common Mistakes

- Forgetting to commit or roll back.
- Doing too much work inside one transaction.
- Assuming `READ COMMITTED` gives repeatable reads.
- Updating stock without locking or checking availability.
- Ignoring deadlock and serialization retry handling.

## Learning Outcomes

After completing this chapter, you should be able to:

- Use `BEGIN`, `COMMIT`, and `ROLLBACK` safely.
- Explain the four ACID properties.
- Use savepoints for partial rollback.
- Choose between PostgreSQL isolation levels.
- Recognise common locking and deadlock patterns.
- Build simple order and payment transactions.

## Recommended Learning Order

1. [BEGIN and COMMIT](01_begin_commit.sql)
2. [ROLLBACK](02_rollback.sql)
3. [SAVEPOINTS](03_savepoints.sql)
4. [Transaction isolation](04_transaction_isolation.sql)
5. [READ COMMITTED](05_read_committed.sql)
6. [REPEATABLE READ](06_repeatable_read.sql)
7. [SERIALIZABLE](07_serializable.sql)
8. [Deadlock example](08_deadlock_example.sql)
9. [Locking](09_locking.sql)
10. [ACID properties](10_acid_properties.sql)
11. [Real-world transaction](11_real_world_transaction.sql)
12. [Common transaction mistakes](12_common_transaction_mistakes.sql)
13. [Chapter summary](13_chapter_summary.sql)

## Related Chapters

- [Chapter 3: Joins](../03_joins/README.md)
- [Chapter 4: Aggregation](../04_aggregates/README.md)
- [Chapter 6: Common Table Expressions](../06_ctes/README.md)

## Difficulty

Intermediate

## Estimated Completion Time

3-4 Hours
