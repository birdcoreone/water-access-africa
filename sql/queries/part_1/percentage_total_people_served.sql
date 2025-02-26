SELECT
    type_of_water_source,
    SUM(number_of_people_served) AS total_people_served,
    ROUND((SUM(number_of_people_served) / @total_people_surveyed * 100),0) AS percentage_of_total
FROM
    water_source
GROUP BY
    type_of_water_source
ORDER BY
    percentage_of_total DESC;
