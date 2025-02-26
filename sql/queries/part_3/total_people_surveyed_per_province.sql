-- This query generates a pivot table showing the percentage of people served by different water sources in each province

WITH province_totals AS (
    -- This CTE calculates the total number of people served in each province
    SELECT
        province_name,
        SUM(people_served) AS total_ppl_serv
    FROM
        combined_analysis_table
    GROUP BY
        province_name
)

-- Now, simply select everything from the province_totals CTE
SELECT
    *
FROM
    province_totals;

