WITH JoinedData AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY v.record_id) AS row_num,
        v.record_id,
        v.location_id AS visit_location,  -- Include location_id from the visits table
        a.true_water_source_score AS auditor_score
    FROM 
        visits v
    JOIN 
        auditor_report a
    ON 
        v.location_id = a.location_id
)
SELECT 
    jd.row_num,
    jd.record_id,
    jd.visit_location,
    jd.auditor_score,
    w.subjective_quality_score AS surveyor_score
FROM
    JoinedData jd
JOIN
    water_quality w 
ON
    jd.record_id = w.record_id
LIMIT 10000;  -- Set a high enough number to ensure all rows are returned

    
