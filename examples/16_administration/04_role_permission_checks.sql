/*
Title: Role and Permission Checks
Difficulty: Intermediate

Learning objectives:
- Check current role information.
- Use privilege helper functions.
- Debug table access safely.

Problem statement:
A reporting query fails in one environment, and the team needs to verify table
permissions.

Business scenario:
Permission mismatches often appear during deployments, reporting access setup,
or local development onboarding.

SQL solution:
*/

SELECT
    current_user AS current_user_name,
    current_role AS current_role_name,
    session_user AS session_user_name;

SELECT
    'orders' AS table_name,
    has_table_privilege(current_user, 'orders', 'SELECT') AS can_select,
    has_table_privilege(current_user, 'orders', 'INSERT') AS can_insert,
    has_table_privilege(current_user, 'orders', 'UPDATE') AS can_update;

/*
Explanation:
The first query shows role context. The second query checks table privileges
without attempting a write.

Expected output:
The current role names and boolean privilege checks are returned.

Performance considerations:
Privilege checks are lightweight. Use them before broad grants or risky access
changes.

Common mistakes:
- Granting broad permissions before identifying the missing privilege.
- Confusing current_user and session_user.
- Testing permissions only with a superuser account.

Challenge:
Check whether the current user can SELECT from payments.

Challenge solution:
*/

SELECT
    'payments' AS table_name,
    has_table_privilege(current_user, 'payments', 'SELECT') AS can_select;

/*
Related chapters:
- ../09_views/09_security_views.sql
- ../18_django_examples/README.md
- 03_activity_monitoring.sql
*/
