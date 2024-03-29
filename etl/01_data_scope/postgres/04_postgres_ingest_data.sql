-- copy data from csv files to previously generated tables

SET SEARCH_PATH TO data_scope;

--copying natio_dic.csv
\copy data_scope.nation_dic (natio_ref, "label", tt) FROM '/stage_files/natio_dic.csv' DELIMITER ';' CSV HEADER;

--copying demog
\copy data_scope.demog (patient_ref, birth_date, sex, nation_ref,load_date) FROM '/stage_files/demo_2022-07-28.txt' DELIMITER ';' CSV HEADER;

--copying znt_score
\copy data_scope.znt_score (patient_id, id, mandt, id_score, "date", hora, usuari, vpid, vwert, pop_up, envio_medxat_med, envio_medxat_enf, envio_email, valors, aillat, ou_med_ref, care_level_ref) FROM '/stage_files/znt_score_2022-07-28.txt' DELIMITER ';' CSV HEADER;

--copying diag_scope
\copy data_scope.diag_scope  FROM '/stage_files/diag_230822.csv' DELIMITER ',' CSV HEADER;

--copying diag_dic
\copy data_scope.diag_dic   FROM '/stage_files/diag_dic_230822.csv' DELIMITER ',' CSV HEADER;

--copying exitus_scope
\copy data_scope.exitus_scope   FROM '/stage_files/death_events_230822.csv' DELIMITER ',' CSV HEADER;

--copying lab_scope
\copy data_scope.lab_scope   FROM '/stage_files/lab_events_2022-09-11.csv' DELIMITER ',' CSV HEADER;