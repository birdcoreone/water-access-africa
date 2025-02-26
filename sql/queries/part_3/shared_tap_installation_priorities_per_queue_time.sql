WITH shared_tap_upgrades AS (
    SELECT
        location.town_name,
        COUNT(*) AS shared_tap_count,
        visits.time_in_queue,
        FLOOR(visits.time_in_queue / 30) AS taps_to_install
    FROM
        water_source
    INNER JOIN
        visits ON water_source.source_id = visits.source_id
    INNER JOIN
        location ON location.location_id = visits.location_id
    WHERE
        water_source.type_of_water_source = 'shared_tap'
        AND visits.time_in_queue >= 30
    GROUP BY
        location.town_name, visits.time_in_queue
)

SELECT
    town_name,
    shared_tap_count,
    time_in_queue,
    taps_to_install
FROM
    shared_tap_upgrades
ORDER BY
    time_in_queue DESC, -- Prioritize towns with the longest queue times
    taps_to_install DESC; -- Secondary sort by number of taps needed (if needed)
