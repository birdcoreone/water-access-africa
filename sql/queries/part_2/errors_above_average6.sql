WITH error_count AS (
    SELECT
        employee_name,
        COUNT(*) AS number_of_mistakes
    FROM (
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
            visits
        ON
            auditor_report.location_id = visits.location_id
        JOIN
            water_quality AS wq
        ON
            visits.record_id = wq.record_id
        JOIN
            employee
        ON
            employee.assigned_employee_id = visits.assigned_employee_id
        WHERE
            visits.visit_count = 1
            AND auditor_report.true_water_source_score != wq.subjective_quality_score
    ) AS Incorrect_records
    GROUP BY
        employee_name
),
average_mistakes AS (
    SELECT
        AVG(number_of_mistakes) AS avg_error_count_per_empl
    FROM
        error_count
)
SELECT
    ec.employee_name,
    ec.number_of_mistakes
FROM
    error_count ec
JOIN
    average_mistakes am
ON
    ec.number_of_mistakes > am.avg_error_count_per_empl
ORDER BY
    ec.number_of_mistakes DESC;
