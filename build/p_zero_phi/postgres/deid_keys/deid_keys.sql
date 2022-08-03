-- -------------------------------------------------------------------------------
--
-- Create covidhm tables
--
-- -------------------------------------------------------------------------------

--------------------------------------------------------
--  File created - 19/01/2021
--------------------------------------------------------

-- If running scripts individually, you can set the schema where all tables are created as follows:
SET search_path TO p_zero_phi; -- or your schema name

--------------------------------------------------------
--  DDL for Table antibiograma
--------------------------------------------------------

DROP TABLE IF EXISTS p_zero_phi.deid_keys;
CREATE TABLE p_zero_phi.deid_keys
(
WITH unique_patients AS
	(
SELECT
		DISTINCT patient_id AS patient_id
FROM
		p_zero_stage.znt_score_tp
	)
	SELECT 
	patient_id,
	patient_id + floor(random()*(100000000-1 + 1))+ 1 AS patient_deid,
	(floor(random()*(1000000-1 + 1))+ 1)* 7 AS week_multiples
FROM
	unique_patients
);

