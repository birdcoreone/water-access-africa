WITH error_count AS ( -- This CTE calculates the number of mistakes each employee made
	SELECT
	employee_name,
	COUNT(employee_name) AS number_of_mistakes
	FROM
	Incorrect_records
	/*
	Incorrect_records is a view that joins the audit report to the database
	for records where the auditor and
	employees scores are different
    */
	
	GROUP BY
	employee_name)
	-- Query
	SELECT * FROM error_count;