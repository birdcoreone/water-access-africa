SELECT
    COUNT(*) AS num_sources,
    location_type
FROM
    location
GROUP BY
    location_type
;

    