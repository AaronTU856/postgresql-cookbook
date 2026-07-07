/*
Title: Project - Store Locator Mapping API
Difficulty: Advanced

Learning Objectives:
- Build a map API response using PostGIS when available.
- Return GeoJSON for frontend mapping libraries.
- Apply bounded spatial queries for production safety.

Problem Statement:
Return nearby collection points as a GeoJSON FeatureCollection.

Business Scenario:
A checkout page lets customers choose a collection point on a Leaflet map. The backend should return only nearby stores.

SQL Solution:
*/

CREATE TEMP TABLE cookbook_project_output (
    example_name TEXT,
    result_key TEXT,
    result_value TEXT
);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_available_extensions WHERE name = 'postgis') THEN
        INSERT INTO cookbook_project_output
        VALUES ('mapping_api', 'postgis_status', 'PostGIS is not installed in this database.');
        RETURN;
    END IF;

    CREATE EXTENSION IF NOT EXISTS postgis;

    EXECUTE $spatial$
        CREATE TEMP TABLE cookbook_collection_points (
            point_id INTEGER PRIMARY KEY,
            point_name TEXT NOT NULL,
            location GEOMETRY(Point, 4326) NOT NULL
        );

        INSERT INTO cookbook_collection_points (point_id, point_name, location)
        VALUES
            (1, 'Dublin Fulfilment Hub', ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326)),
            (2, 'Galway Collection Point', ST_SetSRID(ST_MakePoint(-9.0568, 53.2707), 4326)),
            (3, 'Cork Returns Desk', ST_SetSRID(ST_MakePoint(-8.4756, 51.8985), 4326)),
            (4, 'Belfast Service Desk', ST_SetSRID(ST_MakePoint(-5.9301, 54.5973), 4326));

        CREATE INDEX idx_cookbook_collection_points_location
            ON cookbook_collection_points
            USING GIST (location);

        INSERT INTO cookbook_project_output
        WITH request_context AS (
            SELECT
                ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326) AS customer_location,
                250000::DOUBLE PRECISION AS radius_metres
        ),
        nearby_points AS (
            SELECT
                p.point_id,
                p.point_name,
                p.location,
                ROUND((ST_Distance(p.location::geography, r.customer_location::geography) / 1000)::NUMERIC, 2) AS distance_km
            FROM cookbook_collection_points AS p
            CROSS JOIN request_context AS r
            WHERE ST_DWithin(p.location::geography, r.customer_location::geography, r.radius_metres)
            ORDER BY p.location <-> r.customer_location
            LIMIT 10
        )
        SELECT
            'mapping_api',
            'geojson_response',
            jsonb_build_object(
                'type', 'FeatureCollection',
                'features', COALESCE(
                    jsonb_agg(
                        jsonb_build_object(
                            'type', 'Feature',
                            'geometry', ST_AsGeoJSON(location)::jsonb,
                            'properties', jsonb_build_object(
                                'id', point_id,
                                'name', point_name,
                                'distance_km', distance_km
                            )
                        )
                        ORDER BY distance_km
                    ),
                    '[]'::jsonb
                )
            )::TEXT
        FROM nearby_points;
    $spatial$;
END;
$$;

SELECT *
FROM cookbook_project_output
ORDER BY example_name, result_key;

/*
Explanation:
The API pattern filters by radius, limits results, orders by proximity, and returns frontend-ready GeoJSON. It mirrors what a Django REST or Node API endpoint might execute behind a map view.

Expected Output:
When PostGIS is available, one row contains a GeoJSON FeatureCollection. Otherwise, the file returns a status row explaining that PostGIS is not installed.

Performance Notes:
Use spatial indexes, require bounded requests, and cap result counts. For heavy traffic, cache common map tiles or cluster markers.

Common Mistakes:
- Returning every collection point to the browser.
- Letting the client control an unlimited radius.
- Calculating map distances in application code after fetching all rows.

Challenge Exercise:
Add a `city` property to each GeoJSON feature.

Challenge Solution:
Add a `city` column to the temporary table and include `'city', city` inside the `properties` object.

Related Chapters:
- Chapter 13 - Performance
- Chapter 14 - JSONB
- Chapter 19 - PostGIS
*/
