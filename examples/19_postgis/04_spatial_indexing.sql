/*
Title: Spatial Indexing for Radius Search
Difficulty: Advanced

Learning Objectives:
- Create a GiST index for spatial queries.
- Use `ST_DWithin` for radius search.
- Understand why spatial filters should be index friendly.

Problem Statement:
The store locator must stay fast as the number of locations grows.

Business Scenario:
A map API returns nearby collection points within a requested radius. A spatial index keeps the endpoint responsive.

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
        VALUES ('spatial_indexing', 'postgis_status', 'PostGIS is not installed in this database.');
        RETURN;
    END IF;

    CREATE EXTENSION IF NOT EXISTS postgis;

    EXECUTE $spatial$
        CREATE TEMP TABLE cookbook_store_geography (
            store_name TEXT PRIMARY KEY,
            location GEOGRAPHY(Point, 4326) NOT NULL
        );

        INSERT INTO cookbook_store_geography (store_name, location)
        VALUES
            ('Dublin Fulfilment Hub', ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326)::geography),
            ('Galway Collection Point', ST_SetSRID(ST_MakePoint(-9.0568, 53.2707), 4326)::geography),
            ('Cork Returns Desk', ST_SetSRID(ST_MakePoint(-8.4756, 51.8985), 4326)::geography),
            ('Belfast Service Desk', ST_SetSRID(ST_MakePoint(-5.9301, 54.5973), 4326)::geography);

        CREATE INDEX idx_cookbook_store_geography_location
            ON cookbook_store_geography
            USING GIST (location);

        INSERT INTO cookbook_spatial_demo_output
        SELECT
            'spatial_indexing',
            'stores_within_175km',
            COUNT(*)::TEXT
        FROM cookbook_store_geography
        WHERE ST_DWithin(
            location,
            ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326)::geography,
            175000
        );
    $spatial$;
END;
$$;

SELECT *
FROM cookbook_spatial_demo_output
ORDER BY example_name, result_key;

/*
Explanation:
GiST indexes support spatial predicates such as `ST_DWithin`. The query asks for stores within 175 kilometres of Dublin using metre-based geography distance.

Expected Output:
The result shows how many store locations are inside the requested radius.

Performance Notes:
For production tables, inspect plans with `EXPLAIN (ANALYZE, BUFFERS)` and verify that the spatial index is used for selective radius filters.

Common Mistakes:
- Creating the index on `geometry` but querying a casted `geography` expression.
- Using `ST_Distance(...) < radius` instead of `ST_DWithin`.
- Testing only with tiny datasets and missing scaling problems.

Challenge Exercise:
Create a second query for a 350 kilometre radius and compare the count.

Challenge Solution:
Change the radius argument from `175000` to `350000`.

Related Chapters:
- Chapter 12 - Indexes
- Chapter 13 - Performance
- Chapter 19 - PostGIS
*/
