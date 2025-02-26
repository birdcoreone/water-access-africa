SET SQL_SAFE_UPDATES = 0;

UPDATE employee
SET email = CONCAT(LOWER(REPLACE(employee_name, ' ', '.')), '@ndogowater.gov');

SET SQL_SAFE_UPDATES = 1; -- Re-enable safe updates



