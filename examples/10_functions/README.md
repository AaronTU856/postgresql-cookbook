# Chapter 10: Functions

## Overview

PostgreSQL functions let you package reusable database logic behind a clear
name. They are useful for calculations, read models, reporting helpers, business
rules, and carefully controlled database-side workflows.

This chapter focuses on practical functions for the cookbook online store:
pricing calculations, order totals, customer reports, stock checks, and safer
function design.

## Key Concepts

- `CREATE FUNCTION` defines reusable database logic.
- SQL functions are best for simple query expressions.
- PL/pgSQL functions are useful for branching, validation, and error handling.
- Function parameters make logic reusable across rows and reports.
- `RETURNS TABLE` can expose report-shaped results.
- Volatility categories help PostgreSQL understand whether results can change.
- Functions can hide complexity, but they should not hide unclear business rules.

## Learning Outcomes

After completing this chapter, you should be able to:

- Create simple SQL functions.
- Pass parameters into reusable business calculations.
- Return scalar values and table-shaped results.
- Choose between SQL and PL/pgSQL functions.
- Use volatility markers such as `IMMUTABLE`, `STABLE`, and `VOLATILE`.
- Add safe validation and error handling.
- Recognise common function design mistakes in interviews and code reviews.

## When To Use Functions

Use functions when logic is reused, belongs close to the data, and benefits from
being tested in one place. Good examples include order totals, stock labels,
payment summaries, validation checks, and reporting helpers.

Functions are also useful when multiple applications need the same database rule.

## When NOT To Use Functions

Avoid functions when the logic belongs in application orchestration, requires
external services, or would hide important query behaviour from developers.

Do not use functions as a dumping ground for unclear business logic. A readable
query is often better than an opaque function.

## Syntax Overview

```sql
CREATE FUNCTION function_name(parameter_name DATA_TYPE)
RETURNS DATA_TYPE
LANGUAGE SQL
STABLE
AS $$
    SELECT ...
$$;
```

PL/pgSQL functions use a block structure:

```sql
CREATE FUNCTION function_name()
RETURNS DATA_TYPE
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN ...;
END;
$$;
```

## Best Practices

- Use descriptive names that include the business purpose.
- Prefer SQL functions for simple single-query logic.
- Use PL/pgSQL only when procedural control flow is useful.
- Mark volatility accurately.
- Keep functions small and testable.
- Avoid side effects in functions used by reports.
- Use explicit parameter names to avoid ambiguity.
- Return predictable data types.

## Performance Considerations

Functions can improve consistency, but they do not automatically make queries
faster. Poorly designed functions can hide expensive queries, prevent useful
planner optimisations, or run once per row in costly ways.

Check execution plans for functions used in high-volume reports or application
hot paths.

## Common Mistakes

- Putting too much business workflow inside one function.
- Marking a database-reading function as `IMMUTABLE`.
- Hiding slow joins inside a function called once per row.
- Returning ambiguous column names.
- Forgetting to handle missing rows.
- Using PL/pgSQL when a simple SQL function is clearer.

## Business Examples

- Calculate order totals.
- Apply discounts and VAT.
- Label product stock levels.
- Return customer order history.
- Build category revenue reports.
- Validate stock before checkout.

## Interview Tips

Be ready to explain when you would put logic in PostgreSQL instead of the
application layer. Strong answers mention reuse, consistency, performance
tradeoffs, testing, permissions, and operational visibility.

Also be ready to explain function volatility. Interviewers often use volatility
questions to check whether you understand the query planner and data freshness.

## Recommended Learning Order

1. [Create function](01_create_function.sql)
2. [Function parameters](02_function_parameters.sql)
3. [Return table](03_return_table.sql)
4. [SQL vs PL/pgSQL](04_sql_vs_plpgsql.sql)
5. [Function volatility](05_function_volatility.sql)
6. [Error handling](06_error_handling.sql)
7. [Business calculation function](07_business_calculation_function.sql)
8. [Reporting function](08_reporting_function.sql)
9. [Function best practices](09_function_best_practices.sql)
10. [Common function mistakes](10_common_function_mistakes.sql)
11. [Chapter summary](chapter_summary.sql)
12. [Interview questions](interview_questions.md)

## Related Chapters

- [Chapter 4: Aggregation](../04_aggregates/README.md)
- [Chapter 8: Transactions & ACID](../08_transactions/README.md)
- [Chapter 9: Views](../09_views/README.md)

## Difficulty

Intermediate

## Estimated Completion Time

3-4 Hours

## Useful PostgreSQL Documentation References

- [CREATE FUNCTION](https://www.postgresql.org/docs/current/sql-createfunction.html)
- [SQL Functions](https://www.postgresql.org/docs/current/xfunc-sql.html)
- [PL/pgSQL](https://www.postgresql.org/docs/current/plpgsql.html)
- [Function Volatility Categories](https://www.postgresql.org/docs/current/xfunc-volatility.html)
- [Control Structures](https://www.postgresql.org/docs/current/plpgsql-control-structures.html)
