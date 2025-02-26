-- Query to find towns with the highest ratio of broken taps
SELECT
    province_name,
    town_name,
    ROUND((tap_in_home_broken_percentage * 100.0 / (tap_in_home_broken_percentage + tap_in_home_percentage)), 0) AS pct_broken_taps
FROM
    town_aggregated_water_access
ORDER BY
    pct_broken_taps DESC;
