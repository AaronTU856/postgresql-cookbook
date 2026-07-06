# SQL Style Guide

This guide keeps examples consistent and easy to read.

## Keywords

Use uppercase for SQL keywords:

```sql
SELECT
    first_name,
    last_name
FROM users;
```

## Indentation

Place each selected column on its own line when a query has more than two columns.

```sql
SELECT
    id,
    name,
    price
FROM products;
```

Use four spaces for indentation.

## Table and Column Names

Use `snake_case` for table and column names:

```sql
order_items
stock_quantity
created_at
```

## Joins

Put each `JOIN` on its own line and keep the join condition close to the joined table.

```sql
SELECT
    orders.id,
    users.email
FROM orders
JOIN users
    ON users.id = orders.user_id;
```

## Aliases

Use short, meaningful aliases when they improve readability. Avoid aliases that hide meaning in beginner examples.

```sql
SELECT
    p.name,
    c.name AS category_name
FROM products AS p
JOIN categories AS c
    ON c.id = p.category_id;
```

## Ordering Clauses

Use this order for common query clauses:

```sql
SELECT
FROM
JOIN
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT
```

## Comments

Use comments to explain learning intent or non-obvious decisions. Avoid comments that simply repeat the SQL.

## Example File Headers

Beginner example files should use a consistent teaching header inside a SQL block comment:

```sql
/*
Title: Short Example Title
Difficulty: Beginner

Concepts:
- First concept.
- Second concept.

Learning objectives:
- First objective.
- Second objective.

Problem statement:
Describe the realistic problem the query solves.

SQL solution:
*/
```

After the query, include the expected result description, explanation, real-world example, performance notes, common mistakes, challenge exercise, challenge solution, and related examples.
