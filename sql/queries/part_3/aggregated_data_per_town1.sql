-- CTE to calculate the total population served in each town
-- We include both province_name and town_name to handle towns with duplicate names
WITH town_totals AS (
    SELECT 
        province_name, 
        town_name, 
        SUM(people_served) AS total_ppl_serv
    FROM 
        combined_analysis_table
    GROUP BY 
        province_name, 
        town_name
)

-- Main query to calculate the percentage of people served by each type of water source per town
SELECT
    ct.province_name,
    ct.town_name,
    
    -- Calculate percentage of people served by each type of water source
    ROUND((SUM(CASE WHEN source_type = 'river' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS river_percentage,
    ROUND((SUM(CASE WHEN source_type = 'shared_tap' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS shared_tap_percentage,
    ROUND((SUM(CASE WHEN source_type = 'tap_in_home' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS tap_in_home_percentage,
    ROUND((SUM(CASE WHEN source_type = 'tap_in_home_broken' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS tap_in_home_broken_percentage,
    ROUND((SUM(CASE WHEN source_type = 'well' THEN people_served ELSE 0 END) * 100.0 / tt.total_ppl_serv), 0) AS well_percentage

FROM 
    combined_analysis_table ct
    
    -- Join with town_totals CTE to get the total population served in each town
    JOIN town_totals tt 
    ON ct.province_name = tt.province_name 
    AND ct.town_name = tt.town_name
    
-- Group by province_name and town_name to aggregate the results correctly
GROUP BY 
    ct.province_name, 
    ct.town_name

-- Order by town_name for better readability
ORDER BY 
    ct.town_name;
