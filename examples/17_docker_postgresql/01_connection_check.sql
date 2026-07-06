/*
Title: Connection Check
Difficulty: Beginner

Learning objectives:
- Confirm the connected database.
- Verify the current user.
- Return server version details.

Problem statement:
A developer has started PostgreSQL with Docker Compose and needs to confirm the
psql session is connected to the expected database.

Business scenario:
Local onboarding fails quickly when developers connect to the wrong database or
wrong container.

SQL solution:
*/

SELECT
    current_database() AS database_name,
    current_user AS connected_user,
    inet_server_addr() AS server_address,
    inet_server_port() AS server_port,
    version() AS postgres_version;

/*
Explanation:
The query confirms connection identity from inside PostgreSQL. In Docker, the
server address may be null for Unix socket connections, which is normal.

Expected output:
The result identifies the database, user, server port, and PostgreSQL version.

Performance considerations:
This is a lightweight check suitable for startup verification.

Common mistakes:
- Connecting to the host PostgreSQL instead of the Docker container.
- Using the wrong database name.
- Assuming a running container means the database is ready.

Challenge:
Show the current schema search path for the Docker session.

Challenge solution:
*/

SELECT
    current_setting('search_path') AS search_path;

/*
Related chapters:
- ../16_administration/01_database_health_checks.sql
- 02_healthcheck_query.sql
- 03_init_verification.sql
*/
