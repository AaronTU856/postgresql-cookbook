/*
Title: PostGIS Chapter Summary
Difficulty: Advanced

Learning Objectives:
- Combine spatial filtering, distance sorting, and JSON output.
- Review the core PostGIS workflow for map APIs.
- Connect spatial SQL to production backend design.

Problem Statement:
Build a small store-locator response that returns nearby locations as GeoJSON.

Business Scenario:
A backend endpoint receives a customer's current location and returns nearby collection points for a web map.

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
        VALUES ('postgis_summary', 'postgis_status', 'PostGIS is not installed in this database.');
        RETURN;
    END IF;

    CREATE EXTENSION IF NOT EXISTS postgis;

    EXECUTE $spatial$
        CREATE TEMP TABLE cookbook_summary_stores (
            store_id INTEGER PRIMARY KEY,
            store_name TEXT NOT NULL,
            location GEOMETRY(Point, 4326) NOT NULL
        );

        INSERT INTO cookbook_summary_stores (store_id, store_name, location)
        VALUES
            (1, 'Dublin Fulfilment Hub', ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326)),
            (2, 'Galway Collection Point', ST_SetSRID(ST_MakePoint(-9.0568, 53.2707), 4326)),
            (3, 'Cork Returns Desk', ST_SetSRID(ST_MakePoint(-8.4756, 51.8985), 4326)),
            (4, 'Belfast Service Desk', ST_SetSRID(ST_MakePoint(-5.9301, 54.5973), 4326));

        CREATE INDEX idx_cookbook_summary_stores_location
            ON cookbook_summary_stores
            USING GIST (location);

        INSERT INTO cookbook_spatial_demo_output
        WITH customer_location AS (
            SELECT ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326) AS location
        ),
        nearby_stores AS (
            SELECT
                s.store_id,
                s.store_name,
                s.location,
                ROUND((ST_Distance(s.location::geography, c.location::geography) / 1000)::NUMERIC, 2) AS distance_km
            FROM cookbook_summary_stores AS s
            CROSS JOIN customer_location AS c
            WHERE ST_DWithin(s.location::geography, c.location::geography, 300000)
            ORDER BY s.location <-> c.location
            LIMIT 3
        )
        SELECT
            'postgis_summary',
            'nearby_store_geojson',
            jsonb_build_object(
                'type', 'FeatureCollection',
                'features', jsonb_agg(
                    jsonb_build_object(
                        'type', 'Feature',
                        'geometry', ST_AsGeoJSON(location)::jsonb,
                        'properties', jsonb_build_object(
                            'id', store_id,
                            'name', store_name,
                            'distance_km', distance_km
                        )
                    )
                    ORDER BY distance_km
                )
            )::TEXT
        FROM nearby_stores;
    $spatial$;
END;
$$;

SELECT *
FROM cookbook_spatial_demo_output
ORDER BY example_name, result_key;

/*
Explanation:
The summary combines the chapter's production pattern: bounded spatial filtering, nearest-neighbour ordering, distance calculation, indexing, and API-ready GeoJSON output.

Expected Output:
When PostGIS is installed, the result is a GeoJSON FeatureCollection of nearby collection points.

Performance Notes:
For large datasets, use a generated `geography` column or a matching expression index if most radius filters use metre-based distance.

Common Mistakes:
- Returning all stores and calculating distance in application code.
- Missing limits on map endpoints.
- Building GeoJSON manually with string concatenation.

Challenge Exercise:
Add a `max_results` parameter concept by changing the final `LIMIT` from 3 to 2.

Challenge Solution:
In a real API, bind `LIMIT LEAST(:max_results, 50)` to cap client-controlled result sizes.

Related Chapters:
- Chapter 12 - Indexes
- Chapter 13 - Performance
- Chapter 14 - JSONB
- Chapter 18 - Django Integration
*/
