-- This view converts znt_score_tp data from wide to long format
-- The index is generated ordering the items alphabetically, according to the order they were received.
-- The first table that was received was znt_score

--------------------------------------------------------
--  DDL for Table monitor_events_phi
--------------------------------------------------------

-- DROP TABLE 
DROP TABLE IF EXISTS p_zero_phi.monitor_events_phi;

CREATE TABLE p_zero_phi.monitor_events_phi
AS 
SELECT
patient_ref,
phi_id,
care_level_ref,
ou_med_ref,
monitor_events_user,
result_date,
score,
group_flag,
 1 AS reg_clin_ref,   
 conc_state AS value
FROM
p_zero_stage.znt_score_tp
WHERE conc_state IS NOT NULL
UNION ALL
      SELECT
patient_ref,
phi_id,
care_level_ref,
ou_med_ref,
monitor_events_user,
result_date,
score,
group_flag,
 2 AS reg_clin_ref,   
 hr_ecg AS value
FROM
p_zero_stage.znt_score_tp
WHERE hr_ecg IS NOT NULL
UNION ALL
      SELECT
patient_ref,
phi_id,
care_level_ref,
ou_med_ref,
monitor_events_user,
result_date,
score,
group_flag,
 3 AS reg_clin_ref,   
 hr_osc AS value
FROM
p_zero_stage.znt_score_tp
WHERE hr_osc IS NOT NULL
UNION ALL
      SELECT
patient_ref,
phi_id,
care_level_ref,
ou_med_ref,
monitor_events_user,
result_date,
score,
group_flag,
 4 AS reg_clin_ref,   
 rr_ip AS value
FROM
p_zero_stage.znt_score_tp
WHERE rr_ip IS NOT NULL
UNION ALL
      SELECT
patient_ref,
phi_id,
care_level_ref,
ou_med_ref,
monitor_events_user,
result_date,
score,
group_flag,
 5 AS reg_clin_ref,   
 rr AS value
FROM
p_zero_stage.znt_score_tp
WHERE rr IS NOT NULL
UNION ALL
      SELECT
patient_ref,
phi_id,
care_level_ref,
ou_med_ref,
monitor_events_user,
result_date,
score,
group_flag,
 6 AS reg_clin_ref,   
 o2_sup AS value
FROM
p_zero_stage.znt_score_tp
WHERE o2_sup IS NOT NULL
UNION ALL
      SELECT
patient_ref,
phi_id,
care_level_ref,
ou_med_ref,
monitor_events_user,
result_date,
score,
group_flag,
 7 AS reg_clin_ref,   
 pa_s AS value
FROM
p_zero_stage.znt_score_tp
WHERE pa_s IS NOT NULL
UNION ALL
      SELECT
patient_ref,
phi_id,
care_level_ref,
ou_med_ref,
monitor_events_user,
result_date,
score,
group_flag,
 8 AS reg_clin_ref,   
 presn AS value
FROM
p_zero_stage.znt_score_tp
WHERE presn IS NOT NULL
UNION ALL
      SELECT
patient_ref,
phi_id,
care_level_ref,
ou_med_ref,
monitor_events_user,
result_date,
score,
group_flag,
 9 AS reg_clin_ref,   
 pulsiox AS value
FROM
p_zero_stage.znt_score_tp
WHERE pulsiox IS NOT NULL
UNION ALL
      SELECT
patient_ref,
phi_id,
care_level_ref,
ou_med_ref,
monitor_events_user,
result_date,
score,
group_flag,
 10 AS reg_clin_ref,   
 pulse AS value
FROM
p_zero_stage.znt_score_tp
WHERE pulse IS NOT NULL
UNION ALL
      SELECT
patient_ref,
phi_id,
care_level_ref,
ou_med_ref,
monitor_events_user,
result_date,
score,
group_flag,
 11 AS reg_clin_ref,   
 temp_axi AS value
FROM
p_zero_stage.znt_score_tp
WHERE temp_axi IS NOT NULL



ORDER BY
	patient_ref,
	result_date;
ALTER TABLE  p_zero_phi.monitor_events_phi ADD COLUMN monitor_events_phi_id BIGSERIAL PRIMARY KEY;
