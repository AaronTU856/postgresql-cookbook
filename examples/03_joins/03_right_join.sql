/*
Title: RIGHT JOIN Orders to Users
Difficulty: Beginner

Learning Objectives:
- Use RIGHT JOIN to keep all rows from the right table.
- Recognise that RIGHT JOIN can often be rewritten as LEFT JOIN.
- Read join direction carefully.

Problem Statement:
The support team wants all users shown, with any matching order information.

Business Scenario:
This produces the same kind of customer completeness report as a LEFT JOIN, but
uses RIGHT JOIN to demonstrate join direction.

SQL Solution:
*/

SELECT
    users.id AS user_id,
    users.email,
    orders.id AS order_id,
    orders.status,
    orders.order_date
FROM orders
RIGHT JOIN users
    ON users.id = orders.user_id
ORDER BY users.id ASC, orders.order_date DESC;

/*
Explanation:
RIGHT JOIN keeps every row from the table on the right side of the join. In this
query, users is on the right side, so all users are returned.

Expected Output:
The query returns all users with their orders. Amelia Clark appears twice because
she has two orders.

Performance Notes:
RIGHT JOIN is valid SQL, but many teams prefer rewriting it as a LEFT JOIN by
swapping table order. LEFT JOIN usually reads more naturally.

Common Mistakes:
- Thinking RIGHT JOIN means "right answer" or "preferred join".
- Losing track of which table is preserved.
- Mixing RIGHT JOIN with several other joins in a query that becomes hard to
  read.

Challenge Exercise:
Rewrite the report as a LEFT JOIN.

Challenge Solution:
*/

SELECT
    users.id AS user_id,
    users.email,
    orders.id AS order_id,
    orders.status,
    orders.order_date
FROM users
LEFT JOIN orders
    ON orders.user_id = users.id
ORDER BY users.id ASC, orders.order_date DESC;

/*
Related Chapters:
- ../01_basic_queries/README.md
- ../02_filtering_sorting/README.md
- README.md
*/
