SELECT
	COUNT(*) AS records_per_province,
    province_name
FROM
	location
GROUP BY
	province_name;
    