-- Fusion of demog table with exitus data in order to provide prognostic insights.

CREATE TABLE p_zero_phi.demog AS
SELECT 
  data_scope.demog.*, date(p_zero_stage.exitus_events.exitus_date) as exitus_date
FROM
  data_scope.demog 
  LEFT JOIN
  p_zero_stage.exitus_events
  USING (patient_ref)
