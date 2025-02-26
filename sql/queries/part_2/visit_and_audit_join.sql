WITH JoinedData as (
	SELECT 
		v.record_id,
		v.location_id AS visit_location,
		a.location_id AS audit_location,
		a.true_water_source_score
	FROM 
		visits v
	JOIN 
		auditor_report a
	ON 
		v.location_id = a.location_id
)
SELECT 
	jd.record_id,
    jd.visit_location,
    jd.audit_location,
    jd.true_water_source_score,
    w.subjective_quality_score
FROM
	JoinedData jd
JOIN
	water_quality w 
ON
	jd.record_id = w.record_id;
    
