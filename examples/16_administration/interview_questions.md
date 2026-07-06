# Chapter 16 Interview Questions: PostgreSQL Administration

## 1. What would you check first if an app cannot connect to PostgreSQL?

**Model answer:** Check host, port, database name, credentials, server status,
network reachability, and whether the user has permission.

**Practical tip:** Confirm the environment before changing anything.

**Common follow-up:** How would Docker change your debugging steps?

## 2. What is pg_stat_activity used for?

**Model answer:** It shows current database sessions, their state, wait events,
and query timing.

**Practical tip:** Idle sessions are not the same as active queries.

**Common follow-up:** How would you investigate lock waits?

## 3. Why monitor database size?

**Model answer:** Storage affects backups, migrations, hosting cost, and outage
risk.

**Practical tip:** Track trends, not only one snapshot.

**Common follow-up:** What grows besides table data?

## 4. What does ANALYZE do?

**Model answer:** It refreshes planner statistics so PostgreSQL can choose better
query plans.

**Practical tip:** Run it after significant data changes.

**Common follow-up:** How is ANALYZE different from VACUUM?

## 5. How do you debug permission issues?

**Model answer:** Check current user, current role, grants, ownership, and
specific object privileges.

**Practical tip:** Avoid fixing narrow issues with broad grants.

**Common follow-up:** What is least privilege?

## 6. What is the risk of running admin commands in production?

**Model answer:** Some commands can lock tables, consume I/O, affect performance,
or change security posture.

**Practical tip:** Prefer read-only diagnostics first.

**Common follow-up:** How would you plan a risky maintenance task?

## 7. What should be included in a database runbook?

**Model answer:** Connection checks, health checks, backup checks, restore steps,
monitoring dashboards, escalation paths, and rollback plans.

**Practical tip:** Runbooks should be tested, not just written.

**Common follow-up:** How often should restore steps be tested?

## 8. What is a good production administration habit for junior engineers?

**Model answer:** Gather evidence, make small reversible changes, ask for review
on risky actions, and document outcomes.

**Practical tip:** Operational caution is a strength.

**Common follow-up:** When should you escalate to a DBA or senior engineer?

## 9. How do you check table privileges without writing data?

**Model answer:** Use helper functions such as `has_table_privilege`.

**Practical tip:** Test the specific privilege needed.

**Common follow-up:** Why is testing as a superuser misleading?

## 10. Why should query text be handled carefully during monitoring?

**Model answer:** Queries may contain sensitive values or customer data.

**Practical tip:** Redact before sharing incident evidence.

**Common follow-up:** What should be included in an incident report?
