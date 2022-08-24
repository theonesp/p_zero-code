-- This table anonimizes monitor_events_phi
-- it selects patient_deid associated with every patient_ref
-- it adds week_multiples (always a multiple of seven) days to the real result date of the patient

--------------------------------------------------------
--  DDL for Table monitor_events
--------------------------------------------------------

-- DROP TABLE 
-- DROP TABLE p_zero.monitor_events;

CREATE TABLE p_zero.monitor_events
AS 
SELECT
	znt_score_tp_id,
	score_id,
	patient_deid,
	patient_ref,
	care_level_ref,
	ou_med_ref,
	result_date + interval '1' day * week_multiples AS result_date_deid,
	znt_score_tp_user,
	vpid,
	score,
	item_id,
	value,
	group_flag
FROM
	p_zero_phi.monitor_events_phi
JOIN
	p_zero_phi.deid_keys 
USING
(patient_ref)
;
ALTER TABLE  p_zero.monitor_events ADD COLUMN monitor_events_id BIGSERIAL PRIMARY KEY;
