/*
Example: Select recent users

SQL query:
Find users in the sample store and show the newest accounts first.
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
Explanation:
This query reads selected columns from the users table. ORDER BY created_at DESC
puts the newest users at the top of the result set.

Real-world use case:
An admin dashboard might show recently registered customers so support or sales
teams can review new activity.

Common mistake:
Using SELECT * for every query. It works, but it can return unnecessary columns
and make application code depend on table details it does not need.

Challenge exercise:
Change the query so it only returns users from London, ordered by last name.
*/
