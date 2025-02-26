-- Define the CTE to calculate the total population served by each province
WITH province_totals AS (
    SELECT
        province_name,
        SUM(people_served) AS total_ppl_serv
    FROM
        combined_analysis_table
    GROUP BY
        province_name
)

-- Main query to calculate the percentage of people served by each type of water source per province
SELECT
    ct.province_name,
    
    -- Calculate percentage of people served by each type of water source
    ROUND((SUM(CASE WHEN source_type = 'river' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS river_percentage,
    ROUND((SUM(CASE WHEN source_type = 'shared_tap' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS shared_tap_percentage,
    ROUND((SUM(CASE WHEN source_type = 'tap_in_home' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS tap_in_home_percentage,
    ROUND((SUM(CASE WHEN source_type = 'tap_in_home_broken' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS tap_in_home_broken_percentage,
    ROUND((SUM(CASE WHEN source_type = 'well' THEN people_served ELSE 0 END) * 100.0 / pt.total_ppl_serv), 0) AS well_percentage

FROM
    combined_analysis_table ct
    
    -- Join with the province_totals CTE to get the total population served by each province
    JOIN province_totals pt
    ON ct.province_name = pt.province_name
    
-- Group by province_name to aggregate the data
GROUP BY
    ct.province_name

-- Order the results by province_name for readability
ORDER BY
    ct.province_name;
