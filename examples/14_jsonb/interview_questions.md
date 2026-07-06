# Chapter 14 Interview Questions: JSONB

## 1. What is JSONB?

**Model answer:** JSONB is PostgreSQL's binary JSON type. It stores parsed JSON
and supports indexing and operators.

**Practical tip:** Contrast it with relational columns.

**Common follow-up:** How is JSONB different from JSON?

## 2. When would you use JSONB?

**Model answer:** Flexible metadata, event payloads, external API snapshots, and
optional attributes that vary by record.

**Practical tip:** Keep core business fields relational.

**Common follow-up:** What data should not be JSONB?

## 3. What is the difference between -> and ->>?

**Model answer:** `->` returns JSON/JSONB. `->>` returns text.

**Practical tip:** Use `->>` when comparing to text values.

**Common follow-up:** How do you compare a JSON number numerically?

## 4. What does @> do?

**Model answer:** It checks whether one JSONB value contains another JSONB
structure.

**Practical tip:** It is common with GIN indexes.

**Common follow-up:** What index type helps containment?

## 5. What is a GIN index?

**Model answer:** A Generalized Inverted Index supports values with multiple
components, such as JSONB documents or full-text search vectors.

**Practical tip:** GIN indexes can be large.

**Common follow-up:** Are GIN indexes free for writes?

## 6. What are JSONB performance risks?

**Model answer:** Large payloads, repeated extraction and casting, broad GIN
indexes, and using JSONB for data that should be relational.

**Practical tip:** Index only real access patterns.

**Common follow-up:** How would you tune a JSONB query?

## 7. Can JSONB replace normalized tables?

**Model answer:** Usually no. It complements relational design but should not
replace typed, constrained, join-heavy data.

**Practical tip:** Use JSONB where flexibility is more valuable than strict
schema.

**Common follow-up:** Give an example from e-commerce.

## 8. How do you build JSON in PostgreSQL?

**Model answer:** Use functions such as `jsonb_build_object` and `jsonb_agg`.

**Practical tip:** Use `ORDER BY` inside aggregates when array order matters.

**Common follow-up:** When should JSON formatting stay in the application?

## 9. How would you validate JSONB shape?

**Model answer:** Application validation, CHECK constraints for simple rules,
generated columns, or trigger-based validation for advanced cases.

**Practical tip:** Important business rules deserve explicit validation.

**Common follow-up:** Would you validate every key in the database?

## 10. What is a common JSONB design mistake?

**Model answer:** Hiding important relational data inside JSONB, then needing to
join, filter, and constrain it later.

**Practical tip:** Model stable business concepts as columns.

**Common follow-up:** How would you migrate JSONB data into columns?
