# PostgreSQL Cheatsheet

## Connect With Docker

```bash
docker compose exec postgres psql -U postgres -d postgresql_cookbook
```

## List Tables

```sql
\dt
```

## Describe a Table

```sql
\d users
```

## Basic Select

```sql
SELECT
    id,
    email
FROM users;
```

## Filtering

```sql
SELECT
    name,
    price
FROM products
WHERE price >= 25.00;
```

## Sorting

```sql
SELECT
    name,
    price
FROM products
ORDER BY price DESC;
```

## Limit Results

```sql
SELECT
    id,
    order_date
FROM orders
ORDER BY order_date DESC
LIMIT 5;
```

## Count Rows

```sql
SELECT COUNT(*) AS total_users
FROM users;
```

## Join Tables

```sql
SELECT
    orders.id,
    users.email,
    orders.status
FROM orders
JOIN users
    ON users.id = orders.user_id;
```
