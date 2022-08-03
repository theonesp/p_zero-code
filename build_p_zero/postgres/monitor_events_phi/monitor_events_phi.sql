-- This view converts znt_score_tp data from wide to long format
-- The index is generated ordering the items alphabetically, according to the order they were received.
-- The first table that was received was znt_score

--------------------------------------------------------
--  DDL for Table monitor_events_phi
--------------------------------------------------------

-- DROP TABLE 
-- DROP TABLE p_zero_phi.monitor_events_phi

CREATE TABLE p_zero_phi.monitor_events_phi
AS 
SELECT
	znt_score_tp_id,
	score_id,
	patnr,
	patient_ref,
	care_level_ref,
	ou_med_ref,
	result_date,
	znt_score_tp_user,
	vpid,
	score,
	1 AS item_id,
	conc_state AS value,
	group_flag
FROM
	p_zero_stage.znt_score_tp
WHERE
	conc_state IS NOT NULL
UNION ALL

SELECT
	znt_score_tp_id,
	score_id,
	patnr,
	patient_ref,
	care_level_ref,
	ou_med_ref,
	result_date,
	znt_score_tp_user,
	vpid,
	score,
	2 AS item_id,
	hr_ecg AS value,
	group_flag
FROM
	p_zero_stage.znt_score_tp
WHERE
	hr_ecg IS NOT NULL
UNION ALL

SELECT
	znt_score_tp_id,
	score_id,
	patnr,
	patient_ref,
	care_level_ref,
	ou_med_ref,
	result_date,
	znt_score_tp_user,
	vpid,
	score,
	3 AS item_id,
	hr_osc AS value,
	group_flag
FROM
	p_zero_stage.znt_score_tp
WHERE
	hr_osc IS NOT NULL
UNION ALL

SELECT
	znt_score_tp_id,
	score_id,
	patnr,
	patient_ref,
	care_level_ref,
	ou_med_ref,
	result_date,
	znt_score_tp_user,
	vpid,
	score,
	4 AS item_id,
	rr_ip AS value,
	group_flag
FROM
	p_zero_stage.znt_score_tp
WHERE
	rr_ip IS NOT NULL
UNION ALL

SELECT
	znt_score_tp_id,
	score_id,
	patnr,
	patient_ref,
	care_level_ref,
	ou_med_ref,
	result_date,
	znt_score_tp_user,
	vpid,
	score,
	5 AS item_id,
	rr AS value,
	group_flag
FROM
	p_zero_stage.znt_score_tp
WHERE
	rr IS NOT NULL
UNION ALL

SELECT
	znt_score_tp_id,
	score_id,
	patnr,
	patient_ref,
	care_level_ref,
	ou_med_ref,
	result_date,
	znt_score_tp_user,
	vpid,
	score,
	6 AS item_id,
	o2_sup AS value,
	group_flag
FROM
	p_zero_stage.znt_score_tp
WHERE
	o2_sup IS NOT NULL
UNION ALL

SELECT
	znt_score_tp_id,
	score_id,
	patnr,
	patient_ref,
	care_level_ref,
	ou_med_ref,
	result_date,
	znt_score_tp_user,
	vpid,
	score,
	7 AS item_id,
	pa_s AS value,
	group_flag
FROM
	p_zero_stage.znt_score_tp
WHERE
	pa_s IS NOT NULL
UNION ALL

SELECT
	znt_score_tp_id,
	score_id,
	patnr,
	patient_ref,
	care_level_ref,
	ou_med_ref,
	result_date,
	znt_score_tp_user,
	vpid,
	score,
	8 AS item_id,
	presn AS value,
	group_flag
FROM
	p_zero_stage.znt_score_tp
WHERE
	presn IS NOT NULL
UNION ALL

SELECT
	znt_score_tp_id,
	score_id,
	patnr,
	patient_ref,
	care_level_ref,
	ou_med_ref,
	result_date,
	znt_score_tp_user,
	vpid,
	score,
	9 AS item_id,
	pulsiox AS value,
	group_flag
FROM
	p_zero_stage.znt_score_tp
WHERE
	pulsiox IS NOT NULL
UNION ALL

SELECT
	znt_score_tp_id,
	score_id,
	patnr,
	patient_ref,
	care_level_ref,
	ou_med_ref,
	result_date,
	znt_score_tp_user,
	vpid,
	score,
	10 AS item_id,
	pulse AS value,
	group_flag
FROM
	p_zero_stage.znt_score_tp
WHERE
	pulse IS NOT NULL
UNION ALL

SELECT
	znt_score_tp_id,
	score_id,
	patnr,
	patient_ref,
	care_level_ref,
	ou_med_ref,
	result_date,
	znt_score_tp_user,
	vpid,
	score,
	11 AS item_id,
	temp_axi AS value,
	group_flag
FROM
	p_zero_stage.znt_score_tp
WHERE
	temp_axi IS NOT NULL
ORDER BY
	patnr,
	result_date;
ALTER TABLE  p_zero_phi.monitor_events_phi ADD COLUMN monitor_events_phi_id BIGSERIAL PRIMARY KEY;	
