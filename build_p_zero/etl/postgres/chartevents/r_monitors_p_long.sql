
-- Converting r_monitor_parsed data from wide to long format

CREATE CHARTEVENTS AS

SELECT
patnr,
usuari,
vpid,
data,
hora,
1 AS item_id,   
hr_ecg AS value
FROM
stage_sild.r_monitor_parsed
WHERE
hr_ecg IS NOT null
UNION ALL
SELECT
patnr,
usuari,
vpid,
data,
hora,
2 AS item_id,   
rr_ip AS value
FROM
stage_sild.r_monitor_parsed
WHERE
rr_ip IS NOT null
union all 
SELECT
patnr,
usuari,
vpid,
data,
hora,
3 AS item_id,
vwert::integer as value
FROM
stage_sild.r_monitor_parsed
WHERE
vwert IS NOT NULL
UNION all
SELECT
patnr,
usuari,
vpid,
data,
hora,
4 AS item_id,
conc_state as value
FROM
stage_sild.r_monitor_parsed
WHERE
conc_state IS NOT null
