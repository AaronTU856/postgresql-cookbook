/*
Title: Django GIS REST API Query Shape
Difficulty: Advanced

Learning Objectives:
- Filter map records by the current viewport.
- Return API-friendly JSON from spatial SQL.
- Connect PostGIS predicates to Django GIS concepts.

Problem Statement:
A map endpoint should return only stores visible inside the current browser viewport.

Business Scenario:
A Django REST API receives west, south, east, and north coordinates from Leaflet and returns matching collection points.

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
        VALUES ('django_gis_rest_api', 'postgis_status', 'PostGIS is not installed in this database.');
        RETURN;
    END IF;

    CREATE EXTENSION IF NOT EXISTS postgis;

    EXECUTE $spatial$
        CREATE TEMP TABLE cookbook_api_stores (
            store_id INTEGER PRIMARY KEY,
            store_name TEXT NOT NULL,
            location GEOMETRY(Point, 4326) NOT NULL
        );

        INSERT INTO cookbook_api_stores (store_id, store_name, location)
        VALUES
            (1, 'Dublin Fulfilment Hub', ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326)),
            (2, 'Galway Collection Point', ST_SetSRID(ST_MakePoint(-9.0568, 53.2707), 4326)),
            (3, 'Cork Returns Desk', ST_SetSRID(ST_MakePoint(-8.4756, 51.8985), 4326));

        INSERT INTO cookbook_spatial_demo_output
        WITH request_bounds AS (
            SELECT ST_MakeEnvelope(-6.45, 53.20, -6.05, 53.45, 4326) AS viewport
        )
        SELECT
            'django_gis_rest_api',
            store_name,
            jsonb_build_object(
                'id', store_id,
                'name', store_name,
                'longitude', ST_X(location),
                'latitude', ST_Y(location)
            )::TEXT
        FROM cookbook_api_stores AS s
        CROSS JOIN request_bounds AS b
        WHERE ST_Intersects(s.location, b.viewport)
        ORDER BY store_id;
    $spatial$;
END;
$$;

SELECT *
FROM cookbook_spatial_demo_output
ORDER BY example_name, result_key;

/*
Explanation:
`ST_MakeEnvelope` builds a viewport polygon from web-map bounds. In Django GIS this maps naturally to bounding-box filters before serialization.

Expected Output:
Only stores inside the Dublin viewport are returned as JSON-friendly rows.

Performance Notes:
Add a GiST index to the location column and require clients to send bounded viewports or radius filters.

Common Mistakes:
- Letting API clients request unbounded map data.
- Not validating coordinate inputs.
- Returning internal columns the API consumer does not need.

Challenge Exercise:
Change the viewport to include Galway and confirm the returned store changes.

Challenge Solution:
Use bounds around Galway, for example `ST_MakeEnvelope(-9.20, 53.15, -8.90, 53.35, 4326)`.

Related Chapters:
- Chapter 14 - JSONB
- Chapter 18 - Django Integration
- Chapter 20 - Real World Projects
*/
