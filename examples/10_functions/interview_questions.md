# Chapter 10 Interview Questions: Functions

## 1. What is a PostgreSQL function?

**Model answer:** A PostgreSQL function is reusable database logic defined with
`CREATE FUNCTION`. It can return a scalar value, a row, a table, or no value.

**Practical tip:** Mention that functions can be written in SQL or PL/pgSQL.

**Common follow-up:** When would you use a function instead of application code?

## 2. What is the difference between a SQL function and a PL/pgSQL function?

**Model answer:** SQL functions are best for simple expressions or single-query
logic. PL/pgSQL functions support procedural logic such as variables, branching,
loops, and exceptions.

**Practical tip:** Prefer the simpler SQL function when procedural logic is not
needed.

**Common follow-up:** Why might PL/pgSQL be a poor choice for a simple SELECT?

## 3. What does `RETURNS TABLE` do?

**Model answer:** `RETURNS TABLE` defines a function that returns a result set
with named columns, similar to querying a table or view.

**Practical tip:** Use clear output column names because callers depend on them.

**Common follow-up:** How is a table-returning function different from a view?

## 4. What does function volatility mean?

**Model answer:** Volatility tells PostgreSQL how stable a function result is.
`IMMUTABLE` depends only on inputs, `STABLE` can read database state within a
statement, and `VOLATILE` can change every call or have side effects.

**Practical tip:** Never mark a function that reads tables as `IMMUTABLE`.

**Common follow-up:** Why does volatility matter for the query planner?

## 5. When should a function be marked `IMMUTABLE`?

**Model answer:** Use `IMMUTABLE` only when the same inputs always produce the
same output and the function does not read or modify database state.

**Practical tip:** Price arithmetic with only input parameters can be immutable.

**Common follow-up:** Is a function that reads `products` immutable?

## 6. When should a function be marked `STABLE`?

**Model answer:** Use `STABLE` for functions that read database tables but do not
modify data and return consistent results within a statement.

**Practical tip:** Reporting helpers that read orders or payments are usually
`STABLE`.

**Common follow-up:** How is `STABLE` different from `VOLATILE`?

## 7. What makes a function `VOLATILE`?

**Model answer:** A function is `VOLATILE` if it can return different results
for the same inputs in one statement or if it has side effects.

**Practical tip:** Functions using `CLOCK_TIMESTAMP()` are volatile.

**Common follow-up:** Are functions that update tables volatile?

## 8. What are common performance risks with functions?

**Model answer:** Functions can hide expensive queries, run once per row, block
planner optimisations, or make execution plans harder to understand.

**Practical tip:** For large reports, compare a function-based query with a join
and aggregate query.

**Common follow-up:** How would you investigate a slow function call?

## 9. How do functions support data consistency?

**Model answer:** Functions can centralise calculations and validation rules so
multiple reports or applications use the same logic.

**Practical tip:** Use functions for stable business definitions such as order
totals, but keep workflows visible and testable.

**Common follow-up:** What business logic should stay outside the database?

## 10. How should functions handle missing data?

**Model answer:** Functions should return a deliberate fallback, return `NULL`
when that is meaningful, or raise a clear exception when missing data is invalid.

**Practical tip:** Use `COALESCE` for report totals that should return zero.

**Common follow-up:** When is raising an exception better than returning `NULL`?

## 11. What is the risk of hiding business logic in functions?

**Model answer:** Hidden logic can make behaviour harder to review, test, debug,
and optimise. Developers may not realise a simple SELECT calls expensive logic.

**Practical tip:** Keep functions small and name them for the business rule they
implement.

**Common follow-up:** How would you document important database functions?

## 12. Can PostgreSQL functions modify data?

**Model answer:** Yes, PL/pgSQL functions can modify data, but write functions
should be designed carefully because side effects can surprise callers.

**Practical tip:** Avoid side effects in functions used by reports.

**Common follow-up:** What volatility should a data-modifying function have?

## 13. How do functions compare with views?

**Model answer:** Views expose saved queries that are queried like tables.
Functions can accept parameters and return scalar or table-shaped results.

**Practical tip:** Use views for shared read models and functions when parameters
or procedural logic are needed.

**Common follow-up:** When might a materialized view be better than a function?

## 14. What makes a good junior-level function implementation?

**Model answer:** A good implementation is small, clearly named, correctly typed,
accurately marked for volatility, tested against real data, and easy to explain.

**Practical tip:** In interviews, explain both the function and why it belongs in
the database.

**Common follow-up:** How would you test this function?

## 15. What should you mention in a code review of a new function?

**Model answer:** Check naming, parameters, return type, volatility, permissions,
error handling, performance, tests, and whether the logic should be a function at
all.

**Practical tip:** Good review comments focus on correctness and maintainability,
not just syntax.

**Common follow-up:** What would make you reject a database function in review?
