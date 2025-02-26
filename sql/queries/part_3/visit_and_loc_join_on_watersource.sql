SELECT
    loc.province_name,
    loc.town_name,
    ws.type_of_water_source,
    ws.number_of_people_served,
    v.visit_count
FROM
    visits v
JOIN
    location loc ON v.location_id = loc.location_id
JOIN
    water_source ws ON v.source_id = ws.source_id
