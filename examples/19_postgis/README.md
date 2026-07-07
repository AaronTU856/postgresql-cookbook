# Chapter 19 - PostGIS

## Overview

PostGIS turns PostgreSQL into a spatial database. It lets you store geometry, query locations, build map APIs, find nearby records, export GeoJSON, and power GIS features without moving data into a separate search service.

This chapter connects PostgreSQL to mapping applications, nearest-neighbour search, spatial indexing, Leaflet, Django GIS, and REST APIs. The examples use temporary spatial tables so they can be run safely against the cookbook database without changing the shared schema.

## Key Concepts

- `geometry` stores projected or geographic shapes with a spatial reference identifier.
- `geography` stores longitude and latitude data with distance calculations in metres.
- SRID `4326` is the common WGS 84 coordinate system used by GPS, GeoJSON, and web maps.
- `ST_SetSRID`, `ST_MakePoint`, and `ST_GeomFromText` create spatial values.
- `ST_DWithin`, `ST_Distance`, `ST_Contains`, and `ST_Intersects` answer spatial questions.
- GiST indexes make spatial filtering and nearest-neighbour queries practical.
- `ST_AsGeoJSON` prepares database results for Leaflet, Mapbox, Django REST Framework, and other web clients.

## Learning Outcomes

After completing this chapter, you should be able to:

- Explain when PostgreSQL should use `geometry` versus `geography`.
- Store points and polygons with the correct SRID.
- Find nearby stores, customers, or assets with distance-aware queries.
- Add spatial indexes for location search workloads.
- Export query results as GeoJSON for mapping frontends.
- Reason about how Django GIS and REST APIs map to PostGIS queries.

## When To Use PostGIS

Use PostGIS when location is part of the business model:

- Store locator and nearest branch search
- Delivery zones and service availability
- Asset tracking and route planning
- Property, booking, logistics, and marketplace maps
- Spatial analytics for operations or product teams
- APIs that return GeoJSON to a frontend map

## When NOT To Use PostGIS

Avoid PostGIS when the application only stores a city name, country name, or static address text and never needs distance, containment, routing, map display, or spatial filtering. A normal relational column is simpler for non-spatial data.

## Syntax Overview

```sql
CREATE EXTENSION IF NOT EXISTS postgis;

SELECT ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326);

SELECT *
FROM store_locations
WHERE ST_DWithin(
    location::geography,
    ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326)::geography,
    5000
);
```

Longitude comes before latitude in `ST_MakePoint(longitude, latitude)`.

## Best Practices

- Store longitude and latitude with SRID `4326` unless there is a clear reason not to.
- Use `geography` or cast to `geography` for metre-based distance calculations.
- Use GiST indexes on spatial columns used by map filters or proximity searches.
- Filter with `ST_DWithin` before sorting by exact distance.
- Return only the map fields the frontend needs.
- Keep GeoJSON API responses small enough for the browser to render smoothly.

## Performance Considerations

Spatial functions can be expensive on large datasets. Production systems usually combine:

- Bounding-box or radius filters
- GiST indexes
- Result limits
- Cached materialized views for heavy reporting
- Simplified geometries for web maps
- Separate read endpoints for map viewport queries and detailed record views

## Common Mistakes

- Reversing latitude and longitude.
- Mixing SRIDs without transforming coordinates.
- Calculating exact distance for every row before filtering.
- Forgetting a spatial index on production-sized tables.
- Returning huge GeoJSON payloads to a browser.
- Treating PostGIS as a replacement for clean relational modelling.

## Business Examples

- Find the nearest fulfilment store for an order.
- Check whether a customer address falls inside a delivery zone.
- Return a GeoJSON feature collection to a Leaflet map.
- Filter map markers by the current browser viewport.
- Expose a Django REST endpoint backed by spatial SQL.

## Interview Tips

Be ready to explain SRIDs, `geometry` versus `geography`, GiST indexes, KNN nearest-neighbour search, and why a map API should query by viewport or radius rather than returning every marker.

## Recommended Learning Order

1. `01_enable_postgis_and_geometry.sql`
2. `02_spatial_data_model.sql`
3. `03_nearest_neighbour_search.sql`
4. `04_spatial_indexing.sql`
5. `05_geojson_for_leaflet.sql`
6. `06_django_gis_rest_api.sql`
7. `chapter_summary.sql`
8. `interview_questions.md`

## Related Chapters

- [Chapter 12 - Indexes](../12_indexes/README.md)
- [Chapter 13 - Performance](../13_performance/README.md)
- [Chapter 14 - JSONB](../14_jsonb/README.md)
- [Chapter 18 - Django Integration](../18_django_examples/README.md)
- [Chapter 20 - Real World Projects](../20_real_world_projects/README.md)

## Difficulty

Advanced

## Estimated Completion Time

3-4 hours

## Useful PostgreSQL Documentation References

- PostgreSQL extensions: https://www.postgresql.org/docs/current/extend-extensions.html
- PostgreSQL indexes: https://www.postgresql.org/docs/current/indexes.html
- PostGIS manual: https://postgis.net/docs/
- GeoJSON format: https://datatracker.ietf.org/doc/html/rfc7946
