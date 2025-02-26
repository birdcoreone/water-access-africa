SELECT
	town_name,
    COUNT(DISTINCT employee_name) AS number_of_employees
FROM
	employee
GROUP BY town_name;



