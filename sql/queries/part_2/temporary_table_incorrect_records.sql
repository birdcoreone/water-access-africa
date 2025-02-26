CREATE TEMPORARY TABLE temp_incorrect_records AS
SELECT
    auditor_report.location_id,
    visits.record_id,
    employee.employee_name,
    auditor_report.true_water_source_score AS auditor_score,
    wq.subjective_quality_score AS surveyor_score,
    auditor_report.statements AS statements
FROM
    auditor_report
JOIN
    visits ON auditor_report.location_id = visits.location_id
JOIN
    water_quality AS wq ON visits.record_id = wq.record_id
JOIN
    employee ON employee.assigned_employee_id = visits.assigned_employee_id
WHERE
    visits.visit_count = 1
    AND auditor_report.true_water_source_score != wq.subjective_quality_score;
