# Chapter 11 Interview Questions: Triggers

## 1. What is a PostgreSQL trigger?

**Model answer:** A trigger automatically runs a trigger function when a table
event such as `INSERT`, `UPDATE`, or `DELETE` occurs.

**Practical tip:** Mention that the trigger and trigger function are separate.

**Common follow-up:** What is the difference between `BEFORE` and `AFTER`?

## 2. When would you use a trigger?

**Model answer:** Use triggers for database-owned rules such as audit logs,
updated timestamps, validation, and defensive consistency checks.

**Practical tip:** Say what you would not put in a trigger.

**Common follow-up:** Why can triggers be risky?

## 3. What are `NEW` and `OLD`?

**Model answer:** `NEW` is the incoming row for insert or update operations.
`OLD` is the previous row for update or delete operations.

**Practical tip:** `INSERT` has no `OLD`; `DELETE` has no `NEW`.

**Common follow-up:** Which row should a `BEFORE UPDATE` trigger return?

## 4. What is a row-level trigger?

**Model answer:** A row-level trigger runs once for every affected row.

**Practical tip:** Bulk updates can fire row-level triggers many times.

**Common follow-up:** How can that affect performance?

## 5. What is a statement-level trigger?

**Model answer:** A statement-level trigger runs once for the SQL statement,
regardless of how many rows are affected.

**Practical tip:** Use it when row-specific OLD and NEW values are not needed.

**Common follow-up:** Can statement-level triggers see each changed row?

## 6. Why are audit triggers common?

**Model answer:** They reliably capture changes no matter which application made
the write.

**Practical tip:** Include old value, new value, row id, and timestamp.

**Common follow-up:** What indexes might an audit table need?

## 7. What makes trigger debugging difficult?

**Model answer:** Trigger behaviour is implicit. Developers may run a simple
update without realising extra logic also runs.

**Practical tip:** Inspect `information_schema.triggers` during debugging.

**Common follow-up:** How would you document triggers?

## 8. What is recursive trigger behaviour?

**Model answer:** It happens when a trigger writes to a table in a way that fires
the same or related trigger again.

**Practical tip:** Keep trigger writes targeted and test carefully.

**Common follow-up:** How would you prevent accidental recursion?

## 9. Should triggers call external services?

**Model answer:** Usually no. Database triggers should stay inside the database
and avoid slow or unreliable external dependencies.

**Practical tip:** Use application events or queues for external work.

**Common follow-up:** What happens if the external call fails?

## 10. What should you review before approving a trigger?

**Model answer:** Timing, event, row vs statement level, performance, recursion
risk, error behaviour, audit needs, and tests.

**Practical tip:** Ask whether a constraint would be simpler.

**Common follow-up:** When is a CHECK constraint better than a trigger?
