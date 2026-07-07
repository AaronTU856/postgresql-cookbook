/*
Title: Enable PostGIS and Store Points
Difficulty: Advanced

Learning Objectives:
- Check whether PostGIS is available.
- Create point geometry values with SRID 4326.
- Read coordinates back from spatial columns.

Problem Statement:
The business wants to store fulfilment locations so a future map can show stores and warehouses.

Business Scenario:
An online store is adding a store locator. The first step is modelling each store as a longitude and latitude point.

SQL Solution:
The executable block below runs the PostGIS example when the extension is available and returns a clear message otherwise.
*/

CREATE TEMP TABLE cookbook_spatial_demo_output (
    example_name TEXT,
    result_key TEXT,
    result_value TEXT
);

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_available_extensions
        WHERE name = 'postgis'
    ) THEN
        INSERT INTO cookbook_spatial_demo_output
        VALUES ('enable_postgis', 'postgis_status', 'PostGIS is not installed in this database.');
        RETURN;
    END IF;

    CREATE EXTENSION IF NOT EXISTS postgis;

    EXECUTE $spatial$
        CREATE TEMP TABLE cookbook_store_locations (
            store_name TEXT PRIMARY KEY,
            city TEXT NOT NULL,
            location GEOMETRY(Point, 4326) NOT NULL
        );

        INSERT INTO cookbook_store_locations (store_name, city, location)
        VALUES
            ('Dublin Fulfilment Hub', 'Dublin', ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326)),
            ('Galway Collection Point', 'Galway', ST_SetSRID(ST_MakePoint(-9.0568, 53.2707), 4326)),
            ('Cork Returns Desk', 'Cork', ST_SetSRID(ST_MakePoint(-8.4756, 51.8985), 4326));

        INSERT INTO cookbook_spatial_demo_output
        SELECT
            'enable_postgis',
            store_name,
            CONCAT(ST_AsText(location), ' SRID=', ST_SRID(location))
        FROM cookbook_store_locations
        ORDER BY store_name;
    $spatial$;
END;
$$;

SELECT *
FROM cookbook_spatial_demo_output
ORDER BY example_name, result_key;

/*
Explanation:
PostGIS adds spatial types and functions to PostgreSQL. `ST_MakePoint` creates a point, `ST_SetSRID` labels the coordinate system, and `ST_AsText` displays the geometry in a readable format.

Expected Output:
When PostGIS is installed, the result lists store names with point coordinates and SRID 4326. Without PostGIS, it returns one explanatory status row.

Performance Notes:
Small point tables do not need special tuning. Production location search should add a GiST index once queries filter or sort by location.

Common Mistakes:
- Passing latitude before longitude.
- Forgetting to set SRID 4326.
- Storing coordinates as plain text and losing spatial query support.

Challenge Exercise:
Add a Belfast store location and return its Well-Known Text value.

Challenge Solution:
INSERT INTO cookbook_store_locations (store_name, city, location)
VALUES ('Belfast Service Desk', 'Belfast', ST_SetSRID(ST_MakePoint(-5.9301, 54.5973), 4326));

Related Chapters:
- Chapter 12 - Indexes
- Chapter 18 - Django Integration
- Chapter 20 - Real World Projects
*/
