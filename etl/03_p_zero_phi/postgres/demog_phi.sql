-- This table Fusions the  demog table with exitus data in order to provide prognostic insights.
--------------------------------------------------------
--  DDL for Table monitor_events
--------------------------------------------------------
-- DROP TABLE 
-- DROP TABLE p_zero.demog_phi;

CREATE TABLE p_zero_phi.demog_phi AS
SELECT
	data_scope.demo_scope.*,
	date(data_scope.exitus_scope.exitus_date) AS exitus_date
FROM
	data_scope.demo_scope
LEFT JOIN 
	data_scope.exitus_scope 
ON
	data_scope.demo_scope.patient_ref = data_scope.exitus_scope.patient_id
