-- Project_progress_filtered_query
SELECT
    location.address,
    location.town_name,
    location.province_name,
    water_source.source_id,
    water_source.type_of_water_source,
    well_pollution.results,
    CASE
        -- Improvement for rivers
        WHEN water_source.type_of_water_source = 'river' THEN 'Drill wells'
        
        -- Improvement for wells with chemical contamination
        WHEN well_pollution.results = 'chemical contamination' THEN 'Install RO filter'
        
        -- Improvement for wells with biological contamination
        WHEN well_pollution.results = 'biological contamination' THEN 'Install UV and RO filter'
        
        -- Improvement for shared taps with long queue times
        WHEN water_source.type_of_water_source = 'shared_tap' AND visits.time_in_queue >= 30 THEN
            CONCAT('Install ', FLOOR(visits.time_in_queue / 30), ' taps')
        
        -- Improvement for broken taps in homes
        WHEN water_source.type_of_water_source = 'tap_in_home_broken' THEN 'Diagnose local infrastructure'
        
        ELSE 'No improvement needed'
    END AS Improvement
FROM
    water_source
LEFT JOIN
    well_pollution ON water_source.source_id = well_pollution.source_id
INNER JOIN
    visits ON water_source.source_id = visits.source_id
INNER JOIN
    location ON location.location_id = visits.location_id
WHERE
    visits.visit_count = 1
    AND (
        (water_source.type_of_water_source = 'shared_tap' AND visits.time_in_queue >= 30)
        OR (water_source.type_of_water_source = 'well' AND well_pollution.results != 'clean')
        OR water_source.type_of_water_source = 'river'
        OR water_source.type_of_water_source = 'tap_in_home_broken'
    );
