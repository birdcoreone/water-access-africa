SELECT
	CONCAT(
		LOWER(REPLACE(employee_name,' ', '.')),'@ndogowater.gov'
	      ) 
        AS 
			new_email
FROM
	employee
LIMIT 20;