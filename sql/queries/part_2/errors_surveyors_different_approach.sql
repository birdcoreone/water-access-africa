WITH Incorrect_records AS (
    SELECT
        v.record_id,
        v.location_id AS visit_location,
        a.true_water_source_score AS auditor_score,
        w.subjective_quality_score AS surveyor_score,
        e.employee_name,
        e.phone_number,
        e.email,
        e.address,
        e.province_name,
        e.town_name,
        e.position
    FROM 
		visits v
    JOIN 
		auditor_report a
    ON v.location_id = a.location_id
    JOIN 
		water_quality w
    ON 
		v.record_id = w.record_id
    JOIN 
		employee e
    ON 
		e.assigned_employee_id = v.assigned_employee_id
    WHERE 
		v.visit_count = 1
      AND 
		a.true_water_source_score != w.subjective_quality_score
)
SELECT 
	* 
FROM 
	Incorrect_records;

