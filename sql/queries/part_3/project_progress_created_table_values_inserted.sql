DROP TABLE IF EXISTS Project_progress;
CREATE TABLE Project_progress (
    Project_id SERIAL PRIMARY KEY,
    source_id VARCHAR(20) NOT NULL REFERENCES water_source(source_id) ON DELETE CASCADE ON UPDATE CASCADE,
    Address VARCHAR(255),
    Town VARCHAR(30),
    Province VARCHAR(30),
    Source_type VARCHAR(255),
    Improvement VARCHAR(255),
    Source_status VARCHAR(255) DEFAULT 'Backlog' CHECK (Source_status IN ('Backlog', 'In progress', 'Complete')),
    Date_of_completion DATE,
    Comments TEXT
);

INSERT INTO Project_progress (source_id, Address, Town, Province, Source_type, Improvement)
SELECT
    water_source.source_id,
    location.address,
    location.town_name AS Town,
    location.province_name AS Province,
    water_source.type_of_water_source AS Source_type,
    CASE
        WHEN well_pollution.results = 'Contaminated: Biological' THEN 'Install UV and RO filter'
        WHEN well_pollution.results = 'Contaminated: Chemical' THEN 'Install RO filter'
        WHEN water_source.type_of_water_source = 'river' THEN 'Drill well'
        WHEN water_source.type_of_water_source = 'shared_tap' AND visits.time_in_queue >= 30 THEN CONCAT('Install ', FLOOR(visits.time_in_queue / 30), ' taps nearby')
        WHEN water_source.type_of_water_source = 'tap_in_home_broken' THEN 'Diagnose local infrastructure'
        ELSE NULL
    END AS Improvement
FROM
    water_source
    LEFT JOIN well_pollution ON water_source.source_id = well_pollution.source_id
    INNER JOIN visits ON water_source.source_id = visits.source_id
    INNER JOIN location ON location.location_id = visits.location_id
WHERE
    visits.visit_count = 1
    AND (
        well_pollution.results != 'Clean'
        OR water_source.type_of_water_source IN ('tap_in_home_broken', 'river')
        OR (water_source.type_of_water_source = 'shared_tap' AND visits.time_in_queue >= 30)
    );
