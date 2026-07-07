# Chapter 19 Interview Questions - PostGIS

Use these questions to prepare for graduate, junior backend, GIS, and full-stack interviews where PostgreSQL may support map or location features.

## Questions and Model Answers

1. **What problem does PostGIS solve?**
   PostGIS adds spatial types, indexes, and functions to PostgreSQL so applications can store and query locations, routes, boundaries, and map data inside the relational database.

2. **What is an SRID?**
   An SRID identifies the coordinate reference system for a geometry. SRID `4326` is commonly used for GPS longitude and latitude coordinates.

3. **What is the difference between `geometry` and `geography`?**
   `geometry` works on a coordinate plane and is flexible for spatial operations. `geography` treats coordinates on the earth and returns distance in metres, which is useful for longitude and latitude radius searches.

4. **Why is longitude passed before latitude in `ST_MakePoint`?**
   PostGIS follows the x/y coordinate convention. Longitude is x and latitude is y.

5. **How would you find the nearest store to a customer?**
   Store each location as a point, create a GiST index, filter with `ST_DWithin` when possible, and order by the KNN `<->` operator or exact `ST_Distance` depending on the requirement.

6. **Why should a map API filter by viewport or radius?**
   Returning every marker is slow for the database, network, and browser. A bounded query keeps responses small and predictable.

7. **What index type is commonly used for PostGIS columns?**
   GiST indexes are the standard choice for many spatial predicates and nearest-neighbour workloads.

8. **What is GeoJSON used for?**
   GeoJSON is a JSON format for geographic features. It is widely used by web map libraries such as Leaflet and Mapbox.

9. **How does PostGIS relate to Django GIS?**
   Django GIS maps model fields and lookups to spatial database columns and predicates such as distance filters, bounding boxes, and intersections.

10. **What is a common performance mistake with spatial queries?**
    Calculating exact distance for every row before applying a selective spatial filter. Use `ST_DWithin` and indexes first.

11. **How would you check whether a customer is inside a delivery zone?**
    Store the delivery zone as a polygon and use `ST_Contains` or `ST_Intersects` against the customer's point.

12. **What should you validate before accepting coordinates from an API client?**
    Confirm longitude and latitude ranges, ensure numeric input, reject unbounded requests, and use the expected SRID.

13. **When might you simplify geometries for frontend maps?**
    When polygons are detailed enough to slow rendering or increase payload size. Simplification can be used for display while preserving authoritative geometry separately.

14. **Why might a production system separate map marker endpoints from detail endpoints?**
    Marker endpoints should be small and fast. Detail endpoints can fetch richer data only when the user selects a specific record.

15. **How would you explain PostGIS to a non-GIS backend engineer?**
    It is PostgreSQL with location-aware columns, functions, and indexes, allowing the database to answer questions such as "nearby", "inside", "intersects", and "return this as map data".

## Practical Tips

- Mention SRID `4326`, GiST indexes, `ST_DWithin`, and GeoJSON in interviews.
- Explain how the query supports a product feature, not just the function names.
- Be honest about tradeoffs: PostGIS is powerful, but still needs bounded queries and careful API design.

## Common Follow-Up Questions

- How would you prevent a user from requesting a global map query?
- What changes when the table grows from hundreds to millions of points?
- How would you test a spatial API endpoint?
- How would you represent both delivery zones and store locations?
- How would you connect a PostGIS query to a Django REST Framework serializer?
