WITH JoinedData AS (
    SELECT
        v.record_id,
        v.location_id AS visit_location,
        a.true_water_source_score AS auditor_score
    FROM 
        visits v
    JOIN 
        auditor_report a
    ON 
        v.location_id = a.location_id
    WHERE
        v.visit_count = 1
)
SELECT 
    jd.record_id,
    jd.visit_location,
    jd.auditor_score,
    w.subjective_quality_score AS surveyor_score,
    e.employee_name,
    e.phone_number,
    e.email,
    e.address,
    e.province_name,
    e.town_name,
    e.position
FROM
    JoinedData jd
JOIN
    water_quality w 
ON
    jd.record_id = w.record_id
JOIN
    visits v
ON
    jd.record_id = v.record_id
JOIN
    employee e
ON
    v.assigned_employee_id = e.assigned_employee_id
WHERE
    jd.auditor_score != w.subjective_quality_score
LIMIT 10000;  -- Adjust as needed
