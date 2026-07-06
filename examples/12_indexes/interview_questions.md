# Chapter 12 Interview Questions: Indexes

## 1. What is an index?

**Model answer:** An index is a data structure PostgreSQL can use to find rows
more efficiently than scanning a whole table.

**Practical tip:** Mention the tradeoff: faster reads, slower writes.

**Common follow-up:** Why might PostgreSQL ignore an index?

## 2. What is a B-tree index good for?

**Model answer:** Equality filters, range filters, sorting, joins, and many
common lookup patterns.

**Practical tip:** B-tree is PostgreSQL's default index type.

**Common follow-up:** When might another index type be better?

## 3. What is a composite index?

**Model answer:** An index on multiple columns, useful when queries filter or
sort by those columns together.

**Practical tip:** Column order matters.

**Common follow-up:** Does `(status, created_at)` equal `(created_at, status)`?

## 4. What is a partial index?

**Model answer:** An index that includes only rows matching a WHERE predicate.

**Practical tip:** It is useful for frequent filtered subsets such as completed
payments or active products.

**Common follow-up:** Why must the query predicate match?

## 5. What is an expression index?

**Model answer:** An index on an expression such as `LOWER(email)` rather than a
raw column.

**Practical tip:** The query should use the same expression.

**Common follow-up:** How would you support case-insensitive email lookup?

## 6. What is a covering index?

**Model answer:** An index that includes extra columns so a query can retrieve
needed values from the index more easily.

**Practical tip:** In PostgreSQL, use `INCLUDE`.

**Common follow-up:** Do included columns help filtering?

## 7. Why can too many indexes be bad?

**Model answer:** They slow writes, use disk, consume memory, and add maintenance
work.

**Practical tip:** Indexes should be tied to important queries.

**Common follow-up:** How would you find unused indexes?

## 8. What is selectivity?

**Model answer:** Selectivity describes how well a predicate narrows rows. More
selective predicates usually benefit more from indexes.

**Practical tip:** Boolean columns often have poor selectivity unless used in a
partial index.

**Common follow-up:** Is an index on `is_active` always useful?

## 9. What is EXPLAIN used for?

**Model answer:** It shows PostgreSQL's planned execution strategy for a query.

**Practical tip:** Use it before and after indexing.

**Common follow-up:** What does `EXPLAIN ANALYZE` add?

## 10. What would you check before adding an index in production?

**Model answer:** Query frequency, execution plan, table size, selectivity,
existing indexes, write volume, and storage impact.

**Practical tip:** Add indexes for measured bottlenecks, not guesses.

**Common follow-up:** How would you roll out an index safely on a large table?
