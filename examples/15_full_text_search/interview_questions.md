# Chapter 15 Interview Questions: Full Text Search

## 1. What is PostgreSQL Full Text Search?

**Model answer:** It is PostgreSQL's built-in system for tokenizing, querying,
ranking, and indexing natural-language text.

**Practical tip:** Mention `tsvector` and `tsquery`.

**Common follow-up:** How is it different from LIKE?

## 2. What is a tsvector?

**Model answer:** A searchable representation of text split into lexemes.

**Practical tip:** Use `to_tsvector`.

**Common follow-up:** Why does language configuration matter?

## 3. What is a tsquery?

**Model answer:** A structured full-text search query matched against a
`tsvector`.

**Practical tip:** Use `plainto_tsquery` for raw user input.

**Common follow-up:** Why avoid raw tsquery strings from users?

## 4. What does @@ do?

**Model answer:** It checks whether a `tsvector` matches a `tsquery`.

**Practical tip:** It is the core match operator for full-text search.

**Common follow-up:** Can @@ use an index?

## 5. How do you rank search results?

**Model answer:** Use `ts_rank` or `ts_rank_cd` with a vector and query.

**Practical tip:** Add deterministic tie-breakers.

**Common follow-up:** How can field weighting affect rank?

## 6. What is setweight used for?

**Model answer:** It gives different importance to parts of a document, such as
product name over description.

**Practical tip:** Product names often deserve higher weight.

**Common follow-up:** What weights are available?

## 7. What index supports full-text search?

**Model answer:** A GIN index is commonly used for `tsvector` search.

**Practical tip:** Match the index expression to the query expression.

**Common follow-up:** Why might PostgreSQL still scan a small table?

## 8. What is ts_headline?

**Model answer:** It creates highlighted snippets showing where search terms
matched.

**Practical tip:** Generate snippets after narrowing results.

**Common follow-up:** Is headline formatting the final UI?

## 9. When is PostgreSQL search not enough?

**Model answer:** Advanced typo tolerance, autocomplete, massive distributed
search, and complex relevance tuning may need a dedicated search system.

**Practical tip:** PostgreSQL search is often excellent for internal tools and
moderate catalogues.

**Common follow-up:** What external systems might be used?

## 10. What is a common Full Text Search mistake?

**Model answer:** Using `LIKE '%term%'` for large-scale natural-language search
or building unsafe tsquery strings from user input.

**Practical tip:** Prefer `plainto_tsquery` or `websearch_to_tsquery`.

**Common follow-up:** How would you safely accept user search input?
