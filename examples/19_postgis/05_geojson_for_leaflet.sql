/*
Title: Return GeoJSON for Leaflet
Difficulty: Advanced

Learning Objectives:
- Convert spatial rows into GeoJSON.
- Build a FeatureCollection in SQL.
- Separate geometry from frontend display properties.

Problem Statement:
A frontend map needs store markers as GeoJSON.

Business Scenario:
The ecommerce site uses Leaflet to show collection points. The API should return a compact FeatureCollection.

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
        VALUES ('geojson_for_leaflet', 'postgis_status', 'PostGIS is not installed in this database.');
        RETURN;
    END IF;

    CREATE EXTENSION IF NOT EXISTS postgis;

    EXECUTE $spatial$
        CREATE TEMP TABLE cookbook_map_stores (
            store_id INTEGER PRIMARY KEY,
            store_name TEXT NOT NULL,
            city TEXT NOT NULL,
            location GEOMETRY(Point, 4326) NOT NULL
        );

        INSERT INTO cookbook_map_stores (store_id, store_name, city, location)
        VALUES
            (1, 'Dublin Fulfilment Hub', 'Dublin', ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326)),
            (2, 'Galway Collection Point', 'Galway', ST_SetSRID(ST_MakePoint(-9.0568, 53.2707), 4326)),
            (3, 'Cork Returns Desk', 'Cork', ST_SetSRID(ST_MakePoint(-8.4756, 51.8985), 4326));

        INSERT INTO cookbook_spatial_demo_output
        SELECT
            'geojson_for_leaflet',
            'feature_collection',
            jsonb_build_object(
                'type', 'FeatureCollection',
                'features', jsonb_agg(
                    jsonb_build_object(
                        'type', 'Feature',
                        'geometry', ST_AsGeoJSON(location)::jsonb,
                        'properties', jsonb_build_object(
                            'id', store_id,
                            'name', store_name,
                            'city', city
                        )
                    )
                    ORDER BY store_id
                )
            )::TEXT
        FROM cookbook_map_stores;
    $spatial$;
END;
$$;

SELECT *
FROM cookbook_spatial_demo_output
ORDER BY example_name, result_key;

/*
Explanation:
Leaflet can render GeoJSON directly. PostgreSQL builds the API response with `jsonb_build_object`, while PostGIS converts each geometry with `ST_AsGeoJSON`.

Expected Output:
The result contains one GeoJSON FeatureCollection with three store marker features.

Performance Notes:
Keep map payloads bounded by viewport, radius, or pagination. Browser maps can struggle with very large FeatureCollections.

Common Mistakes:
- Returning raw database columns instead of valid GeoJSON.
- Placing business fields inside `geometry` instead of `properties`.
- Returning every marker in the database on initial map load.

Challenge Exercise:
Add a `marker_type` property with the value `collection_point`.

Challenge Solution:
Add `'marker_type', 'collection_point'` inside the `properties` object.

Related Chapters:
- Chapter 14 - JSONB
- Chapter 18 - Django Integration
- Chapter 20 - Real World Projects
*/
