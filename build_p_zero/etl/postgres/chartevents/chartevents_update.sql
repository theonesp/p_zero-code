CREATE PROCEDURE chartevents_update 
LANGUAGE plpgsql AS

$$ BEGIN

CREATE OR REPLACE TABLE p_zero.chartevents
AS 
SELECT
	patnr,
	usuari,
	vpid,
	DATA AS store_date,
	hora AS store_time,
	1 AS item_id,
	conc_state AS value
FROM
	stage_sild.r_monitor_parsed
WHERE
	conc_state IS NOT NULL
UNION ALL

SELECT
	patnr,
	usuari,
	vpid,
	DATA AS store_date,
	hora AS store_time,
	2 AS item_id,
	hr_ecg AS value
FROM
	stage_sild.r_monitor_parsed
WHERE
	hr_ecg IS NOT NULL
UNION ALL

SELECT
	patnr,
	usuari,
	vpid,
	DATA AS store_date,
	hora AS store_time,
	3 AS item_id,
	hr_osc AS value
FROM
	stage_sild.r_monitor_parsed
WHERE
	hr_osc IS NOT NULL
UNION ALL

SELECT
	patnr,
	usuari,
	vpid,
	DATA AS store_date,
	hora AS store_time,
	4 AS item_id,
	rr_ip AS value
FROM
	stage_sild.r_monitor_parsed
WHERE
	rr_ip IS NOT NULL
UNION ALL

SELECT
	patnr,
	usuari,
	vpid,
	DATA AS store_date,
	hora AS store_time,
	5 AS item_id,
	rr AS value
FROM
	stage_sild.r_monitor_parsed
WHERE
	rr IS NOT NULL
UNION ALL

SELECT
	patnr,
	usuari,
	vpid,
	DATA AS store_date,
	hora AS store_time,
	6 AS item_id,
	o2_sup AS value
FROM
	stage_sild.r_monitor_parsed
WHERE
	o2_sup IS NOT NULL
UNION ALL

SELECT
	patnr,
	usuari,
	vpid,
	DATA AS store_date,
	hora AS store_time,
	7 AS item_id,
	pa_s AS value
FROM
	stage_sild.r_monitor_parsed
WHERE
	pa_s IS NOT NULL
UNION ALL

SELECT
	patnr,
	usuari,
	vpid,
	DATA AS store_date,
	hora AS store_time,
	8 AS item_id,
	presn AS value
FROM
	stage_sild.r_monitor_parsed
WHERE
	presn IS NOT NULL
UNION ALL

SELECT
	patnr,
	usuari,
	vpid,
	DATA AS store_date,
	hora AS store_time,
	9 AS item_id,
	pulsiox AS value
FROM
	stage_sild.r_monitor_parsed
WHERE
	pulsiox IS NOT NULL
UNION ALL

SELECT
	patnr,
	usuari,
	vpid,
	DATA AS store_date,
	hora AS store_time,
	10 AS item_id,
	pulse AS value
FROM
	stage_sild.r_monitor_parsed
WHERE
	pulse IS NOT NULL
UNION ALL

SELECT
	patnr,
	usuari,
	vpid,
	DATA AS store_date,
	hora AS store_time,
	11 AS item_id,
	temp_axi AS value
FROM
	stage_sild.r_monitor_parsed
WHERE
	temp_axi IS NOT NULL
ORDER BY
	patnr,
	store_date,
	store_time;

END $$
