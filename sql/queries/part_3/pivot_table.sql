-- This query generates a pivot table showing the percentage of people served by different water sources in each province

WITH province_totals AS (
    -- Step 1: Calculate the total population served in each province
    SELECT
        province_name,
        SUM(people_served) AS total_ppl_serv
    FROM
        combined_analysis_table
    GROUP BY
        province_name
)

SELECT
    ct.province_name,  -- Select the province name to display in the results
    
    -- Step 2: Calculate the percentage of people served by each type of water source
    -- The percentage is calculated as (Number of People Served by Source Type / Total Population of Province) * 100
    ROUND((SUM(CASE WHEN source_type = 'river'
        THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS river,
    ROUND((SUM(CASE WHEN source_type = 'shared_tap'
        THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS shared_tap,
    ROUND((SUM(CASE WHEN source_type = 'tap_in_home'
        THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS tap_in_home,
    ROUND((SUM(CASE WHEN source_type = 'tap_in_home_broken'
        THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS tap_in_home_broken,
    ROUND((SUM(CASE WHEN source_type = 'well'
        THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS well

FROM
    combined_analysis_table ct  -- Use the main data table to get source types and population served

JOIN
    province_totals pt  -- Join the total population data calculated in the CTE
ON
    ct.province_name = pt.province_name  -- Match provinces between the main table and the totals table

GROUP BY
    ct.province_name  -- Group the results by province

ORDER BY
    ct.province_name;  -- Order the results by province for easy reading
