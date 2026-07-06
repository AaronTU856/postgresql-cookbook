/*
Title: Transaction Isolation
Difficulty: Intermediate

Learning objectives:
- Check the current isolation level.
- Set an isolation level for one transaction.
- Understand why isolation affects concurrent reads and writes.

Problem statement:
The engineering team wants to confirm which isolation level a checkout report
uses before reading payment totals.

SQL solution:
*/

BEGIN ISOLATION LEVEL REPEATABLE READ;

SELECT
    CURRENT_SETTING('transaction_isolation') AS isolation_level;

SELECT
    COUNT(*) AS completed_payment_count,
    SUM(amount) AS completed_payment_total
FROM payments
WHERE status = 'completed';

COMMIT;

/*
Explanation:
BEGIN ISOLATION LEVEL starts the transaction with a specific isolation level.
REPEATABLE READ gives the transaction a stable view of rows it reads.

Expected results:
The first query returns repeatable read. The second query returns the completed
payment count and total from the seed data.

Real-world example:
Financial reports may need a stable view while several related totals are read.

Performance notes:
Stronger isolation can increase retry pressure in busy systems. Choose the
lowest level that protects the business rule.

Common mistakes:
- Setting the isolation level after running a query in the transaction.
- Assuming every database uses the same default isolation behaviour.
- Using stronger isolation without retry handling.

Challenge exercise:
Start a READ COMMITTED transaction and check the current isolation level.

Challenge solution:
*/

BEGIN ISOLATION LEVEL READ COMMITTED;

SELECT
    CURRENT_SETTING('transaction_isolation') AS isolation_level;

COMMIT;

/*
Related examples:
- 05_read_committed.sql
- 06_repeatable_read.sql
- 07_serializable.sql
*/
