SELECT
	COUNT(*) AS records_per_town,
    town_name
FROM
	location
GROUP BY
	town_name;
    