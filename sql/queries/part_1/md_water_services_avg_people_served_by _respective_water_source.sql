SELECT
    type_of_water_source,
    COUNT(*) AS source_count,
    SUM(number_of_people_served) AS total_people_served,
    ROUND(AVG(number_of_people_served),0) AS avg_people_served
FROM
    water_source
GROUP BY
    type_of_water_source
ORDER BY
    avg_people_served DESC;

	
