-- This table anonimizes demog_phi
-- it selects patient_deid associated with every patient_id
-- it adds week_multiples (always a multiple of seven) days to the real birth, load and exitus dates of the patient
--------------------------------------------------------
--  DDL for Table monitor_events
--------------------------------------------------------
-- DROP TABLE 
-- DROP TABLE p_zero.demog;

CREATE TABLE p_zero.demog
AS 
SELECT
    patient_ref,
    birth_date + INTERVAL '1' DAY * week_multiples AS birth_date_deid,
    CASE
        WHEN sex = 1 THEN 'M'
        WHEN sex = 2 THEN 'W'
        ELSE sex::varchar
    END AS sex,
    nation_ref,
    load_date + INTERVAL '1' DAY * week_multiples AS load_date_deid,
    exitus_date + INTERVAL '1' DAY * week_multiples AS exitus_date_deid
FROM
    p_zero_phi.demog_phi
JOIN
    p_zero_phi.deid_keys
USING
    (patient_ref);
ALTER TABLE p_zero.demog ADD COLUMN demog_id BIGSERIAL PRIMARY KEY;
