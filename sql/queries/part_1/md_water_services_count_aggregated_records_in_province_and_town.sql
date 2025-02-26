SELECT
    province_name,
    town_name,
    COUNT(*) AS records_per_town
FROM
    location
GROUP BY
    province_name,
    town_name
ORDER BY
    province_name ASC,
    records_per_town DESC;

    