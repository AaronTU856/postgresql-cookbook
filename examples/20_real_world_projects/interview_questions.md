# Chapter 20 Interview Questions - Real World Projects

Use these questions to practise explaining PostgreSQL project work in a clear, production-aware way.

## Questions and Model Answers

1. **How do you start designing a reporting query?**
   Start with the business question, identify the authoritative tables, define which statuses count, and then write the simplest query that returns the required metrics.

2. **Why should completed revenue reports filter payment status?**
   Revenue should usually count completed payments only. Pending, failed, cancelled, or refunded rows can mislead financial and product decisions.

3. **How do you avoid N+1 queries in a backend API?**
   Fetch related data with joins, prefetching, or aggregate queries instead of issuing one database query per parent record.

4. **What makes a SQL query portfolio-ready?**
   It solves a realistic problem, names each step clearly, handles edge cases, avoids unnecessary complexity, and can be explained in business terms.

5. **When should a backend return JSON built by PostgreSQL?**
   It is useful for read-heavy endpoints where PostgreSQL can efficiently assemble a stable response shape. Keep it readable and testable.

6. **What is the safest way to approach performance tuning?**
   Measure the query, inspect the plan, change one thing, and measure again. Do not add indexes blindly.

7. **How would you design a store locator feature?**
   Store locations as PostGIS points, index them with GiST, require radius or viewport bounds, order by distance, limit results, and return GeoJSON or compact JSON.

8. **What belongs in an operational runbook query?**
   Safe read-only checks that help diagnose common incidents quickly, such as counts, recent timestamps, failed jobs, payment states, or active sessions.

9. **Why should map endpoints be bounded?**
   Unbounded map queries can overload the database, network, and browser. Radius or viewport filters keep work proportional to the user's current view.

10. **How do CTEs help in real project SQL?**
    CTEs name intermediate steps, make reviews easier, and reduce the need to repeat complex expressions.

11. **When should you materialize a report?**
    Materialize when the report is expensive, read often, and does not need second-by-second freshness.

12. **How do you explain an index choice in an interview?**
    Connect the index to the query's filters, joins, ordering, or uniqueness requirement, then mention that you verified the plan.

13. **What is a common mistake in dashboard SQL?**
    Returning too many detailed rows instead of pre-aggregated metrics that match the dashboard's actual display.

14. **How would you test SQL used by a REST API?**
    Use known seed data, validate response shape, test empty states, test status filters, and run the query in CI when possible.

15. **How do you keep advanced SQL maintainable?**
    Use explicit names, format consistently, keep business rules visible, add focused comments, and avoid cleverness that future maintainers cannot reason about.

## Practical Tips

- Explain project SQL as a product feature, not a syntax exercise.
- Talk through data correctness before performance.
- Bring up status filters, indexes, bounded APIs, and validation.
- Show that you can connect PostgreSQL to Django, REST APIs, Docker, and maps.

## Common Follow-Up Questions

- What would change if the dataset grew to millions of rows?
- How would you cache or materialize this report?
- What index would you add and why?
- How would you expose this through Django REST Framework?
- How would you monitor whether the query is slow in production?
