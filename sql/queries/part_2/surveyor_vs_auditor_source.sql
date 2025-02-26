WITH JoinedData AS (
    SELECT
        v.record_id,
        v.location_id AS visit_location,
        a.true_water_source_score AS auditor_score,
        ws.type_of_water_source AS survey_source,  -- Adding this
        a.type_of_water_source AS auditor_source  -- Adding this
    FROM 
        visits v
    JOIN 
        auditor_report a
    ON 
        v.location_id = a.location_id
    JOIN
        water_source ws  -- Joining water_source to get survey_source
    ON
        ws.source_id = v.source_id
    WHERE
        v.visit_count = 1
)
SELECT 
    jd.record_id,
    jd.visit_location,
    jd.auditor_score,
    w.subjective_quality_score AS surveyor_score,
    jd.survey_source,  -- Selecting the added column
    jd.auditor_source  -- Selecting the added column
FROM
    JoinedData jd
JOIN
    water_quality w 
ON
    jd.record_id = w.record_id
WHERE
    jd.auditor_score != w.subjective_quality_score
LIMIT 10000;  -- Adjust as needed

