/*
Title: Select Recent Users
Difficulty: Beginner

Learning Objectives:
- Select several useful columns from one table.
- Sort users by registration date.
- Read customer account data without exposing unnecessary fields.

Problem Statement:
The support team wants to review recently registered users in the online store.

SQL Solution:
*/

SELECT
    id,
    first_name,
    last_name,
    email,
    city,
    created_at
FROM users
ORDER BY created_at DESC;

/*
Expected Output:
The query returns all six users, ordered from the newest account to the oldest
account.

Explanation:
This query reads selected user columns from the users table. ORDER BY
created_at DESC puts the newest users at the top of the result set.

Business Scenario:
An admin dashboard might show recently registered customers so support or sales
teams can review new activity.

Performance Notes:
Sorting by created_at can benefit from an index when the users table becomes
large. This sample table is small, so readability is the priority here.

Common Mistakes:
Using SELECT * for every query. It works, but it can return unnecessary columns
and make application code depend on table details it does not need.

Challenge Exercise:
Change the query so it only returns users from London, ordered by last name.

Challenge Solution:
*/

SELECT
    id,
    first_name,
    last_name,
    email,
    city,
    created_at
FROM users
WHERE city = 'London'
ORDER BY last_name;

/*
Related Chapters:
- 02_select_columns.sql
- 05_order_by.sql
- 04_where_clause.sql
*/
