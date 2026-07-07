/*
Title: Model Delivery Zones With Polygons
Difficulty: Advanced

Learning Objectives:
- Model service areas as polygons.
- Check whether a point falls inside a delivery zone.
- Use spatial predicates for business rules.

Problem Statement:
The business needs to know whether a customer location is inside an express delivery zone.

Business Scenario:
Operations defines city delivery zones. Checkout can use this query to decide whether same-day delivery is available.

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
        VALUES ('spatial_data_model', 'postgis_status', 'PostGIS is not installed in this database.');
        RETURN;
    END IF;

    CREATE EXTENSION IF NOT EXISTS postgis;

    EXECUTE $spatial$
        CREATE TEMP TABLE cookbook_delivery_zones (
            zone_name TEXT PRIMARY KEY,
            zone GEOMETRY(Polygon, 4326) NOT NULL
        );

        CREATE TEMP TABLE cookbook_customer_points (
            customer_name TEXT PRIMARY KEY,
            location GEOMETRY(Point, 4326) NOT NULL
        );

        INSERT INTO cookbook_delivery_zones (zone_name, zone)
        VALUES (
            'Central Dublin Express Zone',
            ST_GeomFromText(
                'POLYGON((-6.35 53.30, -6.15 53.30, -6.15 53.42, -6.35 53.42, -6.35 53.30))',
                4326
            )
        );

        INSERT INTO cookbook_customer_points (customer_name, location)
        VALUES
            ('City Centre Customer', ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326)),
            ('Outer County Customer', ST_SetSRID(ST_MakePoint(-6.4500, 53.5000), 4326));

        INSERT INTO cookbook_spatial_demo_output
        SELECT
            'spatial_data_model',
            customer_name,
            CASE
                WHEN ST_Contains(zone, location) THEN 'inside express zone'
                ELSE 'outside express zone'
            END
        FROM cookbook_customer_points
        CROSS JOIN cookbook_delivery_zones
        ORDER BY customer_name;
    $spatial$;
END;
$$;

SELECT *
FROM cookbook_spatial_demo_output
ORDER BY example_name, result_key;

/*
Explanation:
Polygons represent areas such as delivery zones, sales territories, or service boundaries. `ST_Contains` checks whether a point is inside the polygon.

Expected Output:
One customer is inside the Dublin express zone and one is outside it.

Performance Notes:
Create a GiST index on polygon columns when many zones are checked. For large customer tables, filter by bounding boxes before exact containment checks.

Common Mistakes:
- Using invalid polygons that do not close.
- Comparing geometries with different SRIDs.
- Using text city names when the business rule is actually spatial.

Challenge Exercise:
Replace `ST_Contains` with `ST_Intersects` and explain why boundary points may behave differently.

Challenge Solution:
`ST_Intersects(zone, location)` returns true for points inside or touching the polygon boundary.

Related Chapters:
- Chapter 3 - Joins
- Chapter 12 - Indexes
- Chapter 20 - Real World Projects
*/
