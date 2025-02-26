SELECT
    assigned_employee_id,
    SUM(visit_count) AS total_visits
FROM
    visits
GROUP BY
    assigned_employee_id
ORDER BY
    total_visits DESC
LIMIT 3;





