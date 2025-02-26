SELECT
    type_of_water_source,
    SUM(number_of_people_served) AS total_people_served,
    RANK() OVER (ORDER BY SUM(number_of_people_served) DESC) AS rank_by_population
FROM
    water_source
WHERE
    type_of_water_source != 'tap_in_home'
GROUP BY
    type_of_water_source
ORDER BY
    rank_by_population;

