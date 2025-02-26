SELECT 
    l.province_name,
    l.town_name,
    l.location_type,
    ws.type_of_water_source,
    ws.number_of_people_served,
    v.time_in_queue,
    wp.results AS pollution_results,
    wp.pollutant_ppm,
    wp.biological
FROM 
    visits v
JOIN 
    location l ON v.location_id = l.location_id
JOIN 
    water_source ws ON v.source_id = ws.source_id
LEFT JOIN 
    well_pollution wp ON v.source_id = wp.source_id
WHERE 
    v.visit_count = 1
ORDER BY 
    l.province_name, l.town_name;
