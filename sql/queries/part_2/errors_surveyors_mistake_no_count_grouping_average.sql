WITH error_count AS (
    -- This CTE calculates the number of mistakes each employee made
    SELECT
        employee_name,
        COUNT(employee_name) AS number_of_mistakes
    FROM
        Incorrect_records
    GROUP BY
        employee_name
),
average_mistakes AS (
    -- This CTE calculates the average number of mistakes
    SELECT
        AVG(number_of_mistakes) AS avg_error_count_per_empl
    FROM
        error_count
)
-- Query to get the average number of mistakes
SELECT * FROM average_mistakes;
