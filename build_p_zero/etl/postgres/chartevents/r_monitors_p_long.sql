
-- Converting r_monitor_parsed data from wide to long format
-- The index is generated ordering the items alphabetically, depending on the order they were received.
-- The first table that was received was r_monitor

CREATE CHARTEVENTS AS

SELECT
patnr,
usuari,
vpid,
data,
hora,
 1 AS item_id,   
 conc_state AS value
FROM
stage_sild.r_monitor_parsed
WHERE conc_state IS NOT NULL
UNION ALL

SELECT
patnr,
usuari,
vpid,
data,
hora,
 2 AS item_id,   
 hr_ecg AS value
FROM
stage_sild.r_monitor_parsed
WHERE hr_ecg IS NOT NULL
UNION ALL

SELECT
patnr,
usuari,
vpid,
data,
hora,
 3 AS item_id,   
 hr_osc AS value
FROM
stage_sild.r_monitor_parsed
WHERE hr_osc IS NOT NULL
UNION ALL

SELECT
patnr,
usuari,
vpid,
data,
hora,
 4 AS item_id,   
 rr_ip AS value
FROM
stage_sild.r_monitor_parsed
WHERE rr_ip IS NOT NULL
UNION ALL

SELECT
patnr,
usuari,
vpid,
data,
hora,
 5 AS item_id,   
 rr AS value
FROM
stage_sild.r_monitor_parsed
WHERE rr IS NOT NULL
UNION ALL

SELECT
patnr,
usuari,
vpid,
data,
hora,
 6 AS item_id,   
 o2_sup AS value
FROM
stage_sild.r_monitor_parsed
WHERE o2_sup IS NOT NULL
UNION ALL

SELECT
patnr,
usuari,
vpid,
data,
hora,
 7 AS item_id,   
 pa_s AS value
FROM
stage_sild.r_monitor_parsed
WHERE pa_s IS NOT NULL
UNION ALL

SELECT
patnr,
usuari,
vpid,
data,
hora,
 8 AS item_id,   
 presn AS value
FROM
stage_sild.r_monitor_parsed
WHERE presn IS NOT NULL
UNION ALL

SELECT
patnr,
usuari,
vpid,
data,
hora,
 9 AS item_id,   
 pulsiox AS value
FROM
stage_sild.r_monitor_parsed
WHERE pulsiox IS NOT NULL
UNION ALL

SELECT
patnr,
usuari,
vpid,
data,
hora,
 10 AS item_id,   
 pulse AS value
FROM
stage_sild.r_monitor_parsed
WHERE pulse IS NOT NULL
UNION ALL

SELECT
patnr,
usuari,
vpid,
data,
hora,
 11 AS item_id,   
 temp_axi AS value
FROM
stage_sild.r_monitor_parsed
WHERE temp_axi IS NOT NULL

