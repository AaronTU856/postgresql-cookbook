/*
Title: Nearest Neighbour Store Search
Difficulty: Advanced

Learning Objectives:
- Find the nearest locations to a customer.
- Use KNN ordering with the `<->` distance operator.
- Calculate readable distances in kilometres.

Problem Statement:
Given a customer point, return the closest fulfilment locations.

Business Scenario:
A checkout service wants to assign the closest collection point for click-and-collect orders.

SQL Solution:
*/

CREATE TEMP TABLE cookbook_spatial_demo_output (
    example_name TEXT,
    result_key TEXT,
    result_value TEXT
);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_available_extensions WHERE name = 'postgis') THEN
        INSERT INTO cookbook_spatial_demo_output
        VALUES ('nearest_neighbour', 'postgis_status', 'PostGIS is not installed in this database.');
        RETURN;
    END IF;

    CREATE EXTENSION IF NOT EXISTS postgis;

    EXECUTE $spatial$
        CREATE TEMP TABLE cookbook_store_locations (
            store_name TEXT PRIMARY KEY,
            location GEOMETRY(Point, 4326) NOT NULL
        );

        INSERT INTO cookbook_store_locations (store_name, location)
        VALUES
            ('Dublin Fulfilment Hub', ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326)),
            ('Galway Collection Point', ST_SetSRID(ST_MakePoint(-9.0568, 53.2707), 4326)),
            ('Cork Returns Desk', ST_SetSRID(ST_MakePoint(-8.4756, 51.8985), 4326)),
            ('Belfast Service Desk', ST_SetSRID(ST_MakePoint(-5.9301, 54.5973), 4326));

        INSERT INTO cookbook_spatial_demo_output
        WITH customer_location AS (
            SELECT ST_SetSRID(ST_MakePoint(-6.2450, 53.3400), 4326) AS location
        )
        SELECT
            'nearest_neighbour',
            store_name,
            CONCAT(
                ROUND((ST_Distance(s.location::geography, c.location::geography) / 1000)::NUMERIC, 2),
                ' km'
            )
        FROM cookbook_store_locations AS s
        CROSS JOIN customer_location AS c
        ORDER BY s.location <-> c.location
        LIMIT 3;
    $spatial$;
END;
$$;

SELECT *
FROM cookbook_spatial_demo_output
ORDER BY example_name, result_value;

/*
Explanation:
The `<->` operator supports nearest-neighbour ordering. Exact distance is calculated with `ST_Distance` on `geography` values so the result is in metres.

Expected Output:
The closest locations to the customer point are returned, with approximate distance in kilometres.

Performance Notes:
On large tables, add a GiST index to the geometry column and filter by `ST_DWithin` before ordering by distance.

Common Mistakes:
- Calculating exact distance for every row before applying a search radius.
- Forgetting to limit nearest-neighbour results.
- Sorting by text city names instead of spatial distance.

Challenge Exercise:
Change the query to return only stores within 250 kilometres.

Challenge Solution:
Add `WHERE ST_DWithin(s.location::geography, c.location::geography, 250000)` before the `ORDER BY`.

Related Chapters:
- Chapter 6 - Common Table Expressions
- Chapter 12 - Indexes
- Chapter 13 - Performance
*/
